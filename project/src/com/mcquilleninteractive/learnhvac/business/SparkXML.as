
package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.mcquilleninteractive.learnhvac.err.*;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger
	import mx.collections.ArrayCollection;
	
	public class SparkXML
	{
		
		public function SparkXML()
		{
			
		}		
		
		public static function serializeSparkData():String
		{
			var scenModel:ScenarioModel	 = LHModelLocator.getInstance().scenarioModel
			var sysNodesArr:ArrayCollection = scenModel.sysNodesArr
			var outXML:XML = <SparkData/>
			var sysNodeXML:XML
			for each (var sysNode:SystemNodeModel in sysNodesArr)
			{
				sysNodeXML = <systemNode />
				sysNodeXML.@name = sysNode.name
				sysNodeXML.@id = sysNode.id
				
				var sysVarXML:XML 				
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{
					sysVarXML = <systemVariable/>
					sysVarXML.@name = sysVar.name
					sysVarXML.varData = sysVar.historySI.join()
					sysNodeXML.appendChild(sysVarXML)
				}				
								
				outXML.appendChild(sysNodeXML)
				
			}	
			return outXML.toXMLString()
		}
		
		public static function deserializeSparkData(serializedData:String):XML
		{
			Logger.debug("#SparkXML: deserializeSparkData string: " + serializedData)
			/* transforms string into XML and does error check before passing back XML for inclusion into model */
			
			var scenModel:ScenarioModel	 = LHModelLocator.getInstance().scenarioModel
			
			//try to make string an XML file
			try
			{
				Logger.debug("#SparkXML: trying to cast to XML... ")
				var sparkDataXML:XML = new XML(serializedData)
				Logger.debug("#SparkXML: xmlString: " + sparkDataXML)
			}
			catch(e:Error)
			{
				//can't convert file to XML and find correct nodes, so must be invalid
				Logger.error("#SimulationDataManager: deserializeSparkData() couln't create XML file. Msg: " + e.message)
				throw new InvalidDataFileError("Invalid Spark data file")
			}
			
			Logger.debug("#SparkXML: sparkDataXML.name : " + sparkDataXML.name())
			if (sparkDataXML.name()!="SparkData")
			{
				Logger.error("#SimulationDataManager: deserializeSparkData() Supplied string doesn't follow SparkData xml file format.")
				throw new InvalidDataFileError("Invalid Spark data file")
			}
			
			return sparkDataXML
		
		}
	}
}