
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class ResetInputsEvent extends Event
	{		
		public static const RESET_SHORT_TERM_INPUTS_TO_INITIAL_VALUES : String = "resetShortTermInputsToInitialValues";
		public static const SHORT_TERM_INPUTS_RESET:String = "shortTermInputsReset"
		
		public function ResetInputsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
     	
	}
}