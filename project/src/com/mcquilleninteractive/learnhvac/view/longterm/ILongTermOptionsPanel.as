package com.mcquilleninteractive.learnhvac.view.longterm
{
	import com.mcquilleninteractive.learnhvac.vo.LongTermSimulationVO
	
	public interface ILongTermOptionsPanel
	{
		function initializeValues():void 
		function setViewRefs(elevationView:ElevationView, zoneSelector:ZoneSelector):void 
		function resetValues():void
		function unitsUpdate():void
		function isValid():Boolean
		function get errorMsg():String
		function onScenarioLoaded():void
	}
}