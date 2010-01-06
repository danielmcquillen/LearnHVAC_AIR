// ActionScript file
package com.mcquilleninteractive.learnhvac.event{
	
	import flash.events.Event;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mcquilleninteractive.learnhvac.business.SparkService

	public class SparkEvent extends CairngormEvent{
		
		
		public static var SPARK_CRASHED:String = SparkService.SPARK_CRASHED
		public static var SPARK_INTERVAL_TIMEOUT:String = SparkService.SPARK_INTERVAL_TIMEOUT
		public static var SPARK_STARTUP_TIMEOUT:String = SparkService.SPARK_STARTUP_TIMEOUT
		public static var SPARK_ON: String = SparkService.SPARK_ON
		public static var SPARK_OFF: String = SparkService.SPARK_OFF
		
		public var code:String = ""
		public var msg:String = ""
		
		public function SparkEvent(type:String, code:String="", msg:String="")
		{
	      	super( type )
     	}
     	
     	override public function clone() : Event
     	{
			return new SparkEvent(type)
		}		
		
	}
	
}