package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataLoadedEvent;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import flash.events.EventDispatcher;
	import org.swizframework.Swiz;
	
	[Bindable]
	public class ShortTermSimulationDataModel extends EventDispatcher
	{
		public static var RUN_1:String = "spark_run1"
		public static var RUN_2:String = "spark_run2"
		public var currRunID:String = ShortTermSimulationDataModel.RUN_1	//current run as selected by user
		
		public var initialLoaded:Boolean = false
		public var comparisonLoaded:Boolean = false
		
		public var sparkRuns:Array  // holds instances of SparkData, each of which can hold data from a DRQAT run
		
		public function ShortTermSimulationDataModel()
		{
			sparkRuns = new Array()
			sparkRuns[ShortTermSimulationDataModel.RUN_1] = new SparkData(this)
			sparkRuns[ShortTermSimulationDataModel.RUN_2] = new SparkData(this)
		}
		
		public function loadCurrSparkData():void
		{
			//loads data directly from Scenario Model after SPARK is run.
			Logger.debug("#SparkRunsModel: copying SPARK data into runs model. currRunID: " + currRunID)
			var sparkData:SparkData = SparkData(sparkRuns[currRunID])
			sparkData.loadCurrData()			
			
			if (currRunID==ShortTermSimulationDataModel.RUN_1) initialLoaded = true
			if (currRunID==ShortTermSimulationDataModel.RUN_2) comparisonLoaded = true
				
			//launch event
			Logger.debug("#SparkRunsModel: loadCurrSparkData() dispatching loaded event")
			var event:ScenarioDataLoadedEvent = new ScenarioDataLoadedEvent(ScenarioDataLoadedEvent.SPARK_DATA_PARSED,true)
			event.graphDataModel = IGraphDataModel(sparkData)
			event.graphDataModelID =  currRunID
			Swiz.dispatchEvent(event)
			
		}


		public function getData(runID:String):SparkData
		{
			if (sparkRuns[runID]==undefined)
			{
				Logger.warn("#SparkRunsModel: getData() runID: " +runID+" not found")
				return null
			}
			return SparkData(sparkRuns[runID])
		}

	}
}