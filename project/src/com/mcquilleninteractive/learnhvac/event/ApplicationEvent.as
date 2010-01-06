// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ApplicationEvent extends CairngormEvent
	{
		public static var EVENT_SELECT_NEW_SCENARIO: String = "selectNewScenario"
		
		public function ApplicationEvent(type:String){
	      	super( type )
     	}
     	
     	override public function clone() : Event{
			return new ApplicationEvent(type)
		}		
		
	}
	
}