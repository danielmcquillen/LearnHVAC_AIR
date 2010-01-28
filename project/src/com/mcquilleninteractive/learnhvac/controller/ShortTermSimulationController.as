package com.mcquilleninteractive.learnhvac.controller
{
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.event.SetPointEvent;	
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.util.Logger
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.business.ShortTermSimulationDelegate;
	import com.mcquilleninteractive.learnhvac.business.IShortTermSimulationDelegate;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.event.ResetInputsEvent;
	
	import org.swizframework.controller.AbstractController
	import org.swizframework.Swiz
	import org.swizframework.factory.IInitializingBean;

	
	public class ShortTermSimulationController extends AbstractController implements IInitializingBean
	{
		
		[Bindable]
		[Autowire]
		public var shortTermSimulationModel:ShortTermSimulationModel
		
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
			delegate.addEventListener(ShortTermSimulationEvent.SIM_UPDATED, simulationOutputUpdated)
		}
		
		public function onOutputReceived(event:Event):void
		{
			Logger.debug("onOutputReceived() from delegate", this)
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.OUTPUT_UPDATED)
			Swiz.dispatchEvent(evt)
		}
		
		
		[Mediate(event="SetPointEvent.CHANGE_SET_POINT")]
		public function onSetPointChange(event:SetPointEvent):void
		{
			scenarioModel.setSysVarValue("TRoomSP", event.temp)
			update()		
		}
					
		
		[Mediate(event="ShortTermSimulationEvent.SIM_START")]
		public function start():void
		{
			Logger.debug("starting AHU", this)
			scenarioModel.resetAllSysVarValueHistories()
			if (scenarioModel.importLongTermVarsFromRun!=ScenarioModel.LT_IMPORT_NONE)
			{ 
				scenarioModel.importLongTermVars()
			}			
			delegate.start()
		}

		[Mediate(event="ShortTermSimulationEvent.SIM_STOP")]		
		public function stop():void
		{
			delegate.stop()
		}

		[Mediate(event="ShortTermSimulationEvent.SIM_UPDATE")]	
		public function update():void
		{
			delegate.update()
		}
		
			
		[Mediate(event="ShortTermSimulationEvent.SIM_CRASHED")]
		public function simulationCrashed(event:ShortTermSimulationEvent):void
		{
			shortTermSimulationModel.currentState = ShortTermSimulationModel.STATE_OFF
			Logger.debug("simulationError()",this)
		}
		
		
		
		//Not sure if I need this...
		public function copyDataForAnalysis():void
		{
			//save SPARK data as either initial or comparison run, based on users selection (as stored in model)
			Logger.debug("#ShortTermSimulationDelegate: copyDataForAnalysis()")
			var shortTermRunsModel:ShortTermSimulationDataModel = scenarioModel.shortTermSimulationDataModel
			shortTermRunsModel.loadCurrSparkData()
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

		
		/* ****************** */
		/* DELEGATE LISTENERS */
		/* ****************** */
		
		/* The following functions handle events coming from the delegate.
		   The controller will handle the events first, and then broadcast to
		   all listeners via Swiz after its own function is complete */
		
		public function simulationStarted(event:ShortTermSimulationEvent):void
		{
			shortTermSimulationModel.currentState = ShortTermSimulationModel.STATE_RUNNING
			Logger.debug("simulationStarted()",this)
			Swiz.dispatchEvent(event)
		}
		
		public function simulationOutputUpdated(event:ShortTermSimulationEvent):void
		{
			Logger.debug("simulationOutputUpdated()",this)
			Swiz.dispatchEvent(event)
		}
		
		public function simulationError(event:ShortTermSimulationEvent):void
		{
			shortTermSimulationModel.currentState = ShortTermSimulationModel.STATE_RUNNING
			Logger.debug("simulationError()",this)
			Swiz.dispatchEvent(event)
		}
		
		public function simulationStopped(event:ShortTermSimulationEvent):void
		{
			shortTermSimulationModel.currentState = ShortTermSimulationModel.STATE_OFF
			Logger.debug("simulationError()",this)
			Swiz.dispatchEvent(event)
		}
		
		/* END DELEGATE FUNCTIONS */
		

	}
}