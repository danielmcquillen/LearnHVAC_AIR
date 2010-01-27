package com.mcquilleninteractive.learnhvac.controller
{
	
	import com.mcquilleninteractive.learnhvac.util.Logger
	import com.mcquilleninteractive.learnhvac.event.LoginEvent;
	import com.mcquilleninteractive.learnhvac.event.LoggedInEvent;
	import com.mcquilleninteractive.learnhvac.business.UserDelegate;
	import com.mcquilleninteractive.learnhvac.model.UserModel;
	import org.swizframework.Swiz
	import org.swizframework.controller.AbstractController
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.AsyncToken;
	import mx.controls.Alert
	
	public class LoginController extends AbstractController
	{
		public function LoginController()
		{
		}
		
		[Autowire]
		public var userDelegate:UserDelegate
		
		[Autowire]
		public var userModel:UserModel
		
		[Mediate(event="LoginEvent.LOGIN")]
		public function login(event:LoginEvent):void
		{  	
			Logger.debug("Login()",this)	
			if (event.loggingInAsGuest)
			{
				userModel.first_name = ""
				userModel.last_name = ""
				userModel.username = "guest"
				userModel.role = UserModel.ROLE_GUEST
				userModel.loggedInAsGuest = true
				Swiz.dispatchEvent(new LoggedInEvent(LoggedInEvent.LOGGED_IN))
			}
			else
			{
				userModel.username = event.username
				var call:AsyncToken = userDelegate.loginUser(event.username, event.password)
				executeServiceCall(call, onLoginResult, onLoginFault)
			}			
			
		}
		
		public function onLoginResult(re:ResultEvent) : void
		{
			Logger.debug("onLoginResult() " ,this)
			if (re.result)
			{
				userModel.first_name = re.result[0]
				userModel.last_name = re.result[1]				
				userModel.loggedInAsGuest = false
				Swiz.dispatchEvent( new LoggedInEvent(LoggedInEvent.LOGGED_IN))				
			}
			else
			{
				Logger.debug("Login failed. info: " + re.result, this)
				Alert.show( "Login Failed!" );
			}		
			
		}
		
		public function onLoginFault(fault:FaultEvent) : void
		{
			Alert.show( "Login Failed!" );
			Logger.debug("Login failed.", this)
		}
		

	}
}