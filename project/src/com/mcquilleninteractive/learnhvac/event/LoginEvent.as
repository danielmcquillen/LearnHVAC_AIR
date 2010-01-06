// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class LoginEvent extends CairngormEvent{
		
		public static var EVENT_LOGIN : String = "login"
		public var username : String
		public var password : String
		public var loggingInAsGuest : Boolean
		
		public function LoginEvent(username : String, 
									password : String, 
									loggingInAsGuest:Boolean = false){
	      	super( EVENT_LOGIN )
	      	this.username = username
			this.password = password
	      	this.loggingInAsGuest = loggingInAsGuest
     	}
     	
     	override public function clone() : Event{
			return new LoginEvent(username, password,  loggingInAsGuest)
		}		
		
	}
	
}