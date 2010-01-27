// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
		
	import flash.events.Event;

	public class DebugEvent extends Event
	{
		
		public static const LOAD_TEST_EPLUS_DATA_EVENT : String = "loadTestEplusData";

		public var runID:String

		public function DebugEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	

		
		override public function clone():Event
        {
            return new DebugEvent(this.type, this.bubbles, this.cancelable );
        }
	}
	
}