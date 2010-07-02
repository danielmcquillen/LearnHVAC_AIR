package com.mcquilleninteractive.learnhvac.model
{
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class UserModel extends EventDispatcher
	{		
		
		//Roles
		public static var ROLE_GUEST:String = "guest"
		public static var ROLE_STUDENT:String = "student"
		public static var ROLE_INSTRUCTOR:String = "instructor"
		public static var ROLE_ADMINISTRATOR:String = "admin"
		
		public var username:String
		public var password:String
		public var firstName:String
		public var lastName:String
		public var role:String
		public var institution:String
		public var loggedInAsGuest:Boolean = false
		
		public function UserModel()
		{
		}

	}
}