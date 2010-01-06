// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ShortTermSimulationEvent extends CairngormEvent{
		
		public static var EVENT_START_AHU : String = "startAHU";
		public static var EVENT_UPDATE_AHU : String = "updateAHU";
		public static var EVENT_STOP_AHU : String = "stopAHU";
		public static var EVENT_CANCEL_START_AHU : String = "cancelStartAHU";
		
		
		public function ShortTermSimulationEvent(type:String)
		{
		  	super( type )
     	}
     	
     	override public function clone() : Event
		{
			return new ShortTermSimulationEvent( type )
		}		
	}
}