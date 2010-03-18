package com.mcquilleninteractive.learnhvac.business
{
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;		import flash.events.EventDispatcher;	import flash.events.TimerEvent;	import flash.utils.Timer;
	/* 
		This class serves as a mock object to simulation the output
       	of the coming Modelica model (currently being developed) 
     */
	
	public class ShortTermSimulationMockDelegate extends EventDispatcher implements IShortTermSimulationDelegate
	{
		
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		protected var _timer:Timer 
		protected var _step:int
		
		public function ShortTermSimulationMockDelegate()
		{
			_timer = new Timer(1000)
			_timer.addEventListener(TimerEvent.TIMER, onTimer)			
		}
		
		public function start():void
		{
			
		}
		
		public function stop():void
		{
			
		}
		
		public function onTimer(event:TimerEvent):void
		{
			
		}
	}
}