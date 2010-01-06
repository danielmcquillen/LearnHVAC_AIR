// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	/* This event is meant for starting the process of loading
	   stored scenario data, either from SPARK or E+. The user
	   will be loading this information so they can review in the analysis section
	   or configure the scenario before running */
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	public class ScenarioDataEvent extends CairngormEvent{
		
		public static var SAVE_SPARK_DATA_EVENT: String = "saveSparkDataEvent"
		public static var SAVE_EPLUS_DATA_EVENT: String = "saveEPlusDataEvent"
		public static var LOAD_SPARK_DATA_EVENT: String = "loadSparkDataEvent"
		public static var LOAD_EPLUS_DATA_EVENT: String = "loadEPlusDataEvent"
		public static var UPDATE_SIM_VARS_WITH_EPLUS_DATA:String = "updateSimVarsWithEPlusData"
				
		public var runID:String //position to load data into (e.g. "initial","current")
		
		public function ScenarioDataEvent(type:String, runID:String="")
		{
	      	super( type )
	      	this.runID = runID
     	}
     	
     	override public function clone() : Event
     	{
			return new ScenarioDataEvent(type, runID)
		}		
		
	}
	
}