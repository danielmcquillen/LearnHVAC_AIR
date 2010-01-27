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
*/

package com.adobe.onair.logging
{
	
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	
	import flash.filesystem.*;
	
	import mx.core.mx_internal;
	import mx.logging.targets.LineFormattedTarget;
	import org.swizframework.Swiz;
	
	use namespace mx_internal;

	public class FileTarget extends LineFormattedTarget
	{
		
		private var model:ApplicationModel
		private var logFile:File		
		public function FileTarget()
		{
			logFile = File.userDirectory.resolvePath(ApplicationModel.baseStoragePath + "logs/application-log.txt")
			if (logFile.exists)
			{
				logFile.deleteFile()			
			}
			model = Swiz.getBean("applicationModel") as ApplicationModel
		}
		
		public function get logURI():String
		{
			return logFile.nativePath;
		}
		
		mx_internal override function internalLog(message:String):void
	    {
			write(message);
	    }		
		
		private function write(msg:String):void
		{	
			if (!model.logToFile) return
			
			var stream:FileStream = new FileStream()
			stream.open(logFile, FileMode.APPEND)
			stream.writeUTFBytes(msg)
			stream.close()
			
		}	
		
		public function clear():void
		{
				
		}
		
	}
}