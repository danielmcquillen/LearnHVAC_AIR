// ActionScript file
package com.mcquilleninteractive.learnhvac.business {
	
	import mx.rpc.IResponder
	
	import mx.rpc.remoting.mxml.RemoteObject
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel
	import com.mcquilleninteractive.learnhvac.util.Logger
	import mx.rpc.AsyncToken;
	
	public class UserDelegate	
	{		
		[Autowire(bean="userService")]
		public var userService:RemoteObject		
		
		public function UserDelegate(){}
		
		public function loginUser(login:String, password:String):AsyncToken 
		{	
			//call service 
			return userService.doLogin(login, password);
		}
		
	
	}
}
