package com.mcquilleninteractive.learnhvac.model
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataLoadedEvent;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	[Bindable]
	public class SparkRunsModel
	{
		public static var RUN_1:String = "spark_run1"
		public static var RUN_2:String = "spark_run2"
		public var currRunID:String = SparkRunsModel.RUN_1	//current run as selected by user
		
		public var initialLoaded:Boolean = false
		public var comparisonLoaded:Boolean = false
		
		public var sparkRuns:Array  // holds instances of SparkData, each of which can hold data from a DRQAT run
		
		public function SparkRunsModel()
		{
			sparkRuns = new Array()
			sparkRuns[SparkRunsModel.RUN_1] = new SparkData(this)
			sparkRuns[SparkRunsModel.RUN_2] = new SparkData(this)
		}

		
		/*
		public function loadSparkOutput(sparkOutputXML:XML, modelID:String):Boolean
		{
			//loads SPARK data contained in a simple XML format (as defined by and saved by this application)
			
			Logger.debug("#SparkRunsModel: loadSparkOutput() modelID: " + modelID)
			if (sparkRuns[modelID]==undefined)
			{
				Logger.warn("#SparkRunsModel: loadSparkOutput: no model with id: " + modelID)
				//create new model if ID doesn't exist
				sparkRuns[modelID] = new SparkData(this)
			}
		
			var sparkData:SparkData = SparkData(sparkRuns[modelID])
			var loadWarning:Boolean = sparkData.loadXMLData(sparkOutputXML)
			
			//launch event
			Logger.debug("#SparkRunsModel: loadSparkOutput() dispatching loaded event")
			var cgEvent:ScenarioDataLoadedEvent = new ScenarioDataLoadedEvent(ScenarioDataLoadedEvent.SPARK_DATA_PARSED, modelID, IGraphDataModel(sparkData))
			CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent)
			
			if (modelID==SparkRunsModel.RUN_1) initialLoaded=true
			if (modelID==SparkRunsModel.RUN_2) comparisonLoaded=true
			
			return loadWarning		
		}
		*/
		
		public function loadCurrSparkData():void
		{
			//loads data directly from Scenario Model after SPARK is run.
			Logger.debug("#SparkRunsModel: copying SPARK data into runs model. currRunID: " + currRunID)
			var sparkData:SparkData = SparkData(sparkRuns[currRunID])
			//try
			//{
				sparkData.loadCurrData()
			//}
			//catch(err:Error)
			//{
			// 	Logger.error("#SparkRunsModel: error trying to load current SPARK data into SparkRunsModel. e: " + err.message)
			//	return
			//}
			
			if (currRunID==SparkRunsModel.RUN_1) initialLoaded = true
			if (currRunID==SparkRunsModel.RUN_2) comparisonLoaded = true
				
			//launch event
			Logger.debug("#SparkRunsModel: loadCurrSparkData() dispatching loaded event")
			var cgEvent:ScenarioDataLoadedEvent = new ScenarioDataLoadedEvent(ScenarioDataLoadedEvent.SPARK_DATA_PARSED, currRunID, IGraphDataModel(sparkData))
			CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent)
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