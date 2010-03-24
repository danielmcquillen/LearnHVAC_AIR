package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;

	public class CloseScenarioEvent extends Event
	{
		public static const CLOSE_SCENARIO:String = "closeScenario"	
		
		public function CloseScenarioEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}