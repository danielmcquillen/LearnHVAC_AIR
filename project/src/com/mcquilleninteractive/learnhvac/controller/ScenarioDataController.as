package com.mcquilleninteractive.learnhvac.controller
{
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.event.UnitsEvent;
	import com.mcquilleninteractive.learnhvac.model.*;
	import com.mcquilleninteractive.learnhvac.model.data.EnergyPlusData;
	import com.mcquilleninteractive.learnhvac.model.data.ZoneEnergyUseDataPoint;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.AbstractController;
	import org.swizframework.factory.IInitializingBean;

	public class ScenarioDataController  extends AbstractController 
	{		
		
		[Autowire]
		public var scenarioModel:ScenarioModel	
		
		[Autowire]
		public var scenarioDataModel:ScenarioDataModel	
				
		[Autowire]
		public var longTermSimulationModel:LongTermSimulationModel	
				
		[Autowire]
		public var longTermSimulationDataModel:LongTermSimulationDataModel	
		
		[Autowire]
		public var shortTermSimulationDataModel:ShortTermSimulationDataModel	
		
		[Autowire]
		public var shortTermSimulationModel:ShortTermSimulationModel	
				
		
		public function ScenarioDataController()
		{
		}
		
		
		
		/** 
		 *  update the zone energy data when new data comes in from either short or long term simulations
		 *  (or other event that affects data, such as units change)
		 */
		
		/*
		[Mediate(event="UnitsEvent.UNITS_CHANGED")]	
		[Mediate(event="ShortTermSimulationEvent.SIM_OUTPUT_RECEIVED")]		
		public function onUpdateZoneEnergy(event:Event):void
		{	
			var importingFromRun:String = scenarioModel.importLongTermVarsFromRun
			
			if (importingFromRun == ScenarioModel.LT_IMPORT_NONE)
			{
				return 
			}
			
			if (longTermSimulationDataModel.runLoaded(importingFromRun)==false)
			{
				return
			}
			
			var energyPlusData:EnergyPlusData = longTermSimulationDataModel.getEnergyPlusData(importingFromRun)
			
			
			var vavRhcQd:Number = 0
			var lightingPeakLoad:Number = longTermSimulationModel.lightingPeakLoad
			var equipPeakLoad:Number = 0
			var zoneSize:Number = longTermSimulationModel.getCurrentZoneSize()		
			
			scenarioDataModel.calculateZoneEnergyUse(importingFromRun, vavRhcQd, lightingPeakLoad, equipPeakLoad, zoneSize)	
				
		}*/
		
		
		
		
		[Mediate(event="ShortTermSimulationEvent.SIM_STOP")]		
		public function onSimStop(event:Event):void
		{
			scenarioDataModel.clearZoneEnergyUse()
		}
		
		
		
	}
}