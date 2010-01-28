package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.util.Logger
	import com.mcquilleninteractive.learnhvac.model.DefaultScenariosModel
	
	import mx.collections.ArrayCollection
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class ScenarioLibraryModel extends EventDispatcher
	{
		//Location of scenarios
		public static const SCENARIOS_LIST_LOCAL : String = "Scenario List : Local file system"
		public static const SCENARIOS_LIST_REMOTE : String = "Scenario List : Server"
		public static const SCENARIOS_LIST_DEFAULT : String= " Scenario List : Default"
		
		public var scenarioListLocation:String 
		
		public var currScenarioList:ArrayCollection = new ArrayCollection(); // from either server or local
		public var defaultScenarioList : DefaultScenariosModel 
				
		public function ScenarioLibraryModel()
		{
			defaultScenarioList = new DefaultScenariosModel()
		}

	}
}