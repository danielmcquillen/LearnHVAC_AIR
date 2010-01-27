// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
		
	import flash.events.Event;

	public class GetScenarioListEvent extends Event
	{
		
		public static const GET_LOCAL_SCENARIO_LIST : String = "getLocalScenarioList"
		public static const SCENARIO_LIST_LOADED : String = "scenarioListLoaded"
		public static const GET_DEFAULT_SCENARIO_LIST : String = "getDefaultScenarioList"
		public static const GET_REMOTE_SCENARIO_LIST : String = "getRemoteScenarioList"

		
     	public function GetScenarioListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
		override public function clone():Event
        {
            return new GetScenarioListEvent(this.type, this.bubbles, this.cancelable );
        }
	}
	
}