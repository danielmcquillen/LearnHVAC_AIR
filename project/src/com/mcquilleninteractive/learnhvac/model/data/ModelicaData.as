package com.mcquilleninteractive.learnhvac.model.data
{

	/** Class Modelica Data
	 * 
	 * This class massages the output data so that it can be
	 * displayed in the Analysis section UI controls --
	 * it builds an XML representation of the data for a tree control and
	 * it will massage and return data so that the data set can be graphed.
	 */ 

	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.DateUtil;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
		
	public class ModelicaData extends BaseSimData implements IGraphDataModel
	{
		
		public static const MODELICA_DATA_TYPE:String = "ModelicaDataType"
		public static const DATE_TIME:String = "dateTime"
				
		public var dataArr:Array
		public var dataStructureXML	:XML
		private var _startDateTime:Date
		private var _startDateTimeMilli:Number
		//this is the SysVar that marks time increments
			
		private var currYear:String 	
		private var totalElapsedTimeInSeconds:Number		
		
		public function ModelicaData()
		{
			clearData()	
		}
		
		public function set startDateTime(date:Date):void
		{
			_startDateTime = date
			_startDateTimeMilli  = date.time		
		}
		
		public function clearData():void
		{
			dataArr = []
			dataArr[DATE_TIME] = []
			dataStructureXML  = createBaseXML()
			// use the current year for timecode of output
			currYear = String(new Date().fullYear)	
		}
		
		public function getDataType():String
		{
			return MODELICA_DATA_TYPE
		}
		
		public function getDataStructureXML():XML
		{
			return dataStructureXML
		}
		
		private function createBaseXML():XML
		{
			var baseXML:XML = <VizTool dataSourceType="" dataSourcePath="" >
									<Campus>
										<Building/>
									</Campus>
								</VizTool>
		
			return baseXML
		}
				
		public function varExists(varID:String):Boolean
		{
			return (dataArr[varID]!=undefined)
		}
		
		/* Record the state of each system variable at the current time interval */				
		public function recordCurrentTimeStep(timeInSeconds:Number, sysVarsArr:Array):void
		{
			var d:Date = new Date(_startDateTimeMilli + (timeInSeconds * 1000))
			Logger.debug("recordCurrentTimeStep() _startDateTime: " + _startDateTime,this)
			Logger.debug("recordCurrentTimeStep() timeInSeconds: " + timeInSeconds,this)
			Logger.debug("recordCurrentTimeStep() d: " + d,this)
			dataArr[DATE_TIME].push(d)
			for each (var sysVar:SystemVariable in sysVarsArr)
			{
				if (!dataArr[sysVar.name])
				{
					dataArr[sysVar.name] = new Object()
					dataArr[sysVar.name].historySI = []
					dataArr[sysVar.name].historyIP = []
				} 
				dataArr[sysVar.name].historySI.push(sysVar.currValue)
				dataArr[sysVar.name].historyIP.push(sysVar.currValue)	
			}
			totalElapsedTimeInSeconds = timeInSeconds
		}
				
		public function getVarName(varID:String):String
		{	
			//TODO: figure out where variable name will come from
			return varID	
		}
		
		public function getUnits(varID:String):String
		{
			//TODO: figure out where units info will come from
			return "--"
		}
		
		
		public function buildMenuStructure(scenarioModel:ScenarioModel):void
		{
			Logger.debug("loadCurrData()" , this)
			
			//clear out current XML structure
			dataStructureXML = createBaseXML()					
			for each (var sysNode:SystemNodeModel in scenarioModel.sysNodesAC)
			{				
				//add component to XML structure
				var component:XML = <Component />
				component.@label = sysNode.name
				component.@id = sysNode.id
				dataStructureXML.Campus.Building.appendChild(component)
				
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{													
					//add to data structure for graphing
					var dataPointXML:XML = <dataPoint/>
					dataPointXML.@id = sysVar.name
					dataPointXML.@label = sysVar.displayName
					dataPointXML.@pointType = MODELICA_DATA_TYPE
					dataPointXML.@units = sysVar.units
					dataPointXML.@shortName = sysVar.displayName
					dataPointXML.@description = sysVar.description
					component.appendChild(dataPointXML)		
				}
			}
			
			//Initialize dateTime
			
												
		}
		
		public function getVarData(varIDs:Array, includeTime:Boolean):Array
		{
			Logger.debug(" getVarData() for varIDs: length " + varIDs.length + " array: " + varIDs, this)				
			//build array for graph
			var returnArr:Array = new Array()
			var varID:String = null
			
			//use the time array for the length of array (all arrays should have same length)
			var valuesLength:Number = dataArr[DATE_TIME].length
		
			for (var index:Number=0;index<valuesLength;index++)
			{
				var obj:Object = new Object()
				if (includeTime)
				{
					obj.time = dataArr[DATE_TIME][index]	
				}
				//add all variables sent in argument array to dataprovider
				var historyArr:Array 				
				for (var j:Number = 0; j<varIDs.length; j++)
				{
					varID = varIDs[j]		
					if (ApplicationModel.currUnits=="SI")
					{
						historyArr = dataArr[varID].historySI
					}
					else
					{
						historyArr = dataArr[varID].historyIP
					}
					
					obj["value"+(j+1)] = historyArr[index]
				}
						
				returnArr.push(obj)		
			}
			return returnArr
		}
		
		public function getStartDateTime():String
		{
			return DateUtil.formatDateTime(_startDateTime) 		
		}
		
		public function getStopDateTime():String
		{
			var len:Number = dataArr[DATE_TIME].length
			if (len==0)
			{
				return DateUtil.formatDateTime(_startDateTime)
			}
			var stopDateTime:Date = dataArr[DATE_TIME][len-1] as Date
			return DateUtil.formatDateTime(stopDateTime)
		}
		
	}
}