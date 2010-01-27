// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class SysVarInfoPopupEvent extends Event
	{
		
		public static const SHOW_INFO: String = "showSysVarInfoPopup";
		public static const HIDE_INFO: String = "hideSysVarInfoPopup";
		
		public var sysVarName:String
		public var sysVarDisplayName:String
		public var sysVarDescription:String
		public var lowValue:String
		public var highValue:String
		
		public function SysVarInfoPopupEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		  	
		override public function clone():Event
        {
            return new SysVarInfoPopupEvent(this.type, this.bubbles, this.cancelable );
        }
		
	}
	
}