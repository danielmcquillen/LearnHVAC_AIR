package com.mcquilleninteractive.learnhvac.model
{

	import com.mcquilleninteractive.learnhvac.util.DateUtil;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import org.swizframework.Swiz
	import mx.collections.XMLListCollection;
	
		
	public class SparkData implements IGraphDataModel
	{
				
		public var sparkRunsModel		:ShortTermSimulationDataModel
		public var dataArr				:Array
		public var dataStructureXML		:XML
		public var dateTimeID			:String = "Tstep" //this is the var within spark that marks time increments
		public var dataLoaded			:Boolean = false	
		
		private var currYear			:String 	
		private var totalElapsedTimeInSeconds:Number		
		
		private var _scenarioModel:ScenarioModel
		
		public function SparkData(srModel:ShortTermSimulationDataModel)
		{
			
			sparkRunsModel = srModel
			dataArr = []
			dataStructureXML  = createBaseXML()
				
			// use the current year for timecode of output
			currYear = String(new Date().fullYear)	
			
			
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
		
		
		public function getDataType():String
		{
			return ScenarioModel.SPARK_DATA_TYPE
		}
		
		public function getDataStructureXML():XML
		{
			return dataStructureXML
		}
		
		public function varExists(varID:String):Boolean
		{
			return (dataArr[varID]!=undefined)
		}
		
		public function getVarData(varIDs:Array, includeTime:Boolean):Array
		{
			Logger.debug(" getVarData() for varIDs: length " + varIDs.length + " array: " + varIDs, this)				
			//build array for graph
			var returnArr:Array = new Array()
			var varID:String = null
			
			//use the time array for the length of array (all arrays should have same length)
			var valuesLength:Number = dataArr[dateTimeID].historySI.length
			for (var index:Number=0;index<valuesLength;index++)
			{
				var obj:Object = new Object()
				if (includeTime)
				{
					obj.time = dataArr[dateTimeID].historySI[index]	
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
		
		
		public function addData(varID:String, values:Array):void
		{
			dataArr[varID] = values
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
		
		
		public function loadCurrData():void
		{
			Logger.debug("loadCurrData()" , this)
			// load current data from Scenario Model
			// place into array structure, and also build an XML structure for the tree selector
			
			if (_scenarioModel==null) _scenarioModel = Swiz.getBean("scenarioModel") as ScenarioModel
			
			var today:Date = _scenarioModel.realtime_start_datetime
			var epochTimeArr:Array = _scenarioModel.epochTimeArr
			
			//clear out current XML structure
			dataStructureXML = createBaseXML()
			
			var returnArr:Array = []
			
			for each (var sysNode:SystemNodeModel in _scenarioModel.sysNodesAC)
			{
				
				//add component to XML structure
				var component:XML = <Component />
				component.@label = sysNode.name
				component.@id = sysNode.id
				dataStructureXML.Campus.Building.appendChild(component)
				
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{			
					//load data into this model for graphing
										
					dataArr[sysVar.name] = {}
					dataArr[sysVar.name].historySI = sysVar.historySI.concat() //don't want to pass by reference					
					dataArr[sysVar.name].historyIP = sysVar.historyIP.concat()
										
					//add to data structure for graphing
					var dataPoint:XML = <dataPoint/>
					dataPoint.@id = sysVar.name
					dataPoint.@label = sysVar.display_name
					dataPoint.@pointType = "SPARK"
					dataPoint.@units = sysVar.units
					dataPoint.@shortName = sysVar.display_name
					dataPoint.@description = sysVar.description
					component.appendChild(dataPoint)		
				}
			}
						
			//transform TStep into date objects
			var tstepArr:Array = dataArr[dateTimeID].historySI as Array //always take SI as this is unitless
			var len:Number = tstepArr.length
			for (var i:Number=0;i<len;i++)
			{
				tstepArr[i] = new Date(epochTimeArr[i])			
			}
			
			totalElapsedTimeInSeconds = _scenarioModel.elapsedTime
						
		}
		
				
		
		public function getStartDateTime():String
		{
			var startDateTime:Date = dataArr[dateTimeID].historySI[0] as Date
			return DateUtil.formatDateTime(startDateTime)
		
		}
		
		public function getStopDateTime():String
		{
			var len:Number = dataArr[dateTimeID].historySI.length
			var stopDateTime:Date = dataArr[dateTimeID].historySI[len-1] as Date
			return DateUtil.formatDateTime(stopDateTime)
		}
		
	}
}