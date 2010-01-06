
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ResetInputsToInitialValuesEvent extends CairngormEvent{
		
		public static var EVENT_RESET_INPUTS_TO_INITIAL_VALUES : String = "resetInputsToInitialValues";
		
		public function ResetInputsToInitialValuesEvent(){
	      	super( EVENT_RESET_INPUTS_TO_INITIAL_VALUES );
     	}	
     	
     	
	}
}