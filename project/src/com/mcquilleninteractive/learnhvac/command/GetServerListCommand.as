// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.event.GetServerListEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class GetServerListCommand implements Command, IResponder
	{
	
		private var service : RemoteObject
		private var ignoreError : Boolean = false //this flag is turned off if the user cancels the request
		
		public function GetServerListCommand()
		{		
			CairngormEventDispatcher.getInstance().addEventListener(GetServerListEvent.EVENT_CANCEL_GET_SERVER_LIST, cancelRequest, false, 0,true)
		}
	
		public function execute( event : CairngormEvent ): void	{
			Logger.debug("#GetServerListCommand: getting server list...")
			service = ServiceLocator.getInstance().getRemoteObject( "AdminService" );
			service.requestTimeout = 10
			Logger.debug("#GetServerListCommand: service.requestTimeout : " + service.requestTimeout)
			var call : Object = service.getServerList();
			call.resultHandler = result;
			call.faultHandler = fault;
		}
		
		public function result(data : Object) : void
		{
			var cgEvent: GetServerListEvent
			if (data.result)
			{
				var model : LHModelLocator = LHModelLocator.getInstance()
				model.serverList = new ArrayCollection(data.result) 
				model.instructorSiteURL = data.result[0].URL 
				Logger.debug("#GetServerListCommand: model.serverList: " + model.serverList.toString())
				Logger.debug("#GetServerListCommand: model.instructorSiteURL: " + model.instructorSiteURL)
			
				cgEvent = new GetServerListEvent(GetServerListEvent.EVENT_SERVER_LIST_RETRIEVED)
				CairngormEventDispatcher.getInstance().dispatchEvent( cgEvent )
				
			}
			else
			{
				Logger.error("#GetServerListCommand: no info returned from server")
				var msg:String = "Currently, there are institution servers available for use. Please try again later, use the \"Main Learn HVAC\" server, or log in as \"guest\"" 
				cgEvent = new GetServerListEvent(GetServerListEvent.EVENT_SERVER_LIST_UNAVAILABLE, msg )
				CairngormEventDispatcher.getInstance().dispatchEvent( cgEvent )
			
			}		
		}
		
		public function fault(info : Object) : void
		{
			if (ignoreError) return
			var faultEvent : FaultEvent = FaultEvent( info );
			var msg:String = "Error contacting main server: " + info + ". Please try again or log in as \"guest\""
			Logger.error("#GetServerList:Get server list failed.: " + info)
			var cgEvent : GetServerListEvent = new GetServerListEvent(GetServerListEvent.EVENT_SERVER_LIST_UNAVAILABLE, msg )
			CairngormEventDispatcher.getInstance().dispatchEvent( cgEvent)
			
		}
		
		public function cancelRequest(event:GetServerListEvent) : void
		{
			Logger.debug("#GetServerListCommand#cancelRequest called...")
			CursorManager.removeBusyCursor()
			ignoreError = true
		}
				
	}
}