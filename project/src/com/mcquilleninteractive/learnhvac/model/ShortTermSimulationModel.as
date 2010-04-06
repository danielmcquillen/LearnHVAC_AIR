package com.mcquilleninteractive.learnhvac.model
{
	
	/** Class ShortTermSimulationModel
	 * 
	 *  This class holds the data needed to configure
	 *  each run of the short-term simulation (Modelica). 
	 *  It does not hold the actual data that results from each run
	 *  (that happens in ShortTermSimulationDataModel).
	 *  
	 *  TODO: Add a memento so that when users switches between runs, this
	 *        model will remember the settings for that run.
	 */
	 
	import com.mcquilleninteractive.learnhvac.event.ShortTermTimerEvent;
	import com.mcquilleninteractive.learnhvac.util.DateUtil;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.EventDispatcher;
	
	import org.swizframework.Swiz;
	
	[Bindable]	
	public class ShortTermSimulationModel extends EventDispatcher
	{
		public static const MAX_TIME_STEP:Number = 1000
		public static const STATE_OFF:String = "off"
		public static const STATE_RUNNING:String = "running"
		public static const STATE_PAUSED:String = "paused"
		
		//set to realtimeStartDatetime from scenario and then incremented while modelica is running
		public var startDateTime:Date	
		public var currDateTime:Date	
		
		//seconds elapsed since start time		
		public var timeInSec:int		
							
		//holds each increment in array for graphing time axis							
		public var stepArr:Array 				
		//timeStep is changed by user...x second increment
		public var timeStep:Number 			
		//string representation of time (visual components bind to this)
		public var currTimeDisplay:String 	
		//array of epoch seconds representating DATE and time of each step for graphing 	
		public var epochTimeArr:Array			
		//where the simulation will start from when first started or reset
		//(this will be set by model based on Scenario)
		public var realtimeStartDatetime:Date
					
		protected var _currentState:String = STATE_OFF
				
		public function ShortTermSimulationModel()
		{
			init()
		}
		
		public function init():void
		{
			_currentState = STATE_OFF
			timeInSec = 0
			stepArr = []
			epochTimeArr = []
			timeStep = 1
			currTimeDisplay = "00:00:00"
			realtimeStartDatetime = new Date("01/1/2010 12:00:00 PM")
		}
		
		public function get currentState():String
		{
			return _currentState
		}

		public function set currentState(value:String):void
		{
			 _currentState = value
		}
		
		public function setRealTimeStartDate(d:Date):void
		{
			realtimeStartDatetime = d
			currDateTime = new Date(realtimeStartDatetime)
			currTimeDisplay = DateUtil.formatTime(currDateTime)
			resetTimer()
		}
		
		
		//////////////////////////////////////
		// TIMER FUNCTIONS 
		//////////////////////////////////////
		
		public function updateTimer(seconds:Number):void
		{
			
			//TODO: update time in seconds according to some kind of time step setting
			//      For now, one step is one second
			
			timeInSec = seconds
			stepArr.push(timeInSec)
			if (timeInSec!=0)
			{
				currDateTime.seconds = realtimeStartDatetime.seconds + seconds
			}
			
			epochTimeArr.push(Date.parse(currDateTime.toString()))
			currTimeDisplay = DateUtil.formatTime(currDateTime)
						
			var evt:ShortTermTimerEvent = new ShortTermTimerEvent(ShortTermTimerEvent.TIMER_STEP)
			evt.currDateTime = currDateTime
			Swiz.dispatchEvent(evt)
											
		}

	
		public function resetTimer():void
		{
			/* Resets timer to the start datetime defined in the scenario 
			   and stored in the realtime_start_datetime variable */
			Logger.debug("resetTimer()  realtimeStartDatetime: " + realtimeStartDatetime, this)
			timeInSec = 0
			epochTimeArr = []
			if (realtimeStartDatetime != null)
			{
				currDateTime = new Date(realtimeStartDatetime.toString())
			}
			else
			{
				Logger.warn("tried to resetTime() but there's no realtimeStartDatetime", this)
				currDateTime = new Date()			
			}
			updateTimer(0)
		}
			
		
		
	}
}