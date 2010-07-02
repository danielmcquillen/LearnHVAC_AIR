
package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.adobe.protocols.dict.Response;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.model.UserModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.filesystem.*;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	import mx.utils.Base64Encoder;
	
	import org.swizframework.Swiz;
	
	public class RemoteScenarioDelegate
	{
		
		[Autowire]
		public var applicationModel:ApplicationModel
	
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		[Autowire]
		public var userModel:UserModel
		
		[Autowire(bean="scenarioService")]
		public var scenarioService:HTTPService
							
				
		public function RemoteScenarioDelegate()
		{
			
		}
					
		
		public function getRemoteScenarioList():AsyncToken
		{
			setHeader()						
			scenarioService.url = ApplicationModel.baseServiceURL + "scenarios.xml"
			scenarioService.headers
			return scenarioService.send();  
		}
						
		public function getRemoteScenario( scenID:String, login:String ):AsyncToken
		{
			setHeader()	
			scenarioService.url = ApplicationModel.baseServiceURL + "scenarios/" + scenID + ".xml"
			return scenarioService.send();  
		}
		
		protected function setHeader():void
		{
			var auth:String = userModel.username + ":" + userModel.password
			var encoder:Base64Encoder = new Base64Encoder();
			encoder.encode(auth);
			scenarioService.headers["Authorization"] = "Basic " + encoder.toString();
		}
		
		
	}	
}