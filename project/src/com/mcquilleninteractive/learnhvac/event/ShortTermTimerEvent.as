package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;

	public class ShortTermTimerEvent extends Event
	{
		public static const TIMER_STEP:String="shortTermTimerStep"

		public var currDateTime:Date

		public function ShortTermTimerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}