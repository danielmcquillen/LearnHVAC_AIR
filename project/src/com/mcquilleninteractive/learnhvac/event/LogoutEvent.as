// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LogoutEvent extends CairngormEvent
	{
		public static var EVENT_LOGOUT: String = "logout"
		
		public function LogoutEvent(){
	      	super( EVENT_LOGOUT )
     	}
     	
     	override public function clone() : Event{
			return new LogoutEvent()
		}		
		
	}
	
}