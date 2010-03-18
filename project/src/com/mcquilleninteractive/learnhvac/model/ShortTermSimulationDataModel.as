package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataLoadedEvent;
	import com.mcquilleninteractive.learnhvac.model.data.IGraphDataModel;
	import com.mcquilleninteractive.learnhvac.model.data.ModelicaData;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.EventDispatcher;
	
	import org.swizframework.Swiz;
	
	[Bindable]
	public class ShortTermSimulationDataModel extends EventDispatcher
	{
		
		public var initialLoaded:Boolean = false
		public var comparisonLoaded:Boolean = false
		
		public static var RUN_1:String = "short_term_run1"
		public static var RUN_2:String = "short_term_run2"
		
		// for graphing	
		public static var SHORT_TERM_DATA_TYPE:String = "shortTermDataType"; 	
		
		//current run as selected by user
		public var currRunID:String = ShortTermSimulationDataModel.RUN_1	
		
		// holds instances of ModelicaData, each of which holds data from Modelica run
		public var runsArr:Array  
		
		public function ShortTermSimulationDataModel()
		{
			runsArr = new Array()
			runsArr[ShortTermSimulationDataModel.RUN_1] = new ModelicaData()
			runsArr[ShortTermSimulationDataModel.RUN_2] = new ModelicaData()
		}
		
		public function init():void
		{
			//initialize each run's ModelicaData class with the currently loaded SystemVariables
			var scenarioModel:ScenarioModel = Swiz.getBean("scenarioModel") as ScenarioModel
			var shortTermSimulationModel:ShortTermSimulationModel = Swiz.getBean("shortTermSimulationModel") as ShortTermSimulationModel
			
			for each (var md:ModelicaData in runsArr)
			{
				md.startDateTime = shortTermSimulationModel.realtimeStartDatetime
				md.buildMenuStructure(scenarioModel)
			}
					
			//launch event
			Logger.debug("init() dispatching loaded event", this)
			var event:ScenarioDataLoadedEvent = new ScenarioDataLoadedEvent(ScenarioDataLoadedEvent.SHORT_TERM_SYSVARS_LOADED,true)
			event.graphDataModel = IGraphDataModel(runsArr[currRunID])
			event.graphDataModelID =  currRunID
			Swiz.dispatchEvent(event)
		}
				
		public function clearCurrentRun():void
		{
			if (runsArr[currRunID])
			{
				ModelicaData(runsArr[currRunID]).clearData()
			}
			else
			{
				Logger.error("Couldn't find Modelica data for run: " + currRunID,this)
			}
		}
		
		public function currRunComplete():void
		{
			if (currRunID==ShortTermSimulationDataModel.RUN_1) initialLoaded = true
			if (currRunID==ShortTermSimulationDataModel.RUN_2) comparisonLoaded = true
						
		}


		public function getData(runID:String):ModelicaData
		{
			if (runsArr[runID]==undefined)
			{
				Logger.warn("getData() runID: " +runID+" not found", this)
				return null
			}
			return ModelicaData(runsArr[runID])
		}
		
		public function recordCurrentTimeStep(timeInSeconds:Number, sysVarsArr:Array):void
		{
			runsArr[currRunID].recordCurrentTimeStep(timeInSeconds, sysVarsArr)
		}

	}
}