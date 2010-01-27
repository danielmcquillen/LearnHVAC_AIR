package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;

	public class SetPointEvent extends Event
	{
		public static const CHANGE_SET_POINT:String = "changeSetPoint"
		
		public var temp:Number
		
		public function SetPointEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}