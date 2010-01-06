// ActionScript file
// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class AHUEvent extends CairngormEvent{
		
		// There are two different event classes that handle AHU events
		// The SimuationEvent class handles events that affect the AHU
		// This class, AHUEvent, handles events coming out of the AHU itself
		// Splitting the classes like this allows us to create components
		// that respond to the true state of the AHU, not just what the user wants it to do
				
		public static var EVENT_AHU_STARTED : String = "AHUStarted";
		public static var EVENT_AHU_STOPPED: String = "AHUStopped";

		public function AHUEvent(type:String){
	      	super( type )
     	}
     	
     	override public function clone():Event{
			return new AHUEvent(type)
		}		
		
	}
	
}