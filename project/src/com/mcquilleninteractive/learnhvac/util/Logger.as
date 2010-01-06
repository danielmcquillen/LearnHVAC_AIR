package com.mcquilleninteractive.learnhvac.util
{

	import flash.events.IOErrorEvent;
	import flash.net.XMLSocket;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	
	public class Logger	
	{
		
		public static var reportErrorsToCMS:Boolean = true
		
		public static var enabled : Boolean = true;
		public static var myLogger : ILogger
		private static var socket : XMLSocket;
		public static var logToFile:Boolean

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
				myLogger = Log.getLogger("LearnHVAC") 
				
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
                    	monsterLevel = "DEBUG: " 
                    }
                    break;
				case LogEventLevel.INFO:
					if (Log.isInfo()) {
						myLogger.info(String(target) + " : " +o.toString()); 
						monsterLevel = "INFO: " 
					}
					break;
				case LogEventLevel.WARN:
					if (Log.isWarn()) {
                        myLogger.warn(String(target) + " : " + o.toString());
                        monsterLevel = "WARN: " 
                    }
                    break;
                case LogEventLevel.ERROR:
                    if (Log.isError()) {
                        myLogger.error(String(target) + " : " + o.toString());
                        monsterLevel = "ERROR: " 
                    }
                    break;
                case LogEventLevel.FATAL:
                    if (Log.isFatal()) {
                        myLogger.fatal(String(target) + " : " + o.toString());
                        monsterLevel = "FATAL: " 
                    }
                    break;
				case LogEventLevel.ALL:
					myLogger.log(lvl, String(target) + " : " +  o.toString());
					break;
            }
            
            
           //MonsterDebugger.trace(target, monsterLevel + " : " + o.toString())
           		            
				
		}
	

	}


}
