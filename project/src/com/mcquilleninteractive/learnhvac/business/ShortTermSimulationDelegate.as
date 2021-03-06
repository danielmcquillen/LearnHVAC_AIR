package com.mcquilleninteractive.learnhvac.business
{
	import com.mcquilleninteractive.learnhvac.event.ModelicaInputsTrace;
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.controls.Alert;

	/* Manages communication between Learn HVAC and the modelica (Dymola) process
	   		- Converts inputs into string for Modelica consumption
	   		- Parses Modelica output string for LH
			
			Documentation on protocol is at bottom of class
	
	*/
	
	
		
	public class ShortTermSimulationDelegate extends EventDispatcher implements IShortTermSimulationDelegate
	{
		public static const SOCKET_PORT:Number = 3001
		public static const OUTPUT_RECEIVED:String = "shortTermOutputReceived";
		public static const MODELICA_VERSION:String = "1"
			
		// simulation reached end time.
		public static const FLAG_END_TIME:Number = 1  			
		// normal operation
		public static const FLAG_NORMAL_OPERATION:Number = 0 	
		// simulation terminates due to an (unspecified) error.
		public static const SIM_FATAL_ERROR:Number = -1 		
		// simulation terminates due to error during initialization.
 		public static const SIM_FATAL_INIT:Number = -10			
 		// simulation terminates due to error during time integration. 	
 		public static const SIM_FATAL_INTEGRATION:Number = -20;	
			
		[Autowire]
		public var applicationModel:ApplicationModel
		
		[Autowire]
		public var scenarioModel:ScenarioModel
				
		protected var _serverSocket:ServerSocket;
		protected var _modelicaSocket:Socket
		protected var _modelicaExe:File 
		protected var _modelicaDir:File
		protected var _modelicaProcess:NativeProcess 
		protected var _timer:Timer
		protected var _simTime:int = 0
		protected var _timeStep:int = 1
		protected var _startupInfo:NativeProcessStartupInfo
		
		//this flag let's us ignore the first set of outputs that come
		//in from Modelica when it's first started up
		protected var _firstStartupOutputReceived:Boolean = false
		
		
		//to avoid counting each time
		protected var _outputsSysVarsArrLength:uint 
		
		public function ShortTermSimulationDelegate() 
		{
			_modelicaDir = File.userDirectory.resolvePath(ApplicationModel.baseStorageDirPath + "modelica")
			_modelicaExe = _modelicaDir.resolvePath("dymosim.exe")
			
			_timer = new Timer(1000)
			_timer.addEventListener(TimerEvent.TIMER, onTimer)
			openSocket()
			
		}
				
		/** This function starts the Nativeprocess for modelica and then waits for a 
		 *  connection from the Modelica process. When a connection and the first set 
		 *  of variables are received, the delegate sets a timer and, after the delay,
		 *  sends the next increment of input variables, whether or not the user has
		 *  changed any of them.
		 * 
		 * 
		 * */		
				
		public function start():void
		{
			if (_modelicaProcess==null)
			{
				_modelicaProcess = new NativeProcess()
				setupModelicaProcess()	
			}
			Logger.debug("start()",this)
			//openSocket()
			launchModelicaProcess()			
		}
		
		public function stop():void
		{
			//closeSocket()
			_timer.stop()
			if (_modelicaProcess) _modelicaProcess.exit(true)			
		}
		
		public function onTimer(event:TimerEvent):void
		{
			sendInput()
		}

		public function get simTime():int
		{
			return _simTime
		}
		
		/** resets the delegate so that simulation starts at correct start date/time 
		 *  This function is called when user wants to "rewind" to start
		 * */
		public function reset():void
		{
			_simTime = 0
		}
		
		public function set timeStep(value:int):void
		{
			Logger.debug("trying to set timeStep to: " + value, this)
			if (value<0 || isNaN(value)) value = 1
			_timeStep = value
		}
									
		/*Sends an array of system variables to the Modelica simulation*/
		public function sendInput():void
		{						
			var inputSysVarsArr:Array = this.scenarioModel.getInputSysVars()
			
			if (inputSysVarsArr.length==0)
			{
				inputSysVarsArr = scenarioModel.getInputSysVars() //these should already be sorted by index
			}
			
			if (_modelicaSocket.connected)
			{			
				var inputToModelica:String = formatInputToModelica(inputSysVarsArr, _simTime)
				//Logger.debug("input :  " + inputToModelica,this)
				_modelicaSocket.writeUTFBytes(inputToModelica)
				_modelicaSocket.flush()	
				
			}
			else
			{
				Logger.error("Can't sendInput() since socket isn't connected.",this)
			}
		}
		
		public function receiveOutput(output:String):void
		{
			_timer.start()									
			
			if (_firstStartupOutputReceived==false)
			{
				//ignore if this is the output generated on first starting up
				_firstStartupOutputReceived = true
			}
			else
			{
				//Otherwise, do all the things we need to do to parse the Modelica output
				this.parseOutputFromModelica(output)
				
			}		
				
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_OUTPUT_RECEIVED, true)
			dispatchEvent(evt)
			_simTime += _timeStep
			
		}

		/* ****************** */
		/*  SOCKET FUNCTIONS  */
		/* ****************** */
		
		public function openSocket():void
		{
			try
			{				
				_serverSocket = new ServerSocket();
				_serverSocket.addEventListener(Event.CONNECT, socketConnectHandler);
				_serverSocket.bind(SOCKET_PORT)
				_serverSocket.listen();				
			}
			catch (error:Error)
			{
				var msg:String = "Error when opening socket server on " + SOCKET_PORT + " " + error
				Logger.error(msg, this )
				Alert.show(msg, "Socket Error");
			}			
		}
				
		public function closeSocket():void
		{
			if (_serverSocket && _serverSocket.listening)
			{
				_serverSocket.close()
				_serverSocket.removeEventListener(Event.CONNECT, socketConnectHandler);
				_serverSocket = null
			}
		}
		
		
		
		protected function socketConnectHandler(event:ServerSocketConnectEvent):void
		{
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_STARTED,true)
			dispatchEvent(evt)
			
			if (_modelicaSocket)
			{
				_modelicaSocket.removeEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
				_modelicaSocket = null
			}
			
			_modelicaSocket = event.socket;
			_modelicaSocket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		protected function socketDataHandler(event:ProgressEvent):void
		{
			try
			{			
				var bytes:ByteArray = new ByteArray();
				_modelicaSocket.readBytes(bytes);
				var outputFromModelica:String = "" + bytes;			
				_modelicaSocket.flush();		
				receiveOutput(outputFromModelica)		
			}
			catch (error:Error)
			{
				Logger.error("socketDataHandler() error: " + error,this)
				Alert.show(error.message, "Error");
			}
		}
		
		
		
		/* ************************* */
		/*  MODELICA PROCESS         */
		/* ************************* */
		
		protected function setupModelicaProcess():void
		{
			_startupInfo = new NativeProcessStartupInfo()
			_startupInfo.executable = _modelicaExe
			_startupInfo.workingDirectory = _modelicaDir
			
			_modelicaProcess.addEventListener(NativeProcessExitEvent.EXIT, onModelicaProcessExit)
			_modelicaProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onModelicaStandardOutput)
			_modelicaProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onModelicaStandardError)
			
		}
		
		protected function launchModelicaProcess():void
		{		
			if (_modelicaProcess.running)
			{
				_modelicaProcess.exit(true)
			}
																
			try
			{
				Logger.debug("\n***********************\nSTARTING MODELICA AT : " + _modelicaDir.nativePath + "\n***********************",this)
				_modelicaProcess.start(_startupInfo)
				_firstStartupOutputReceived = false
			}
			catch (err:Error)
			{				
				Logger.error("launchModelica() Error starting process: "+ err.errorID + " " + err.name + " " + err.message, this)
				Alert.show("Cannot start Modelica. Please try again or contact support for help.")
			}
		}
		
		public function onModelicaProcessExit(event:NativeProcessExitEvent):void
		{
			Logger.error("event.exitCode : " + event.exitCode, this)
			
			stop()
			
			if (event.exitCode >0)
			{				
				var evt:ShortTermSimulationEvent= new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_ERROR, true)
				evt.errorMessage = "Error code : " + event.exitCode
				dispatchEvent(evt)
			}
			else
			{
			 	evt= new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_STOPPED, true)
				dispatchEvent(evt)
			}
			
			
		}
		
		public function onModelicaStandardOutput(event:ProgressEvent):void
		{
			var text:String = _modelicaProcess.standardOutput.readUTFBytes(_modelicaProcess.standardOutput.bytesAvailable)
			if (applicationModel.mTrace)
			{
				Logger.debug("Modelica process output: " + text, this)
			}
		}

		public function onModelicaStandardError(event:ProgressEvent):void
		{
			var text:String = _modelicaProcess.standardError.readUTFBytes(_modelicaProcess.standardError.bytesAvailable)
			Logger.error("Modelica process error: " + text, this)			
			Alert.show(text, "Modelica Error")
			
		}
		
		
		/* ************************* */
		/*  MODELICA I/O FORMATTING  */
		/* ************************* */
		
		protected function parseOutputFromModelica(outputFromModelica:String):void
		{
						
			var outputSysVarsArr:Array = scenarioModel.getOutputSysVars()
			var len:int = outputSysVarsArr.length
					
			var outArr:Array = outputFromModelica.split(" ")
			
			var status:Number = outArr[1]
			var numOutputs:Number = outArr[2]
			// outArr[3] num integers
			// outArr[4] num boolean
			// outArr[5] sim time
			
			//check flag for exit
			if (outArr[1]==FLAG_END_TIME)
			{				
				stop()
				var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_ERROR, true)
				evt.errorMessage = "Modelica unexpectedly reached 'simulation end time'"
				dispatchEvent(evt)
				return
			}
			
			var out:String = ""
			for (var i:uint = 0; i<len; i++)
			{	
				var sysVar:SystemVariable = SystemVariable(outputSysVarsArr[i])		
				
				sysVar.baseSIValue = outArr[i+6]								
				if (applicationModel.mTrace) out +=  "\n " + (i+1).toString() + " var: " + sysVar.name + " value: " + outArr[i+6];				
			}
			
			if (applicationModel.mTrace) Logger.debug("Values set by Modelica: \n----------------------------\n " + out, this);
			
			
						
		}
		
		protected function formatInputToModelica(inputSysVarsArr:Array, simTime:int):String
		{
			var inputs:String = ""
			var len:uint = inputSysVarsArr.length
			
			//this variable is used to build a debug trace for inputs
			var tr:String = "(time: " + _simTime + ")"
			//this variable is used to build a debug output
			var inputsTrace:String = ""
			
			for(var i:uint=0;i<len;i++)
			{
				var sysVar:SystemVariable = inputSysVarsArr[i] as SystemVariable
				
				inputs += " " + inputSysVarsArr[i].baseSIValue	
							
				if (applicationModel.mTrace)
				{
					tr += "\n  " + (i+1).toString() + " : " + inputSysVarsArr[i].name + " : " + inputSysVarsArr[i].baseSIValue;	
			
					//build a string for special file requested by MWetter for debugging
					//input vales should be written like {val1, val2, val3...}
					inputsTrace += inputSysVarsArr[i].baseSIValue
					if (i!=len-1)
					{
						inputsTrace +=","
					}
				} 
			}		
			
			if (applicationModel.mTrace)
			{
				var s:String = ""
				s = "{" 
				s += MODELICA_VERSION + ","
				s += FLAG_NORMAL_OPERATION+ ","
				s += len + ","
				s += "0," //never integers
				s += "0," //never booleans
				s +=  _simTime + ","
				s += inputsTrace
				s += "}\n"
			
				var evt:ModelicaInputsTrace = new ModelicaInputsTrace(ModelicaInputsTrace.INPUTS_TRACE, true)
				evt.inputsTrace = s
				dispatchEvent(evt)
								
			}
			
			var out:String = ""
			out += MODELICA_VERSION
			out += " " + FLAG_NORMAL_OPERATION
			out += " " + len
			out += " 0" //never integers
			out += " 0" //never booleans
			out += " " + _simTime
			out += inputs
			out += "\n"
			
			if (applicationModel.mTrace)
			{				
				Logger.debug("Inputs details :\n---------------------\n" + tr, this);
				Logger.debug("Input string: " + out, this);
			}
				
			
			return out
		}
		

	}
}

		
/**
* 
* The string that is exchanged between server and client is defined as follows:
a b c d e f g1 g2
where
a=1 is the version number,
b is a flag, defined as
 +1: simulation reached end time.
  0: normal operation
 -1: simulation terminates due to an (unspecified) error.
 -10: simulation terminates due to error during initialization.
 -20: simulation terminates due to error during time integration. 
c = number of doubles to be exchanged,
d = 0 [number of integers to be exchanged],
e = 0 [number of booleans to be exchanged],
f = current simulation time in seconds
g1 = first double, g2 = second double, etc.
The string is terminated by '\n' and there is one space between each token.

An example where 2 values are sent at time equals 60 looks like
1 0 2 0 0 6.000000000000000e+01 9.958333333333334e+00 9.979166666666666e+00

If you want to stop dymola because LearnHVAC reached its final time, you would send a '+1' as the flag
1 1 2 0 0 6.000000000000000e+01 9.958333333333334e+00 9.979166666666666e+00

 * 
 * **/
		  
