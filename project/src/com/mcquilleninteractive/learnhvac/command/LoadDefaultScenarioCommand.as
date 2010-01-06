// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.event.ScenarioLoadedEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class LoadDefaultScenarioCommand implements Command, IResponder
	{
	
		private var model : LHModelLocator = LHModelLocator.getInstance();
	
	
		public function execute( event : CairngormEvent ): void
		{
			Logger.debug("Loading default scenario", this)
		
			var scenarioXML:XML = XML(new _defaultScenarioXMLSource())
			result = delegate.populateScenarioModel(defaultScenarioXML)
			loadSuccess(result)
					
		}		
			
		public function loadSuccess(success:Boolean):void
		{
			Logger.debug("#LoadScenarioCommand: loadSuccess()")
			//update view if parse is ok
			if (success)
			{
				//change to simulation view if this step succeeds
				model.viewing = LHModelLocator.PANEL_SIMULATION 				
				model.simBtnEnabled = true
				model.bldgSetupEnabled = true
				model.scenarioLoaded = true
				
				var cgEvent : ScenarioLoadedEvent = new ScenarioLoadedEvent(ScenarioLoadedEvent.SCENARIO_LOADED);
				Logger.debug("##################################################################");
				Logger.debug("#LoadScenarioCommand: Scenario loaded. Dispatching loaded event.");
				Logger.debug("##################################################################");
				CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent)
			}
			else
			{
				mx.controls.Alert.show("The default scenario is not properly formed and could not be loaded. Please try a different scenario.");
			}		
		}
		
		
		
		
		
	}
}