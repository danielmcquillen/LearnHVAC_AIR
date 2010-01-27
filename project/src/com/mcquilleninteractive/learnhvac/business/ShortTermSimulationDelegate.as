package com.mcquilleninteractive.learnhvac.business
{
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;	
	import com.mcquilleninteractive.learnhvac.util.Logger
	import flash.events.EventDispatcher
		
	public class ShortTermSimulationDelegate extends EventDispatcher
	{
		
		public static const OUTPUT_RECEIVED:String = "shortTermOutputReceived";
			
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		public function ShortTermSimulationDelegate() 
		{
		}
		
		public function start():void
		{
			
		}
		
		public function stop():void
		{
			
		}
		
		public function update():void
		{		
		}
		
		public function onOutputReceived():void
		{
			Logger.debug("onOutputReceived()",this)
			//Do all the things we need to do to parse the Modelica output
			var step:uint = 1 // this will be read in from Modelica			
			scenarioModel.updateTimer(step);			
		}

	}
}