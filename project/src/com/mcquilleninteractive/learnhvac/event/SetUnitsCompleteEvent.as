// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.Event;

	public class SetUnitsCompleteEvent extends CairngormEvent{
		
		public static var UNITS_CHANGED : String = "unitsChanged";
		public var units:String 
				
		public function SetUnitsCompleteEvent(type:String, units:String){
			Logger.debug("#SetUnitsCompleteEvent: created type: " + type)
			this.units = units
	      	super( type );
     	}
     	
     	override public function clone() : Event
		{
			return new SetUnitsCompleteEvent(type, units);
		}	
     	
    	
		
	}
	
}