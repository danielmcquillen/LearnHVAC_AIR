package com.mcquilleninteractive.learnhvac.command
{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.event.GetScenarioListEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	
	public class GetDefaultScenarioListCommand implements Command
	{
	
	
		public function GetDefaultScenarioListCommand(){}
	
		public function execute( event : CairngormEvent ): void	
		{
			
			//setup default scenarios
			
			var model : LHModelLocator = LHModelLocator.getInstance()			
			model.currScenarioList = model.defaultScenarioList.defaultScenariosAC	
			
			model.scenarioListLocation = LHModelLocator.SCENARIOS_LIST_DEFAULT
			CairngormEventDispatcher.getInstance().dispatchEvent(new GetScenarioListEvent(GetScenarioListEvent.EVENT_SCENARIO_LIST_LOADED))
						
		}
		
		
	}

}