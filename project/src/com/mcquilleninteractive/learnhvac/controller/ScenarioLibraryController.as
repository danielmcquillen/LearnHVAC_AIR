package com.mcquilleninteractive.learnhvac.controller
{
	
	
	import com.mcquilleninteractive.learnhvac.business.LocalScenarioDelegate;
	import com.mcquilleninteractive.learnhvac.business.RemoteScenarioDelegate;
	import com.mcquilleninteractive.learnhvac.event.GetScenarioListEvent;
	import com.mcquilleninteractive.learnhvac.event.LoadScenarioEvent;
	import com.mcquilleninteractive.learnhvac.event.ScenarioLoadedEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.DefaultScenariosModel;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioLibraryModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.model.UserModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.ScenarioListItemVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.AbstractController;
	
	public class ScenarioLibraryController  extends AbstractController
	{
		[Autowire]
		public var applicationModel:ApplicationModel
		
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		[Autowire]
		public var userModel:UserModel
		
		[Autowire]
		public var scenarioLibraryModel:ScenarioLibraryModel
		
		[Autowire]
		public var longTermSimulationModel:LongTermSimulationModel
		
		[Autowire]
		public var localScenarioDelegate:LocalScenarioDelegate
		
		[Autowire]
		public var remoteScenarioDelegate:RemoteScenarioDelegate
		
		[Autowire]
		public var defaultScenariosModel:DefaultScenariosModel
		
		//this array describes how the nodes should be ordered in the array collection -- for navigation
		private var sortOrderArr:Array = ["SYS","MX", "Fan","Flt","HC","CC","Fan","VAV","DIF","PLT","BOI","CHL","CTW","SPK"]
		
				
		public function ScenarioLibraryController()	{}
		
		
		/* ******************** */
		/*    LOCAL SCENARIOS   */		
		/* ******************** */			
				
		/*   LOCAL SCENARIO LIST  */		
		[Mediate(event="GetScenarioListEvent.GET_LOCAL_SCENARIO_LIST")]
		public function getLocalScenarioList():void
		{			
			var localScenariosAC:ArrayCollection
			try
			{
				 localScenariosAC = localScenarioDelegate.loadScenarioList()
			}
			catch(err:Error)
			{
				Logger.error("error trying to load scenarios: " + err.message, this)
				Alert.show("Couldn't load a list of scenarios from the scenarios folder. Please make sure all scenarios are valid. Error: " + err.message, "Error");
				return
			}
						
			if (localScenariosAC.length == 0)
			{
				Alert.show( "There are no valid scenarios in the scenarios folder." );
				scenarioLibraryModel.currScenarioList = new ArrayCollection()
			}
			else
			{
				scenarioLibraryModel.scenarioListLocation = ScenarioLibraryModel.SCENARIOS_LIST_LOCAL			
				scenarioLibraryModel.currScenarioList = localScenarioDelegate.localScenarioListAC		
				Swiz.dispatchEvent(new GetScenarioListEvent(GetScenarioListEvent.SCENARIO_LIST_LOADED))
			}
		}
		
		
		/* LOCAL SCENARIO */		
		
		[Mediate(event="LoadScenarioEvent.LOAD_LOCAL_SCENARIO")]
		public function loadLocalScenario( event:LoadScenarioEvent):void
		{
			Swiz.dispatchEvent(new LoadScenarioEvent(LoadScenarioEvent.LOAD_STARTING, true))
			
			var fileName:String = event.fileName
			try
			{
				var scenXML:XML = localScenarioDelegate.loadLocalScenario(fileName)		
			}
			catch(error:Error)
			{
				Logger.error("Error loading local scenario: " + error, this)
				Alert.show( "Error encountered when loading local scenario. Error: " + error.message, "Error");
				return
			}			
			var result:Boolean = populateScenarioModel(scenXML)
			if (result)
			{
				startScenario()				
			}
			else
			{
				var msg:String = "Error parsing local scenario XML. This scenario file may be corrupt" 
				Logger.error(msg, this)
				Alert.show( msg, "Local Scenario Error");		
				var evt : ScenarioLoadedEvent = new ScenarioLoadedEvent(ScenarioLoadedEvent.SCENARIO_LOAD_FAILED, true)
				Swiz.dispatchEvent(evt)
			}
		}
		
		
		
		
		
		/* ******************** */
		/*   REMOTE SCENARIOS   */
		/* ******************** */		
		
		[Mediate(event="GetScenarioListEvent.GET_REMOTE_SCENARIO_LIST")]
		public function getRemoteScenarioList(event : GetScenarioListEvent) : void
		{	
			Logger.debug("getRemoteScenarioList()", this);
			var call:AsyncToken = remoteScenarioDelegate.getRemoteScenarioList();
			executeServiceCall(call, onRemoteScenarioListResult, onRemoteScenarioListFault);
		}
				
		
		public function onRemoteScenarioListResult(re:ResultEvent) : void
		{		
			Logger.debug("onRemoteScenarioListResult() result: " + re.result );
			if (re.result)
			{								
				if (re.result=="")
				{
					Alert.show("There are no scenarios available.", "No Scenarios")
				}								
				scenarioLibraryModel.currScenarioList.removeAll()
				
				//Until we get remoting to automatically cast these objects to ScenarioListItemVO
				for (var i:uint=0;i<re.result.length;i++)
				{
					var obj:Object = re.result[i]
					var vo:ScenarioListItemVO = new ScenarioListItemVO()
					vo.id = obj.id
					vo.name = obj.name
					vo.scenID = obj.scenID
					vo.description = obj.description
					vo.short_description = obj.short_description
					vo.thumbnail_URL = obj.thumbnail_URL
					vo.sourceType = ScenarioListItemVO.SOURCE_REMOTE
					scenarioLibraryModel.currScenarioList.addItem(vo)									
				}				
				
				scenarioLibraryModel.currScenarioList.refresh()
				scenarioLibraryModel.scenarioListLocation = ScenarioLibraryModel.SCENARIOS_LIST_REMOTE
				Swiz.dispatchEvent(new GetScenarioListEvent(GetScenarioListEvent.SCENARIO_LIST_LOADED))
			}
			else 
			{
				Logger.debug("data.result is null", this);
				mx.controls.Alert.show( "No scenarios are available from the server. This means that either no scenarios are available, or there is an error on the server. Please use local scenarios for the time being." );
			}
		}
	
		public function onRemoteScenarioListFault(fault:FaultEvent) : void
		{
			Logger.error("rpc fault : info: " + fault.message, this)
			Alert.show( "The scenario list could not be retrieved. Please try again or use the default or local scenarios." );
		}
							

		/* LOAD A SCENARIO */
		[Mediate(event="LoadScenarioEvent.LOAD_REMOTE_SCENARIO")]		
		public function onLoadRemoteScenarioEvent( event : LoadScenarioEvent ): void
		{
			Logger.debug("onLoadRemoteScenarioEvent()", this)			
			Swiz.dispatchEvent(new LoadScenarioEvent(LoadScenarioEvent.LOAD_STARTING, true))
			var call:AsyncToken = remoteScenarioDelegate.getRemoteScenario(event.scenID, userModel.username);
			executeServiceCall(call, onLoadRemoteScenarioResult, onLoadRemoteScenarioFault);		
		}
		
		public function onLoadRemoteScenarioResult(re:ResultEvent):void
		{
			Logger.debug("onLoadRemoteScenarioResult() ", this)
			if (re.result)
			{
				//build scenario model
				Logger.debug("scenario received ok", this);
								
				//convert result to XML
				XML.ignoreWhitespace = true;
				var scenXML:XML
				try
				{
					scenXML = new XML(re.result);					
				}
				catch (error:Error)
				{
					Logger.error("populateScenarioModel() couldn't parse xmlstring to XML", this);
					Logger.error("error message: " + error.message, this);
					return
				}		
				
				//parse XML via delegate
				var success:Boolean = populateScenarioModel(scenXML)				
				if (success)
				{
					Logger.debug("Scenario " + scenarioModel.name + " loaded. Starting...",this)
					scenarioModel.traceSystemVariables()
					startScenario()
				}
				else
				{
					Logger.error("Couldn't parse scenario xml", this)
					Alert.show("This scenario is not properly formed and could not be loaded. A message has been sent to the administrator. In the meantime, please try a different scenario.");
				}		
				
			}
			else 
			{
				Logger.debug("data.result is null", this);
				mx.controls.Alert.show( "This scenario could not be loaded. Please use another scenario for the time being." );
				var evt : ScenarioLoadedEvent = new ScenarioLoadedEvent(ScenarioLoadedEvent.SCENARIO_LOAD_FAILED, true)
				Swiz.dispatchEvent(evt)
			}
		}
				
		public function onLoadRemoteScenarioFault(fault:FaultEvent):void
		{
			Logger.error("onLoadRemoteScenarioFault() fault: " + fault.message)
			Alert.show( "This scenario could not be loaded. Please try again or use another scenario.", "Scenario Load Error" );
			var evt : ScenarioLoadedEvent = new ScenarioLoadedEvent(ScenarioLoadedEvent.SCENARIO_LOAD_FAILED, true)
			Swiz.dispatchEvent(evt)
		}
	

		/* ******************** */
		/*   DEFAULT SCENARIOS  */		
		/* ******************** */	

		/* DEFAULT SCENARIO LIST */
		
	
		[Mediate(event="GetScenarioListEvent.GET_DEFAULT_SCENARIO_LIST")]
		public function getDefaultScenarioList():void
		{
			scenarioLibraryModel.currScenarioList = scenarioLibraryModel.defaultScenarioList.defaultScenariosAC	
			scenarioLibraryModel.scenarioListLocation = ScenarioLibraryModel.SCENARIOS_LIST_DEFAULT
			Swiz.dispatchEvent(new GetScenarioListEvent(GetScenarioListEvent.SCENARIO_LIST_LOADED))
		}


		/* DEFAULT SCENARIO */
		
		
		[Mediate(event="LoadScenarioEvent.LOAD_DEFAULT_SCENARIO")]		
		public function onLoadDefaultScenario(event:LoadScenarioEvent):void
		{	
			//TODO					
			Logger.debug("onLoadDefaultScenarioCommand()", this)	
			var success:Boolean = populateScenarioModel(defaultScenariosModel.defaultScenarioXML)
			if (success)
			{
				Logger.debug("Default scenario loaded. Starting...",this)
				scenarioModel.traceSystemVariables()
				startScenario()
			}
			else
			{
				Logger.error("Couldn't load deafult scenario", this)
				Alert.show("Couldn't load the defaul scenario");
			}		
		}		
		
		/*
		public function onLoadDefaultScenarioComplete(success:Boolean):void
		{
			Logger.debug("#LoadScenarioCommand: loadSuccess()")
			//update view if parse is ok
			if (success)
			{
				//change to simulation view if this step succeeds
				_applicationModel.viewing = ApplicationModel.PANEL_SIMULATION 				
				_applicationModel.simBtnEnabled = true
				_applicationModel.bldgSetupEnabled = true
				_applicationModel.scenarioLoaded = true
				
				var cgEvent : ScenarioLoadedEvent = new ScenarioLoadedEvent(ScenarioLoadedEvent.SCENARIO_LOADED);
				Logger.debug("##################################################################");
				Logger.debug("#LoadScenarioCommand: Scenario loaded. Dispatching loaded event.");
				Logger.debug("##################################################################");
				CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent)
			}
			else
			{
				mx.controls.Alert.show("The default scenario is not properly formed and could not be loaded. Please try a different scenario.");
			}		
		}
		*/

		
		/* CORE */
		
		
		
		public function populateScenarioModel(scenXML:XML):Boolean
		{
			
			Logger.debug("#ScenarioDelegate: popuplateScenarioModel");
											
			//get scenario meta-information
			scenarioModel.id = scenXML.@id
			scenarioModel.scenID = scenXML.@scenID
			scenarioModel.name = scenXML.@name
			scenarioModel.short_description  = scenXML.@short_description
			scenarioModel.goal = scenXML.@goal
			scenarioModel.thumbnail_URL = scenXML.@thumbnail_URL 
			
			
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
				longTermSimulationModel.startDate = startDate
				
				var stopDate:Date = new Date()
				var stop:String = scenXML.@longterm_stop_date
				var stopM:Number = Number(stop.split("/")[0]) - 1
				var stopD:Number = Number(stop.split("/")[1])
				stopDate.month = stopM
				stopDate.date = stopD
				longTermSimulationModel.stopDate = stopDate
						
				scenarioModel.allow_longterm_date_change = (scenXML.@allow_longterm_date_change == "true")
			}
			catch(err:Error)
			{
				Logger.error("#ScenarioDelegate: couldn't parse longterm date info: " + err.message)
			}
			
			
			//get realtime datetime info
			try
			{
				Logger.debug("#ScenarioDelegate: setting shortTermSim realtime_start_datetime: " + new Date(scenXML.@realtime_start_datetime.toString()))
				scenarioModel.setRealTimeStartDate(new Date(scenXML.@realtime_start_datetime.toString()))
				//Reset the timer to reflect the new starttime
				scenarioModel.resetTimer()
			}
			catch(e:Error)
			{
				Logger.error("#ScenarioDelegate: couldn't change following into date for simulation start datetime: " + scenXML.@sim_start_datetime)
			}		
			
			scenarioModel.allow_realtime_datetime_change = (scenXML.@allow_realtime_datetime_change == "true")
			
			//assets
			if (scenXML.scenarioMovie.@url != "")
			{
				scenarioModel.movieURL = scenXML.scenarioMovie.@url
				scenarioModel.movieAvailable = true				
				scenarioModel.movieToolTip = "View movie for this scenario."
			}
			else
			{
				scenarioModel.movieAvailable = false
				scenarioModel.movieToolTip = "No movie available for this scenario."
			}
				
			//read in settings for input and fault panels
			scenarioModel.inputsVisible = (scenXML.inputPanel.@visible == "true")
			scenarioModel.inputsEnabled = (scenXML.inputPanel.@enabled == "true")
			scenarioModel.faultsVisible = (scenXML.faultPanel.@visible == "true")
			scenarioModel.faultsEnabled = (scenXML.faultPanel.@enabled == "true")
			
			
			//read in settings for output panel
			scenarioModel.useCustomOutputGraphs = (scenXML.outputPanel.@useCustomOutputGraphs == "true")
			
			//read in setttings for visualization window
			scenarioModel.enableDragSensor = (scenXML.visualizationPanel.@enableDragSensor == "true")
			scenarioModel.showValveInfoWindow = (scenXML.visualizationPanel.@showValveInfoWindow == "true")
						
			scenarioModel.sysNodesAC = new ArrayCollection()
			scenarioModel.sysVarsImportedFromLongTermAC = new ArrayCollection()
		
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
				scenarioModel.sysNodesAC.addItem(sysNode)
				if (sysNode.id!="SPK") scenarioModel.sysNodesForNavAC.addItem(sysNode)
				
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
					sysVar.units = ApplicationModel.currUnits;
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
						scenarioModel.timeScale  = sysVar.currValue
					}
					
					
					
				}
			}
			
			//TEMP -> sysVar information in XML should have a boolean property for isImportedFromEPlus
			//        until this is done, we assign here to correct vars
			var ltImportsArr:Array = ["RmQSENS","TAirOut", "TwAirOut"]
			for each (var name:String in ltImportsArr)
			{
				sysVar = scenarioModel.getSysVar(name)
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
				sysVar = scenarioModel.getSysVar(name)
				sysVar.isExportedToLongTermSim = true
			}				
			//END TEMP	
																	
			scenarioModel.initLongTermImports()						
			scenarioModel.setSort()
			
			Logger.debug("#ScenarioDelegate: finished mapping XML to model")
			return true
		}
		
		protected function startScenario():void
		{
			Logger.debug("startScenario()",this)
			//change to simulation view if this step succeeds
			applicationModel.viewing = ApplicationModel.PANEL_SHORT_TERM_SIMULATION 				
			applicationModel.simBtnEnabled = true
			applicationModel.bldgSetupEnabled = true
			applicationModel.scenarioLoaded = true
			var evt : ScenarioLoadedEvent = new ScenarioLoadedEvent(ScenarioLoadedEvent.SCENARIO_LOADED, true)
			Swiz.dispatchEvent(evt)
				
		}
		
		
		protected function getSysNodeSortIndex(sysNodeID:String):Number
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