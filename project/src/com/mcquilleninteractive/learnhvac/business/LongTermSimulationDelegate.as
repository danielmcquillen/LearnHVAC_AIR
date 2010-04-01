package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.mcquilleninteractive.learnhvac.err.EPlusParseError;
	import com.mcquilleninteractive.learnhvac.event.EnergyPlusEvent;
	import com.mcquilleninteractive.learnhvac.event.LongTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.*;
	import flash.system.Capabilities;
	
	import org.swizframework.Swiz
	
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
		protected var _baseDir:File
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
			_baseDir	 = File.userDirectory.resolvePath(_energyPlusPath)
			
			_ePlusExe = _baseDir.resolvePath("LearnHVACEPlusLauncher.exe")
			_includeFilesDir =  _baseDir.resolvePath("LgOff/IncFiles")
			_paramBaseFile = _baseDir.resolvePath("LgOff/IncFiles/Param_LgOff_base.inc")
			_paramFile = _baseDir.resolvePath("LgOff/IncFiles/Param_LgOff.inc")
			_eplusOutVarsFile = _baseDir.resolvePath('LgOff/Output/LgOff.csv')
			_eplusOutputMeterFile = _baseDir.resolvePath('LgOff/Output/LgOffMeter.csv')			
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
			if (ApplicationModel.mockEPlusData)
			{
				loadOutputFiles()
				return
			}
	
	
			//Check weather file exists...and if so copy to In.epw
			
			if (longTermSimulationModel.weatherFile==null)
			{
				Logger.error("Missing weather file from longTermSimulationModel",this)
			}
			
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
			var includeFiles:Array = ["BldgGeom.inc","ParamCalc.inc",
										"BldgGeom.inc","Construction.inc",
										"general.inc","location.inc","material.inc",
										"report.inc","Schedule.inc","SpCond.inc",
										"System.inc"
										]
													
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
									
					
						
			////////////////////////////////////////					
			// BUILD SAVE THE LEARN HVAC .inc file
			////////////////////////////////////////
			
			Logger.debug(" buildilng .inc file...")
			var lhInc:String = buildOutputString()
									 
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
			
				Logger.debug("Starting energyPlus from: " + launchEPlusHelper.nativePath,this)
			
				_process = new NativeProcess()								
				var startupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo()
				startupInfo.executable = launchEPlusHelper
				startupInfo.workingDirectory = _baseDir
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
		
		public function buildOutputString():String
		{
			var lhInc:String = ""
			lhInc += "!  Parameter File for Large Office Prototype"
			lhInc += "\n! ***************************************************************"
			lhInc += "\n! Learn HVAC-specific values are included below"
			lhInc += "\n! ***************************************************************"
						
			//write in .inc lines, substituting in values from MODELICA
			lhInc += "\n! Variables for general setup"
			lhInc += "\n##def1 LH_ScenarioName	   " + scenarioModel.name
			lhInc += "\n##def1 LH_weatherFile      " + longTermSimulationModel.weatherFile
			
			//make sure to add one to months, since Flex stores dates as
			// 0 index and E+ wants them as 1 index.
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
			
			/* ****************** */
			/* MODELICA VARIABLES */
			/* ****************** */
			
			/* Note...at some point we need to change up the variable names 
			   encoded in the E+ input template. I'm leaving as MOD_ for now
			   but should be MDL_
			*/
			
			lhInc += "\n\n! SPK Variables for temp of room & supply air"
			
			var tRoomSPHeat:SystemVariable = scenarioModel.getSysVar("SYSTRmSPHeat")
			var tRoomSPCool:SystemVariable = scenarioModel.getSysVar("SYSTRmSPCool")
			
			//lhInc += "\n##def1 MOD_TRoomSP       " + tRoomSP_val
			lhInc += "\n##def1 MOD_HRoomSP       " + tRoomSPHeat.baseSIValue
			lhInc += "\n##def1 MOD_CRoomSP       " + tRoomSPCool.baseSIValue
			
			var tSupS:SystemVariable = scenarioModel.getSysVar("SYSTSupS")			
			lhInc += "\n##def1 MOD_TSupS         " + tSupS.baseSIValue
			lhInc += "\n##def1 MOD_DCSupS        15 ! For now set this = 15 C"
			lhInc += "\n##def1 MOD_DHSupS        35 ! For now set this = 35 C"

			var rmQSens:SystemVariable = scenarioModel.getSysVar("SYSRmQSens") 
			var rmQSens_val:Number = rmQSens.baseSIValue
			lhInc += "\n\n! SPK Variable for total room internal load" 
			lhInc += "\n##def1 MOD_RmQSENS         " + rmQSens.baseSIValue

	
			var vavPosMin:SystemVariable = scenarioModel.getSysVar("VAVMinPos") 
			lhInc += "\n\n! SPK Variable for equip max/min settings"
			lhInc += "\n##def1 MOD_VAVminpos       " + (vavPosMin.baseSIValue / 100).toString() // since we keep as percentage and E+ expects 0 > value >1
			
			var fanpower:SystemVariable = scenarioModel.getSysVar("FANPwr") 
			lhInc += "\n##def1 MOD_FanpowerTot     "+ fanpower.baseSIValue
			
			var hcUA:SystemVariable = scenarioModel.getSysVar("HCQd") 
			lhInc += "\n##def1 MOD_HCUA     "+ hcUA.baseSIValue
			
			var vavHCUA:SystemVariable = scenarioModel.getSysVar("VAVRhcQd") 
			lhInc += "\n##def1 MOD_VAVHCUA     "+ vavHCUA.baseSIValue
			
			var ccUA:SystemVariable = scenarioModel.getSysVar("CCQd") 
			lhInc += "\n##def1 MOD_CCUA     "+ ccUA.baseSIValue
						
			//We don't have PAtm right now (3/11/2010) so just use default value			
			//var pAtm:SystemVariable = scenarioModel.getSysVar("PAtm") 
			//lhInc += "\n##def1 MOD_PAtm     "+ pAtm.baseSIValue
			lhInc += "\n##def1 MOD_PAtm     101325.0"
						
			var mxTOut:SystemVariable = scenarioModel.getSysVar("SYSTAirDB") 
			lhInc += "\n##def1 MOD_MXTOut     "+ mxTOut.baseSIValue
			
			
			var mxTwOut:SystemVariable = scenarioModel.getSysVar("SYSTAirDB") 
			lhInc += "\n##def1 MOD_MXTwOut     "+ mxTwOut.baseSIValue
			
			return lhInc
		}
		
			
		/* *************************** */
		/*  Process Command Listeners  */
		/* *************************** */
			
		public function onStandardOutput(event:ProgressEvent):void
		{
			var text:String = _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable)
			Logger.debug("onStandardOutput text: " + text, this)	
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
				dispatchEvent(evt)
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
				var errorEvent:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				errorEvent.errorMessage = msg
				dispatchEvent(errorEvent)
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
				errorEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				errorEvent.errorMessage = msg
				dispatchEvent(errorEvent)
				return				
			}
						
			//make sure files have something in them...
			if (basicMeterData == null)
			{
				Logger.error("basicMeterData file is empty!", this)
				msg = "There was an error during the E+ run: no data available in LgOffMeter.csv."				
				errorEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				errorEvent.errorMessage = msg
				dispatchEvent(errorEvent)
				return
			}
			if (basicOutputData == null)
			{
				Logger.error("basicOutputData file is empty!", this)
				msg = "There was an error during the E+ run: no data available in LgOff.csv."				
				errorEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				errorEvent.errorMessage = msg
				dispatchEvent(errorEvent)
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
				Logger.error("had trouble parsing EnergyPlus output. Err: " + err, this)
				msg = "Error when parsing EnergyPlus output. Error: " + err
				errorEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				errorEvent.errorMessage = msg
				dispatchEvent(errorEvent)
				return
			}			
		
			Logger.debug("Finished simulation. runID was: " + _runID,this)
			
			var evt:Event = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_COMPLETE, true)
			dispatchEvent(evt)
		}
		 

		
		
	}
}