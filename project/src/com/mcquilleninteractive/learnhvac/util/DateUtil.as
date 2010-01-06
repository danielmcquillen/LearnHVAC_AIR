package com.mcquilleninteractive.learnhvac.util
{
	public class DateUtil
	{
		public function DateUtil()
		{
		}


		public static function formatTime(d:Date):String
		{
			
			var h:String = d.hours.toString()
			var m:String = d.minutes.toString()
			var s:String = d.seconds.toString()
			
			//make a nice string with 0's to keep 00:00:00 format
			if (h.length ==1){
				h = "0"+h
			}
			if (m.length ==1){
				m = "0"+m
			}
			if (s.length ==1){
				s = "0"+s
			}
			
			return h +  ":" + m + ":" + s
			
		}
		
		public static function formatDateTime(d:Date):String
		{
			var time:String = DateUtil.formatTime(d)
			var date:String = (d.month+1).toString() + "/" + d.date 
			
			return date + " " + time
				
		}
		
		
	}
}