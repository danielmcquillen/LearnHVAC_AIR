// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class InputsUpdateEvent extends CairngormEvent{
		
		public static var EVENT_INPUTS_UPDATE : String = "inputsUpdate";

		public function InputsUpdateEvent():void{
	      	super( EVENT_INPUTS_UPDATE );
     	}
     	
     	override public function clone() : Event{
			return new InputsUpdateEvent();
		}		
		
	}
	
}