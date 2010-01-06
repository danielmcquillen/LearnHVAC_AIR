package com.mcquilleninteractive.learnhvac.view.controllers
{
	import com.mcquilleninteractive.learnhvac.control.ViewController;
	import com.mcquilleninteractive.learnhvac.control.LHController;
	import com.mcquilleninteractive.learnhvac.event.ScenarioLoadedEvent;
	import com.mcquilleninteractive.learnhvac.util.Logger
	import flash.events.Event;


	//NOTE: Not using this class yet. Started to use it when I wasn't sure of how
	// Cairngorm event dispatcher was working. Somebody on mailing list suggested
	// using a view controller like this to manage events coming from CG to view.
	// But I don't think I need this.

	[Event(name="scenarioLoaded",type="flash.events.Event")]
   
	public class SimulationViewController extends ViewController
	{
    	public function SimulationViewController() 
    	{
			Logger.debug("#SimulationViewController: adding listener")
      	    addListener(ScenarioLoadedEvent.SCENARIO_LOADED, scenarioLoaded);
      	}
      
      private function scenarioLoaded(event:ScenarioLoadedEvent):void {
         Logger.debug("#SimulationViewController: scenarioLoaded() called. Now launching flash event");
         var e:Event = new Event("scenarioLoaded");
         dispatchEvent(e);
      }
   }
}