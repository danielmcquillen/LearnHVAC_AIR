// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.business.LocalScenarioListLoader;
	import com.mcquilleninteractive.learnhvac.event.GetScenarioListEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	/**
	 * @version	$Revision: $
	 */
	public class GetLocalScenarioListCommand implements Command
	{
	
		public function GetLocalScenarioListCommand()
		{
				
		}
	
		public function execute( event : CairngormEvent ): void	
		{
			var localLoader:LocalScenarioListLoader = new LocalScenarioListLoader(this)
			try
			{
				localLoader.loadScenarioList()
			}
			catch(e:Error)
			{
				Logger.error("#LocalScenarioListLoader: error trying to load scenarios: " + e.message)
				mx.controls.Alert.show( "Couldn't load a list of scenarios from the scenarios folder. Please make sure all scenarios are valid. Error: " + e.message );
			}
		}
		
		public function noLocalFilesFound():void
		{
			mx.controls.Alert.show( "There are no valid scenarios in the scenarios folder." );
			LHModelLocator.getInstance().currScenarioList = new ArrayCollection()
		}
		
		public function scenariosLoaded(scenarioListAC:ArrayCollection):void
		{
			var model : LHModelLocator = LHModelLocator.getInstance();
			
			model.scenarioListLocation = LHModelLocator.SCENARIOS_LIST_LOCAL
			
			model.currScenarioList = scenarioListAC
			
			CairngormEventDispatcher.getInstance().dispatchEvent(new GetScenarioListEvent(GetScenarioListEvent.EVENT_SCENARIO_LIST_LOADED))
				
		}
		
		
	}

}