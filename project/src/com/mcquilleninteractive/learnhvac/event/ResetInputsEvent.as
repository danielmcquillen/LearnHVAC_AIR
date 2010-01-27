
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class ResetInputsEvent extends Event
	{		
		public static const RESET_SHORT_TERM_INPUTS_TO_INITIAL_VALUES : String = "resetShortTermInputsToInitialValues";
		
		public function ResetInputsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
		override public function clone():Event
        {
            return new ResetInputsEvent(this.type, this.bubbles, this.cancelable );
        }
     	
	}
}