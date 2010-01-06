
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.business.UserDelegate;
	import com.mcquilleninteractive.learnhvac.event.LoggedInEvent;
	import com.mcquilleninteractive.learnhvac.event.LoginEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.UserVO;
	import mx.controls.Alert;

	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;

	public class LoginCommand implements Command, IResponder
	{
		private var model : LHModelLocator = LHModelLocator.getInstance();
		
		public function execute(event : CairngormEvent) : void
		{
			var delegate : UserDelegate = new UserDelegate( this );    
			var loginEvent : LoginEvent = LoginEvent( event );
									
			if (loginEvent.loggingInAsGuest)
			{
				//create guest user ... no need to validate against server
				var user:UserVO = new UserVO
				user.first_name = ""
				user.last_name = ""
				user.login = "guest"
				user.role_id = LHModelLocator.ROLE_GUEST
				model.loggedInAsGuest = true
				model.user = user
				var cgEvent:CairngormEvent = new LoggedInEvent(LoggedInEvent.EVENT_LOGGED_IN)
				CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent)
			}
			else
			{
				delegate.loginUser(loginEvent.username, loginEvent.password);
			}
		}
		
		public function result(data : Object) : void
		{
			if (data.result)
			{
				var user:UserVO = new UserVO
				user.first_name = data.result[0]
				user.last_name = data.result[1]
				user.login = data.result[2]
				model.user = user
				model.loggedInAsGuest = false
				var cgEvent:CairngormEvent = new LoggedInEvent(LoggedInEvent.EVENT_LOGGED_IN)
				CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent)
				
			}
			else
			{
				Logger.debug("Login failed. info: " + data.result)
				mx.controls.Alert.show( "Login Failed!" );
			}		
		}
		
		public function fault(info : Object) : void
		{
			var faultEvent : FaultEvent = FaultEvent( info );
			mx.controls.Alert.show( "Login Failed!" );
			Logger.debug("Login failed. info: " + info)
		}
		
	}
}