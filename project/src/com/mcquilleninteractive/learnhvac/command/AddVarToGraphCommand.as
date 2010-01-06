package com.mcquilleninteractive.learnhvac.command
{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mcquilleninteractive.learnhvac.event.AddVarToGraphEvent;
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataLoadedEvent;
	import com.mcquilleninteractive.learnhvac.model.EPlusRunsModel
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.charts.chartClasses.CartesianChart;
	import mx.collections.ArrayCollection;
	public class AddVarToGraphCommand implements Command
	{
 
		public function AddVarToGraphCommand()
		{
			
		}

		public function execute( evt : CairngormEvent ): void
		{
			var e:AddVarToGraphEvent = AddVarToGraphEvent(evt)
			var chart:CartesianChart = e.chart as CartesianChart
			var includeTime:Boolean
			switch (e.type)
			{
				case AddVarToGraphEvent.EVENT_ADD_EPLUS_VAR:
					var eplusData : EPlusData = LHModelLocator.getInstance().scenarioModel.ePlusRunsModel.eplusRuns["initial"]
					includeTime = (e.graphType=="TS")
					chart.dataProvider = new ArrayCollection(eplusData.getVarData(e.eplusModelID, e.varIDs, includeTime))	
					break
					
				case AddVarToGraphEvent.EVENT_ADD_SPARK_VAR:
					Logger.error("#AddVarToGraphCommand: execute() getting data for " + e.varIDs)
					var scenModel : ScenarioModel = LHModelLocator.getInstance().scenarioModel
					chart.dataProvider = new ArrayCollection(scenModel.getVarData(e.varIDs, true))	
					break
			
				default:
					Logger.error("#AddVarToGraphCommand: execute() unrecognized event type: " + e.type)
			}
			
		}	
	}
}

