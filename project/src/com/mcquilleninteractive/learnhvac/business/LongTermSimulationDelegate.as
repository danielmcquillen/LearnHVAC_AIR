package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.command.LongTermSimulationCommand;
	import com.mcquilleninteractive.learnhvac.err.EPlusParseError;
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataLoadedEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.LTSettingsModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.*;
	import flash.system.Capabilities;
	
	import mx.controls.Alert;

	
	public class LongTermSimulationDelegate 
	{
		protected var command:LongTermSimulationCommand
		
		protected var _ePlusExe:File
		protected var _includeFilesDir:File
		protected var _paramBaseFile:File		
		protected var _paramFile:File		
		protected var _eplusOutVarsFile:File
		protected var _eplusOutputMeterFile:File	
		
		protected var _process:NativeProcess	
		protected var _stream:FileStream
		protected var _readTries:Number = 0
		protected var _runID:String 			
		protected var _processID:Number = 0 //returned from ZINC when starting eplus process
			
		public function LongTermSimulationDelegate(command : LongTermSimulationCommand)
		{
			this.command = command
			
			_ePlusExe = File.applicationStorageDirectory.resolvePath("energyplus/Run-Prototype-LgOffice.bat")
			_includeFilesDir =  File.applicationStorageDirectory.resolvePath("energyplus/LgOff/IncFiles")
			_paramBaseFile = File.applicationStorageDirectory.resolvePath("energyplus/LgOff/IncFiles/Param_LgOff_base.inc")
			_paramFile = File.applicationStorageDirectory.resolvePath("energyplus/LgOff/IncFiles/Param_LgOff.inc")
			_eplusOutVarsFile = File.applicationStorageDirectory.resolvePath('LgOff/Output/LgOff.csv')
			_eplusOutputMeterFile = File.applicationStorageDirectory.resolvePath('LgOff/Output/LgOffMeter.csv')
			
			_stream = new FileStream()
			
		}
				
		public function runLongTermSimulation():Boolean
		{
						
			Logger.debug(" runLongTermSimulation() called...", this)	
			
			var ltSettings:LTSettingsModel = LHModelLocator.getInstance().scenarioModel.ltSettingsModel	
			
			/* CODE FOR TEST MODE */			
			if (LHModelLocator.testMode)
			{				
				return true
			}			
			/* END CODE FOR TEST MODE */
			
			//error checks
			//make sure all include files are present
			
			//check .bat file
			
			if (_ePlusExe.exists==false)
			{
				Logger.warn(" couldn't find eplus file " + _ePlusExe.nativePath, this)
				mx.controls.Alert.show("Couldn't find the required EnergyPlus file (" + _ePlusExe.nativePath +"). This file is required.","Error")
				return false
			}
	
			//Check weather file exists...and if so copy to In.epw
			var weatherFile:File = File.applicationDirectory.resolvePath("energyplus/Weather/" + ltSettings.weatherFile)
			var inEPWFile:File = File.applicationDirectory.resolvePath("energyplus/In.epw")
			
			if (weatherFile.exists==false)
			{
				Logger.warn(" couldn't find selected weather file " + weatherFile.nativePath, this)
				mx.controls.Alert.show("The weather file for the city you selected ("+ltSettings.weatherFile+") is not in the energyplus\\Weather folder. Please select another city.","Error")
				return false
			}
			else
			{
				weatherFile.copyTo(inEPWFile, true)
			}
					
			//check include files
			
			var includeFiles:Array = ["BldgGeom.inc","Construction.inc","material.inc",
										"Param_LgOff.inc","ParamCalc.inc","Schedule.inc",
										"SpCond.inc","System.inc"]
										
			Logger.debug("checking for necessary .inc files...", this)			
			for each (var fileName:String in includeFiles)
			{
				var includeFile:File = _includeFilesDir.resolvePath(fileName)
				if (includeFile.exists==false)
				{
					if (fileName=="Param_LgOff.inc") //I know this one is fatal if not found, are other as well?
					{
						Logger.warn(" couldn't find .inc file " + includeFile.nativePath, this)
						mx.controls.Alert.show("Couldn't find Param_LgOff.inc in the EnergyPlus folder. This file is necessary to run the Long Term Simulation.","Error")
					}
					else
					{
						Logger.warn(" couldn't find .inc file " + includeFile.nativePath, this)
						mx.controls.Alert.show("Couldn't find " + fileName +" in the EnergyPlus IncFiles folder. Simulation may not work or may be inaccurate.","Warning")	
					}
				}	
			}
				
			_runID = ltSettings.runID
			Logger.debug(" runID set to : " + _runID, this)			
			Logger.debug(" checking if output files exist...if so, delete them...")
						
			
			//TODO: Clear out existing output, if present			
		
			if (_eplusOutVarsFile.exists)
			{
				//Logger.debug("#BSD: deleting existing BasicOutput.csv from energyplus")
				try
				{
					_eplusOutVarsFile.deleteFile()
				}
				catch(e:Error)
				{
					Logger.warn(" couldn't delete " + _eplusOutVarsFile.nativePath, this)
					mx.controls.Alert.show("Couldn't delete " + _eplusOutVarsFile.name +" in the EnergyPlus IncFiles folder. Please close this file if open.","Warning")	
					
				}
				
			}
			if (_eplusOutputMeterFile.exists)
			{
				//Logger.debug("#BSD: deleting existing BasicOutput.csv from energyplus")
				try
				{
					_eplusOutputMeterFile.deleteFile()
				}
				catch(e:Error)
				{
					Logger.warn(" couldn't delete " + _eplusOutputMeterFile.nativePath, this)
					mx.controls.Alert.show("Couldn't delete " + _eplusOutputMeterFile.name +" in the EnergyPlus IncFiles folder. Please close this file if open.","Warning")	
					
				}
				
			}
			
						
			////////////////////////////////////////					
			// BUILD SAVE THE LEARN HVAC .inc file
			////////////////////////////////////////
			
			Logger.debug(" buildilng .inc file...")
			var lhInc:String 
			var scenModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			lhInc = "\n"
			lhInc += "!  Parameter File for Large Office Prototype\n\n"
			lhInc += "! ***************************************************************\n"
			lhInc += "! Learn HVAC-specific values are included below\n"
			lhInc += "! ***************************************************************\n"
						
			//write in .inc lines, substituting in values from SPARK
			lhInc += "\n! Variables for general setup"
			lhInc += "\n##def1 LH_ScenarioName	   " + scenModel.name
			lhInc += "\n##def1 LH_weatherFile      " + ltSettings.weatherFile
			Logger.debug("startDate: " + ltSettings.startDate)
			Logger.debug("stopDate: " + ltSettings.stopDate)
			lhInc += "\n##def1 LH_startMonth         " + (ltSettings.startDate.month + 1)
			lhInc += "\n##def1 LH_startDay         " + ltSettings.startDate.date
			lhInc += "\n##def1 LH_stopMonth         " + (ltSettings.stopDate.month + 1)
			lhInc += "\n##def1 LH_stopDay          " + ltSettings.stopDate.date
			lhInc += "\n##def1 LH_WDD_startMonth   " + (ltSettings.wddStartDate.month + 1)
			lhInc += "\n##def1 LH_WDD_startDay     " + ltSettings.wddStartDate.date
			lhInc += "\n##def1 LH_WDD_stopMonth    " + (ltSettings.wddStopDate.month + 1)
			lhInc += "\n##def1 LH_WDD_stopDay    " + ltSettings.wddStopDate.date
			lhInc += "\n##def1 LH_WDD_typeOfDD     " + ltSettings.wddTypeOfDD
			lhInc += "\n##def1 LH_SDD_startMonth    " + (ltSettings.sddStartDate.month + 1)
			lhInc += "\n##def1 LH_SDD_startDay    " + ltSettings.sddStartDate.date
			lhInc += "\n##def1 LH_SDD_stopMonth    " + (ltSettings.sddStopDate.month + 1)
			lhInc += "\n##def1 LH_SDD_stopDay    " + ltSettings.sddStopDate.date
			lhInc += "\n##def1 LH_SDD_typeOfDD    " + ltSettings.sddTypeOfDD
			
			//lhInc += "\n##def1 LH_DD_heating       " + setupVO.ddHeating
			//lhInc += "\n##def1 LH_DD_cooling       " + setupVO.ddCooling
			//lhInc += "\n##def1 LH_DD_other         " + setupVO.ddOther
			
			lhInc += "\n##def1 LH_timeStepEP       " + ltSettings.timeStepEP
			lhInc += "\n##def1 LH_Orientation " + ltSettings.northAxis + "\n"
			
			lhInc += "\n\n! Variables for building setup"
			lhInc += "\n##def1 LH_Orientation      " + ltSettings.northAxis
			lhInc += "\n##def1 LH_zoneOfInterest   " + ltSettings.zoneOfInterest
			lhInc += "\n##def1 LH_region           " + ltSettings.region
			lhInc += "\n##def1 LH_location           " + ltSettings.city
			lhInc += "\n##def1 LH_shell            " + ltSettings.shell
			
			lhInc += "\n\n! Variables for building geometry " 
			lhInc += "\n##def1 LH_stories          " + ltSettings.stories
			lhInc += "\n##def1 LH_storyHeight        " + ltSettings._storyHeight		//SI Value
			lhInc += "\n##def1 LH_width            " + ltSettings._buildingWidth		//SI Value
			lhInc += "\n##def1 LH_length           " + ltSettings._buildingLength		//SI Value
			lhInc += "\n##def1 LH_WWR_North        " + ltSettings.windowRatioNorth
			lhInc += "\n##def1 LH_WWR_South        " + ltSettings.windowRatioSouth
			lhInc += "\n##def1 LH_WWR_East        " + ltSettings.windowRatioEast
			lhInc += "\n##def1 LH_WWR_West        " + ltSettings.windowRatioWest
			lhInc += "\n##def1 LH_WWR_Bldg         " + ltSettings.ratioBldg
			
			lhInc += "\n\n! Variables for building envlope construction"
			lhInc += "\n##def1 LH_massLevel        " + ltSettings.massLevel
			
			lhInc += "\n\n! Variables for internal loads"
			lhInc += "\n##def1 LH_lightingPeakLoad " + ltSettings._lightingPeakLoad		//SI Value
			lhInc += "\n##def1 LH_equipPeakLoad    " + ltSettings._equipPeakLoad		//SI Value
			lhInc += "\n##def1 LH_areaPerPerson    " + ltSettings._areaPerPerson		//SI Value
			
			/* *************** */
			/* SPARK VARIABLES */
			/* *************** */
			
			lhInc += "\n\n! SPK Variables for temp of room & supply air"
			
			var tRoomSPHeat:SystemVariable = scenModel.getSysVar("TRoomSP_Heat")
			var tRoomSPCool:SystemVariable = scenModel.getSysVar("TRoomSP_Cool")
			
			//lhInc += "\n##def1 SPK_TRoomSP       " + tRoomSP_val
			lhInc += "\n##def1 SPK_HRoomSP       " + tRoomSPHeat.baseSIValue
			lhInc += "\n##def1 SPK_CRoomSP       " + tRoomSPCool.baseSIValue
			
			var tSupS:SystemVariable = scenModel.getSysVar("TSupS")			
			lhInc += "\n##def1 SPK_TSupS         " + tSupS.baseSIValue
			lhInc += "\n##def1 SPK_DCSupS        15 ! For now set this = 15 C"
			lhInc += "\n##def1 SPK_DHSupS        35 ! For now set this = 35 C"

			var rmQSens:SystemVariable = scenModel.getSysVar("RmQSENS") 
			var rmQSens_val:Number = rmQSens.baseSIValue
			lhInc += "\n\n! SPK Variable for total room internal load" 
			lhInc += "\n##def1 SPK_RmQSENS         " + rmQSens.baseSIValue

	
			var vavPosMin:SystemVariable = scenModel.getSysVar("VAVposMin") 
			lhInc += "\n\n! SPK Variable for equip max/min settings"
			lhInc += "\n##def1 SPK_VAVminpos       " + vavPosMin.baseSIValue
			
			var fanpowerTot:SystemVariable = scenModel.getSysVar("FanpowerTot") 
			lhInc += "\n##def1 SPK_FanpowerTot     "+ fanpowerTot.baseSIValue
			
			var hcUA:SystemVariable = scenModel.getSysVar("HCUA") 
			lhInc += "\n##def1 SPK_HCUA     "+ hcUA.baseSIValue
			
			var vavHCUA:SystemVariable = scenModel.getSysVar("VAVHCUA") 
			lhInc += "\n##def1 SPK_VAVHCUA     "+ vavHCUA.baseSIValue
			
			var ccUA:SystemVariable = scenModel.getSysVar("CCUA") 
			lhInc += "\n##def1 SPK_CCUA     "+ ccUA.baseSIValue
						
			var pAtm:SystemVariable = scenModel.getSysVar("PAtm") 
			lhInc += "\n##def1 SPK_PAtm     "+ pAtm.baseSIValue
			
			
			var mxTOut:SystemVariable = scenModel.getSysVar("MXTOut") 
			lhInc += "\n##def1 SPK_MXTOut     "+ mxTOut.baseSIValue
			
			
			var mxTwOut:SystemVariable = scenModel.getSysVar("MXTwOut") 
			lhInc += "\n##def1 SPK_MXTwOut     "+ mxTwOut.baseSIValue
						 
			// load base .inc file to which we'll add variables
			try
			{
				var stream:FileStream = new FileStream()
				stream.open(_paramBaseFile, FileMode.READ)
				var paramLgOff:String = stream.readUTFBytes(stream.bytesAvailable)
			}
			catch(e:Error)
			{
				Logger.error(" couldn't load Param_LgOff.inc file", this)
				mx.controls.Alert.show("Couldn't load " + _paramBaseFile.name + ".","Error")
				return false
			}
			
			var outputParamLgOff:String = lhInc + "\n\n" + paramLgOff
			
			Logger.debug(" writing output to ParamLgOff: " + outputParamLgOff, this)
			
			// save new version
			try
			{				
				_stream.open(_paramFile, FileMode.WRITE)
				_stream.writeUTFBytes(outputParamLgOff)
				_stream.close()
				Logger.debug(" output file written", this)
				
			}
			catch(e:Error)
			{
				Logger.error(" couldn't save " + _paramFile.nativePath + "file. Error: " + e.message, this)
				mx.controls.Alert.show("Couldn't save " + _paramFile.name + ". Error: " + e.message,"Error")
				return false
			}			
			 
			
			////////////////////////////////////////						
			// STARTUP ENERGY PLUS
			////////////////////////////////////////
						

			try
			{
				//run energyPlus via proxy
				var launchEPlusHelper:File = File.applicationDirectory.resolvePath("energyplus/launchEPlusHelper.exe")
				
				if (Capabilities.os.toLowerCase().indexOf("mac") > -1)
				{
					Alert.show("can't run EPlus on mac just yet.")
					return false
				}
												
				var startupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo()
				startupInfo.executable = launchEPlusHelper
				startupInfo.workingDirectory = File.applicationDirectory.resolvePath("energyplus")
				_process.addEventListener(NativeProcessExitEvent.EXIT, onProcessFinished)
				_process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onStandardOutput)
				_process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onStandardError)
				try
				{
					_process.start(startupInfo)
				}
				catch (err:Error)
				{				
					Logger.error("runEnergyPlus() Error starting process: "+ err, this)
					Alert.show("Cannot start EnergyPlus. Please try again or contact support for help.")
				}
								
				
			} 
			catch(error:Error)
			{
				var msg:String =  "Couldn't launch runEPlusHelper.exe"
				Logger.error(" " + msg)
				mx.controls.Alert.show(msg)
				return false	
			}
									
			return true
		}
		
		
			
		/* *************************** */
		/*  Process Command Listeners  */
		/* *************************** */
		
		
		
		public function onStandardOutput(event:ProgressEvent):void
		{
			var text:String = _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable)
			Logger.debug("onProcessOutput text: " + text, this)
		}

		public function onStandardError(event:ProgressEvent):void
		{
			var text:String = _process.standardError.readUTFBytes(_process.standardError.bytesAvailable)
			Logger.debug("onProcessError text: " + text, this)			
		}
		
		public function onProcessFinished(event:NativeProcessExitEvent):void
		{
			Logger.debug("onProcessFinished event: " + event, this)
			if (_eplusOutVarsFile.exists && _eplusOutputMeterFile.exists)
			{
				loadOutputFiles()
			}
			else
			{
				//TODO: Need to do check to make sure E+ ended correctly			
				var msg:String = "Output files weren't generated. Please see log and energplus error files for details."
				Logger.error( msg, this)
				mx.controls.Alert.show(msg)
			}			
		}
				
		public function cancelEPlus():void
		{
			Logger.debug(" trying to kill EPlus process: " + _process, this)
			_process.exit(true)
		}
		
	
		
		public function loadOutputFiles():void
		{
			Logger.debug(" Output file finished. Loading ...", this)
						
			//DISCUSSION:
			//Zinc is causing lots of problems here when trying to loadFile.
			//We discovered that the file exists and are therefore in this function
			//However, if the file is still being written, Zinc throws an error
			//but Zinc does not trap errors well with Flex. So for now
			//just using a try block and then letting the error die silently while
			//keeping the timer going. If the read goes through, THEN we turn the timer off. 
			//We try five times, if still no success, then we fail
						
			try
			{
				Logger.debug(" Trying to read... (try #"+ _readTries+")", this)
				var stream:FileStream = new FileStream()
				stream.open (_eplusOutVarsFile, FileMode.READ)				
				var basicOutputData:String  = stream.readUTFBytes(stream.bytesAvailable)
			}
			catch(error:Error)
			{
				_readTries++
				if (_readTries>10)
				{
        			Logger.error("couldn't read the LgOff.csv output file. Error: " + error), this
					mx.controls.Alert.show("Error while trying to read the EnergyPlus LgOff.csv file.  \n\nError msg: " + error)
					command.setupFailed()
				}
				return
			}
		
			//try to read meter
			try
			{
				_stream.open (_eplusOutputMeterFile, FileMode.READ)				
				var basicMeterData:String  = stream.readUTFBytes(stream.bytesAvailable)
			}
			catch(error:Error)
			{
				Logger.error("LTSD: couldn't read the LgOffMeter.csv output file. Error: " + error, this)
				mx.controls.Alert.show("Error while trying to read the EnergyPlus LgOffMeter.csv file.  \n\nError msg: " + error)
				command.setupFailed()
				return				
			}
			
			//the rest of this won't be run if mdm.FileSystem.loadFile throws an error
			
			//make sure files have something in them...
			if (basicMeterData == null)
			{
				Logger.error("basicMeterData file is empty!", this)
				mx.controls.Alert.show("There was an error during the E+ run: no data available in LgOffMeter.csv.")
				return
			}
			if (basicOutputData == null)
			{
				Logger.error("basicOutputData file is empty!", this)
				mx.controls.Alert.show("There was an error during the E+ run: no data available in LgOff.csv.")
				return
			}
				
			
			//update models...models will parse data
			var scenarioModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			try
			{
				scenarioModel.ePlusRunsModel.loadEPlusOutput(basicOutputData, basicMeterData, _runID)
			}
			catch (err:EPlusParseError)
			{
				Logger.error("had trouble parsing E+ output. Err: " + err, this)
				mx.controls.Alert.show("There were some errors when parsing EnergyPlus output. Some data may be missing. Error: " + err)
			}
			
			//launch event (for the modal dialog)
			var ePlusDataEvent:ScenarioDataLoadedEvent = new ScenarioDataLoadedEvent(ScenarioDataLoadedEvent.EVENT_EPLUS_FILE_LOADED)
			CairngormEventDispatcher.getInstance().dispatchEvent(ePlusDataEvent)			
			
			command.setupFinished(_runID)
		}
		 

		
		
	}
}