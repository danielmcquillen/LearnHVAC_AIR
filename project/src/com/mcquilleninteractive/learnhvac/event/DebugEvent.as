// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class DebugEvent extends CairngormEvent{
		
		public static var LOAD_TEST_EPLUS_DATA_EVENT : String = "loadTestEplusData";

		public var runID:String

		public function DebugEvent(type : String){
	      	super( type );
     	}
     	
     	override public function clone() : Event{
			return new DebugEvent(type);
		}		
		
	}
	
}