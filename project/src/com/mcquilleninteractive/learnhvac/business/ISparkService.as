package com.mcquilleninteractive.learnhvac.business
{
	public interface ISparkService
	{
		function startSpark():void
		function updateSpark():void
		function stopSpark():void 
		function resetAll(evt:Object):void
		function destroy():void
	}
}