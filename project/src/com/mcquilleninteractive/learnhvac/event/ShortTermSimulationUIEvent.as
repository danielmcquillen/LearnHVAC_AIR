// ActionScript file
package com.mcquilleninteractive.learnhvac.event
{
	
	import flash.events.Event;
	
	public class ShortTermSimulationUIEvent extends Event
	{
		public static const UI_READY : String = "shortTermSimUIReady";
	
		public function ShortTermSimulationUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}				
	}
}