package com.mcquilleninteractive.learnhvac.business
{
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.events.ServerSocketConnectEvent;
	import flash.filesystem.File;
	import flash.net.ServerSocket;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
		
	public class ShortTermSimulationDelegate extends EventDispatcher implements IShortTermSimulationDelegate
	{
		public static const SOCKET_PORT:String = "3000"
		public static const OUTPUT_RECEIVED:String = "shortTermOutputReceived";
		public static const MODELICA_VERSION:String = "1"	
		
		public static const FLAG_END_TIME:Number = 1  			// simulation reached end time.
		public static const FLAG_NORMAL_OPERATION:Number = 0 	// normal operation
		public static const SIM_FATAL_ERROR:Number = -1 		// simulation terminates due to an (unspecified) error.
 		public static const SIM_FATAL_INIT:Number = -10			// simulation terminates due to error during initialization.
 		public static const SIM_FATAL_INTEGRATION:Number = -20;	// simulation terminates due to error during time integration. 	
			
		[Autowire]
		public var scenarioModel:ScenarioModel
				
		protected var _serverSocket:ServerSocket;
		protected var _modelicaSocket:Socket
		protected var _modelicaExe:File 
		protected var _modelicaDir:File
		protected var _modelicaProcess:NativeProcess
		
		public function ShortTermSimulationDelegate() 
		{
			//TEMP
			_modelicaDir = File.applicationDirectory.resolvePath("modelica")
			_modelicaExe = _modelicaDir.resolvePath("modelica.exe")
			
		}
		
		
		public function start():void
		{			
		}
		
		public function stop():void
		{
			
		}
		
		/*Sends an array of system variables to the Modelica simulation*/
		public function update(inputSysVarsArr:Array):void
		{	
			Logger.debug("update()",this)
			if (_modelicaSocket.connected)
			{
				var inputToModelica:String = formatInputToModelica(inputSysVarsArr)
				_modelicaSocket.writeUTFBytes(inputToModelica)
			}
		}
		
		public function onOutputReceived():void
		{
			Logger.debug("onOutputReceived()",this)
			//Do all the things we need to do to parse the Modelica output
			var step:uint = 1 // this will be read in from Modelica			
			scenarioModel.updateTimer(step);			
		}

		/* ****************** */
		/*  SOCKET FUNCTIONS  */
		/* ****************** */

		public function setupSocket():void
		{
			Logger.debug("setupSocket()",this)
			// Initialize the server directory 
			try
			{
				_serverSocket = new ServerSocket();
				_serverSocket.addEventListener(Event.CONNECT, socketConnectHandler);
				_serverSocket.bind(Number(SOCKET_PORT));
				_serverSocket.listen();
			}
			catch (error:Error)
			{
				Logger.error("Error opening socket server on 3000. Error: " + error, this)
				Alert.show("Port 3000 may be in use. Please close any applications using this port and try again.", "Error");
			}
		}
		
		
		
		protected function socketConnectHandler(event:ServerSocketConnectEvent):void
		{
			Logger.debug("socketConnectHandler()",this) 
			_modelicaSocket = event.socket;
			_modelicaSocket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		protected function socketDataHandler(event:ProgressEvent):void
		{
			try
			{
				Logger.debug("socketDataHandler()",this)				
				var bytes:ByteArray = new ByteArray();
				_modelicaSocket.readBytes(bytes);
				var outputFromModelica:String = "" + bytes;			
				Logger.debug("output data from Modelica: " + outputFromModelica,this)	
				this.parseOutputFromModelica(outputFromModelica)				
				_modelicaSocket.flush();
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
		
		protected function launchModelica():void
		{
			Logger.debug("launchModelica()",this)
															
			var startupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo()
			startupInfo.executable = _modelicaExe
			startupInfo.workingDirectory = _modelicaDir
			
			_modelicaProcess.addEventListener(NativeProcessExitEvent.EXIT, onModelicaProcessExit)
			_modelicaProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onModelicaStandardOutput)
			_modelicaProcess.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onModelicaStandardError)
			
			try
			{
				_modelicaProcess.start(startupInfo)
			}
			catch (err:Error)
			{				
				Logger.error("launchModelica() Error starting process: "+ err, this)
				Alert.show("Cannot start Modelica. Please try again or contact support for help.")
			}
			
				
		}
		public function onModelicaProcessExit(event:NativeProcessExitEvent):void
		{
			Logger.debug("onModelicaProcessExit() " + event, this)
		}
		
		public function onModelicaStandardOutput(event:ProgressEvent):void
		{
			var text:String = _modelicaProcess.standardOutput.readUTFBytes(_modelicaProcess.standardOutput.bytesAvailable)
			Logger.debug("Modelica process output: " + text, this)
		}

		public function onModelicaStandardError(event:ProgressEvent):void
		{
			var text:String = _modelicaProcess.standardError.readUTFBytes(_modelicaProcess.standardError.bytesAvailable)
			Logger.error("Modelica process error: " + text, this)			
		}
		
		
		/* ************************* */
		/*  MODELICA I/O FORMATTING  */
		/* ************************* */
		
		protected function parseOutputFromModelica(outputFromModelica:String):void
		{
			//TODO: parse output from Modelica and place into model directly
			
			//TODO: Error checks to make sure data is OK
			
		}
		
		protected function formatInputToModelica(inputSysVarsArr:Array):String
		{
			var out:String 
			out += MODELICA_VERSION
			out += " " + FLAG_NORMAL_OPERATION
			out += " " + inputSysVarsArr.length
			out += " 0" //never integers
			out += " 0" //never booleans
			out += "  "
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
		  
