
package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.filesystem.*;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	public class ScenarioDelegate
	{
		public static var SCENARIO_LOADED:String = "scenarioLoaded"
		
		private var responder:IResponder
		private var service:Object
		
		//this array describes how the nodes should be ordered in the array collection -- for navigation
		private var sortOrderArr:Array = ["SYS","MX", "Fan","Flt","HC","CC","Fan","VAV","DIF","PLT","BOI","CHL","CTW","SPK"]
			
		
		public function ScenarioDelegate(responder : IResponder)
		{
			this.service = mx.rpc.remoting.mxml.RemoteObject(ServiceLocator.getInstance().getRemoteObject( "ScenarioService" ))
			this.responder = responder
			service.endpoint = LHModelLocator.getInstance().instructorSiteURL 
		}
		
		
		public function getRemoteScenarioList():void
		{
			
			var call : Object = service.getScenarioList();			
			call.resultHandler = responder.result
			call.faultHandler = responder.fault
		}
		
				
		public function loadScenario( scenID:String, login:String ):void
		{
			var call:Object = service.getScenario( scenID, login );
			call.resultHandler = responder.result
			call.faultHandler = responder.fault
		}
		
		public function loadLocalScenario( fileName:String):Boolean
		{
			Logger.debug("#ScenarioDelegate: loadLocalScenario: path: " + fileName)
			var scenFile:File = File.applicationDirectory.resolvePath("scenarios/" + fileName)
			if (!scenFile.exists) return false
			var stream:FileStream = new FileStream()
			stream.open(scenFile, FileMode.READ)
			var content:String = stream.readUTFBytes(stream.bytesAvailable)
			var scenXML:XML = new XML(content)
			Logger.debug("#ScenarioDelegate: loadLocalScenario: xml: " + scenXML);
			var result:Boolean = populateScenarioModel(scenXML)
			return result
		}
			
		public function populateScenarioModel(scenXML:XML):Boolean{
			
			Logger.debug("#ScenarioDelegate: popuplateScenarioModel");
					
			//get ref to model
			var model : LHModelLocator = LHModelLocator.getInstance()
			
			//Transform XML into ScenarioModel
			var scenModel:ScenarioModel = new ScenarioModel()
			model.scenarioModel = scenModel
			
			//get scenario meta-information
			scenModel.id = scenXML.@id
			scenModel.scenID = scenXML.@scenID
			scenModel.name = scenXML.@name
			scenModel.short_description  = scenXML.@short_description
			scenModel.goal = scenXML.@goal
			scenModel.thumbnail_URL = scenXML.@thumbnail_URL 
			
			
			//get longterm date info
			try
			{
				Logger.debug("#ScenarioDelegate: scenXML.longterm_start_date: " + scenXML.@longterm_start_date)
				Logger.debug("#ScenarioDelegate: scenXML.@longterm_start_date.split(/	)[0]: " + scenXML.@longterm_start_date.split("/")[0])
				
				var startDate:Date = new Date()
				
				var start:String = scenXML.@longterm_start_date
				var startM:Number = Number(start.split("/")[0]) - 1
				var startD:Number = Number(start.split("/")[1])
				startDate.month = startM
				startDate.date = startD
				scenModel.ltSettingsModel.startDate = startDate
				
				var stopDate:Date = new Date()
				var stop:String = scenXML.@longterm_stop_date
				var stopM:Number = Number(stop.split("/")[0]) - 1
				var stopD:Number = Number(stop.split("/")[1])
				stopDate.month = stopM
				stopDate.date = stopD
				scenModel.ltSettingsModel.stopDate = stopDate
						
				scenModel.allow_longterm_date_change = (scenXML.@allow_longterm_date_change == "true")
			}
			catch(err:Error)
			{
				Logger.error("#ScenarioDelegate: couldn't parse longterm date info: " + err.message)
			}
			
			
			//get realtime datetime info
			try
			{
				Logger.debug("#ScenarioDelegate: setting shortTermSim realtime_start_datetime: " + new Date(scenXML.@realtime_start_datetime.toString()))
				scenModel.setRealTimeStartDate(new Date(scenXML.@realtime_start_datetime.toString()))
				//Reset the timer to reflect the new starttime
				scenModel.resetTimer()
			}
			catch(e:Error)
			{
				Logger.error("#ScenarioDelegate: couldn't change following into date for simulation start datetime: " + scenXML.@sim_start_datetime)
			}		
			
			scenModel.allow_realtime_datetime_change = (scenXML.@allow_realtime_datetime_change == "true")
			
			//assets
			if (scenXML.scenarioMovie.@url != "")
			{
				scenModel.movieURL = scenXML.scenarioMovie.@url
				scenModel.movieAvailable = true				
				scenModel.movieToolTip = "View movie for this scenario."
			}
			else
			{
				scenModel.movieAvailable = false
				scenModel.movieToolTip = "No movie available for this scenario."
			}
				
			//read in settings for input and fault panels
			scenModel.inputsVisible = (scenXML.inputPanel.@visible == "true")
			scenModel.inputsEnabled = (scenXML.inputPanel.@enabled == "true")
			scenModel.faultsVisible = (scenXML.faultPanel.@visible == "true")
			scenModel.faultsEnabled = (scenXML.faultPanel.@enabled == "true")
			
			
			//read in settings for output panel
			scenModel.useCustomOutputGraphs = (scenXML.outputPanel.@useCustomOutputGraphs == "true")
			
			//read in setttings for visualization window
			scenModel.enableDragSensor = (scenXML.visualizationPanel.@enableDragSensor == "true")
			scenModel.showValveInfoWindow = (scenXML.visualizationPanel.@showValveInfoWindow == "true")
						
			scenModel.sysNodesArr = new ArrayCollection()
			scenModel.sysVarsImportedFromLongTermAC = new ArrayCollection()
		
			//loop through all systemNodes
			for each (var systemNodeXML:XML in scenXML.sysVars.*){
				
				//create new SystemNode
				var sysNode:SystemNodeModel = new SystemNodeModel();
				sysNode.sysVarsArr = new ArrayCollection();
								
				//get properties
				sysNode.id = systemNodeXML.@id;
				sysNode.sortOrderIndex = getSysNodeSortIndex(sysNode.id)
				sysNode.name = systemNodeXML.@name;
				Logger.debug("#ScenarioDelegate: creating new node: " + sysNode.name)
				
				//add to scenarioModel
				scenModel.sysNodesArr.addItem(sysNode)
				if (sysNode.id!="SPK") scenModel.sysNodesForNavArr.addItem(sysNode)
				
				//parse this system node's sysVars
				for each (var sysVarXML:XML in systemNodeXML.*)
				{
					var sysVar:SystemVariable = new SystemVariable();
					sysNode.sysVarsArr.addItem(sysVar)
					Logger.debug("#ScenarioDelegate:      sysVar :"  + sysVarXML.@name)
					
					for each (var attr:XML in sysVarXML.@*)
					{
						var attrName:String = attr.name()
						//manually cast to boolean if need be
						if (attrName =="is_fault" || attrName == "is_percentage" || attrName == "disabled")
						{
							if (attr.toXMLString() == "false") sysVar[attrName] = false; 
							if (attr.toXMLString() == "true") sysVar[attrName] = true;
						}
						else 
						{
							sysVar[attrName] = attr.toXMLString() 
						}
					}
					
					//sysVar._currValue = sysVar.convert(sysVar.initial_value, LHModelLocator.UNITS_IP);
					sysVar.units = LHModelLocator.currUnits;
					sysVar.setConversionFunctions()
					sysVar.lastValue = sysVar.currValue

					//-999 on a fault means it's not to be made active on start of the scenario.
					//So, if it's not -999, then make fault active
					if (sysVar.is_fault && sysVar.initial_value != -999)
					{
						sysVar.faultIsActive = true
					}
					
					//SETUP ANY MODEL LEVEL STUFF					
					if (sysVar.name=="timeScale")
					{
						scenModel.timeScale  = sysVar.currValue
					}
					
					
					
				}
			}
			
			//TEMP -> sysVar information in XML should have a boolean property for isImportedFromEPlus
			//        until this is done, we assign here to correct vars
			var ltImportsArr:Array = ["RmQSENS","TAirOut", "TwAirOut"]
			for each (var name:String in ltImportsArr)
			{
				sysVar = scenModel.getSysVar(name)
				sysVar.isImportedFromLongTermSim = true
			}
			
			var ltExportsArr:Array =		 ["TRoomSP_Heat",
											"TRoomSP_Cool",
											"TSupS",
											"VAVposMin",
											"PAtm"];
											//	"HCUA",	"CCUA", "VAVHCUA",
			for each (name in ltExportsArr)
			{
				sysVar = scenModel.getSysVar(name)
				sysVar.isExportedToLongTermSim = true
			}				
			//END TEMP	
											
			
			
			scenModel.initLongTermImports()
						
			scenModel.setSort()
			
			Logger.debug("#ScenarioDelegate: finished mapping XML to model")
			return true
		}
		
		private function getSysNodeSortIndex(sysNodeID:String):Number
		{
			var len:uint = sortOrderArr.length
			for (var i:uint =0; i<len;i++)
			{
				if (sortOrderArr[i] == sysNodeID)
					return i
			}
			Logger.warn("ScenarioDelegate: getSysNodeIndex() unrecognized sysNodeID: " + sysNodeID)
			return 0
		}
		
	}	
}