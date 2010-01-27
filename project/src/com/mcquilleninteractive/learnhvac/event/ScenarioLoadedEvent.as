// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class ScenarioLoadedEvent extends Event
	{		
		public static const SCENARIO_LOAD_FAILED : String = "scenarioLoadFailed";
		public static const SCENARIO_LOADED : String = "scenarioLoaded";
		
		public function ScenarioLoadedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		  	
		
		
		override public function clone():Event
        {
            return new ScenarioLoadedEvent(this.type, this.bubbles, this.cancelable );
        }
		    
	}
}