// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;

	// A scenario can be either loaded from the remote service
	// or from a supplied XML doc (which was either loaded locally or 

	public class LoadScenarioEvent extends CairngormEvent{
		
		//load a scenario from a local file
		public static var EVENT_LOAD_LOCAL_SCENARIO : String = "loadLocalScenario";
		//load a scenario from the AMF servier
		public static var EVENT_LOAD_REMOTE_SCENARIO : String = "loadRemoteScenario";
		// load a scenario directly from the xml stored in this event
		public static var EVENT_LOAD_SCENARIO_XML : String = "loadScenarioXML" 
		//load a deafult scenario that's embedded in the application
		public static var EVENT_LOAD_DEFAULT_SCENARIO : String ="loadDefaultScenario"
		
		// flag for components that need to do things like clear out old info
		public static var EVENT_LOAD_STARTING : String = "loadStarting" 
		
		public var scenID:String = "";
		public var fileName:String = "";
		public var xml:XML

		public function LoadScenarioEvent(type:String):void
		{
	      	super( type )
		}	
     	
     	override public function clone() : Event
		{
			return new LoadScenarioEvent(this.type);
		}	
	}
}