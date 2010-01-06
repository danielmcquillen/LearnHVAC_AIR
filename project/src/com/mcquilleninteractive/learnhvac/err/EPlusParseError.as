package com.mcquilleninteractive.learnhvac.err
{	
	
	public class EPlusParseError extends Error
	{
		public static var NO_DATA_ERROR:Number = 0
		public static var PARSE_ERROR:Number = 1
		
   		public function EPlusParseError(message:String, errorID:int=0)
    	{
       		super(message, errorID);
    	}
	}	
}