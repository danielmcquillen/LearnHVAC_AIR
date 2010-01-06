// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.business.ScenarioDelegate;
	import com.mcquilleninteractive.learnhvac.event.GetScenarioListEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.ScenarioListItemVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
			
	public class GetRemoteScenarioListCommand implements Command, IResponder
	{
	
		public function execute(event : CairngormEvent) : void
		{	
			Logger.debug("#GetRemoteScenarioList: execute()");
			var delegate:ScenarioDelegate = new ScenarioDelegate(this);
			delegate.getRemoteScenarioList()
		}
		
		public function result(data : Object) : void
		{
			
			var model : LHModelLocator = LHModelLocator.getInstance();
		
			Logger.debug("#GetRemoteScenarioList:result(): data.result: " + data.result);
			if (data.result){
				
				
				if (data.result=="")
				{
					mx.controls.Alert.show("No scenarios have been made active on this server. Please use a local scenario or log into a server with active Scenarios.")
				}
								
				model.currScenarioList = new ArrayCollection()
				
				//Until we get remoting to automatically cast these objects to ScenarioListItemVO
				for (var i:uint=0;i<data.result.length;i++)
				{
					var obj:Object = data.result[i]
					var vo:ScenarioListItemVO = new ScenarioListItemVO()
					vo.id = obj.id
					vo.name = obj.name
					vo.scenID = obj.scenID
					vo.description = obj.description
					vo.short_description = obj.short_description
					vo.thumbnail_URL = obj.thumbnail_URL
					vo.sourceType = ScenarioListItemVO.SOURCE_REMOTE
					model.currScenarioList.addItem(vo)									
				}				
								
				model.scenarioListLocation = LHModelLocator.SCENARIOS_LIST_REMOTE
				CairngormEventDispatcher.getInstance().dispatchEvent(new GetScenarioListEvent(GetScenarioListEvent.EVENT_SCENARIO_LIST_LOADED))
			}
			else 
			{
				Logger.debug("#GetRemoteScenarioList: data.result is null");
				mx.controls.Alert.show( "No scenarios are available from the server. This means that either no scenarios are available, or there is an error on the server. A message has been sent to the administrators.  Please use local scenarios for the time being." );
			}
		}
	
		public function fault(info : Object) : void
		{
			var faultEvent : FaultEvent = FaultEvent( info );
			Logger.error("#GetRemoteScenarioList: rpc fault : info: " + info)
			mx.controls.Alert.show( "The scenario list could not be retrieved. A message has been sent to the administrators. Please use local scenarios for the time being and try again later." );
		}
		
		
	}

}