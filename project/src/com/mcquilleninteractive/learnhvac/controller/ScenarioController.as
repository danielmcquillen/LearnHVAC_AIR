package com.mcquilleninteractive.learnhvac.controller
{
	
	import com.mcquilleninteractive.learnhvac.event.FloorChangeEvent;
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.event.ShortTermTimerEvent;
	import com.mcquilleninteractive.learnhvac.event.ZoneChangeEvent;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	
	import org.swizframework.controller.AbstractController;
	
	public class ScenarioController extends AbstractController
	{
		
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		//these two variables keeps track of a change in hours and date.
		//when either changed, we need to import longTermSysVars
		public var currHour:Number		
		public var currDate:Number
				
		public function ScenarioController()
		{
		}
		
		
		
		
		[Mediate(event="ZoneChangeEvent.ZONE_CHANGED")]
		public function zoneChanged(event:ZoneChangeEvent):void
		{
			
		}
		
		
		[Mediate(event="FloorChangeEvent.FLOOR_CHANGED")]
		public function onFloorChanged(event:FloorChangeEvent):void
		{
			
		}
		
		/* IMPORTING VARIABLES FROM LONG-TERM TO SHORT-TERM (E+ to MODELICA)
		   Each time the timer hits the top of the hour, import the long-term values into the short-term 	
		*/
		
		[Mediate(event="ShortTermTimerEvent.TIMER_STEP")]
		public function onTimer(event:ShortTermTimerEvent):void
		{			
			// import long-term variables on the hour 						
			if (currHour != event.currDateTime.hours || currDate != event.currDateTime.date)
			{
				//import long term vars before next sending of vars to short term sim
				scenarioModel.importLongTermVars()
				currHour = event.currDateTime.hours
				currDate = event.currDateTime.date
			}	
		}
		
		
	}
}