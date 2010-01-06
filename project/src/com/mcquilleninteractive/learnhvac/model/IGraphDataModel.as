package com.mcquilleninteractive.learnhvac.model
{
	import mx.collections.XMLListCollection;
	
	public interface IGraphDataModel
	{
		function getDataStructureXML():XML
		function varExists(varID:String):Boolean
		function getVarData(varIDs:Array, includeTime:Boolean):Array
		function getVarName(varID:String):String
		function getUnits(varID:String):String
		function getDataType():String
		function getStartDateTime():String
		function getStopDateTime():String
	}
}