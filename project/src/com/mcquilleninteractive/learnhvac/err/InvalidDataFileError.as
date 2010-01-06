
package com.mcquilleninteractive.learnhvac.err
{
	public class InvalidDataFileError extends Error
	{
   		public function InvalidDataFileError(message:String, errorID:int=0)
    	{
       		super(message, errorID);
    	}
	}	
}