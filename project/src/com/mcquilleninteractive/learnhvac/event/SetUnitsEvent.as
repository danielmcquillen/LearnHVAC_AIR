// ActionScript file
package com.mcquilleninteractive.learnhvac.event
{
	
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.Event;

	public class SetUnitsEvent extends Event
	{
		
		public static const SET_UNITS : String = "setUnits"
		
		public var units:String
				
		public function SetUnitsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
     	
    	
		override public function clone():Event
        {
            return new SetUnitsEvent(this.type, this.bubbles, this.cancelable );
        }
		
	}
	
}