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
	import org.swizframework.factory.IInitializingBean;
	
	public class LongTermSimulationController extends AbstractController implements IInitializingBean
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
				simulationFailed(null)
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
		
		
		[Mediate(event="SetUnitsCompleteEvent.UNITS_CHANGED")]
		public function onUnitsChanged(event:SetUnitsCompleteEvent):void
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
			Swiz.dispatchEvent(event.clone())	
		}   
		   
		public function simulationFailed(event:LongTermSimulationEvent):void
		{
			Logger.debug("simulationFailed()", this)						
			PopUpManager.removePopUp(_popUp)	
			Swiz.dispatchEvent(event)	
			Alert.show("Long-term simulation failed. " + event.errorMessage, "Simulation Failed")
		}
		
		public function simulationComplete(event:LongTermSimulationEvent):void
		{
			Logger.debug("simulationComplete()", this)						
			PopUpManager.removePopUp(_popUp)
			scenarioModel.importLongTermVars()		
			Swiz.dispatchEvent(event)			
			Alert.show("Long-term simulation finished. Use the Analysis section to view results.","Simulation Finished")
		}		
		
		/* END DELEGATE FUNCTIONS */


	}
}