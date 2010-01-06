// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	import mx.containers.Canvas
	import mx.containers.Panel;

	public class GraphEvent extends CairngormEvent{
		
		public static var EVENT_REFRESH_GRAPH: String = "refreshGraphEvent"
		public static var EVENT_ADD_MINI_GRAPH: String = "addMiniGraph"
		
		public var host:Canvas //the panel that's launching the mini graph popup
		
		public function GraphEvent(type:String){
	      	super( type )
     	}
     	
     	override public function clone() : Event{
			return new GraphEvent(type)
		}		
		
	}
	
}