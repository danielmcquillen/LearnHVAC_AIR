package com.mcquilleninteractive.learnhvac.controller
{
	import org.swizframework.controller.AbstractController
	import com.mcquilleninteractive.learnhvac.event.AddVarToGraphEvent;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationDataModel
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationDataModel
	import com.mcquilleninteractive.learnhvac.model.data.EnergyPlusData
	import com.mcquilleninteractive.learnhvac.util.Logger
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationDataModel;
	import mx.collections.ArrayCollection

	import mx.charts.chartClasses.CartesianChart;	
	public class ChartController extends AbstractController
	{
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		[Autowire]
		public var longTermSimulationDataModel:LongTermSimulationDataModel
		
		[Autowire]
		public var shortTermSimulationDataModel:ShortTermSimulationDataModel
		
		public function ChartController()
		{
		}

		[Mediate(event="AddVarToGraphEvent.ADD_LONG_TERM_VAR")]
		public function addLongTermVarToGraph(event:AddVarToGraphEvent):void
		{			
			var chart:CartesianChart = event.chart as CartesianChart
			var includeTime:Boolean
			
			var eplusData : EnergyPlusData = longTermSimulationDataModel.getEnergyPlusData(event.eplusModelID)
			includeTime = (event.graphType=="TS")
			chart.dataProvider = new ArrayCollection(eplusData.getVarData(event.varIDs, includeTime))	
														, event.varIDs, includeTime
		}
		
		[Mediate(event="AddVarToGraphEvent.ADD_SHORT_TERM_VAR")]
		public function addShortTermVarToGraph(event:AddVarToGraphEvent):void
		{			
			var chart:CartesianChart = event.chart as CartesianChart
			var includeTime:Boolean
			chart.dataProvider = new ArrayCollection(scenarioModel.getVarData(event.varIDs, true))	
		}
		
		
	}
}