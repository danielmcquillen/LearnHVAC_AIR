// ActionScript file
// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mcquilleninteractive.learnhvac.model.IGraphDataModel;
	import com.mcquilleninteractive.learnhvac.util.Logger
	import flash.events.Event;

	public class ScenarioDataLoadedEvent extends CairngormEvent{
		
		// There are two different event classes that handle AHU events
		// The SimuationEvent class handles events that affect the AHU
		// This class, AHUEvent, handles events coming out of the AHU itself
		// Splitting the classes like this allows us to create components
		// that respond to the true state of the AHU, not just what the user wants it to do
				
		// E+ output file has been loaded but not parsed
		public static var EVENT_EPLUS_FILE_LOADED : String = "EPlusFileLoaded";
		// E+ output file has been parsed
		public static var EVENT_EPLUS_DATA_PARSED : String = "EPlusDataParsed";

		// Spark output file has been loaded but not parsed
		public static var SPARK_FILE_LOADED : String = "SparkFileLoaded";
		// Spark file has been parsed
		public static var SPARK_DATA_PARSED : String = "SparkDataParsed";

		public var graphDataModelID:String
		public var graphDataModel:IGraphDataModel

		public function ScenarioDataLoadedEvent(type:String, graphDataModelID:String="", graphDataModel:IGraphDataModel=null){
	      	super( type )
	      	Logger.debug("#SimDataLoadEvent: type: " + type)
	      	Logger.debug("#SimDataLoadEvent: graphDataModelID: " + graphDataModelID)
	      	Logger.debug("#SimDataLoadEvent: graphDataModel: " + graphDataModel)
	      	this.graphDataModelID = graphDataModelID
	      	this.graphDataModel = graphDataModel
     	}
     	
     	override public function clone():Event{
			return new ScenarioDataLoadedEvent(type, graphDataModelID, graphDataModel)
		}		
		
	}
	
}