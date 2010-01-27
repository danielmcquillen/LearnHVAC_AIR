// ActionScript file

package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class VisualizationEvent extends Event
	{		
		public static const NAVIGATION_CHANGE_NODE : String = "navigationComplete";
		public var toNode:String //node navigated to by user
	
		public function VisualizationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
			
		override public function clone():Event
        {
            return new VisualizationEvent(this.type, this.bubbles, this.cancelable );
        }	
	}
}