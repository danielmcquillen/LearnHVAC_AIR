// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataEvent;
	import com.mcquilleninteractive.learnhvac.model.EPlusData;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.Event;
	import flash.filesystem.*;
	
	import mx.controls.Alert;
	
	public class SaveScenarioDataCommand implements Command
	{
		public var runID:String  //loaded from event
	
		public function SaveScenarioDataCommand()
		{
				
		}
	
		public function execute( event : CairngormEvent ): void	
		{
			Logger.debug("#SaveScenarioData: execute()")
			runID = ScenarioDataEvent(event).runID		
			switch (event.type)
			{
				case ScenarioDataEvent.SAVE_SPARK_DATA_EVENT:
					saveSparkData()
					break
				case ScenarioDataEvent.SAVE_EPLUS_DATA_EVENT:
					saveEPlusData()
					break
				default:
					Logger.error("#SaveScenarioDataCommand: unrecognized event type: " + event.type)
			}
		
			
		}
		
		protected function saveSparkData():void
		{
			//to implement
		}
		
		protected function saveEPlusData():void
		{
			try
			{			
				var outputFile:File = new File()
				outputFile.browseForSave("Save EnergyPlus data to file")
				outputFile.addEventListener(Event.SELECT,  onSaveEplusAsSelected);		
			}
			catch(error:Error)
			{
				Logger.error("Couldn't have eplus data: error: " + error, this)
				Alert.show("Couldn't save EnergyPlus data.","Save Error")
			}
		}
		
		protected function onSaveEplusAsSelected(event:Event):void
		{
			var saveFileRef:File =  event.target as File
			var eplusData:EPlusData = LHModelLocator.getInstance().scenarioModel.ePlusRunsModel.getEPlusData(runID)
			var outputCSVString:String = eplusData.getEPlusCSV()	
			var stream:FileStream = new FileStream()
			stream.open(saveFileRef, FileMode.WRITE)
			stream.writeUTFBytes(outputCSVString)
			stream.close()
			Alert.show("EnergyPlus output saved.","Data Saved")
		}
				
	}

}