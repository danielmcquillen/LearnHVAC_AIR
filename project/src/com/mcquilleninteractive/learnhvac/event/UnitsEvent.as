// ActionScript file
package com.mcquilleninteractive.learnhvac.event
{
	
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.Event;

	public class UnitsEvent extends Event
	{
		
		public static const CHANGE_UNITS : String = "changeUnits"
		public static const UNITS_CHANGED : String = "unitsChanged";
		
		public var units:String
				
		public function UnitsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
     	
    	
		override public function clone():Event
        {
            return new UnitsEvent(this.type, this.bubbles, this.cancelable );
        }
		
	}
	
}