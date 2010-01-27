// ActionScript file
package com.mcquilleninteractive.learnhvac.event
{
		
	import flash.events.Event;

	public class LoginEvent extends Event
	{
		
		public static const LOGIN : String = "login"
		
		public var username : String
		public var password : String
		public var loggingInAsGuest : Boolean
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
				
		override public function clone():Event
        {
            return new LoginEvent(this.type, this.bubbles, this.cancelable );
        }	
	}
	
}