package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;

	public class ZoneChangeEvent extends Event
	{
		public static const ZONE_CHANGED:String = "zoneChanged"

		public var fromZone:uint
		public var toZone:uint
		
		public function ZoneChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}