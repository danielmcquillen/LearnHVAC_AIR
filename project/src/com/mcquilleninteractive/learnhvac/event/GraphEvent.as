// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
		
	import flash.events.Event;
	import mx.containers.Canvas
	import mx.containers.Panel;

	public class GraphEvent extends Event
	{
		
		public static const REFRESH_GRAPH: String = "refreshGraphEvent"
		public static const ADD_MINI_GRAPH: String = "addMiniGraph"
		
		public var host:Canvas //the panel that's launching the mini graph popup
		   
		public function GraphEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
		override public function clone():Event
        {
            return new GraphEvent(this.type, this.bubbles, this.cancelable );
        }
	}
	
}