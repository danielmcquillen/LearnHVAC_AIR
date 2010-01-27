// ActionScript file
package  com.mcquilleninteractive.learnhvac.vo 
{
	[Bindable]
	[RemoteClass(alias="com.mcquilleninteractive.learnhvac.vo.User")]
	public class UserVO 
	{
		
		public var id : Number;
	
		public var login : String;
		
		public var password : String;
		
		public var first_name : String;
		
		public var last_name : String;
		
		public var email : String;
		
		public var role_id : Number;
		
		public var student_id : String;
		
		public var created_at : Date;
		
		public var modified_at : Date;
		
		//public var password : String;
		
	}
}
