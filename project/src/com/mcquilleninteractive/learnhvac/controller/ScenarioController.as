package com.mcquilleninteractive.learnhvac.controller
{
	
	import com.mcquilleninteractive.learnhvac.event.ShortTermTimerEvent;
	import com.mcquilleninteractive.learnhvac.event.ZoneChangeEvent;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	
	import org.swizframework.controller.AbstractController;
	
	public class ScenarioController extends AbstractController
	{
		
		[Autowire]
		public var scenarioModel:ScenarioModel
		
				
		public function ScenarioController()
		{
		}
		
		
		
		
		[Mediate(event="ZoneChangeEvent.ZONE_CHANGED")]
		public function zoneChanged(event:ZoneChangeEvent):void
		{
			
		}
		
		[Mediate(event="FloorChangeEvent.FLOOR_CHANGED")]
		public function onFloorChanged(event:ZoneChangeEvent):void
		{
			
		}
		
		
		[Mediate(event="ShortTermSimEvent")]
		public function onTimer(event:ShortTermTimerEvent):void
		{
			// import long-term variables on the hour 						
			if (event.currDateTime.minutes==0 && event.currDateTime.seconds== 0)
			{
				//import long term vars before next sending of vars to short term sim
				scenarioModel.importLongTermVars()
			}	
		}
		
		
	}
}