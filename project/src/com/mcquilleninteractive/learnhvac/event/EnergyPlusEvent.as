package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;
	
	public class EnergyPlusEvent extends Event
	{
		public static const ENERGY_PLUS_OUTPUT:String = "energyPlusOutput"
		
		public var output:String
		
		public function EnergyPlusEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
        {
            return new EnergyPlusEvent(this.type, this.bubbles, this.cancelable );
        }

	}
}