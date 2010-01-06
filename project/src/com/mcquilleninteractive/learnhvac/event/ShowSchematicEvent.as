// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ShowSchematicEvent extends CairngormEvent{
		
		public static var EVENT_SHOW_HC_LIQUIDS_POPUP: String = "showHCLiquidsPopup";
		public static var EVENT_SHOW_CC_LIQUIDS_POPUP: String = "showCCLiquidsPopup";
		
		public function ShowSchematicEvent(type:String)
		{
	      	super( type );
     	}
     	
     	override public function clone() : Event
		{
			return new ShowSchematicEvent(type);
		}	
     	
    	
		
	}
	
}