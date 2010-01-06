// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.Event;

	public class SetUnitsEvent extends CairngormEvent{
		
		public static var EVENT_SET_UNITS_TO_IP : String = "IP";
		public static var EVENT_SET_UNITS_TO_SI : String = "SI";
				
		public function SetUnitsEvent(type:String){
			Logger.debug("#SetUnitsEvent: created type: " + type)
	      	super( type );
     	}
     	
     	override public function clone() : Event
		{
			return new SetUnitsEvent(type);
		}	
     	
    	
		
	}
	
}