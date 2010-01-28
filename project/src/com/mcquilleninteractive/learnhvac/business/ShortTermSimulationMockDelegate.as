package com.mcquilleninteractive.learnhvac.business
{
	import com.mcquilleninteractive.learnhvac.util.Logger
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
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
		
		protected function onTimer(event:TimerEvent):void
		{			
			_step++
			onOutputReceived()
		}
		
		public function start():void
		{			
			Logger.debug("start()",this)
			_step = 1  		
			_timer.start()
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_STARTED, false)
			dispatchEvent(evt)
		}
		
		public function stop():void
		{			
			Logger.debug("stop()",this)
			_timer.stop()
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_STOPPED, false)
			dispatchEvent(evt)
		}
		
		public function update():void
		{		
			Logger.debug("update()",this)
			var evt:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_UPDATED, false)
			dispatchEvent(evt)
		}
		
		public function onOutputReceived():void
		{
			Logger.debug("onOutputReceived()",this)
			//Do all the things we need to do to parse the Modelica output				
			scenarioModel.updateTimer(_step);			
		}

	}
}