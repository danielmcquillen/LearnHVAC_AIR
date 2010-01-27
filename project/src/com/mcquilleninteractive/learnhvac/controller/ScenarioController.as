package com.mcquilleninteractive.learnhvac.controller
{
	
	import com.mcquilleninteractive.learnhvac.util.Logger	
	import com.mcquilleninteractive.learnhvac.event.ResetInputs
	

	import org.swizframework.controller.AbstractController;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.event.ZoneChangeEvent;
	import com.mcquilleninteractive.learnhvac.event.FloorChangeEvent;
	import flash.events.Event;
	
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
		
		
		
	}
}