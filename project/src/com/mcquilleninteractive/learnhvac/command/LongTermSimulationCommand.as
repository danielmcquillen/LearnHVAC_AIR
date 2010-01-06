// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.business.LongTermSimulationDelegate;
	import com.mcquilleninteractive.learnhvac.event.LongTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.view.LongTermSimulation;
	import com.mcquilleninteractive.learnhvac.view.popups.RunningEPlusModal;
	
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.managers.PopUpManager;
	
	public class LongTermSimulationCommand implements Command
	{
	
		private var delegate:LongTermSimulationDelegate
		private var view:LongTermSimulation
		private var popUp:RunningEPlusModal
	
		public function LongTermSimulationCommand(){}
	
		public function execute( event : CairngormEvent ): void	
		{
			Logger.debug("execute()", this)
			
			//show progress modal dialog 
			popUp = new RunningEPlusModal()
			PopUpManager.addPopUp(popUp, Application.application as DisplayObject,true)
			PopUpManager.centerPopUp(popUp)
			
			//listen for cancel event
			CairngormEventDispatcher.getInstance().addEventListener(LongTermSimulationEvent.EVENT_CANCEL, onCancel, false, 0,true)
			//set flag for cancelling parsing
			LHModelLocator.getInstance().scenarioModel.ePlusRunsModel.continueParsing = true
						
			delegate = new LongTermSimulationDelegate(this)
			view = LongTermSimulationEvent(event).view
			
			try 
			{
				var result:Boolean = delegate.runLongTermSimulation()
			}
			catch(err:Error)
			{
				Logger.error("error when calling runLongTermSimulation on delegate: e: " +err, this)  
				setupFailed()
			}
			if (!result) setupFailed();
			
			//if result is true, we can just wait for async process to finish
			
			//TESTMODE
			if (LHModelLocator.testMode)
			{
				
				var loadTestData:LoadTestEplusDataCommand = new LoadTestEplusDataCommand()
				loadTestData.execute(null)
				setupFinished(LHModelLocator.getInstance().scenarioModel.ePlusRunsModel.currRunID)
			}
		}
		
		
		
		public function onCancel( event: CairngormEvent ): void
		{
			Logger.debug("onCancel()", this)
			PopUpManager.removePopUp(popUp)
			delegate.cancelEPlus()
			LHModelLocator.getInstance().scenarioModel.ePlusRunsModel.continueParsing = false
			removeEventListeners()
		
		}
		
		public function setupFailed():void
		{
			Logger.debug("setupFailed()", this)
			PopUpManager.removePopUp(popUp)
			removeEventListeners()
			CairngormEventDispatcher.getInstance().dispatchEvent(new LongTermSimulationEvent(LongTermSimulationEvent.EVENT_DONE))
		}
		
		public function setupFinished(runID:String):void
		{
			Logger.debug("setupFinished()", this)
			PopUpManager.removePopUp(popUp)
			removeEventListeners()	
			CairngormEventDispatcher.getInstance().dispatchEvent(new LongTermSimulationEvent(LongTermSimulationEvent.EVENT_DONE))			
			
			//force scenModel to update to newest long term variables
			var scenModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			scenModel.importLongTermVars()
			
			Alert.show("Long-term simulation finished. Use the Analysis section to view results.","Simulation Finished")
		}
		
		private function removeEventListeners():void
		{
			CairngormEventDispatcher.getInstance().removeEventListener(LongTermSimulationEvent.EVENT_CANCEL, onCancel)
		}
		
	}

}