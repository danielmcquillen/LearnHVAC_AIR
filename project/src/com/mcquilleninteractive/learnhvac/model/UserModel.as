package com.mcquilleninteractive.learnhvac.model
{
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class UserModel extends EventDispatcher
	{		
		
		//Roles
		public static var ROLE_GUEST:Number = 0
		public static var ROLE_STUDENT:Number = 1
		public static var ROLE_TEACHER:Number = 2
		public static var ROLE_ADMINISTRATOR:Number = 3
		
		public var username:String
		public var password:String
		public var first_name:String
		public var last_name:String
		public var role:Number
		public var loggedInAsGuest:Boolean = false
		
		public function UserModel()
		{
		}

	}
}