// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	/* This event is meant for starting the process of loading
	   stored scenario data, either from SPARK or E+. The user
	   will be loading this information so they can review in the analysis section
	   or configure the scenario before running */
	
	import flash.events.Event;

	public class ScenarioDataEvent extends Event
	{
		
		public static const SAVE_SPARK_DATA_EVENT: String = "saveSparkDataEvent"
		public static const SAVE_EPLUS_DATA_EVENT: String = "saveEPlusDataEvent"
		public static const LOAD_SPARK_DATA_EVENT: String = "loadSparkDataEvent"
		public static const LOAD_EPLUS_DATA_EVENT: String = "loadEPlusDataEvent"
		public static const UPDATE_SIM_VARS_WITH_EPLUS_DATA:String = "updateSimVarsWithEPlusData"
				
		public var runID:String //position to load data into (e.g. "initial","current")
		
		public function ScenarioDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		     
		override public function clone():Event
        {
            return new ScenarioDataEvent(this.type, this.bubbles, this.cancelable );
        }
     		
		
	}
	
}