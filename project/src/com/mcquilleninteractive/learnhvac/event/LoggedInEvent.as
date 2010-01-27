// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class LoggedInEvent extends Event
	{
		
		public static const LOGGED_IN: String = "loggedIn"
		
		public function LoggedInEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
		
		override public function clone():Event
        {
            return new LoggedInEvent(this.type, this.bubbles, this.cancelable );
        }
	}
	
}