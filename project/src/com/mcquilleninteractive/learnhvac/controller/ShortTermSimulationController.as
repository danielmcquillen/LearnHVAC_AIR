package com.mcquilleninteractive.learnhvac.controller
{
	import com.mcquilleninteractive.learnhvac.business.IShortTermSimulationDelegate;
	import com.mcquilleninteractive.learnhvac.event.ModelicaInputsTrace;
	import com.mcquilleninteractive.learnhvac.event.ResetInputsEvent;
	import com.mcquilleninteractive.learnhvac.event.ScenarioLoadedEvent;
	import com.mcquilleninteractive.learnhvac.event.SetPointEvent;
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.AbstractController;
	import org.swizframework.factory.IInitializingBean;

	
	public class ShortTermSimulationController extends AbstractController implements IInitializingBean
	{
		
		[Autowire]
		public var shortTermSimulationModel:ShortTermSimulationModel
		
		[Autowire]
		public var shortTermSimulationDataModel:ShortTermSimulationDataModel
		
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		[Autowire]
		public var applicationModel:ApplicationModel
		
		[Autowire(bean="shortTermSimulationDelegate")]
		public var delegate:IShortTermSimulationDelegate
		
		
		public function ShortTermSimulationController()
		{
						
		}
		
		public function initialize():void
		{
			delegate.addEventListener(ShortTermSimulationEvent.SIM_STARTED, simulationStarted)
			delegate.addEventListener(ShortTermSimulationEvent.SIM_STOPPED, simulationStopped)
			delegate.addEventListener(ShortTermSimulationEvent.SIM_ERROR, simulationError)
			delegate.addEventListener(ShortTermSimulationEvent.SIM_OUTPUT_RECEIVED, onOutputReceived)
			delegate.addEventListener(ModelicaInputsTrace.INPUTS_TRACE, onInputsTrace)
		
		}
				
		[Mediate(event="ScenarioLoadedEvent.SCENARIO_LOADED")]
		public function scenarioLoaded(event:ScenarioLoadedEvent):void
		{
			shortTermSimulationDataModel.init()
		}
		
		/* Handles for framework events */
		[Mediate(event="SetPointEvent.CHANGE_SET_POINT")]
		public function onSetPointChange(event:SetPointEvent):void
		{
			scenarioModel.setSysVarValue("TRoomSP", event.temp)
		}
					
		
		[Mediate(event="ShortTermSimulationEvent.SIM_START")]
		public function start(event:ShortTermSimulationEvent):void
		{
			Logger.debug("starting short term simulation", this)
			shortTermSimulationDataModel.clearCurrentRun()
			if (scenarioModel.importLongTermVarsFromRun!=ScenarioModel.LT_IMPORT_NONE)
			{ 
				scenarioModel.importLongTermVars()
			}			
			
			
			
			// ask all input system variables to update to the
			// value user has entered in input panel
			var inputSysVarsArr:Array = scenarioModel.getInputSysVars()
			for each (var sysVar:SystemVariable in inputSysVarsArr)
			{
				sysVar.updateFromLocal()
			}
			
			Logger.debug("delegate: " + delegate, this)
			delegate.start()
		}

		[Mediate(event="ShortTermSimulationEvent.SIM_STOP")]		
		public function stop(event:ShortTermSimulationEvent):void
		{
			delegate.stop()			
		}


		[Mediate(event="ShortTermSimulationEvent.SIM_UPDATE")]	
		public function update(event:ShortTermSimulationEvent):void
		{
			Logger.debug("update setting timeStep to : " + event.timeStep,this)
			//update the timestep
			delegate.timeStep = event.timeStep
			
			// ask all input system variables to update to the
			// value user has entered in input panel
			var inputSysVarsArr:Array = scenarioModel.getInputSysVars()
			for each (var sysVar:SystemVariable in inputSysVarsArr)
			{
				sysVar.updateFromLocal()
			}
			
		}
		
		
					
			
		[Mediate(event="ResetInputsEvent.RESET_SHORT_TERM_INPUTS_TO_INITIAL_VALUES")]
		public function onResetInputsToInitialValues(event:ResetInputsEvent):void
		{		
			//cycle through all systemvariables and reset value to initial value
			for each (var sysNode:SystemNodeModel in scenarioModel.sysNodesAC)
			{
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{
					sysVar.resetToInitialValue()
				}	
			}
		}
			
		[Mediate(event="ShortTermSimulationEvent.SIM_RETURN_TO_START")]
		public function onReturnToStart(event:ShortTermSimulationEvent):void
		{	
			shortTermSimulationModel.resetTimer()
		}

		
		/* ****************** */
		/* DELEGATE LISTENERS */
		/* ****************** */
		
		/* The following functions handle events coming from the delegate.
		   I'm attaching directly to events from the delegate because I want to
		   handle them here first ... and then broadcast to
		   all listeners via Swiz after this controller is finished doing its own thing */
		
		public function simulationStarted(event:ShortTermSimulationEvent):void
		{
			shortTermSimulationModel.currentState = ShortTermSimulationModel.STATE_RUNNING
			
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_STARTED, true)
			Logger.debug("simulationStarted()",this)
			Swiz.dispatchEvent(evt)
			
			if (applicationModel.mTrace)
			{
				shortTermSimulationModel.modelicaInputsTrace = ""	
			}
		}
		
		public function onOutputReceived(event:Event):void
		{			
			var simTime:int = delegate.simTime
			shortTermSimulationModel.updateTimer(simTime)
			
			//record values in data model
			shortTermSimulationDataModel.recordCurrentTimeStep(shortTermSimulationModel.timeInSec, scenarioModel.sysVarsArr)
			
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_OUTPUT_RECEIVED)
			Swiz.dispatchEvent(evt)
		}
		
		public function simulationError(event:ShortTermSimulationEvent):void
		{
			Logger.debug("simulationError()",this)
			
			shortTermSimulationModel.currentState = ShortTermSimulationModel.STATE_OFF
			
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_ERROR, true)
			Alert.show("Modelica experienced an error. " + event.errorMessage , "Modelica Error")
			Swiz.dispatchEvent(evt)
			
			//do debug stuff if mtrace is on
			if (applicationModel.mTrace)
			{
				copyDebugFiles()	
			}
		}
		
		public function simulationStopped(event:ShortTermSimulationEvent):void
		{
			Logger.debug("simulationStopped()",this)
				
			shortTermSimulationModel.currentState = ShortTermSimulationModel.STATE_OFF
			
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_STOPPED, true)
			shortTermSimulationDataModel.currRunComplete()
			Swiz.dispatchEvent(evt)
			
			//do debug stuff if mtrace is on
			if (applicationModel.mTrace)
			{
				copyDebugFiles()	
			}
		}
		
		
		[Mediate(event="ModelicaInputsTrace.INPUTS_TRACE")]
		public function onInputsTrace(event:ModelicaInputsTrace):void
		{
			shortTermSimulationModel.modelicaInputsTrace += event.inputsTrace			
		}	
		
		
		
		protected function copyDebugFiles():void
		{
			Logger.debug("copyDebugFiles",this)
				
			var d:Date = new Date()
			var timestamp:String = "_" + (d.month + 1) + "_" + d.day+ "_" + d.fullYear + "_" + d.hours + "_"+ d.minutes + "_" + d.seconds
			var copyDir:File = File.userDirectory.resolvePath(ApplicationModel.baseStoragePath + "modelica/output")
			if (copyDir.exists==false)
			{
				copyDir.createDirectory()
			} 
			
			Logger.debug("writing " + shortTermSimulationModel.modelicaInputsTrace,this)
				
			//Inputs trace
			shortTermSimulationModel.modelicaInputsTraceFile = copyDir.resolvePath( "inputs_trace" + timestamp + ".txt")
			
			try			
			{					
				//write inputs to file
				var s:FileStream = new FileStream()
				s.open(shortTermSimulationModel.modelicaInputsTraceFile, FileMode.WRITE)
				s.writeUTFBytes(shortTermSimulationModel.modelicaInputsTrace)
				s.close()			
			}
			catch(error:Error)
			{
				Logger.error("Couldn't write " + shortTermSimulationModel.modelicaInputsTraceFile.nativePath + " error: " + error, this)
			}
				
					
					
			//.MAT FILE
			var matFile:File = File.applicationDirectory.resolvePath("modelica/dsres.mat")
			if(matFile.exists)
			{	
				try			
				{					
					var copyMatFile:File = copyDir.resolvePath("dsres" + timestamp + ".mat")
					matFile.copyTo(copyMatFile,true)
					Logger.debug("dsres.mat copied to : " + copyMatFile.nativePath,this)
									
				}
				catch(error:Error)
				{
					Logger.error("Couldn't copy dsres.mat to " + copyMatFile.nativePath + " error: " + error, this)
				}
			}
			else
			{
				Logger.warn("No dsres.mat file exists to copy.",this)
			}
			
			//LOG FILE
			var logFile:File = File.applicationDirectory.resolvePath("modelica/dslog.txt")
			if (logFile.exists)
			{
				try
				{
					var copyLogFile:File = copyDir.resolvePath("dslog" + timestamp + ".txt")
					logFile.copyTo(copyLogFile, true)
					Logger.debug("dslog.txt copied to : " + copyLogFile.nativePath,this)
				}
				catch(error:Error)
				{
					Logger.error("Couldn't copy dsres.mat to " + copyMatFile.nativePath + " error: " + error, this)
				}		
			}
			else
			{				
				Logger.warn("No dslog.txt file exists to copy.",this)
			}
				
		}

	}
}