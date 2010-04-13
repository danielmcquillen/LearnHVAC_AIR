package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;

	public class ModelicaInputsTrace extends Event
	{
		public static const INPUTS_TRACE:String = "inputsTrace"
		
		public var inputsTrace:String
		
		public function ModelicaInputsTrace(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}