// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class ShortTermSimulationEvent extends Event
	{
		
		//these are actions that should be performed against simulation
		public static const SIM_START : String = "startShortTermSimulation";
		public static const SIM_UPDATE : String = "updateShortTermSimulation";
		public static const SIM_STOP : String = "stopShortTermSimulation";
		public static const SIM_RETURN_TO_START : String = "returnToStartShortTermSimulation";
		
		
		//these are the responses based on simulation output
		public static const SIM_STARTED:String = "shortTermSimulationStarted"
		public static const SIM_OUTPUT_RECEIVED:String = "shortTermSimulationSimOutputReceived"
		public static const SIM_STOPPED:String = "shortTermSimulationStopped"
		public static const SIM_ERROR:String = "shortTermSimulationError"
		
		public var code:int
		public var errorMessage:String
		
		public function ShortTermSimulationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
        {
            return new ShortTermSimulationEvent(this.type, this.bubbles, this.cancelable );
        }
		
	}
}