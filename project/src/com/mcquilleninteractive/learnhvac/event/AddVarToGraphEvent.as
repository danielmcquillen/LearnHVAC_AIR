package com.mcquilleninteractive.learnhvac.event
{	
	import flash.events.Event;
	import mx.charts.chartClasses.ChartBase;
		
	public class AddVarToGraphEvent extends Event
	{
		
		public static const ADD_LONG_TERM_VAR:String = "addLongTermVarToGraph"
		public static const ADD_SHORT_TERM_VAR:String = "addShortTermVarToGraph"
		
		public static const GRAPH_TYPE_TIME_SERIES:String = "TS"
		public static const GRAPH_TYPE_XY_PLOT:String = "XY"
		
		public var varIDs:Array
		public var eplusModelID:String //if adding an EPlus var, remember ID for specific model
		public var chart:ChartBase
		public var graphType:String
					
		public function AddVarToGraphEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
		override public function clone():Event
        {
            return new AddVarToGraphEvent(this.type, this.bubbles, this.cancelable );
        }

				
	}
}