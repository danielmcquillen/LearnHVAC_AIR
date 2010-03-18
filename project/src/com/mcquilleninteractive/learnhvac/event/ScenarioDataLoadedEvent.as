package com.mcquilleninteractive.learnhvac.event{
	
	import com.mcquilleninteractive.learnhvac.model.data.IGraphDataModel;
	import com.mcquilleninteractive.learnhvac.util.Logger
	import flash.events.Event;

	public class ScenarioDataLoadedEvent extends Event
	{
						
		// loaded but not parsed
		public static const ENERGY_PLUS_FILE_LOADED : String = "EPlusFileLoaded";
		public static const ENERGY_PLUS_DATA_PARSED : String = "EPlusDataParsed";

		//loaded but not parsed
		public static const SHORT_TERM_SYSVARS_LOADED : String = "ShortTermSysVarsLoaded";

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