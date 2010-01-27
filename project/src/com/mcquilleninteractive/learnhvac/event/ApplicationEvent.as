// ActionScript file
package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;

	public class ApplicationEvent extends Event
	{
		public static const SELECT_NEW_SCENARIO: String = "selectNewScenario"
		
		public function ApplicationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
		override public function clone():Event
        {
            return new ApplicationEvent(this.type, this.bubbles, this.cancelable );
        }
	}
	
}