// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
		
	import flash.events.Event;

	// A scenario can be either loaded from the remote service
	// or from a supplied XML doc (which was either loaded locally or 

	public class LoadScenarioEvent extends Event
	{
		
		//load a scenario from a local file
		public static const LOAD_LOCAL_SCENARIO : String = "loadLocalScenario";
		//load a scenario from the AMF servier
		public static const LOAD_REMOTE_SCENARIO : String = "loadRemoteScenario";
		// load a scenario directly from the xml stored in this event
		public static const LOAD_SCENARIO_XML : String = "loadScenarioXML" 
		//load a deafult scenario that's embedded in the application
		public static const LOAD_DEFAULT_SCENARIO : String ="loadDefaultScenario"
		
		// flag for components that need to do things like clear out old info
		public static const LOAD_STARTING : String = "loadStarting" 
		
		public var scenID:String = "";
		public var fileName:String = "";
		public var scenarioXML:XML
		
		public function LoadScenarioEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{			
			super(type, bubbles, cancelable);
		}	
		
		override public function clone():Event
        {
            return new LoadScenarioEvent(this.type, this.bubbles, this.cancelable );
        }
     	
	}
}