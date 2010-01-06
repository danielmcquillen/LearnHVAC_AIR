// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	/* 	This Class loads stored data for different types of simulation: E+ or for SPARK 
	  	and manages translating the different formats each type is saved in
	 */ 
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mcquilleninteractive.learnhvac.business.SparkXML;
	import com.mcquilleninteractive.learnhvac.err.InvalidDataFileError;
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataEvent;
	import com.mcquilleninteractive.learnhvac.model.EPlusRunsModel;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.SparkRunsModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
		
	import mx.controls.Alert;
	
	
	public class LoadScenarioDataCommand implements Command
	{
		
		
		//THIS COMMMAND IS NOT IMPLEMENTED FULLY YET...
		
		public var runID:String  //loaded from event
	
		public function LoadScenarioDataCommand()
		{
				
		}
	
		public function execute( event : CairngormEvent ): void	
		{
			Logger.debug("#LoadScenarioDataCommand: execute()")
			runID = ScenarioDataEvent(event).runID
									
			switch (event.type)
			{
				case ScenarioDataEvent.LOAD_SPARK_DATA_EVENT:
					//loadSparkData()
					break
				case ScenarioDataEvent.LOAD_EPLUS_DATA_EVENT:
					//loadEPlusData()
					break
				default:
					Logger.error("#LoadScenarioDataCommand: unrecognized event type: " + event.type)
			}
							
		}
		
		/*
		public function loadSparkData():void
		{
			Logger.debug("#LoadScenarioDataCommand: loadSparkData()")
			mdm.Dialogs.BrowseFile.dialogText = "Select a Learn HVAC Real-time Data XML File to load as Real-time data.";
			mdm.Dialogs.BrowseFile.defaultDirectory = mdm.FileSystem.getCurrentDir()
			var fileToLoad:String = mdm.Dialogs.BrowseFile.show()
			
			if (fileToLoad=="false" || fileToLoad == "") 
			{
				return
			}			
			
			var serializedSparkData:String = mdm.FileSystem.loadFile(fileToLoad)
			
			if (serializedSparkData=="") 
			{
				mx.controls.Alert.show("File had no contents.","File Error")
				return
			}
			
			try
			{
				var sparkXML:XML = SparkXML.deserializeSparkData(serializedSparkData)					
			}
			catch(e:InvalidDataFileError)
			{
				Logger.error("#LoadScenarioData: loadSparkData() InvalidDataFileError thrown: msg: " + e.message)
				mx.controls.Alert.show("File does not appear to be a valid Learn HVAC Real-time Data XML File .xml file", "File Load Error")
			}
			catch(e:Error)
			{	
				Logger.error("#LoadScenarioData: loadSparkData() Error thrown: msg: " + e.message)
				mx.controls.Alert.show("Could not load selected file. Error: " + e.message, "File Load Error")
			}
			
			// load XML into spark models: this is taken care of by SparkRunsModel
			var sparkRunsModel:SparkRunsModel = LHModelLocator.getInstance().scenarioModel.sparkRunsModel
			Logger.debug("#LoadScenarioDataCommand: loading data into sparkRunsModel")
			
			//File checks were done earlier. Boolean value returned here just indicates
			//	whether file loaded with warnings or not
			var loadWarning:Boolean = sparkRunsModel.loadSparkOutput(sparkXML, runID)
				 
			if (!loadWarning)
			{			
				mx.controls.Alert.show("Real-time simulation data loaded","Data Loaded")
			}
			else
			{
				mx.controls.Alert.show("Real-time simulation data loaded. However, please check your input panel as some values are out of the low/high values set for this scenario.","Data Loaded")
			}
						
		}
		
		
		
		
		
		public function loadEPlusData():void
		{
			mdm.Dialogs.BrowseFile.dialogText = "Select an EPlus Data File to Load";
			mdm.Dialogs.BrowseFile.defaultDirectory = mdm.FileSystem.getCurrentDir()
			var fileToLoad:String = mdm.Dialogs.BrowseFile.show()
			
			Logger.debug("#LoadScenarioData: fileToLoad: " + fileToLoad)
			if (fileToLoad == "" || fileToLoad=="false") 
			{
				return
			}	
				
			//load E+ CSV into EPlus model
			var fileData:String = mdm.FileSystem.loadFile(fileToLoad)
			
			if (fileData=="") 
			{
				mx.controls.Alert.show("File had no contents.","File Error")
				return
			}
			
			var epRunsModel:EPlusRunsModel = LHModelLocator.getInstance().scenarioModel.ePlusRunsModel
			Logger.debug("#LoadScenarioDataCommand: loading data into ePlusRunsModel")
    		var success:Boolean = epRunsModel.loadEPlusOutputFromFile(fileData, runID)
			
			if (success)
			{
				mx.controls.Alert.show("Long-term simulation data loaded","Data Loaded")
			}
			else
			{
				mx.controls.Alert.show("Long-term simulation data could not be loaded. Please make sure this is a valid Learn HVAC Long-term data .csv file","Load Error")
			}
						
		}		
		
	*/
	}
}