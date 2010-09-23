package com.mcquilleninteractive.learnhvac.util
{

	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	
	import flash.events.IOErrorEvent;
	import flash.filesystem.*;
	import flash.net.XMLSocket;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	
	import org.swizframework.Swiz;
	
	public class Logger	
	{
				
		public static var enabled : Boolean = true;
		public static var myLogger : ILogger
		private static var socket : XMLSocket;
		public static var logFile:File		
		public static var logFileStream:FileStream

		public static var logToFile:Boolean = false

		public static function debug(o:Object, target:Object=null):void
		{
			_send(LogEventLevel.DEBUG, o, target);
		}

		public static function info(o:Object, target:Object=null):void
		{
			_send(LogEventLevel.INFO, o, target);
		}
		
		public static function warn(o:Object, target:Object=null):void
		{
			_send(LogEventLevel.WARN, o, target);
		}
		
		public static function error(o:Object, target:Object=null):void
		{
			_send(LogEventLevel.ERROR, o, target);
		}

		public static function fatal(o:Object, target:Object=null):void
		{
			_send(LogEventLevel.FATAL, o, target);
		}

		private static function onSocketError(err:IOErrorEvent):void
		{
				//do nothing.
		}
			
		private static function _send(lvl:Number, o:Object, target:Object):void
		{
			//only take last two portions of target if provided
			if (target!=null)
			{
				var path:String = target.toString()
				{
					var pathArr:Array = path.split(".")
					target = pathArr.slice(pathArr.length-2).join(".")
				}
			}
			
			if (myLogger == null)
			{
				myLogger = Log.getLogger("learnhvac") 
				
				//Flex Builder update broke this...gives sandbox error 11/20/08
				//setup remote logging
				/*socket = new XMLSocket()
				socket.addEventListener(IOErrorEvent.IO_ERROR, Logger.onSocketError)
				try
				{
					socket.connect("localhost",4444)
					
				}
				catch(err:Error)
				{
					Logger.error("Couldn't connect to SOS logger")
				}*/
			}
			
			
            var monsterLevel:String = ""
              
			switch(lvl)
            {
            
            	case LogEventLevel.DEBUG:
                	if (Log.isDebug()) {
                    	myLogger.debug(String(target) + " : " + o.toString()) 
                    }
                    break;
				case LogEventLevel.INFO:
					if (Log.isInfo()) {
						myLogger.info(String(target) + " : " +o.toString()); 
                    	o = "INFO: " + String(target) + o
					}
					break;
				case LogEventLevel.WARN:
					if (Log.isWarn()) {
                        myLogger.warn(String(target) + " : " + o.toString());
                    	o = "WARN: " + String(target) + o
                    }
                    break;
                case LogEventLevel.ERROR:
                    if (Log.isError()) {
                        myLogger.error(String(target) + " : " + o.toString());
                    	o = "ERROR: " + String(target) + o
                    }
                    break;
                case LogEventLevel.FATAL:
                    if (Log.isFatal()) {
                        myLogger.fatal(String(target) + " : " + o.toString());
                    	o = "FATAL: " + String(target) + o
                    }
                    break;
				case LogEventLevel.ALL:
					myLogger.log(lvl, String(target) + " : " +  o.toString());
					break;
            }
            
            //log to file 
            try
            {
				if (logFile==null)
				{
					var logFileDir:File = File.userDirectory.resolvePath(ApplicationModel.baseStorageDirPath)
					if (logFileDir.exists==false)
					{
						logFileDir.createDirectory()
					}
					var appModel:ApplicationModel = Swiz.getBean("applicationModel") as ApplicationModel
					logFile = appModel.logFile
					logFileStream = new FileStream()
					logToFile = appModel.logToFile				
	   			}
	   			if (logToFile)
	   			{
	   				logFileStream.open(logFile, FileMode.APPEND)
	   				logFileStream.writeUTFBytes(File.lineEnding + o)
	   				logFileStream.close()
	   			}
            }
	   		catch(err:Error)
	   		{
	   			
	   		}
           		            
				
		}
	

	}


}
