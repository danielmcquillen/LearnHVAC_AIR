// ActionScript file
// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.mcquilleninteractive.learnhvac.model.IGraphDataModel;
	import com.mcquilleninteractive.learnhvac.util.Logger
	import flash.events.Event;

	public class ScenarioDataLoadedEvent extends Event
	{
		
		// There are two different event classes that handle AHU events
		// The SimuationEvent class handles events that affect the AHU
		// This class, AHUEvent, handles events coming out of the AHU itself
		// Splitting the classes like this allows us to create components
		// that respond to the true state of the AHU, not just what the user wants it to do
				
		// E+ output file has been loaded but not parsed
		public static const EPLUS_FILE_LOADED : String = "EPlusFileLoaded";
		// E+ output file has been parsed
		public static const EPLUS_DATA_PARSED : String = "EPlusDataParsed";

		// Spark output file has been loaded but not parsed
		public static const SPARK_FILE_LOADED : String = "SparkFileLoaded";
		// Spark file has been parsed
		public static const SPARK_DATA_PARSED : String = "SparkDataParsed";

		public var graphDataModelID:String
		public var graphDataModel:IGraphDataModel


		public function ScenarioDataLoadedEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		override public function clone():Event
        {
            return new ScenarioDataLoadedEvent(this.type, this.bubbles, this.cancelable );
        }
		     	
	}
	
}