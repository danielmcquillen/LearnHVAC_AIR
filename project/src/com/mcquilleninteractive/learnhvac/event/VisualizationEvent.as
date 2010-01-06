// ActionScript file

package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class VisualizationEvent extends CairngormEvent{
		
		public static var EVENT_NAVIGATION_CHANGE_NODE : String = "navigationComplete";
		public var toNode:String //node navigated to by user
	
		public function VisualizationEvent(type:String, sysNode:String)
		{
	      	super( type );
	      	toNode = sysNode;
     	}	
	}
}