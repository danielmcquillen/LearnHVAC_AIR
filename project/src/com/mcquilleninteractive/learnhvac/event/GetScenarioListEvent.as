// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class GetScenarioListEvent extends CairngormEvent{
		
		public static var EVENT_GET_LOCAL_SCENARIO_LIST : String = "getLocalScenarioList";
		public static var EVENT_GET_REMOTE_SCENARIO_LIST : String = "getRemoteScenarioList";
		public static var EVENT_SCENARIO_LIST_LOADED : String = "scenarioListLoaded";
		public static var EVENT_GET_DEFAULT_SCENARIO_LIST : String = "getDefaultScenarioList"

		public function GetScenarioListEvent(type : String){
	      	super( type );
     	}
     	
     	override public function clone() : Event{
			return new GetScenarioListEvent(type);
		}		
		
	}
	
}