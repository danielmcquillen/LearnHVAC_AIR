package com.mcquilleninteractive.learnhvac.event
{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import flash.events.Event;
	import mx.charts.chartClasses.ChartBase;
	
	
	public class AddVarToGraphEvent extends CairngormEvent
	{
		
		public static var EVENT_ADD_SPARK_VAR:String = "addSparkVar"
		public static var EVENT_ADD_EPLUS_VAR:String = "addEPlusVar"
		public static var GRAPH_TYPE_TIME_SERIES:String = "TS"
		public static var GRAPH_TYPE_XY_PLOT:String = "XY"
		public var varIDs:Array
		public var eplusModelID:String //if adding an EPlus var, remember ID for specific model
		public var chart:ChartBase
		public var graphType:String
		
		
		public function AddVarToGraphEvent(type:String, varIDs:Array, chart:ChartBase, graphType:String, eplusModelID:String="")
		{
			super(type)
			this.varIDs = varIDs
			this.chart = chart
			this.graphType = graphType
			this.eplusModelID = eplusModelID
		}
		
		override public function clone():Event
		{
			return new AddVarToGraphEvent(type, varIDs, chart, graphType, eplusModelID)
		}		

		
		
	}
}