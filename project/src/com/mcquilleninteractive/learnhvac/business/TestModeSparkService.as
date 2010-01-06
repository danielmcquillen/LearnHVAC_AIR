
package com.mcquilleninteractive.learnhvac.business
{
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.event.SparkEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.testData.TestSparkOutputData;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
		
	import mx.controls.Alert;
	import mx.events.CloseEvent;	
	
	public class TestModeSparkService implements ISparkService
	{		
		
		public function TestModeSparkService(scenModel:ScenarioModel)
		{
			//not implemented			
			
		}
		
		public function startSpark():void{}
		public function updateSpark():void{}
		public function stopSpark():void {}
		public function resetAll(evt:Object):void{}
		public function destroy():void{}
		

	}
}






