package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class LongTermImportEvent extends CairngormEvent
	{
		//Notifies listeners that the user has changed the run to import into short term 
		public static var RUN_CHANGED:String = "runChanged"
		
		public var runToImport:String 
		
		public function LongTermImportEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	
	
		override public function clone():Event
		{
	     	return new LongTermImportEvent(type, bubbles, cancelable)
		}		
	}	
	
}


