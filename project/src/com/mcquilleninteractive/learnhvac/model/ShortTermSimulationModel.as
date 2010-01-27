package com.mcquilleninteractive.learnhvac.model
{
	import flash.events.EventDispatcher;
	
	public class ShortTermSimulationModel extends EventDispatcher
	{
		public static const STATE_OFF:String = "off"
		public static const STATE_RUNNING:String = "running"
		public static const STATE_PAUSED:String = "paused"
				
		protected var _currentState:String
				
		public function ShortTermSimulationModel()
		{
		}
		
		public function get currentState():String
		{
			return _currentState
		}

		public function set currentState(value:String):void
		{
			 _currentState = value
		}
	}
}