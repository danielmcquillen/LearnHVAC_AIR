// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LoggedInEvent extends CairngormEvent{
		
		public static var EVENT_LOGGED_IN: String = "loggedIn"
		
		public function LoggedInEvent(type:String){
	      	super( type )
     	}
     	
     	override public function clone() : Event{
			return new LoggedInEvent(type)
		}		
		
	}
	
}