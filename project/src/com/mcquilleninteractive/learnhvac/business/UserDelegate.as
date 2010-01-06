// ActionScript file
package com.mcquilleninteractive.learnhvac.business {
	
	import mx.rpc.IResponder
	import com.adobe.cairngorm.business.ServiceLocator
	import mx.rpc.remoting.mxml.RemoteObject
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator
	import com.mcquilleninteractive.learnhvac.util.Logger
	
	public class UserDelegate	{
		
		private var responder : IResponder
		private var service : RemoteObject
		
		public function UserDelegate(responder : IResponder){
			
			this.service = mx.rpc.remoting.mxml.RemoteObject(ServiceLocator.getInstance().getRemoteObject( "UserService" ))
			this.responder = responder;
		
		}
		
		public function loginUser(username : String, password : String) : void {	
								
			//call service 
			var call : Object = service.doLogin(username, password);
			call.resultHandler = responder.result;
			call.faultHandler = responder.fault;	
		
		}
		
	
	}
}
