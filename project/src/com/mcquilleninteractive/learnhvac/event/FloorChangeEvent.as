package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;

	public class FloorChangeEvent extends Event
	{
		public static const FLOOR_CHANGED:String = "floorChanged"
		
		public var fromFloor:uint
		public var toFloor:uint
		
		public function FloorChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}