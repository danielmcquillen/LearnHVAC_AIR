package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.mcquilleninteractive.learnhvac.err.EPlusParseError;
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataLoadedEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.event.EnergyPlusEvent;
	import com.mcquilleninteractive.learnhvac.event.LongTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationModel
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.*;
	import flash.system.Capabilities;
	import flash.events.Event
	import mx.controls.Alert;
	import org.swizframework.Swiz;
	import flash.events.EventDispatcher;

	
	public class LongTermSimulationDelegate extends EventDispatcher
	{
		
		[Autowire]
		public var applicationModel:ApplicationModel
		
		[Autowire]
		public var scenarioModel:ScenarioModel
				
		[Autowire]
		public var longTermSimulationModel:LongTermSimulationModel
						
		[Autowire]
		public var longTermSimulationDataModel:LongTermSimulationDataModel
			
		protected var _energyPlusPath:String = ApplicationModel.baseStoragePath + "energyplus/"
		protected var _ePlusExe:File
		protected var _includeFilesDir:File
		protected var _paramBaseFile:File		
		protected var _paramFile:File		
		protected var _eplusOutVarsFile:File
		protected var _eplusOutputMeterFile:File	
		
		protected var _process:NativeProcess	
		protected var _stream:FileStream
		protected var _runID:String 			
		protected var _processID:Number = 0; //returned from ZINC when starting eplus process
					
			
		public function LongTermSimulationDelegate()
		{						
			var baseDir:File = File.userDirectory.resolvePath(_energyPlusPath)
			
			_ePlusExe = baseDir.resolvePath("LearnHVACEPlusLauncher.exe")
			_includeFilesDir =  baseDir.resolvePath("LgOff/IncFiles")
			_paramBaseFile = baseDir.resolvePath("LgOff/IncFiles/Param_LgOff_base.inc")
			_paramFile = baseDir.resolvePath("LgOff/IncFiles/Param_LgOff.inc")
			_eplusOutVarsFile = baseDir.resolvePath('LgOff/Output/LgOff.csv')
			_eplusOutputMeterFile = baseDir.resolvePath('LgOff/Output/LgOffMeter.csv')
			
			_stream = new FileStream()
			
		}
				
		public function runLongTermSimulation():void
		{
			Logger.debug(" runLongTermSimulation() called...", this)		
			if (_ePlusExe.exists==false)
			{
				var msg:String = "Couldn't find the required EnergyPlus file (" + _ePlusExe.nativePath +"). This file is required."
				Logger.error("runLongTermSimulation() error: " + msg, this)
				throw new Error(msg)				
			}
			
			_runID = longTermSimulationModel.runID
			
			//if this is test mode, just jump straight to reading output
			if (ApplicationModel.testMode)
			{
				loadOutputFiles()
				return
			}
	
	
			//Check weather file exists...and if so copy to In.epw
			var weatherFile:File = File.userDirectory.resolvePath(_energyPlusPath+ "Weather/" + longTermSimulationModel.weatherFile)
			var inEPWFile:File = File.userDirectory.resolvePath(_energyPlusPath + "In.epw")
			
			if (weatherFile.exists==false)
			{
				Logger.warn(" couldn't find selected weather file " + weatherFile.nativePath, this)
				msg = "The weather file for the city you selected ("+longTermSimulationModel.weatherFile+") is not in the energyplus\\Weather folder. Please select another city."
				throw new Error(msg)
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
					Logger.warn(" couldn't find .inc file " + includeFile.nativePath, this)
					msg = "Couldn't find " + fileName +" in the EnergyPlus IncFiles folder. This file is required."	
					throw new Error(msg)
				}	
			}
				
			Logger.debug(" runID set to : " + _runID, this)			
			Logger.debug(" checking if output files exist...if so, delete them...")
									
			//Clear out existing output, if present	
			/*This isn't working after first run...E+ is somehow holding onto files				
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
					msg = "Couldn't delete " + _eplusOutVarsFile.name +" in the EnergyPlus IncFiles folder before running simulation. Please close this file if open."
					throw new Error(msg)
				}				
			}
			
			if (_eplusOutputMeterFile.exists)
			{
				try
				{
					_eplusOutputMeterFile.deleteFile()
				}
				catch(e:Error)
				{
					Logger.warn(" couldn't delete " + _eplusOutputMeterFile.nativePath, this)
					msg = "Couldn't delete " + _eplusOutputMeterFile.name +" in the EnergyPlus IncFiles folder before running simulation. Please close this file if open."	
					throw new Error(msg)
				}
				
			}
			*/
			
						
			////////////////////////////////////////					
			// BUILD SAVE THE LEARN HVAC .inc file
			////////////////////////////////////////
			
			Logger.debug(" buildilng .inc file...")
			var lhInc:String 
			lhInc = "\n"
			lhInc += "!  Parameter File for Large Office Prototype\n\n"
			lhInc += "! ***************************************************************\n"
			lhInc += "! Learn HVAC-specific values are included below\n"
			lhInc += "! ***************************************************************\n"
						
			//write in .inc lines, substituting in values from SPARK
			lhInc += "\n! Variables for general setup"
			lhInc += "\n##def1 LH_ScenarioName	   " + scenarioModel.name
			lhInc += "\n##def1 LH_weatherFile      " + longTermSimulationModel.weatherFile
			Logger.debug("startDate: " + longTermSimulationModel.startDate)
			Logger.debug("stopDate: " + longTermSimulationModel.stopDate)
			lhInc += "\n##def1 LH_startMonth         " + (longTermSimulationModel.startDate.month + 1)
			lhInc += "\n##def1 LH_startDay         " + longTermSimulationModel.startDate.date
			lhInc += "\n##def1 LH_stopMonth         " + (longTermSimulationModel.stopDate.month + 1)
			lhInc += "\n##def1 LH_stopDay          " + longTermSimulationModel.stopDate.date
			lhInc += "\n##def1 LH_WDD_startMonth   " + (longTermSimulationModel.wddStartDate.month + 1)
			lhInc += "\n##def1 LH_WDD_startDay     " + longTermSimulationModel.wddStartDate.date
			lhInc += "\n##def1 LH_WDD_stopMonth    " + (longTermSimulationModel.wddStopDate.month + 1)
			lhInc += "\n##def1 LH_WDD_stopDay    " + longTermSimulationModel.wddStopDate.date
			lhInc += "\n##def1 LH_WDD_typeOfDD     " + longTermSimulationModel.wddTypeOfDD
			lhInc += "\n##def1 LH_SDD_startMonth    " + (longTermSimulationModel.sddStartDate.month + 1)
			lhInc += "\n##def1 LH_SDD_startDay    " + longTermSimulationModel.sddStartDate.date
			lhInc += "\n##def1 LH_SDD_stopMonth    " + (longTermSimulationModel.sddStopDate.month + 1)
			lhInc += "\n##def1 LH_SDD_stopDay    " + longTermSimulationModel.sddStopDate.date
			lhInc += "\n##def1 LH_SDD_typeOfDD    " + longTermSimulationModel.sddTypeOfDD
			
			//lhInc += "\n##def1 LH_DD_heating       " + setupVO.ddHeating
			//lhInc += "\n##def1 LH_DD_cooling       " + setupVO.ddCooling
			//lhInc += "\n##def1 LH_DD_other         " + setupVO.ddOther
			
			lhInc += "\n##def1 LH_timeStepEP       " + longTermSimulationModel.timeStepEP
			lhInc += "\n##def1 LH_Orientation " + longTermSimulationModel.northAxis + "\n"
			
			lhInc += "\n\n! Variables for building setup"
			lhInc += "\n##def1 LH_Orientation      " + longTermSimulationModel.northAxis
			lhInc += "\n##def1 LH_zoneOfInterest   " + longTermSimulationModel.zoneOfInterest
			lhInc += "\n##def1 LH_region           " + longTermSimulationModel.region
			lhInc += "\n##def1 LH_location           " + longTermSimulationModel.city
			lhInc += "\n##def1 LH_shell            " + longTermSimulationModel.shell
			
			lhInc += "\n\n! Variables for building geometry " 
			lhInc += "\n##def1 LH_stories          " + longTermSimulationModel.stories
			lhInc += "\n##def1 LH_storyHeight        " + longTermSimulationModel._storyHeight		//SI Value
			lhInc += "\n##def1 LH_width            " + longTermSimulationModel._buildingWidth		//SI Value
			lhInc += "\n##def1 LH_length           " + longTermSimulationModel._buildingLength		//SI Value
			lhInc += "\n##def1 LH_WWR_North        " + longTermSimulationModel.windowRatioNorth
			lhInc += "\n##def1 LH_WWR_South        " + longTermSimulationModel.windowRatioSouth
			lhInc += "\n##def1 LH_WWR_East        " + longTermSimulationModel.windowRatioEast
			lhInc += "\n##def1 LH_WWR_West        " + longTermSimulationModel.windowRatioWest
			lhInc += "\n##def1 LH_WWR_Bldg         " + longTermSimulationModel.ratioBldg
			
			lhInc += "\n\n! Variables for building envlope construction"
			lhInc += "\n##def1 LH_massLevel        " + longTermSimulationModel.massLevel
			
			lhInc += "\n\n! Variables for internal loads"
			lhInc += "\n##def1 LH_lightingPeakLoad " + longTermSimulationModel._lightingPeakLoad		//SI Value
			lhInc += "\n##def1 LH_equipPeakLoad    " + longTermSimulationModel._equipPeakLoad		//SI Value
			lhInc += "\n##def1 LH_areaPerPerson    " + longTermSimulationModel._areaPerPerson		//SI Value
			
			/* *************** */
			/* SPARK VARIABLES */
			/* *************** */
			
			lhInc += "\n\n! SPK Variables for temp of room & supply air"
			
			var tRoomSPHeat:SystemVariable = scenarioModel.getSysVar("TRoomSP_Heat")
			var tRoomSPCool:SystemVariable = scenarioModel.getSysVar("TRoomSP_Cool")
			
			//lhInc += "\n##def1 SPK_TRoomSP       " + tRoomSP_val
			lhInc += "\n##def1 SPK_HRoomSP       " + tRoomSPHeat.baseSIValue
			lhInc += "\n##def1 SPK_CRoomSP       " + tRoomSPCool.baseSIValue
			
			var tSupS:SystemVariable = scenarioModel.getSysVar("TSupS")			
			lhInc += "\n##def1 SPK_TSupS         " + tSupS.baseSIValue
			lhInc += "\n##def1 SPK_DCSupS        15 ! For now set this = 15 C"
			lhInc += "\n##def1 SPK_DHSupS        35 ! For now set this = 35 C"

			var rmQSens:SystemVariable = scenarioModel.getSysVar("RmQSENS") 
			var rmQSens_val:Number = rmQSens.baseSIValue
			lhInc += "\n\n! SPK Variable for total room internal load" 
			lhInc += "\n##def1 SPK_RmQSENS         " + rmQSens.baseSIValue

	
			var vavPosMin:SystemVariable = scenarioModel.getSysVar("VAVposMin") 
			lhInc += "\n\n! SPK Variable for equip max/min settings"
			lhInc += "\n##def1 SPK_VAVminpos       " + vavPosMin.baseSIValue
			
			var fanpowerTot:SystemVariable = scenarioModel.getSysVar("FanpowerTot") 
			lhInc += "\n##def1 SPK_FanpowerTot     "+ fanpowerTot.baseSIValue
			
			var hcUA:SystemVariable = scenarioModel.getSysVar("HCUA") 
			lhInc += "\n##def1 SPK_HCUA     "+ hcUA.baseSIValue
			
			var vavHCUA:SystemVariable = scenarioModel.getSysVar("VAVHCUA") 
			lhInc += "\n##def1 SPK_VAVHCUA     "+ vavHCUA.baseSIValue
			
			var ccUA:SystemVariable = scenarioModel.getSysVar("CCUA") 
			lhInc += "\n##def1 SPK_CCUA     "+ ccUA.baseSIValue
						
			var pAtm:SystemVariable = scenarioModel.getSysVar("PAtm") 
			lhInc += "\n##def1 SPK_PAtm     "+ pAtm.baseSIValue
			
			
			var mxTOut:SystemVariable = scenarioModel.getSysVar("MXTOut") 
			lhInc += "\n##def1 SPK_MXTOut     "+ mxTOut.baseSIValue
			
			
			var mxTwOut:SystemVariable = scenarioModel.getSysVar("MXTwOut") 
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
				msg = "Couldn't load " + _paramBaseFile.name + "."
				throw new Error(msg)
			}
			
			var outputParamLgOff:String = lhInc + "\n\n" + paramLgOff
			
			
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
				msg = "Couldn't save " + _paramFile.name + ". Error: " + e.message
				throw new Error(msg)
			}			
			 
			
			////////////////////////////////////////						
			// STARTUP ENERGY PLUS
			////////////////////////////////////////
						
			try
			{
				//run energyPlus via proxy
				var launchEPlusHelper:File = File.userDirectory.resolvePath(_energyPlusPath + "LearnHVACEPlusLauncher.exe")
				
				if (Capabilities.os.toLowerCase().indexOf("mac") > -1)
				{
					msg = "can't run EnergyPlus on mac just yet. :-("
					throw new Error(msg)
				}
				_process = new NativeProcess()								
				var startupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo()
				startupInfo.executable = launchEPlusHelper
				startupInfo.workingDirectory = File.userDirectory.resolvePath(_energyPlusPath)
				_process.addEventListener(NativeProcessExitEvent.EXIT, onProcessFinished)
				_process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onStandardOutput)
				_process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onStandardError)
				_process.start(startupInfo)								
			} 
			catch(error:Error)
			{
				msg =  "Couldn't launch runEPlusHelper.exe. See log for details."
				Logger.error(msg + " error: " + error, this)
				throw new Error(msg)
			}
							
		}
		
		
			
		/* *************************** */
		/*  Process Command Listeners  */
		/* *************************** */
			
		public function onStandardOutput(event:ProgressEvent):void
		{
			var text:String = _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable)
			
			var evt:EnergyPlusEvent = new EnergyPlusEvent(EnergyPlusEvent.ENERGY_PLUS_OUTPUT,true)
			evt.output = text
			Swiz.dispatchEvent(evt)
			
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
				var evt:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				var message:String = "Output files weren't generated. Please see log and energplus error files for details."
				Logger.error( message, this)
				evt.errorMessage = message
				Swiz.dispatchEvent(evt)
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
			
			//TODO Better error reporting when simulation fails	
															
			try
			{
				var stream:FileStream = new FileStream()
				stream.open (_eplusOutVarsFile, FileMode.READ)				
				var basicOutputData:String  = stream.readUTFBytes(stream.bytesAvailable)
			}
			catch(error:Error)
			{
				Logger.error("couldn't read the LgOff.csv output file. Error: " + error), this				
				var msg:String = "Error while trying to read the EnergyPlus LgOff.csv file."
				event = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				event.errorMessage = msg
				Swiz.dispatchEvent(event)
				return
			}
		
			//try to read meter
			try
			{
				stream.open (_eplusOutputMeterFile, FileMode.READ)				
				var basicMeterData:String  = stream.readUTFBytes(stream.bytesAvailable)
			}
			catch(error:Error)
			{
				Logger.error("LTSD: couldn't read the LgOffMeter.csv output file. Error: " + error, this)
				msg = "Error while trying to read the EnergyPlus LgOffMeter.csv file."
				event = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				event.errorMessage = msg
				Swiz.dispatchEvent(event)
				return				
			}
						
			//make sure files have something in them...
			if (basicMeterData == null)
			{
				Logger.error("basicMeterData file is empty!", this)
				msg = "There was an error during the E+ run: no data available in LgOffMeter.csv."				
				event = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				event.errorMessage = msg
				Swiz.dispatchEvent(event)
				return
			}
			if (basicOutputData == null)
			{
				Logger.error("basicOutputData file is empty!", this)
				msg = "There was an error during the E+ run: no data available in LgOff.csv."				
				event = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				event.errorMessage = msg
				Swiz.dispatchEvent(event)
				return
			}
			
			var event:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.FILE_LOADED, true)
			dispatchEvent(event)
							
			try
			{
				longTermSimulationDataModel.loadEPlusOutput(basicOutputData, basicMeterData, _runID)
			}
			catch (err:EPlusParseError)
			{
				Logger.error("had trouble parsing E+ output. Err: " + err, this)
				msg = "Error when parsing EnergyPlus output. Error: " + err
				event = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				event.errorMessage = msg
				dispatchEvent(event)
			}			
		
			Logger.debug("Finished simulation. runID was: " + _runID,this)
			
			var evt:Event = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_COMPLETE, true)
			dispatchEvent(evt)
		}
		 

		
		
	}
}