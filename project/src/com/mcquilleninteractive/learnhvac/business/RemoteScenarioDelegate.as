
package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.filesystem.*;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.mxml.RemoteObject;
	import org.swizframework.Swiz
	import com.adobe.protocols.dict.Response;
	import mx.rpc.AsyncToken;
	
	public class RemoteScenarioDelegate
	{
		
		[Autowire]
		public var applicationModel:ApplicationModel
	
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		[Autowire(bean="scenarioService")]
		public var scenarioService:RemoteObject
							
				
		public function RemoteScenarioDelegate()
		{
			
		}
					
		
		public function getRemoteScenarioList():AsyncToken
		{
			return scenarioService.getScenarioList();  
		}
						
		public function getRemoteScenario( scenID:String, login:String ):AsyncToken
		{
			return scenarioService.getScenario( scenID, login );
		}
		
		
		
	}	
}