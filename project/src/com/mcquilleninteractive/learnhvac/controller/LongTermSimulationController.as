package com.mcquilleninteractive.learnhvac.controller
{
	import com.mcquilleninteractive.learnhvac.business.LongTermSimulationDelegate;
	import com.mcquilleninteractive.learnhvac.event.LongTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.view.LongTermSimulation;
	import com.mcquilleninteractive.learnhvac.view.popups.RunningLongTermSimulationPopup;
	import org.swizframework.controller.AbstractController	import mx.core.Application
	import mx.managers.PopUpManager
	import mx.controls.Alert
	import flash.display.DisplayObject
	

	import com.mcquilleninteractive.learnhvac.view.popups.SimulationModal;
	import org.swizframework.Swiz;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.event.SetUnitsCompleteEvent;
	
	public class LongTermSimulationController extends AbstractController
	{
		[Autowire]
		public var scenarioModel:ScenarioModel
				
		[Autowire]
		public var longTermSimulationDataModel:LongTermSimulationDataModel
		
		[Autowire]
		public var delegate:LongTermSimulationDelegate
		
		protected var _view:LongTermSimulation
		protected var _popUp:RunningLongTermSimulationPopup
		
		public function LongTermSimulationController()
		{
		}
	
		
		[Mediate(event="LongTermSimulationEvent.SIM_START")]
		public function startLongTermSimulation( event : LongTermSimulationEvent ): void	
		{
			Logger.debug("startLongTermSimulation()", this)
			
			//show progress modal dialog 
			_popUp = new RunningLongTermSimulationPopup()
			PopUpManager.addPopUp(_popUp, Application.application as DisplayObject,true)
			PopUpManager.centerPopUp(_popUp)
			
			//set flag for cancelling parsing
			longTermSimulationDataModel.continueParsing = true
						
			_view = LongTermSimulationEvent(event).view
			
			try 
			{
				delegate.runLongTermSimulation()
			}
			catch(err:Error)
			{
				Logger.error("error when calling runLongTermSimulation on delegate: e: " +err, this)  
				Alert.show("Simulation Error: " + err.message, "Simulation Error")
				simulationFailed()
			}						
		}
						
		[Mediate(event="LongTermSimulationEvent.SIM_CANCEL")]
		public function onCancel( event: LongTermSimulationEvent ): void
		{
			Logger.debug("onCancel()", this)
			PopUpManager.removePopUp(_popUp)
			delegate.cancelEPlus()
			longTermSimulationDataModel.continueParsing = false
		}		
		
		[Mediate(event="LongTermSimulationEvent.SIM_FAILED")]
		public function longTermSimulationFailed(event:LongTermSimulationEvent):void
		{
			Logger.debug("longTermSimulationError()", this)						
			PopUpManager.removePopUp(_popUp)		
			Alert.show("Long-term simulation failed. " + event.errorMessage, "Simulation Failed")
		}
		
		[Mediate(event="LongTermSimulationEvent.SIM_LOAD_COMPLETE")]
		public function longTermSimulationLoadComplete(event:LongTermSimulationEvent):void
		{
			Logger.debug("longTermSimulationFinished()", this)						
			PopUpManager.removePopUp(_popUp)
			scenarioModel.importLongTermVars()		
			Swiz.dispatchEvent(new LongTermSimulationEvent(LongTermSimulationEvent.SIM_COMPLETE))			
			Alert.show("Long-term simulation finished. Use the Analysis section to view results.","Simulation Finished")
		}		
		
		[Mediate(event="SetUnitsCompleteEvent.UNITS_CHANGED")]
		public function onUnitsChanged(event:SetUnitsCompleteEvent):void
		{
			//update any other models or controls that are affected by changes in units
			longTermSimulationDataModel.onUnitsChange(event.units)			
		}

		
		public function simulationFailed():void
		{
			Logger.debug("simulationFailed()", this)
			PopUpManager.removePopUp(_popUp)
			
		}
		

	}
}