package com.mcquilleninteractive.learnhvac.controller
{
	import com.mcquilleninteractive.learnhvac.business.IShortTermSimulationDelegate;
	import com.mcquilleninteractive.learnhvac.event.ResetInputsEvent;
	import com.mcquilleninteractive.learnhvac.event.ScenarioLoadedEvent;
	import com.mcquilleninteractive.learnhvac.event.SetPointEvent;
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.controls.Alert;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.AbstractController;
	import org.swizframework.factory.IInitializingBean;

	
	public class ShortTermSimulationController extends AbstractController implements IInitializingBean
	{
		
		[Bindable]
		[Autowire]
		public var shortTermSimulationModel:ShortTermSimulationModel
		
		[Bindable]
		[Autowire]
		public var shortTermSimulationDataModel:ShortTermSimulationDataModel
		
		[Bindable]
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		[Bindable]
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
		}
		
		public function simulationStopped(event:ShortTermSimulationEvent):void
		{
			shortTermSimulationModel.currentState = ShortTermSimulationModel.STATE_OFF
			Logger.debug("simulationError()",this)
			
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_STOPPED, true)
			shortTermSimulationDataModel.currRunComplete()
			Swiz.dispatchEvent(evt)
		}
		
		
		

	}
}