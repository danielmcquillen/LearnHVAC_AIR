package com.mcquilleninteractive.learnhvac.event
{
	import flash.events.Event;

	public class SettingsEvent extends Event
	{
		public static const SETTINGS_LOADED:String = "settingsLoaded"
			
		public function SettingsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}