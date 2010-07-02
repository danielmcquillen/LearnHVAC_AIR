package com.mcquilleninteractive.learnhvac.model.data
{
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	
	public interface IGraphDataModel
	{
		function varExists(varID:String):Boolean
		function getVarData(varIDs:Array, includeTime:Boolean):Array
		function getVarName(varID:String):String
		function getUnits(varID:String):String
			
		function get dataStructureXML():XML
		function get dataType():String
		function get startDateTimeString():String
		function get stopDateTimeString():String
		function get inputListAC():ArrayCollection
	}
}