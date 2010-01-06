
package com.mcquilleninteractive.learnhvac.business
{
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.event.SparkEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;	
	
	public class SparkService implements ISparkService
	{
		//spark states		
		public static var SPARK_CRASHED: String = "sparkCrashed"
		public static var SPARK_STARTUP_TIMEOUT:String = "sparkStartupTimeout"
		public static var SPARK_INTERVAL_TIMEOUT:String = "spartIntervalTimeout"
		public static var SPARK_ON: String = "sparkOn"
		public static var SPARK_OFF: String = "sparkOff"

		//spark commands issued to input.txt
		public static var SPARK_ABORT:String = "0.0"
		public static var SPARK_CONTINUE:String = "1.0"
		public static var SPARK_RESET:String = "3.0"	
		
		//error states ... TODO: change these into true error classes

		protected var scenarioModel:ScenarioModel
		
		protected var status:String // basic status of spark
		protected var statusCode:String ="000" //specific error status -- e.g. code number from solver.status
	 
	
		//constants for launching window
		protected var SW_SHOW:Number = 5 
		protected var SW_HIDE:Number = 0 
	
		//spark communicates through input.txt and output.txt text files...
		
		protected var _sparkExe:File
		protected var _inputFile:File
		protected var _testFile:File
		protected var _outputFile:File
		protected var _errorFile:File
		protected var _statusFile:File 
	
		protected var _showCmd:String = "SW_SHOWNORMAL" //for screenweaver
	
		protected var _readSparkTimer:Timer //holder for timer that reads spark continously
		protected var _waitForSparkStartupTimer:Timer //holder for initial interval that waits for spark to start up
		protected var _sparkStep:Number=0 //holds "step" counter from output.txt (for monitoring status)
		//protected var monitorIntv //holder for monitor spark interval
		protected var _failedStartupReads:Number=0 //counter for failed reads
		protected var _failedSteps:Number=0 //counter for failed step increments
		protected var _failedStartupReadsLimit:Number // number of times to try reading SPARK at startup, with intervals of one second
		protected var _failedStepLimit:Number //number of times spark can fail an increment before assumed dead
		protected var _codesArr:Array //holds code numbers and messages
		
		protected var _lhProxy:URLLoader
		protected var _startSparkRequest:URLRequest
		protected var _stopSparkRequest:URLRequest
		protected var _statusSparkRequest:URLRequest
		
		//reader and writer helper classes
		public var outReader:SparkReadOut
		public var inWriter:SparkWriteIn
		protected var _stream:FileStream
		protected var _process:NativeProcess
		
		public function SparkService(scenModel:ScenarioModel)
		{
				
			scenarioModel = scenModel;
			outReader = new SparkReadOut();
			inWriter = new SparkWriteIn();
			
			var model:LHModelLocator = LHModelLocator.getInstance()
			
			
			//set up paths
		
			//CURR_DIRECTORY = "C:\\_Daniel_McQuillen\\McQuillen_Interactive\\clients\\Deringer\\LearnHVAC\\Zinc_project\\src\\"
			_sparkExe = File.applicationDirectory.resolvePath("spark/System")			
			_inputFile = File.applicationDirectory.resolvePath("spark/System/input.txt")
			_outputFile = File.applicationDirectory.resolvePath("spark/System/output.txt")
			_statusFile = File.applicationDirectory.resolvePath("spark/System/solver.status")
			_errorFile = File.applicationDirectory.resolvePath("spark/System/error.log")
			
			//setup error codes that are output from SPARK within solver.status
			_codesArr = new Array()
			_codesArr["000"] = "Exit OK";
			_codesArr["001"] = "Crash - and couldn't read error code"; //this is my own error for when I can't read system.solver
			_codesArr["002"] = "Timeout error"; //this is my own error for when SPARK times out
			_codesArr["100"] = "ExitCode ERROR IO";
			_codesArr["101"] = "ExitCode ERROR LEX SCAN";
			_codesArr["102"] = "ExitCode ERROR URL ";
 			_codesArr["120"] = "ExitCode ERROR OUT OF MEMORY";
			_codesArr["121"] = "ExitCode ERROR NULL POINTER";
			_codesArr["130"] = "ExitCode ERROR COMMAND LINE ";
			_codesArr["131"] = "ExitCode ERROR INVALID RUN_CONTROLS";
			_codesArr["132"] = "ExitCode ERROR INVALID PREFERENCES";
			_codesArr["133"] = "ExitCode ERROR INVALID PROBLEM";
			_codesArr["140"] = "ExitCode ERROR EXIT SPARK FACTORY";
			_codesArr["150"] = "ExitCode ERROR RUNTIME ERROR";
			_codesArr["151"] = "ExitCode ERROR INVALID VARIABLE NAME";
			_codesArr["152"] = "ExitCode ERROR INVALID FEATURE";
			_codesArr["160"] = "ExitCode ERROR NUMERICAL";
			
			//write a stop-spark input.txt file to kill any existing processes
			stopSpark();
			
			//create helpers for writing out and reading in text files
			inWriter = new SparkWriteIn();
			outReader = new SparkReadOut();
			
			status = SparkService.SPARK_OFF;
			
			//setup timers
			_readSparkTimer = new Timer(model.sparkIntervalDelay*1000);
			_readSparkTimer.addEventListener(TimerEvent.TIMER, readOutputFile)
			_waitForSparkStartupTimer = new Timer((model.sparkStartupDelay*1000))
			_waitForSparkStartupTimer.addEventListener(TimerEvent.TIMER, isOutputFileReady)
			
			_stream = new FileStream()
			
		}
		
		//////////////////////////////////////////
		//
		// PUBLIC FUNCTIONS FOR CONTROLLINGSPARK
		//
		//////////////////////////////////////////
		
		public function startSpark():void
		{
			Logger.debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
			Logger.debug("STARTING SPARK")
			Logger.debug("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
				
			//setStatus(SPARK_OFF, "005")
			if (writeInput())
			{
				startupSpark()
			}
		}
				
		public function updateSpark():void
		{
			writeInput()
		}
		
		public function stopSpark():void 	
		{
			//Stop spark by writing an output file with STOP information
			Logger.debug("#SparkService: stopSpark() called")
			shutDownSpark()
			setStatus(SparkService.SPARK_OFF, statusCode)
		}	
			
		public function resetAll(evt:Object):void
		{
			Logger.debug("#SparkService: resetAll()")
			stopSpark()
		}
				
		
		////////////////////////////////////////////////////////////
		//
		// INTERNAL FUNCTIONS
		//
		////////////////////////////////////////////////////////////
		
				
		protected function shutDownSpark():void
		{
			Logger.debug("#SparkService: shutDownSpark() called")
			try
			{
				Logger.debug("#Trying to write to INPUT_FILE: " + _inputFile.nativePath)
				//we want to write all values again so that input.txt can be used for debugging
				var textForInputFile:String = inWriter.getText(SparkService.SPARK_ABORT) //use continue even at first writing of input.txt
				
				_stream.open(_inputFile, FileMode.WRITE)
				_stream.writeUTFBytes(textForInputFile)
				_stream.close()
			}
			catch(e:Error)
			{
				Logger.error("#SparkService: error when trying to write stop spark input file.")
			}
			if (_waitForSparkStartupTimer!=null) _waitForSparkStartupTimer.stop()
			if (_readSparkTimer!=null) _readSparkTimer.stop();
			_sparkStep=0
			_failedSteps=0
		}		
				
				
				
		public function writeInput():Boolean
		{
			//Try to creat and write an input.txt file for SPARK. Return success as boolean
			
			var textForInputFile:String = inWriter.getText(SparkService.SPARK_CONTINUE)//use continue even at first writing of input.txt
			try
			{
				_stream.open(_inputFile, FileMode.WRITE)
				_stream.writeUTFBytes(textForInputFile)
				_stream.close()
			}
			catch(e:Error)
			{
				Logger.error("#SparkService: writeInput() ERROR: " + e.message)
				Alert.show("Couldn't write the input.txt file to SPARK. Please make sure this file is writable.","Error")
				return false
			}
			return true
		}
	
		 		
		protected function startupSpark():void
		{			
			
			_sparkStep = 0	
			
			// delete any existing output.txt file
			// then start spark in this call's callback
			
			var model:LHModelLocator = LHModelLocator.getInstance()
			
			// delete any existing output.txt file			
			if (_outputFile.exists) _outputFile.deleteFile()
			
			// delete the error file so we can check for its existence while waiting 			
			if (_errorFile.exists) _errorFile.deleteFile()
			
			// delete old status files so we get correct info (or no info) if spark crashes					
			if (_statusFile.exists) _statusFile.deleteFile()
						
			_process = new NativeProcess()
			var startupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo()
			startupInfo.executable = _sparkExe
			startupInfo.workingDirectory = File.applicationDirectory.resolvePath("spark/System")
			
			var processArgs:Vector.<String> = new Vector.<String>();
			processArgs.push("System.xml")
			processArgs.push("System.prf")
			processArgs.push("System.run")
			 
			startupInfo.arguments = processArgs
			
			_process.start(startupInfo)
			
			//set timers for startup procedure
			_waitForSparkStartupTimer.delay = 1000 // this is always one second
			_failedStartupReadsLimit = model.sparkStartupDelay  //try to read spark at startup each second for user defined time period
			
			//set timers for each read interval
			_readSparkTimer.delay = model.sparkIntervalDelay * 1000
			_failedStepLimit = model.sparkMaxReadsPerStep
			
			Logger.debug("#SparkService: starting spark. Startup delay: " + _waitForSparkStartupTimer.delay)
			Logger.debug("#SparkService: starting spark. Interval delay: " + _readSparkTimer.delay)
			
						
			//wait for defined interval before starting to read spark to give it time to start writing
			_waitForSparkStartupTimer.reset()
			_waitForSparkStartupTimer.start()
		}

		
		public function isOutputFileReady(event:TimerEvent):void
		{
			// Called by interval after SPARK is first started
						
			Logger.debug("#SparkService: isOutputFileReady()")
						
			if (!_outputFile.exists)
			{
				_failedStartupReads ++
				Logger.debug("#SparkService: Couldn't find output.txt (read #" + _failedStartupReads) + ")"
				if (_failedStartupReads > _failedStartupReadsLimit)
				{
					Logger.error("#SparkService: "+ _failedStartupReadsLimit+ " failed read attempts when starting SPARK.")
					_waitForSparkStartupTimer.stop()
					triageSpark(SparkService.SPARK_STARTUP_TIMEOUT)
				}
			} else {
				
				//File exists, so SPARK started OK.
				_waitForSparkStartupTimer.stop() 
				setStatus(SPARK_ON)
				Logger.debug("#SparkService: output.txt exists...calling startReadingSpark()")
				//do an initial read of output file, then start interval to keep reading
				readOutputFile(null)
				_readSparkTimer.start()
			}
		}
		
	
		
		public function readOutputFile(event:TimerEvent):void
		{
			// Called by timer continuously (interval period set above)								
			var data:String
			var scenarioModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			
			// CRASH CHECK: first make sure SPARK hasn't crashed. 
			//              (If SPARK has crashed, it will write a solver.status file)
			if (_statusFile.exists)
			{
				Logger.debug("#SparkService: readOutputFile() Spark has written a solver.status file, which means it's crashed!")
				Logger.debug("               Stop simulation and tell user what went wrong.")
				shutDownSpark()
				triageSpark(SparkService.SPARK_CRASHED)
				return
			}
						
			// If no crash, continue with reading output file
			try
			{
				_stream.open(_outputFile, FileMode.READ)
				data = _stream.readUTFBytes(_stream.bytesAvailable)
				_stream.close()
			} 
			catch (e:Error)
			{
				Logger.error("#SparkService: mdm couldn't read output file: error: " + e)
				data = null
				return
			}
											
			//We may have read SPARK before it's written new output file
			//To check, read the SPARK STEP value and compare with our step value
			//populate ahu model fields only if this is a new step
			var step:Number = outReader.getCurrStep(data)
		
			if (setStepCounter(step))
			{
				//this is a new step so read in values
				Logger.debug("#SparkService: Reading output. Step: " + step)
				var count:Number = outReader.parseOutput(data)

				//tell AHU that we're done loading in this set of variables
				scenarioModel.loadShortTermOutputComplete(step)
			} 
			else
			{
				//not a new step, so don't do anything
			}			
						
		}

		public function setStepCounter(p_step:Number):Boolean
		{
			if (_sparkStep < p_step)
			{
				//SPARK has written a new input file with an incremented step. Update our counter and continue
				_sparkStep = p_step
				_failedSteps = 0
				return true
			} 
			else 
			{
				//spark hasn't updated the output.txt file yet...
				_failedSteps++
				if (_failedSteps > 5)
				{
					Logger.warn("#SparkStatus: setStepCounter() FAILED to see output.txt increment after " + _failedSteps + " tries")
				}
				if (_failedSteps > _failedStepLimit)
				{
					Logger.warn("#SparkStatus: setStepCounter() calling triageSpark()")
					_readSparkTimer.stop() //stop for now, we may restart if user wants to keep waiting
					triageSpark(SparkService.SPARK_INTERVAL_TIMEOUT)
				}
				return false
			}
		}
		
				
		
		public function triageSpark(errorType:String):void
		{
			Logger.error("#SparkService: triageSpark() called. ")
			
			//reset counters and stop timer
			_failedSteps = 0 
			_failedStartupReads = 0
			if (_readSparkTimer!=null) _readSparkTimer.stop();
			
			//turn spark off in case it's still running
			Logger.debug("#SparkService: triageSpark() Stopping spark")
			try
			{
				Logger.debug("#Trying to write to INPUT_FILE: " + _inputFile.nativePath)
				_stream.open(_inputFile, FileMode.WRITE)
				_stream.writeUTFBytes("SPARKRUN: " + SparkService.SPARK_ABORT)
				_stream.close()				
			}
			catch(e:Error)
			{
				Logger.error("#SparkService: error when trying to write stop spark input file.")
			}
			
			
			Logger.debug("#SparkService: triageSpark()  Reading status file to find out what went wrong...")
			switch (errorType)
			{
				case SparkService.SPARK_STARTUP_TIMEOUT:		
					// if it's a startup timeout error, ask user whether he wants to wait
					Alert.show("SPARK isn't starting up within the current timeout limits. Keep waiting?","SPARK timeout",Alert.YES|Alert.NO,null,handleStartupTimeoutAction)
					break
				
				case SparkService.SPARK_INTERVAL_TIMEOUT:
					// if it's an interval timeout error, ask user whether he wants to wait
					Alert.show("SPARK isn't responding within the current timeout limits. Keep waiting?","SPARK timeout",Alert.YES|Alert.NO,null,handleIntervalTimeoutAction)
					break
					
				case SparkService.SPARK_CRASHED:
					// Not a timeout error, so get error status information written out 
					// by SPARK with it's last gasping breath
					var data:String
					try 
					{
						_stream.open(_statusFile, FileMode.READ)
						data = _stream.readUTFBytes(_stream.bytesAvailable)
						_stream.close()
					}
					catch (e:Error)
					{
						Logger.error("#SparkService: triageSpark() couldn't read status file to get error info")
					}
					
					if(data)
					{
						data = data.slice(0,-1) // remove newline
						Logger.debug("#SparkService:  triageSpark()  error code from sparkstatus.txt file:" + data)
						setStatus(errorType, data)			
					} 
					else 
					{
						Logger.debug("#SparkService: triageSpark()  Couldn't read spark status file")
						setStatus(errorType,"001")
					}
					break
				default:
					Logger.warn("#SparkService: triageSpark() unrecognized errorType: " + errorType)
			}			
		}
		
		public function handleStartupTimeoutAction(eventObj:CloseEvent):void
		{
			Logger.debug("#SparkService: handleStartupTimeoutAction() eventObj.detail:"+ eventObj.detail)
			if (eventObj.detail == mx.controls.Alert.YES)
			{
				//continue waiting for SPARK to startup
				_waitForSparkStartupTimer.start()
			}
			else 
			{
				//stop waiting for SPARK and launch error
				shutDownSpark()
				setStatus(SparkService.SPARK_STARTUP_TIMEOUT, "002")	
			}
		}
		
		public function handleIntervalTimeoutAction(eventObj:CloseEvent):void
		{
			if (eventObj.detail == Alert.YES)
			{
				//continue waiting for SPARK to write the next step	
				_readSparkTimer.start()
			}
			else 
			{
				//stop waiting for SPARK and launch error
				shutDownSpark()
				setStatus(SparkService.SPARK_INTERVAL_TIMEOUT, "002")	
			}
		}
				
		public function setStatus(status:String, statusCode:String=""):void
		{
			Logger.debug("#SparkService: setStatus() settings status: " + status + " and statusCode: " + statusCode)
			
			//broadcast status
			this.status = status 
			this.statusCode = statusCode
			sendStatus()
		}
			
		public function sendStatus():void
		{	
			var statusMsg:String = _codesArr[statusCode]
			
			if (statusMsg==null && status==SPARK_CRASHED)
			{
				statusMsg= "No Spark error code reported. Check error.log file."
			} 
			
			Logger.debug("#SparkService: sendStatus() scenarioModel: " + scenarioModel)
			
			var sparkEvent:SparkEvent = new SparkEvent(status)
			sparkEvent.code = statusCode
			sparkEvent.msg = statusMsg
			CairngormEventDispatcher.getInstance().dispatchEvent(sparkEvent)
	
		}
	
		public function destroy():void
		{
			scenarioModel = undefined		
		}
	

	}
}






