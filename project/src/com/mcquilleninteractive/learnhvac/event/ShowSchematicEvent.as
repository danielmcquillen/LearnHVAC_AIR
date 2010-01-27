// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class ShowSchematicEvent extends Event
	{
		
		public static const SHOW_HC_LIQUIDS_POPUP: String = "showHCLiquidsPopup";
		public static const SHOW_CC_LIQUIDS_POPUP: String = "showCCLiquidsPopup";
		     			
		public function ShowSchematicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
    	
		
		override public function clone():Event
        {
            return new ShowSchematicEvent(this.type, this.bubbles, this.cancelable );
        }
	}
	
}