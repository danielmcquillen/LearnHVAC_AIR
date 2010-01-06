// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.business.ScenarioDelegate;
	import com.mcquilleninteractive.learnhvac.event.LoadScenarioEvent;
	import com.mcquilleninteractive.learnhvac.event.ScenarioLoadedEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	
	public class LoadScenarioCommand implements Command, IResponder
	{
	
		private var model : LHModelLocator = LHModelLocator.getInstance();
	
		public function execute( event : CairngormEvent ): void
		{
			Logger.debug("#LoadScenarioCommand: executing...")
			
			var cgEvent:LoadScenarioEvent= new LoadScenarioEvent(LoadScenarioEvent.EVENT_LOAD_STARTING)
			CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent)
			
			var loadScenarioEvent:LoadScenarioEvent = LoadScenarioEvent(event)
			var delegate:ScenarioDelegate = new ScenarioDelegate(this);
				
			var result:Boolean
			if (loadScenarioEvent.type == LoadScenarioEvent.EVENT_LOAD_SCENARIO_XML)
			{
				//parse XML via delegate
				result = delegate.populateScenarioModel(LoadScenarioEvent(event).xml)
				loadSuccess(result)
			}		
			else if (loadScenarioEvent.type == LoadScenarioEvent.EVENT_LOAD_LOCAL_SCENARIO)
			{
				try
				{
					result = delegate.loadLocalScenario(loadScenarioEvent.fileName)
				}
				catch(e:Error)
				{
					Logger.debug("#LoadScenarioCommand: Error loading local scenario: " + e.message);
					mx.controls.Alert.show( "This local scenario could not be loaded. Please use another scenario. Error: " + e.message );
					return
				}
				loadSuccess(result)
			}
			else if (loadScenarioEvent.type == LoadScenarioEvent.EVENT_LOAD_REMOTE_SCENARIO)
			{
				//we send login to remote service as way of tracking downloads
				delegate.loadScenario(loadScenarioEvent.scenID, model.user.login  )	
			}
			else
			{
				Logger.error("#LoadScenarioCommand: unrecognized event type : " + loadScenarioEvent.type)
			}
			
		
		
		}
		
		public function result(data : Object) : void
		{
			if (data.result)
			{
				//build scenario model
				Logger.debug("#LoadScenarioCommand: data received ok");
				var delegate:ScenarioDelegate = new ScenarioDelegate(this);
				
				//convert result to XML
				XML.ignoreWhitespace = true;
				var scenXML:XML
				try
				{
					scenXML = new XML(data.result);
					Logger.debug("#ScenarioDelegate: xml parsed");
					
				}
				catch (error:Error)
				{
					Logger.error("#ScenarioDelegate: populateScenarioModel() couldn't parse xmlstring to XML");
					Logger.error("#ScenarioDelegate: error message: " + error.message);
					return
				}		
				
				//parse XML via delegate
				var result:Boolean = delegate.populateScenarioModel(scenXML)
				loadSuccess(result)
				
			}
			else 
			{
				Logger.debug("#LoadScenarioCommand: data.result is null");
				mx.controls.Alert.show( "This scenario could not be loaded. Please use another scenario for the time being." );
			}
		}
		
		public function fault(info : Object) : void
		{
			var faultEvent : FaultEvent = FaultEvent( info );
			Logger.error("#LoadScenarioCommand: rpc fault : info: " + info)
			mx.controls.Alert.show( "This scenario could not be loaded. A message has been sent to the administrators.  Please use another scenario for the time being." );
		}
	
		public function loadSuccess(success:Boolean):void
		{
			Logger.debug("#LoadScenarioCommand: loadSuccess()")
			//update view if parse is ok
			if (success)
			{
				//change to simulation view if this step succeeds
				model.viewing = LHModelLocator.PANEL_SHORT_TERM_SIMULATION 				
				model.simBtnEnabled = true
				model.bldgSetupEnabled = true
				model.scenarioLoaded = true
				
				var cgEvent : ScenarioLoadedEvent = new ScenarioLoadedEvent(ScenarioLoadedEvent.SCENARIO_LOADED);
				Logger.debug("##################################################################");
				Logger.debug("#LoadScenarioCommand: Scenario loaded. Dispatching loaded event.");
				Logger.debug("##################################################################");
				CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent)
			}
			else
			{
				mx.controls.Alert.show("This scenario is not properly formed and could not be loaded. A message has been sent to the administrator. In the meantime, please try a different scenario.");
			}		
		}
		
		
		
		
		
	}
}