// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;

	public class ShortTermSimulationEvent extends Event
	{
		
		public static const SIM_START : String = "startShortTermSimulation";
		public static const SIM_UPDATE : String = "updateShortTermSimulation";
		public static const SIM_STOP : String = "stopShortTermSimulation";
		
		//these are the responses from the simulation
		public static const SIM_STARTED:String = "shortTermSimulationStarted"
		public static const SIM_UPDATED:String = "shortTermSimulationUpdated"
		public static const SIM_STOPPED:String = "shortTermSimulationStopped"
		public static const SIM_ERROR:String = "shortTermSimulationError"
		public static const SIM_CRASHED:String = "shortTermSimulationCrashed"
		public static const OUTPUT_UPDATED:String ="shortTermSimulationOutputUpdated"
		
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