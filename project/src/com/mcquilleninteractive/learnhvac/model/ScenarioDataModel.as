package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.event.ModelicaInputsTrace;
	import com.mcquilleninteractive.learnhvac.event.ShortTermTimerEvent;
	import com.mcquilleninteractive.learnhvac.model.*;
	import com.mcquilleninteractive.learnhvac.model.data.ZoneEnergyUseDataPoint;
	import com.mcquilleninteractive.learnhvac.util.DateUtil;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	import mx.collections.ArrayCollection;
	
	import org.swizframework.Swiz;
	
	
	/* This class holds ouptput data arrays and values that don't quite fit into either short-term or long-term data models.
	   For example, some data needs to be a combination of values from each (e.g. ZoneEnergyGraph)
	*/
	
	public class ScenarioDataModel extends EventDispatcher
	{
		
		
		[Bindable]
		public var 	zoneEnergyUseRun1AC:ArrayCollection
		
		[Bindable]
		public var zoneEnergyUseRun2AC:ArrayCollection
		
		
		public function ScenarioDataModel()
		{
			init()
		}
		
		
		public function init():void
		{			
			zoneEnergyUseRun1AC = new ArrayCollection([new ZoneEnergyUseDataPoint()])
			zoneEnergyUseRun2AC = new ArrayCollection([new ZoneEnergyUseDataPoint()])			
		}
		
		
		public function calculateZoneEnergyUse(runID:String, vavRhcQd:Number, lightingPeakLoad:Number, equipPeakLoad:Number, zoneSize:Number):void
		{
			if (runID==LongTermSimulationDataModel.RUN_1)
			{
				var zoneEnergyAC:ArrayCollection = zoneEnergyUseRun1AC
			}
			else if (runID==LongTermSimulationDataModel.RUN_2)
			{				
				zoneEnergyAC = zoneEnergyUseRun2AC
			}
			else
			{
				Logger.error("Unrecognized runID: " + runID, this)
				return
			}
			var zoneEnergyDP:ZoneEnergyUseDataPoint = zoneEnergyAC.getItemAt(0) as ZoneEnergyUseDataPoint
			
			zoneEnergyDP.VAVRhcQd = vavRhcQd //TEMP
			zoneEnergyDP.lightingPower = lightingPeakLoad * zoneSize
			zoneEnergyDP.equipPower = equipPeakLoad * zoneSize
			zoneEnergyAC.refresh()
		}
		
		public function clearZoneEnergyUse():void
		{
			
			//TEMP 
			return
			/*
			zoneEnergyUseRun1AC[0] = new ZoneEnergyUseDataPoint()
			zoneEnergyUseRun2AC[1] = new ZoneEnergyUseDataPoint()
			zoneEnergyUseRun1AC.refresh()
			zoneEnergyUseRun2AC.refresh()
			*/
		}
		
	}
}