// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class AutoEvent extends CairngormEvent{
		
		public static var EVENT_INPUT_PANEL : String = "eventInputPanel";
		public var cmd:String
		public var args:Array

		public function AutoEvent(type:String, cmd:String, args:Array = null):void{
			this.cmd = cmd
			this.args = args
	      	super( type );
     	}
     	
     	override public function clone() : Event{
			return new AutoEvent(type, cmd, args);
		}		
		
	}
	
}