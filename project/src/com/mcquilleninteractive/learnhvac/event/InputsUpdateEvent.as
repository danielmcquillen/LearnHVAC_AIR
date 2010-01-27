// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class InputsUpdateEvent extends Event
	{
		
		public static const INPUTS_UPDATE : String = "inputsUpdate";
     	
     	public function InputsUpdateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
			
		
		override public function clone():Event
        {
            return new InputsUpdateEvent(this.type, this.bubbles, this.cancelable );
        }
	}
	
}