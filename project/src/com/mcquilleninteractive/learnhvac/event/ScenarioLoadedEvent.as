// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ScenarioLoadedEvent extends CairngormEvent{
		
		public static var SCENARIO_LOADED : String = "scenarioLoaded";
		
		public function ScenarioLoadedEvent(type:String):void{
	      	super( type);
     	}	
     	
     	override public function clone() : Event
		{
			return new ScenarioLoadedEvent( type );
		}	
	}
}