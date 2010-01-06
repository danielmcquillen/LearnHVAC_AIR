package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.adobe.cairngorm.commands.Command;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SparkRunsModel;
	import com.mcquilleninteractive.learnhvac.util.Logger
	
	public class ShortTermSimulationDelegate 
	{
		private var command:Command
		private var service:Object
		
		/* This class is redundant but becomes important if SPARK is moved to a remote resource */
		
		public function ShortTermSimulationDelegate(command : Command)
		{
			this.command = command;
		}
		
		public function startAHU():void
		{
			var scenarioModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			scenarioModel.startAHU()
		}
		
		public function stopAHU():void
		{
			var scenarioModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			scenarioModel.stopAHU()
		}

		public function updateAHU():void
		{
			var scenarioModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			scenarioModel.updateAHU()
		}
		
		public function cancelStartAHU():void
		{			
			var scenarioModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			scenarioModel.cancelStartAHU()
		}
		
		
		public function copyDataForAnalysis():void
		{
			//save SPARK data as either initial or comparison run, based on users selection (as stored in model)
			Logger.debug("#ShortTermSimulationDelegate: copyDataForAnalysis()")
			var sparkRunsModel:SparkRunsModel = LHModelLocator.getInstance().scenarioModel.sparkRunsModel
			Logger.debug("#ShortTermSimulationDelegate: sparkRunsModel: " + sparkRunsModel)
			sparkRunsModel.loadCurrSparkData()
		}
				
		
	}
}