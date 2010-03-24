package com.mcquilleninteractive.learnhvac.event
{
	
	import com.mcquilleninteractive.learnhvac.view.LongTermSimulation;
	import com.mcquilleninteractive.learnhvac.vo.LongTermSimulationVO;
	
	import flash.events.Event;

	public class LongTermSimulationEvent extends Event
	{
		
		public static const SIM_START : String = "runLongTermSimulation";
		public static const SIM_FAILED : String = "failedLongTermSimulation";
		public static const SIM_CANCEL : String = "cancelLongTermSimulation";
		public static const FILE_LOADED : String = "longTermSimulationFileLoaded";
		public static const SIM_COMPLETE : String = "completeLongTermSimulation";
		
		public var view:LongTermSimulation
		public var setupVO : LongTermSimulationVO
		public var runID:String = ""
		public var errorMessage:String = ""
		
				
		public function LongTermSimulationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
		/*
		override public function clone():Event
        {
            var evt:LongTermSimulationEvent =  new LongTermSimulationEvent(this.type, this.bubbles, this.cancelable );
        	evt.view = view
        	evt.setupVO = setupVO
        	evt.runID = runID
        	evt.errorMessage = errorMessage
        	return evt
        }
        */
		
     	
     	
	}
	
}