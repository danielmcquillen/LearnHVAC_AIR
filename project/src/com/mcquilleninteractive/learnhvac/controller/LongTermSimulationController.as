package com.mcquilleninteractive.learnhvac.controller
{
	import com.mcquilleninteractive.learnhvac.business.LongTermSimulationDelegate;
	import com.mcquilleninteractive.learnhvac.event.LongTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.event.UnitsEvent;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.view.LongTermSimulation;
	import com.mcquilleninteractive.learnhvac.view.popups.RunningLongTermSimulationPopup;
	
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.AbstractController;
	import org.swizframework.factory.IInitializingBean;
	
	public class LongTermSimulationController extends AbstractController implements IInitializingBean
	{
		[Autowire]
		public var scenarioModel:ScenarioModel
				
		
		[Autowire]
		public var longTermSimulationModel:LongTermSimulationModel
		
		[Autowire]
		public var longTermSimulationDataModel:LongTermSimulationDataModel
		
		[Autowire]
		public var delegate:LongTermSimulationDelegate
		
		protected var _view:LongTermSimulation
		protected var _popUp:RunningLongTermSimulationPopup
		
		public function LongTermSimulationController()
		{
			
		}
		
		public function initialize():void
		{
			delegate.addEventListener(LongTermSimulationEvent.SIM_COMPLETE, simulationComplete)
			delegate.addEventListener(LongTermSimulationEvent.FILE_LOADED, simulationFileLoaded)
			delegate.addEventListener(LongTermSimulationEvent.SIM_FAILED, simulationFailed)
		}
	
		
		[Mediate(event="LongTermSimulationEvent.SIM_START")]
		public function startLongTermSimulation( event : LongTermSimulationEvent ): void	
		{
			Logger.debug("startLongTermSimulation()", this)
						
			longTermSimulationModel.currentState = LongTermSimulationModel.STATE_RUNNING	
				
			//load all short-term variables into LongTermSystemModel
			longTermSimulationModel._zoneCoolingSetpointTemp = scenarioModel.getSysVar("SYSTRmSPCool").baseSIValue
			longTermSimulationModel._zoneHeatingSetpointTemp = scenarioModel.getSysVar("SYSTRmSPHeat").baseSIValue			
			longTermSimulationModel._supplyAirSetpointTemp = scenarioModel.getSysVar("SYSTSupS").baseSIValue	
			longTermSimulationModel.vavMinFlwRatio = scenarioModel.getSysVar("VAVMinFlwRatio").baseSIValue			
			longTermSimulationModel.rmQSens = scenarioModel.getSysVar("SYSRmQSens").baseSIValue				
			longTermSimulationModel.fanPwr = scenarioModel.getSysVar("FANPwr").baseSIValue			
			longTermSimulationModel.hcUA= scenarioModel.getSysVar("HCUA").baseSIValue	
			longTermSimulationModel.ccUA = scenarioModel.getSysVar("CCUA").baseSIValue	
			longTermSimulationModel.vavHcQd = scenarioModel.getSysVar("VAVRhcQd").baseSIValue	
								
			//show progress modal dialog 
			_popUp = new RunningLongTermSimulationPopup()
			PopUpManager.addPopUp(_popUp, Application.application as DisplayObject,true)
			PopUpManager.centerPopUp(_popUp)
			
			//set flag for cancelling parsing
			longTermSimulationDataModel.continueParsing = true
						
			_view = LongTermSimulationEvent(event).view
			
			//TEMP
			//try 
			//{
				delegate.runLongTermSimulation()
			//}
			//catch(err:Error)
			//{
			///	Logger.error("error when calling runLongTermSimulation on delegate: e: " +err, this)  
			//	var evt:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED)
			//	evt.errorMessage = err.message
			//	simulationFailed(evt)
			//}						
		}
						
		[Mediate(event="LongTermSimulationEvent.SIM_CANCEL")]
		public function onCancel( event: LongTermSimulationEvent ): void
		{
			Logger.debug("onCancel()", this)
			PopUpManager.removePopUp(_popUp)
			delegate.cancelSimulation()
			longTermSimulationDataModel.continueParsing = false
			longTermSimulationModel.currentState = LongTermSimulationModel.STATE_OFF
		}		
		
		
		[Mediate(event="UnitsEvent.UNITS_CHANGED")]
		public function onUnitsChanged(event:UnitsEvent):void
		{
			//update any other models or controls that are affected by changes in units
			longTermSimulationDataModel.onUnitsChange(event.units)			
		}

		/* ****************** */
		/* DELEGATE LISTENERS */
		/* ****************** */
		
		/* The following functions handle events coming from the delegate.
		   The controller will handle the events first, and then broadcast to
		   all listeners via Swiz after its own function is complete */
		  		   
		public function simulationFileLoaded(event:LongTermSimulationEvent):void
		{
			Logger.debug("simulationFileLoaded()", this)
			
			//dispatch event to all listeners
			var evt:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.FILE_LOADED, true)
			Swiz.dispatchEvent(evt)	
		}   
		   
		public function simulationFailed(event:LongTermSimulationEvent):void
		{
			Logger.warn("simulationFailed() event:" + event, this)						
			Logger.warn("simulationFailed() event.errorMessage:" + event.errorMessage, this)						
			
			longTermSimulationModel.currentState = LongTermSimulationModel.STATE_OFF
				
			//do local/preliminary stuff first
			PopUpManager.removePopUp(_popUp)	
			
			//then dispatch event to all listeners
			var evt:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_FAILED, true)
			Swiz.dispatchEvent(evt)	
			Alert.show("Long-term simulation failed. " + event.errorMessage, "Simulation Failed")
		}
		
		public function simulationComplete(event:LongTermSimulationEvent):void
		{
			longTermSimulationModel.currentState = LongTermSimulationModel.STATE_OFF
				
			Logger.debug("simulationComplete()", this)						
			PopUpManager.removePopUp(_popUp)
			scenarioModel.importLongTermVars()
			
			//dispatch event to all listeners
			var evt:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_COMPLETE, true)
			Swiz.dispatchEvent(evt)				
			Alert.show("Long-term simulation finished. Use the Analysis section to view results.","Simulation Finished")
		}		
		
		/* END DELEGATE FUNCTIONS */


	}
}