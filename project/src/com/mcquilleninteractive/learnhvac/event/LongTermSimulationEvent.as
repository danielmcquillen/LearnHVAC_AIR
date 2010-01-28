package com.mcquilleninteractive.learnhvac.event
{
	
	import flash.events.Event;
	import com.mcquilleninteractive.learnhvac.vo.LongTermSimulationVO
	import com.mcquilleninteractive.learnhvac.view.LongTermSimulation

	public class LongTermSimulationEvent extends Event
	{
		
		public static const SIM_START : String = "runLongTermSimulation";
		public static const SIM_FAILED : String = "failedLongTermSimulation";
		public static const SIM_CANCEL : String = "cancelLongTermSimulation";
		public static const FILE_LOADED : String = "longTermSimulationFileLoaded";
		public static const SIM_COMPLETE : String = "completeLongTermSimulation";
		
		public var view:LongTermSimulation
		public var setupVO : LongTermSimulationVO
		public var runID:String
		public var errorMessage:String
		
				
		public function LongTermSimulationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
		override public function clone():Event
        {
            return new LongTermSimulationEvent(this.type, this.bubbles, this.cancelable );
        }
		
     	
     	
	}
	
}