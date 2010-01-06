// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SysVarInfoPopupEvent extends CairngormEvent{
		
		public static var EVENT_SHOW_INFO: String = "showSysVarInfoPopup";
		public static var EVENT_HIDE_INFO: String = "hideSysVarInfoPopup";
		
		public var sysVarName:String
		public var sysVarDisplayName:String
		public var sysVarDescription:String
		public var lowValue:String
		public var highValue:String
		
		public function SysVarInfoPopupEvent(type:String)
		{
	      	super( type );
     	}
     	
     	override public function clone() : Event
		{
			return new SysVarInfoPopupEvent(type);
		}	
     	
    	
		
	}
	
}