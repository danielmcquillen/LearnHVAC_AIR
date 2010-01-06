/*
	Copyright (c) 2007 Adobe Systems Incorporated
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
	
	Adapted by McQuillen Interactive for ChartTool application
*/

package com.mcquilleninteractive.learnhvac.settings
{
	
	//Class that contains all settings for application
	
	//Make sure runtime knows how to serialize class to file systsem.
	[RemoteClass(alias="com.mcquilleninteractive.learnhvac.settings.LearnHVACSettings")]
	public class LearnHVACSettings 
	{
		//Proxy port
		public var proxyPort:String = "8080";
				
		//API username
		public var username:String = "";
		
		//API password
		public var password:String = "";
		
		//whether to display log info
		public var logInfo:Boolean = true;	
		
		//where we should log to a file
		public var logToFile:Boolean = true;
		
		//where we should log to the application (text area)
		public var logToApplication:Boolean = true;
		
		//where we should log to trace
		public var logToTrace:Boolean = true;	
	}
}