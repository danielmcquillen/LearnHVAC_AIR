package com.mcquilleninteractive.learnhvac.model
{
	/** Class LongTermSimulationDataModel
	 *  
	 *  This class stores and manages the results of the different runs of the long term simulation
	 *
	 */
	
	import com.mcquilleninteractive.learnhvac.event.ScenarioDataLoadedEvent;
	import com.mcquilleninteractive.learnhvac.model.data.EnergyPlusData;
	import com.mcquilleninteractive.learnhvac.model.data.IGraphDataModel;
	import com.mcquilleninteractive.learnhvac.model.data.ZoneEnergyUseDataPoint;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.collections.ArrayCollection;
	
	import org.swizframework.Swiz;
	
	
	
	[Bindable]
	public class LongTermSimulationDataModel
	{				
		public static var RUN_1:String = "eplus_run1"
		public static var RUN_2:String = "eplus_run2";
			
		[Autowire]
		public var longTermSimulationModel:LongTermSimulationModel
		
		public var currRunID:String	= LongTermSimulationDataModel.RUN_1;		//current run as selected by user
		public var run1Loaded:Boolean = false
		public var run2Loaded:Boolean = false
		
		// holds instances of EPlusDataOutput, each of which can hold data from an E+ run
		public var runsArr:Array  
			
		public var dateTimeID:String = "Date/Time"
		public var continueParsing:Boolean = true//flag for when user selects cancel
		private var firstTick:Number //epoch milliseconds for first time data point
		
				
		public function LongTermSimulationDataModel()
		{
			init()
		}
		
		public function onUnitsChange(units:String):void
		{
			for each (var epData:EnergyPlusData in runsArr)
			{
				epData.unitsRefresh()
			}
		}
		
		public function init():void
		{
			//currently we're just storing two runs for EPlus, a base run and a delta run
			//later we will allow multiple runs to be held in memory and accessed by user
			runsArr = []
			runsArr[LongTermSimulationDataModel.RUN_1] = new EnergyPlusData()
			runsArr[LongTermSimulationDataModel.RUN_2] = new EnergyPlusData()						
		}
		
		/** This function loads the two main files generated by E+ 
		    and stores the data in the EnergyPlusData class for this run. 
		
		*/		
		public function loadEPlusOutput(outputCSV:String, meterDataCSV:String, runID:String):Boolean
		{			
			Logger.debug("loadEPlusOutput() loading regular and meter data for runID: " + runID, this)
				
			// error check...simplest way right now to check if this is an E+ output file
			// is to see if the first few characters match what E+ writes out on the first line
			var firstLine:String = outputCSV
			if (firstLine.slice(0,9)!="Date/Time")
			{
				Logger.error("loadEPlusOutput: the output file selected by the user doesn't appear to be a valid Learn HVAC E+ output file.", this)
				return false	
			}			
			
			if (runsArr[runID]==undefined)
			{
				Logger.error("loadEPlusOutput: no model with id: " + runID, this)
				//create new model if ID doesn't exist
				runsArr[runID] = new EnergyPlusData()
			}
		
			var eplusData:EnergyPlusData = EnergyPlusData(runsArr[runID])			
			eplusData.loadData(outputCSV, meterDataCSV)
			
			//store a memento of the inputs
			eplusData.energyPlusInputsMemento = longTermSimulationModel.getEnergyPlusInputsMemento()
				
			//launch event
			var event:ScenarioDataLoadedEvent = new ScenarioDataLoadedEvent(ScenarioDataLoadedEvent.ENERGY_PLUS_DATA_PARSED, true )
			event.graphDataModel = IGraphDataModel(eplusData)
			event.graphDataModelID = runID
			Swiz.dispatchEvent(event)
						
			if (runID==LongTermSimulationDataModel.RUN_1) run1Loaded=true
			if (runID==LongTermSimulationDataModel.RUN_2) run2Loaded=true
			
				
			return true		
		}
		
		
		
		public function getEnergyPlusData(runID:String):EnergyPlusData
		{
			if (runsArr[runID]==undefined)
			{
				return null
			}
			return EnergyPlusData(runsArr[runID])
		}
		
		public function runLoaded(runID:String):Boolean
		{
			if (runsArr[runID]==null) return false
			return EnergyPlusData(runsArr[runID]).dataLoaded
		}
		
		
		
		
		
	}
}