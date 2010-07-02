package com.mcquilleninteractive.learnhvac.controller
{
	
	import com.mcquilleninteractive.learnhvac.event.LoggedInEvent;
	import com.mcquilleninteractive.learnhvac.event.LoginEvent;
	import com.mcquilleninteractive.learnhvac.model.UserModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.AbstractController;

	public class LoginController extends AbstractController
	{
		
		public static const LOGIN_URL:String = "http://v2.learnhvac.org/api/users/user.xml"
			
		public var _httpReturnStatus:uint = 0
		
		public function LoginController()
		{
			
			_loginURLLoader = new URLLoader();		
			_loginURLLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onLoginStatus);
			_loginURLLoader.addEventListener(Event.COMPLETE, onLoginComplete);
			_loginURLLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoginError);
		}
		
		[Autowire]
		public var userModel:UserModel
		
		protected var _loginURLLoader:URLLoader
		
		[Mediate(event="LoginEvent.LOGIN")]
		public function login(event:LoginEvent):void
		{  	
			
			try
			{
				_loginURLLoader.close()
			}
			catch(error:Error)
			{
				//ignore error
			}
						
			Logger.debug("Login()",this)	
			if (event.loggingInAsGuest)
			{
				userModel.firstName = ""
				userModel.lastName = ""
				userModel.username = "guest"
				userModel.role = UserModel.ROLE_GUEST
				userModel.loggedInAsGuest = true
				Swiz.dispatchEvent(new LoggedInEvent(LoggedInEvent.LOGGED_IN))
			}
			else
			{
				
				//Can't use delegate here because in all it's wisdom Adobe doesn't give HTTPSerivce a way to prevent authentication dialog box
				//but it DOES provide URLLoader this property via authenticate=false....but delegate doesn't work with URLLoader b/c it doesn't produce a token
				
				userModel.username = event.username
				userModel.password = event.password
				
				_httpReturnStatus = 0
				var request:URLRequest = new URLRequest(LOGIN_URL);
				request.method = URLRequestMethod.GET;
				request.authenticate = false
				var encoder : Base64Encoder = new Base64Encoder();
				encoder.encode(event.username + ':' + event.password);
				request.requestHeaders.push(new URLRequestHeader("Authorization", "Basic " + encoder.toString()));
				_loginURLLoader.load(request);
			}			
						
		}
		
		
		
		protected function onLoginStatus(event:HTTPStatusEvent):void
		{
			Logger.debug("onLoginStatus() event.status "+ event.status,this)
			_httpReturnStatus = event.status
		}
		
		protected function onLoginComplete(event:Event):void 
		{
			if (event.target.data && _httpReturnStatus==200)
			{
				try
				{
					var userXML:XML = new XML(event.target.data);
					
					if (userXML.enabled=="false")
					{
						Alert.show("This user is currently disabled on the Learn HVAC system","Login Error")
						return
					}
					
					userModel.firstName = userXML["first-name"]				
					userModel.lastName = userXML["last-name"]	
					userModel.role = userXML.role
					userModel.institution = userXML.institution.name
					userModel.loggedInAsGuest = false
					Swiz.dispatchEvent(new LoggedInEvent(LoggedInEvent.LOGGED_IN))
					
				}
				catch(error:Error)
				{
					Logger.error("couldn't parse user information from XML",this)
					Alert.show("Error logging in.","Login Error")
					userModel.username = ""
					userModel.password = ""
				}
				
				var evt:LoginEvent = new LoginEvent(LoginEvent.LOGIN_COMPLETE, true)
				Swiz.dispatchEvent(evt)
				
			}
			else
			{
				evt = new LoginEvent(LoginEvent.LOGIN_FAILED, true)
				Swiz.dispatchEvent(evt)
				Alert.show("Login failed")
			}
		}
				
		protected function onLoginError(error:IOErrorEvent) : void
		{
			Alert.show( "Login Failed" );
			Logger.debug("onLoginError() error: " + error, this)
							
			userModel.username = ""
			userModel.password = ""
			
			var evt:LoginEvent = new LoginEvent(LoginEvent.LOGIN_FAILED, true)
			Swiz.dispatchEvent(evt)
			
		}
		
		[Mediate(event="LoginEvent.CANCEL")]
		public function onCancelLogin(event:LoginEvent):void
		{  	
			try
			{
				_loginURLLoader.close()
			}
			catch(error:Error)
			{
				//ignore error if we can't close
			}
		}

	}
}