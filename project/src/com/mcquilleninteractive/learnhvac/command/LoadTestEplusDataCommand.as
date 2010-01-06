package com.mcquilleninteractive.learnhvac.command
{
	/* Loads test E+ data into LT simulation : this is mainly for debugging / admin stuff */
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.err.EPlusParseError;
	import com.mcquilleninteractive.learnhvac.event.DebugEvent;
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataLoadedEvent;
	import com.mcquilleninteractive.learnhvac.model.EPlusRunsModel;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.testData.*;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.controls.Alert;
	
	public class LoadTestEplusDataCommand implements Command
	{
		
		
		public function LoadTestEplusDataCommand()
		{
		}

		public function execute( event : CairngormEvent ): void
		{
			Logger.debug("executing...", this)
			
			if (event==null)
			{
				var runID:String = LHModelLocator.getInstance().scenarioModel.ePlusRunsModel.currRunID
			}
			else if (DebugEvent(event).runID!=null)
			{
				runID = DebugEvent(event).runID		
			}
			else
			{
				runID = EPlusRunsModel.RUN_1
			}
			
				
			var outData:TestEplusOutData = new TestEplusOutData();
    		var basicOutputData:String = outData.toString();
    		        		
			var meterData:TestEplusMeterData = new TestEplusMeterData();
    		var basicMeterData:String = meterData.toString();
			
			//update models...models will parse data
			var scenarioModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			try
			{
				scenarioModel.ePlusRunsModel.loadEPlusOutput(basicOutputData, basicMeterData, runID)
			}
			catch (err:EPlusParseError)
			{
				Logger.error("had trouble parsing E+ output. Err: " + err, this)
				mx.controls.Alert.show("There were some errors when parsing EnergyPlus output. Some data may be missing. Error: " + err)
			}
			
			
			//launch event (for the modal dialog)
			var ePlusDataEvent:ScenarioDataLoadedEvent = new ScenarioDataLoadedEvent(ScenarioDataLoadedEvent.EVENT_EPLUS_FILE_LOADED)
			CairngormEventDispatcher.getInstance().dispatchEvent(ePlusDataEvent)			
			
			
		}
		
	}
}