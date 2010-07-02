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
	
	import org.swizframework.Swiz;
	
	public class LongTermSimulationDelegate extends EventDispatcher
	{
		public static const SIMULATION_COMPLETE:String = "energyPlusSimulationComplete";
		
		[Autowire]
		public var applicationModel:ApplicationModel
		
		[Autowire]
		public var scenarioModel:ScenarioModel
				
		[Autowire]
		public var longTermSimulationModel:LongTermSimulationModel
						
		[Autowire]
		public var longTermSimulationDataModel:LongTermSimulationDataModel
			
		protected var _energyPlusPath:String = ApplicationModel.baseStorageDirPath + "EnergyPlus/"
		protected var _weatherFilesPath:String = ApplicationModel.baseStorageDirPath + "weather/"
		protected var _mockDataPath:String = ApplicationModel.baseStorageDirPath + "mockData/"
			
					
		//names of executables
		protected var _epMacroExecutable:String = "EPMacro.exe"
		protected var _energyPlusExecutable:String = "EnergyPlus.exe"
		protected var _readVarsESOExecutable:String = "ReadVarsESO.exe"
		
		//names of files
		protected var _outputVarsFileName:String = "eplusout.csv"
		protected var _outputMeterFileName:String = "eplusoutMeter.csv"
			
		protected var _energyPlusDir:File	
			
		protected var _incFilesDir:File
		protected var _incFileNamesArr:Array
		
		protected var _weatherFileDir:File
		protected var _outputDir:File
		protected var _inputDir:File		
		protected var _outputFilesArr:Array
		protected var _mockDataDir:File 
		protected var _eplusOutVarsFile:File
		protected var _eplusOutputMeterFile:File
		protected var _outputErrFile:File		
		
		protected var _process:NativeProcess	
		protected var _stream:FileStream
		protected var _runID:String 			
		protected var _processID:Number = 0; //returned from ZINC when starting eplus process
		
		protected var _errorMessage:String	
		
		protected var _EPMacroProcess:NativeProcess
		protected var _energyPlusProcess:NativeProcess
		protected var _readVarsESOProcess:NativeProcess
		
		protected var _runningOnMac:Boolean = false
			
		public function LongTermSimulationDelegate()
		{						
			_energyPlusDir = File.userDirectory.resolvePath(_energyPlusPath)
			_weatherFileDir = File.userDirectory.resolvePath(_weatherFilesPath)
			
			_EPMacroProcess  = new NativeProcess()
			_energyPlusProcess = new NativeProcess()
			_readVarsESOProcess = new NativeProcess()	
			
			if (Capabilities.os.toLowerCase().indexOf("mac") == -1)
			{	
				_runningOnMac = false		
			}
			else
			{				
				_runningOnMac = true
				
				//names of executables
				_epMacroExecutable = "epmacro"
				_energyPlusExecutable = "EnergyPlus"
				_readVarsESOExecutable = "readvars"				
			}		
			
			//File objects for .inc files
			_incFilesDir = _energyPlusDir.resolvePath("IncFiles")	
			_outputDir = _energyPlusDir.resolvePath("output")				
			_inputDir = _energyPlusDir.resolvePath("input")
				
			//Static files
			_incFileNamesArr = ["Param_LgOff_base.inc", 
								"ParamCalc.inc",
								"general.inc",
								"location.inc",
								"material.inc",
								"Construction.inc",
								"BldgGeom.inc",
								"SpCond.inc",
								"Schedule.inc",
								"System.inc",
								"report.inc"]
								
			//Output files
			_eplusOutVarsFile =_outputDir.resolvePath(_outputVarsFileName)
			_eplusOutputMeterFile = _outputDir.resolvePath(_outputMeterFileName)			
			_stream = new FileStream()
				
			//these are the files that come out of E+.
			// We use this list to make sure these files are 
			// 1) deleted before starting and
			// 2) copied to /Output after simulation finishes		
			_outputFilesArr = [	"eplusout.err", "eplusout.eio", "eplusout.dxf", "eplusout.eso",
				"eplusout.mtr", "eplusout.mtd", "eplusout.rdd", "eplustbl.htm",
				"eplusout.audit", "eplusout.bnd", 
				"eplusout.end", "eplusout.mdd", "eplusout.shd", "eplusssz.csv", "epluszsz.csv" ]		
				
			
		}
				
				
		public function cancelSimulation():void
		{
			Logger.debug(" trying to kill EPlus process: " + _process, this)
			if(_energyPlusProcess.running)
			{
				_energyPlusProcess.exit(true)
			}
			if(_EPMacroProcess.running)
			{
				_EPMacroProcess.exit(true)
			}
			this.removeEnergyPlusEventListeners()
			this.removeEPMacroEventListeners()
		}
		
		
		
		
		public function runLongTermSimulation():void
		{
			Logger.debug(" runLongTermSimulation() called...", this)	
				
			_runID = longTermSimulationModel.runID
						
			//if this is test mode, copy over mock data and jump straight to reading output
			if (ApplicationModel.mockEPlusData)
			{
				
				var mockEPlusOut:File = File.userDirectory.resolvePath(_mockDataPath + "eplusout.csv")					
				var mockEPlusOutMeter:File = File.userDirectory.resolvePath(_mockDataPath + "eplusoutMeter.csv")
				
				if (_eplusOutVarsFile.exists==false)
				{					
					mockEPlusOut.copyTo(_eplusOutVarsFile)
				}
				if (_eplusOutputMeterFile.exists==false)
				{					
					mockEPlusOutMeter.copyTo(_eplusOutputMeterFile)	
				}			
				loadOutputFiles()
				return
			}
			
			// This is an actual run...
			
			//clear old files
			try
			{
				clearFiles()
			}
			catch(error:Error)
			{
				throw new Error("Could not delete EnergyPlus files. Error: " + error, this)
			}						
					
			//Check weather file exists...and if so copy to in.epw			
			if (longTermSimulationModel.selectedWeatherFileName==null)
			{
				var msg:String = "No weather file selected" 
				Logger.error(msg,this)
				throw new Error(msg)					
			}
			
			var weatherFile:File = _weatherFileDir.resolvePath( longTermSimulationModel.selectedWeatherFileName)
			var inEPWFile:File = _inputDir.resolvePath("in.epw")
							
			if (weatherFile.exists==false)
			{
				Logger.warn(" couldn't find selected weather file " + weatherFile.nativePath, this)
				msg = "The weather file for the city you selected ("+longTermSimulationModel.selectedWeatherFileName+") is not in the " + _weatherFileDir.nativePath + " folder. Please select another city."
				throw new Error(msg)
			}
			else
			{
				weatherFile.copyTo(inEPWFile, true)
			}
					
			//check include files																
			Logger.debug("checking for necessary .inc files...", this)			
			for each (var fileName:String in _incFileNamesArr)
			{
				var includeFile:File = _incFilesDir.resolvePath(fileName)
				if (includeFile.exists==false)
				{					
					Logger.warn(" couldn't find .inc file " + fileName + " in " + _incFilesDir.nativePath, this)
					throw new Error("Couldn't find " + fileName +" in the EnergyPlus IncFiles folder " + _incFilesDir.nativePath + ". This file is required."	)
				}	
			}
																						
			// BUILD AND SAVE THE IN.IMF
			
			//Create and save the IMF file
			var imfOutText:String = createIMFText()
			
			if (imfOutText=="")
			{
				Logger.error(".imf text was null", this)
				throw new Error("Error creating .IMF file")
			}
				
			//Save to input directory
			var outImfFile:File = _inputDir.resolvePath("in.imf")	
			try
			{
				var fileStream:FileStream = new FileStream()
				fileStream.open(outImfFile, FileMode.WRITE)
				fileStream.writeUTFBytes(imfOutText)
				fileStream.close()
			}
			catch(err:Error)
			{
				Logger.error("error writing in.imf file : " + err.message, this)
				throw err
			}	 
			
			runEPMacro()
			
		}
		
		
		
		
		/* ***************** */
		/*  EPMACRO PROCESS  */
		/* ***************** */
		
		protected function runEPMacro():void
		{
			Logger.debug("runEPMacro()",this)
			
			//replace all the functionality of the runEPlus.bat here
			Logger.debug("Copying in.imf to EnergyPlus directory", this)
			var file:File = _inputDir.resolvePath("in.imf")
			var inIMFFile:File = _energyPlusDir.resolvePath("in.imf")
			file.copyTo(inIMFFile, true)
			
			Logger.debug("Copying in.epw to EnergyPlus directory", this)
			file = _inputDir.resolvePath("in.epw")
			var inEPWFile:File = _energyPlusDir.resolvePath("in.epw")
			file.copyTo(inEPWFile, true)
				
			
			var startupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo()
			startupInfo.executable = _energyPlusDir.resolvePath(_epMacroExecutable)
			startupInfo.workingDirectory = _energyPlusDir
			
			_EPMacroProcess.addEventListener(NativeProcessExitEvent.EXIT, onEPMacroProcessFinished)
			_EPMacroProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onEPMacroStandardOutput)
			_EPMacroProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onEPMacroStandardError)
			
			try
			{
				_EPMacroProcess.start(startupInfo)
			}
			catch (err:Error)
			{				
				Logger.error("runEPMacro() Error starting process: "+ err, this)
				throw new Error("Cannot start EPMacro.")
			}
			
		}
		
		public function onEPMacroProcessFinished(event:NativeProcessExitEvent):void
		{
			Logger.debug("onEPMacroProcessFinished() " + event, this)
			removeEPMacroEventListeners()			
			runEnergyPlus()			
		}
		
		public function onEPMacroStandardOutput(event:ProgressEvent):void
		{
			var text:String = _EPMacroProcess.standardOutput.readUTFBytes(_EPMacroProcess.standardOutput.bytesAvailable)
			Logger.debug("EPMacro output: " + text, this)
		}
		
		public function onEPMacroStandardError(event:ProgressEvent):void
		{
			var text:String = _EPMacroProcess.standardError.readUTFBytes(_EPMacroProcess.standardError.bytesAvailable)
			Logger.error("EPMacro error: " + text, this)			
		}
		
			 
		
		
		
		
		
		
		
		
		
		/* ******************** */
		/*  ENERGY PLUS PROCESS */
		/* ******************** */
				
		protected function runEnergyPlus():void
		{
			
			Logger.debug("runEnergyPlus()",this)
			
			//replicate functions from runEplus.bat
			Logger.debug("Copying out.idf to in.idf",this)
			var outODFFile:File = _energyPlusDir.resolvePath("out.idf")
			var inIDFFile:File = _energyPlusDir.resolvePath("in.idf")
			outODFFile.copyTo(inIDFFile, true)
			Logger.debug("Copying in.idf to Input/in.idf",this)
			var inputIDFInFile:File = _inputDir.resolvePath("in.idf")
			inIDFFile.copyTo(inputIDFInFile, true)
						
			var startupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo()
			startupInfo.executable = _energyPlusDir.resolvePath(_energyPlusExecutable)
			startupInfo.workingDirectory = _energyPlusDir
			
			_energyPlusProcess.addEventListener(NativeProcessExitEvent.EXIT, onEnergyPlusProcessFinished)
			_energyPlusProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onEnergyPlusStandardOutput)
			_energyPlusProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onEnergyPlusStandardError)
			
			Logger.debug("Run EnergyPlus as : " + _energyPlusDir.nativePath + _energyPlusExecutable, this)
			
			try
			{
				_energyPlusProcess.start(startupInfo)
			}
			catch (err:Error)
			{				
				Logger.error("runEnergyPlus() Error starting process: "+ err, this)				
				var evt:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				var message:String = "Cannot start EnergyPlus."
				Logger.error( message, this)
				evt.errorMessage = message
				dispatchEvent(evt)
				
			}
		}
		
		public function onEnergyPlusStandardOutput(event:ProgressEvent):void
		{
			var text:String = _energyPlusProcess.standardOutput.readUTFBytes(_energyPlusProcess.standardOutput.bytesAvailable)	
			Logger.debug("onEnergyPlusStandardOutput() text:" + text, this)	
			//send an event to update dialog
			var evt:EnergyPlusEvent = new EnergyPlusEvent(EnergyPlusEvent.ENERGY_PLUS_OUTPUT,true)
			evt.output = text
			Swiz.dispatchEvent(evt)				
		}
		
		public function onEnergyPlusStandardError(event:ProgressEvent):void
		{
			_energyPlusProcess.exit()
			var text:String = _energyPlusProcess.standardError.readUTFBytes(_energyPlusProcess.standardError.bytesAvailable)
			Logger.debug("onEnergyPlusStandardError() text:" + text, this)
				
			if (text.indexOf("error")>-1)
			{
				this.removeEnergyPlusEventListeners()
				var evt:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				var message:String = "EnergyPlus failed. Please see EnergyPlus error file for details : " + this._energyPlusDir.nativePath + "/eplusout.err"
				Logger.error( message, this)
				evt.errorMessage = message
				dispatchEvent(evt)
			}
			
				
		}
		
		public function onEnergyPlusProcessFinished(event:NativeProcessExitEvent):void
		{
			Logger.debug("onEnergyPlusProcessFinished() " + event, this)
			
			//check for required output files
			if (_energyPlusDir.resolvePath("eplusout.mtr").exists==false)
			{				
				throw new Error("EnergyPlus didn't finish correctly, as the eplusout.mtr file is missing.")
			}
			else
			{
				//rename eplusout.mtr to eplusoutMeter.csv
				var meterFile:File = _energyPlusDir.resolvePath("eplusout.mtr")
				meterFile.copyTo(_eplusOutputMeterFile, true)
			}
			if (_energyPlusDir.resolvePath("eplusout.eso").exists==false)
			{				
				throw new Error("EnergyPlus didn't finish correctly, as the eplusout.eso file is missing.")
			}
			
			//move all output files to /output directory, except .eso, which we need for the next step
			for each (var fileName:String in _outputFilesArr)
			{
				//delete all original files except for .eso and .mtr, which we need to be in the EnergyPlus directory for this step
				var deleteFile:Boolean = !(fileName=="eplusout.eso" || fileName=="eplusout.mtr") 
				copyToOutputDir(fileName, deleteFile)
			}
			
			removeEnergyPlusEventListeners()	
			
			
			//now start ReadVars process loop 
			try
			{
				runReadVarESO("output.rvi")			
			}
			catch (err:Error)
			{				
				Logger.error("runEnergyPlus() Error starting process: "+ err, this)
				
				var simEvent:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				var message:String = "Cannot run " + _readVarsESOExecutable
				Logger.error( message, this)
				simEvent.errorMessage = message
				dispatchEvent(simEvent)
				return
			}
			
			
		}
		
		
		
		
		
		
		
		
				
	
		/* ******************** */
		/*   READ VARS ESO      */
		/* ******************** */
		
		
		protected function runReadVarESO(rviFileName:String):void
		{
			
			Logger.debug("runReadVarESO() rviFileName: " + rviFileName, this)
			
			var startupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo()
			startupInfo.executable = _energyPlusDir.resolvePath(_readVarsESOExecutable)
			startupInfo.workingDirectory = _energyPlusDir
			
			var args:Vector.<String> = new Vector.<String>();
			args.push(rviFileName)
			startupInfo.arguments = args
								
			_readVarsESOProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onReadVarsESOStandardOutput)
			_readVarsESOProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onReadVarsESOStandardError)

			if (rviFileName=="output.rvi")
			{				
				//send an event to update dialog
				var evt:EnergyPlusEvent = new EnergyPlusEvent(EnergyPlusEvent.ENERGY_PLUS_OUTPUT,true)
				evt.output = "Running output.rvi" 
				Swiz.dispatchEvent(evt)		
				_readVarsESOProcess.addEventListener(NativeProcessExitEvent.EXIT, onReadVarsEplusoutFinished)
				_readVarsESOProcess.start(startupInfo)
			}
			else if (rviFileName=="outputMeter.rvi")
			{
				var evt:EnergyPlusEvent = new EnergyPlusEvent(EnergyPlusEvent.ENERGY_PLUS_OUTPUT,true)
				evt.output = "Running outputMeter.rvi" 
				Swiz.dispatchEvent(evt)		
				_readVarsESOProcess.addEventListener(NativeProcessExitEvent.EXIT, onReadVarsEplusoutMeterFinished)
				_readVarsESOProcess.start(startupInfo)
			}
			else
			{
				Logger.error("unrecognized .rvi file",this)
				
				var simEvent:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
				var message:String = "Error running .rvi files. Please see log for details."
				Logger.error( message, this)
				simEvent.errorMessage = message
				dispatchEvent(simEvent)
			}
				
						
		}
		
		
		public function onReadVarsESOStandardOutput(event:ProgressEvent):void
		{
			var text:String = _readVarsESOProcess.standardOutput.readUTFBytes(_readVarsESOProcess.standardOutput.bytesAvailable)
				
			//send an event to update dialog
			var evt:EnergyPlusEvent = new EnergyPlusEvent(EnergyPlusEvent.ENERGY_PLUS_OUTPUT,true)
			evt.output = text 
			Swiz.dispatchEvent(evt)		
				
			Logger.debug("ReadVarESO output: " + text, this)
		}
		
		public function onReadVarsESOStandardError(event:ProgressEvent):void
		{
			var text:String = _readVarsESOProcess.standardError.readUTFBytes(_readVarsESOProcess.standardError.bytesAvailable)
			Logger.error("ReadVarESO error: " + text, this)			
		}
		
		/* Immediately after the first .rvi file is run for the variables, start the second for the meter data */
		public function onReadVarsEplusoutFinished(event:NativeProcessExitEvent):void
		{
			Logger.debug("Finished ReadVarsESO for eplusout.rvi, now starting ReadVarsESO for eplusoutMeter.rvi",this)	
			_readVarsESOProcess.removeEventListener(NativeProcessExitEvent.EXIT, onReadVarsEplusoutFinished)
			runReadVarESO("outputMeter.rvi")
		}
		
		
		public function onReadVarsEplusoutMeterFinished(event:NativeProcessExitEvent):void
		{
			
			Logger.debug("Finished ReadVarsESO for eplusoutMeter.rvi, now parsing files...",this)	
												
			removeReadVarsESOEventListeners()
						
			//if files copied to /Output ok, then start loading and parsing
			loadOutputFiles()	
				
			//delete input files in EnergyPlus directory
			var inIDFFile:File = _energyPlusDir.resolvePath("in.idf")
			if (inIDFFile.exists) inIDFFile.deleteFile()
			var outIDFFile:File = _energyPlusDir.resolvePath("out.idf")
			if (outIDFFile.exists) outIDFFile.deleteFile()
			var inEPWFile:File = _energyPlusDir.resolvePath("in.epw")
			if (outIDFFile.exists) outIDFFile.deleteFile()
			var inIMFFile:File = _energyPlusDir.resolvePath("in.imf")
			if (inIMFFile.exists) inIMFFile.deleteFile()
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		/* **************************** */
		/* AFTER SIMULATION IS FINISHED */
		/* **************************** */
				
		
		public function loadOutputFiles():void
		{
			Logger.debug("Output file finished. Loading ...", this)
			
			//TODO Better error reporting when simulation fails	
			
			try
			{				
				var stream:FileStream = new FileStream()
				stream.open (_eplusOutVarsFile, FileMode.READ)				
				var basicOutputData:String  = stream.readUTFBytes(stream.bytesAvailable)
			}
			catch(error:Error)
			{
				Logger.error("couldn't read the " + _eplusOutVarsFile.nativePath +" output file. Error: " + error, this)				
				var msg:String = "Error while trying to read the EnergyPlus eplusout.csv file."
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
				Logger.error("couldn't read the " + _eplusOutputMeterFile.nativePath +" output file. Error: " + error, this)
				msg = "Error while trying to read the EnergyPlus eplusoutMeter.csv file."
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
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		/* ***************** */
		/* HELPER FUNCTIONS */
		/* **************** */
			
		
		protected function createIMFText():String
		{			
			Logger.debug("createIMFText()",this)
			
			//the imf file starts with our custom header and 
			//then contains a concatenation of all the inc files
			var imfOutText:String = buildParamHeader()	
			
			//append each .inc file
			var fileStream:FileStream = new FileStream()
			var len:uint = _incFileNamesArr.length
			var incFile:File
			for (var i:uint=0;i<len; i++)
			{	 			
				var errMsg:String = ""				 			
				try
				{
					incFile = _incFilesDir.resolvePath(_incFileNamesArr[i])
					fileStream.open(incFile, FileMode.READ)
					imfOutText += fileStream.readUTFBytes(fileStream.bytesAvailable)
					fileStream.close() 
				}
				catch(err:Error)
				{
					Logger.error("error reading .inc file : " + incFile.nativePath, this)
					err.message = "Couldn't read .inc file: " + incFile.nativePath + " " + err.message
					throw err
				}
			}
			
			return imfOutText
		}
		
		
		
		
		
		
		
		public function buildParamHeader():String
		{
			var nl:String = File.lineEnding
			var lhInc:String = ""
			lhInc += nl + "!  Parameter File for Large Office Prototype"
			lhInc += nl + "! ***************************************************************"
			lhInc += nl + "! Learn HVAC-specific values are included below"
			lhInc += nl + "! ***************************************************************"
						
			//write in .inc lines, substituting in values from MODELICA
			lhInc += nl + "! Variables for general setup"
			lhInc += nl + "##def1 LH_ScenarioName	   " + scenarioModel.name
			lhInc += nl + "##def1 LH_RunName      " + longTermSimulationModel.getCity(true)
			lhInc += nl + "##def1 LH_BldgName      " + "Large Office in " + longTermSimulationModel.getCity(true)
			
			//make sure to add one to months, since Flex stores dates as
			// 0 index and E+ wants them as 1 index.
			lhInc += nl + "##def1 LH_startMonth         " + (longTermSimulationModel.startDate.month + 1)
			lhInc += nl + "##def1 LH_startDay         " + longTermSimulationModel.startDate.date
			lhInc += nl + "##def1 LH_stopMonth         " + (longTermSimulationModel.stopDate.month + 1)
			lhInc += nl + "##def1 LH_stopDay          " + longTermSimulationModel.stopDate.date
			lhInc += nl + "##def1 LH_WDD_startMonth   " + (longTermSimulationModel.wddStartDate.month + 1)
			lhInc += nl + "##def1 LH_WDD_startDay     " + longTermSimulationModel.wddStartDate.date
			lhInc += nl + "##def1 LH_WDD_stopMonth    " + (longTermSimulationModel.wddStopDate.month + 1)
			lhInc += nl + "##def1 LH_WDD_stopDay    " + longTermSimulationModel.wddStopDate.date
			lhInc += nl + "##def1 LH_WDD_typeOfDD     " + longTermSimulationModel.wddTypeOfDD
			lhInc += nl + "##def1 LH_SDD_startMonth    " + (longTermSimulationModel.sddStartDate.month + 1)
			lhInc += nl + "##def1 LH_SDD_startDay    " + longTermSimulationModel.sddStartDate.date
			lhInc += nl + "##def1 LH_SDD_stopMonth    " + (longTermSimulationModel.sddStopDate.month + 1)
			lhInc += nl + "##def1 LH_SDD_stopDay    " + longTermSimulationModel.sddStopDate.date
			lhInc += nl + "##def1 LH_SDD_typeOfDD    " + longTermSimulationModel.sddTypeOfDD
			
			//lhInc += nl + "##def1 LH_DD_heating       " + setupVO.ddHeating
			//lhInc += nl + "##def1 LH_DD_cooling       " + setupVO.ddCooling
			//lhInc += nl + "##def1 LH_DD_other         " + setupVO.ddOther
			
			lhInc += nl + "##def1 LH_timeStepEP       " + longTermSimulationModel.timeStepEP
			
			lhInc += nl + nl +  "! Variables for building setup"
			lhInc += nl + "##def1 LH_Orientation      " + longTermSimulationModel.northAxis
			lhInc += nl + "##def1 LH_zoneOfInterest   " + longTermSimulationModel.zoneOfInterest
			lhInc += nl + "##def1 LH_region           " + longTermSimulationModel.region
			lhInc += nl + "##def1 LH_location         " + longTermSimulationModel.getCity(true)
			lhInc += nl + "##def1 LH_shell            " + longTermSimulationModel.shell
			
			lhInc += nl + nl + "! Variables for building geometry " 
			lhInc += nl + "##def1 LH_stories          " + longTermSimulationModel.stories
			lhInc += nl + "##def1 LH_storyHeight        " + longTermSimulationModel._storyHeight		//SI Value
			lhInc += nl + "##def1 LH_width            " + longTermSimulationModel._buildingWidth		//SI Value
			lhInc += nl + "##def1 LH_length           " + longTermSimulationModel._buildingLength		//SI Value
			lhInc += nl + "##def1 LH_WWR_North        " + longTermSimulationModel.windowRatioNorth
			lhInc += nl + "##def1 LH_WWR_South        " + longTermSimulationModel.windowRatioSouth
			lhInc += nl + "##def1 LH_WWR_East        " + longTermSimulationModel.windowRatioEast
			lhInc += nl + "##def1 LH_WWR_West        " + longTermSimulationModel.windowRatioWest
			lhInc += nl + "##def1 LH_WWR_Bldg         " + longTermSimulationModel.ratioBldg
			
			lhInc += nl + nl+ "! Variables for building envlope construction"
			lhInc += nl + "##def1 LH_massLevel        " + longTermSimulationModel.massLevel
			
			lhInc += nl + nl +  "! Variables for internal loads"
			lhInc += nl + "##def1 LH_lightingPeakLoad " + longTermSimulationModel._lightingPeakLoad		//SI Value
			lhInc += nl + "##def1 LH_equipPeakLoad    " + longTermSimulationModel._equipPeakLoad		//SI Value
			lhInc += nl + "##def1 LH_areaPerPerson    " + longTermSimulationModel._areaPerPerson		//SI Value
			
			/* ****************** */
			/* MODELICA VARIABLES */
			/* ****************** */
			
			/* Note...at some point we need to change up the variable names 
			   encoded in the E+ input template. I'm leaving as MOD_ for now
			   but should be MDL_
			*/
			
			lhInc += nl + nl + "! Modelica Variables import..."
							
			//set to output variable VAVMinPosRatio
			lhInc += nl + "##def1 MOD_HRoomSP       " + longTermSimulationModel._zoneHeatingSetpointTemp
			lhInc += nl + "##def1 MOD_CRoomSP       " + longTermSimulationModel._zoneCoolingSetpointTemp				
			lhInc += nl + "##def1 MOD_TSupS         " + longTermSimulationModel._supplyAirSetpointTemp
			lhInc += nl + "##def1 MOD_HCUA     "+ longTermSimulationModel.hcUA			
			lhInc += nl + "##def1 MOD_CCUA     "+ longTermSimulationModel.ccUA
			lhInc += nl + "##def1 MOD_VAVminpos       " + (longTermSimulationModel.vavMinFlwRatio / 100).toString() // since we keep as percentage and E+ expects 0 > value >1
			lhInc += nl + "##def1 MOD_VAVHCUA     "+ longTermSimulationModel.vavHcQd					
			//We don't have the following vars from Modelica, so use just use default values	
			lhInc += nl + "##def1 MOD_DCSupS        15 ! For now set this = 15 C"
			lhInc += nl + "##def1 MOD_DHSupS        35 ! For now set this = 35 C"
			lhInc += nl + "##def1 MOD_PAtm     101325.0"
						
				
			return lhInc
		}
		
		
		public function removeEnergyPlusEventListeners():void
		{			
			_energyPlusProcess.removeEventListener(NativeProcessExitEvent.EXIT, onEnergyPlusProcessFinished)
			_energyPlusProcess.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onEnergyPlusStandardOutput)
			_energyPlusProcess.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, onEnergyPlusStandardError)
		}
		
		public function removeEPMacroEventListeners():void
		{			
			_EPMacroProcess.removeEventListener(NativeProcessExitEvent.EXIT, onEPMacroProcessFinished)
			_EPMacroProcess.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onEPMacroStandardOutput)
			_EPMacroProcess.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, onEPMacroStandardError)
		}
		
		public function removeReadVarsESOEventListeners():void
		{			
			_readVarsESOProcess.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onReadVarsESOStandardOutput)
			_readVarsESOProcess.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, onReadVarsESOStandardError)
			_readVarsESOProcess.addEventListener(NativeProcessExitEvent.EXIT, onReadVarsEplusoutFinished)
			_readVarsESOProcess.removeEventListener(NativeProcessExitEvent.EXIT, onReadVarsEplusoutMeterFinished)
		}
		
		protected function clearFiles():void
		{
			Logger.debug("Clearing energyPlus files in preparation for a new run",this)
			//delete E+ files
			var outFile:File = _energyPlusDir.resolvePath("out.idf")
			if (outFile.exists) outFile.deleteFile()
			var inFile:File = _energyPlusDir.resolvePath("in.idf")
			if (inFile.exists) inFile.deleteFile()
			
			for each (var outputFileName:String in _outputFilesArr)
			{
				//clear from EnergyPlus directory
				var f:File = _energyPlusDir.resolvePath(outputFileName)
				if (f.exists)
				{
					f.deleteFile()
				}
				//clear from EnergyPlus/Output directory
				f = _outputDir.resolvePath(outputFileName)
				if (f.exists)
				{
					f.deleteFile()				
				}
			}	
			
		}
		
		protected function copyToOutputDir(fileName:String, deleteFile:Boolean = true):void
		{
			var copyFile:File = _energyPlusDir.resolvePath(fileName)
			if (copyFile.exists==false)
			{
				var msg:String = "Couldn't find output file " + fileName + " after simulation finished"
				Logger.error(msg, this)
				
			}
			else
			{
				copyFile.copyTo(_outputDir.resolvePath(fileName),true)
				if (deleteFile) copyFile.deleteFile()
			}
		}
		
		

		
		
	}
}