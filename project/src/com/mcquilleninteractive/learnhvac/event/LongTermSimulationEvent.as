package com.mcquilleninteractive.learnhvac.event
{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mcquilleninteractive.learnhvac.vo.LongTermSimulationVO
	import com.mcquilleninteractive.learnhvac.view.LongTermSimulation

	public class LongTermSimulationEvent extends CairngormEvent{
		
		public static var EVENT_RUN : String = "run"
		public static var EVENT_CANCEL : String = "cancel"
		public static var EVENT_FAILED : String = "failed"
		public static var EVENT_DONE : String = "done"
		
		public var view:LongTermSimulation
		public var setupVO : LongTermSimulationVO
		
		public function LongTermSimulationEvent(type:String, view:LongTermSimulation=null, setupVO:LongTermSimulationVO=null)
		{
	      	super( type )
	      	this.view = view
     	}
     	
     	override public function clone() : Event{
     	
			return new LongTermSimulationEvent(EVENT_RUN, view, setupVO)
		}		
		
	}
	
}