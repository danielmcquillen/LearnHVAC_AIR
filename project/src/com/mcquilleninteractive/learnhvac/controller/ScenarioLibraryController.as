package com.mcquilleninteractive.learnhvac.controller
{
	
	
	import com.mcquilleninteractive.learnhvac.business.LocalScenarioDelegate;
	import com.mcquilleninteractive.learnhvac.business.RemoteScenarioDelegate;
	import com.mcquilleninteractive.learnhvac.event.CloseScenarioEvent;
	import com.mcquilleninteractive.learnhvac.event.GetScenarioListEvent;
	import com.mcquilleninteractive.learnhvac.event.LoadScenarioEvent;
	import com.mcquilleninteractive.learnhvac.event.LongTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.event.ScenarioLoadedEvent;
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationUIEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.DefaultScenariosModel;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioLibraryModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.model.UserModel;
	import com.mcquilleninteractive.learnhvac.util.AboutInfo;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.view.popups.SimulationModal;
	import com.mcquilleninteractive.learnhvac.vo.ScenarioListItemVO;
	
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.managers.PopUpManager;
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
		public var shortTermSimulationModel:ShortTermSimulationModel
		
		[Autowire]
		public var longTermSimulationModel:LongTermSimulationModel
		
		[Autowire]
		public var shortTermSimulationDataModel:ShortTermSimulationDataModel
		
		[Autowire]
		public var longTermSimulationDataModel:LongTermSimulationDataModel
		
		[Autowire]
		public var localScenarioDelegate:LocalScenarioDelegate
		
		[Autowire]
		public var remoteScenarioDelegate:RemoteScenarioDelegate
		
		[Autowire]
		public var defaultScenariosModel:DefaultScenariosModel
		
		//this array describes how the nodes should be ordered in the array collection -- for navigation
		private var sortOrderArr:Array = ["SYS","MX", "FAN","FLT","HC","CC","VAV","DIF","PLT","BOI","CHL","CTW","DCT","RM"]
		
		
		protected var _simModal:SimulationModal
			
		public function ScenarioLibraryController()	{}
		
		
		
		/* ******************** */
		/*    LOCAL SCENARIOS   */		
		/* ******************** */			
				
		/*   LOCAL SCENARIO LIST  */		
		[Mediate(event="GetScenarioListEvent.GET_LOCAL_SCENARIO_LIST")]
		public function getLocalScenarioList(event:GetScenarioListEvent):void
		{	
			Logger.debug("getLocalScenarioList()",this)					
			scenarioLibraryModel.scenarioListLocation = ScenarioLibraryModel.SCENARIOS_LIST_LOCAL			
										
			try
			{
				scenarioLibraryModel.currScenarioList = localScenarioDelegate.loadScenarioList()
				scenarioLibraryModel.currScenarioList.refresh()	
			}
			catch(err:Error)
			{
				Logger.error("error trying to load scenarios: " + err.message, this)
				Alert.show("Couldn't load a list of scenarios from the scenarios folder. Please make sure all scenarios are valid. Error: " + err.message, "Error");
				return
			}
						
			if (scenarioLibraryModel.currScenarioList.length == 0)
			{
				Alert.show( "There are no valid scenarios in the scenarios folder." );
				scenarioLibraryModel.currScenarioList = new ArrayCollection()
				scenarioLibraryModel.currScenarioList.refresh()
			}
			else
			{				
				Swiz.dispatchEvent(new GetScenarioListEvent(GetScenarioListEvent.SCENARIO_LIST_LOADED))
			}
		}
		
		
		/* LOCAL SCENARIO */		
		
		[Mediate(event="LoadScenarioEvent.LOAD_LOCAL_SCENARIO")]
		public function loadLocalScenario( event:LoadScenarioEvent):void
		{
			this.showSimulationModal()
			_simModal.message = SimulationModal.LOADING
			Swiz.dispatchEvent(new LoadScenarioEvent(LoadScenarioEvent.LOAD_STARTING, true))
			
			var fileName:String = event.fileName
			try
			{
				var scenXML:XML = localScenarioDelegate.loadLocalScenario(fileName)		
			}
			catch(error:Error)
			{
				removeSimulationModal()
				Logger.error("Error loading local scenario: " + error, this)
				Alert.show( "Error encountered when loading local scenario. Error: " + error.message, "Error");
				return
			}			
			var result:Boolean = populateScenarioModel(scenXML)
			if (result)
			{
				startScenario()			
				_simModal.message = SimulationModal.INITIALIZING
			}
			else
			{
				removeSimulationModal()
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
		
		/* LOAD REMOTE SCENARIO LIST */
		
		[Mediate(event="GetScenarioListEvent.GET_REMOTE_SCENARIO_LIST")]
		public function getRemoteScenarioList(event : GetScenarioListEvent) : void
		{	
			Logger.debug("getRemoteScenarioList()", this);
			//show popup
			showSimulationModal()				
			_simModal.message = "Loading scenario list"
			
			var call:AsyncToken = remoteScenarioDelegate.getRemoteScenarioList();
			executeServiceCall(call, onRemoteScenarioListResult, onRemoteScenarioListFault);
		}
				
		
		public function onRemoteScenarioListResult(re:ResultEvent) : void
		{		
			removeSimulationModal()
			
			if (re.result)
			{								
				if (re.result=="")
				{
					Alert.show("There are no scenarios available.", "No Scenarios")
				}						
				
				var scenarioListXML:XML = new XML(re.result);
				
				scenarioLibraryModel.currScenarioList = new ArrayCollection()
				
				//Until we get remoting to automatically cast these objects to ScenarioListItemVO
				for each(var scenarioXML:XML in scenarioListXML.*)
				{
					Logger.debug("scenarioXML: " + scenarioXML,this)
					Logger.debug("scenarioXML.id: " + scenarioXML.id,this)
								
					var vo:ScenarioListItemVO = new ScenarioListItemVO()
					vo.id = scenarioXML.id
					vo.name = scenarioXML.name
					vo.scenID = scenarioXML.id
					vo.description = scenarioXML.description
					vo.shortDescription = scenarioXML.shortDescription
					//vo.thumbnailURL = obj.thumbnail_URL
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
			removeSimulationModal()
			Logger.error("rpc fault : info: " + fault.message, this)
			Alert.show( "The scenario list could not be retrieved. Please try again or use the default or local scenarios." );
		}
							

		
		
		/* LOAD A SCENARIO */		
		
		[Mediate(event="LoadScenarioEvent.LOAD_REMOTE_SCENARIO")]		
		public function onLoadRemoteScenarioEvent( event : LoadScenarioEvent ): void
		{
			Logger.debug("onLoadRemoteScenarioEvent()", this)			
			
			showSimulationModal()
				
			Swiz.dispatchEvent(new LoadScenarioEvent(LoadScenarioEvent.LOAD_STARTING, true))
			var call:AsyncToken = remoteScenarioDelegate.getRemoteScenario(event.scenID, userModel.username);
			executeServiceCall(call, onLoadRemoteScenarioResult, onLoadRemoteScenarioFault);		
		}
		
		public function onLoadRemoteScenarioResult(re:ResultEvent):void
		{
			_simModal.message = SimulationModal.DOWNLOADING
			
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
					removeSimulationModal()
					Logger.error("populateScenarioModel() couldn't parse xmlstring to XML", this);
					Logger.error("error message: " + error.message, this);
					return
				}		
				
				//Make sure client version and scenario version match
				var scenarioVersion:String = scenXML.client.version
				if (scenarioVersion != AboutInfo.applicationVersion)
				{					
					//scenario and model are out of since
					var msg:String = "Scenario version does not match client version.\nScenario version: " + scenarioVersion + "\nClient version:   " + AboutInfo.applicationVersion
					Alert.show(msg, "Version mismatch")
					Logger.error("error message: " + msg, this);
					removeSimulationModal()
					return					
				}
					
				
				//parse XML via delegate
				var success:Boolean = populateScenarioModel(scenXML)				
				if (success)
				{
					_simModal.message = SimulationModal.INITIALIZING
					Logger.debug("Scenario " + scenarioModel.name + " loaded. Starting...",this)
					//scenarioModel.traceSystemVariables()
					startScenario()
				}
				else
				{
					removeSimulationModal()
					Logger.error("Couldn't parse scenario xml", this)
					Alert.show("This scenario is not properly formed and could not be loaded. A message has been sent to the administrator. In the meantime, please try a different scenario.");
				}		
				
			}
			else 
			{
				Logger.debug("data.result is null", this);
				removeSimulationModal()
				mx.controls.Alert.show( "This scenario could not be loaded. Please use another scenario for the time being." );
				var evt : ScenarioLoadedEvent = new ScenarioLoadedEvent(ScenarioLoadedEvent.SCENARIO_LOAD_FAILED, true)
				Swiz.dispatchEvent(evt)
			}
		}
				
		public function onLoadRemoteScenarioFault(fault:FaultEvent):void
		{
			removeSimulationModal()
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
			scenarioLibraryModel.currScenarioList.refresh()
			Logger.debug("scenarioLibraryModel.currScenarioList.length: " + scenarioLibraryModel.currScenarioList.length,this)
			Swiz.dispatchEvent(new GetScenarioListEvent(GetScenarioListEvent.SCENARIO_LIST_LOADED))
		}


		/* DEFAULT SCENARIO */
		
		
		[Mediate(event="LoadScenarioEvent.LOAD_DEFAULT_SCENARIO")]		
		public function onLoadDefaultScenario(event:LoadScenarioEvent):void
		{	
			Logger.debug("onLoadDefaultScenario()", this)
			showSimulationModal()
			var success:Boolean = populateScenarioModel(defaultScenariosModel.defaultScenarioXML)
			if (success)
			{
				Logger.debug("Default scenario loaded. Starting...",this)
				//scenarioModel.traceSystemVariables()
				_simModal.message = SimulationModal.INITIALIZING
				startScenario()
			}
			else
			{
				Logger.error("Couldn't load deafult scenario", this)
				Alert.show("Couldn't load the defaul scenario");
				removeSimulationModal()
			}		
		}		
		
	
		
		
		
		[Mediate(event="ShortTermSimulationUIEvent.UI_READY")]
		public function uiReady(event:ShortTermSimulationUIEvent):void
		{
			removeSimulationModal()
		}
		
		
		
		protected function showSimulationModal():void
		{
			if (_simModal)
			{
				PopUpManager.removePopUp(_simModal)
			}
			
			_simModal = new SimulationModal()
			PopUpManager.addPopUp(_simModal, Application.application as DisplayObject, true)
			_simModal.message = SimulationModal.DOWNLOADING
			PopUpManager.centerPopUp(_simModal)
		}
		
		protected function removeSimulationModal():void
		{
			PopUpManager.removePopUp(_simModal)
			_simModal = null
		}
		
		
		/* ***************************** */
		/*   PARSING AND CORE FUNCTIONS  */		
		/* ***************************** */	
					
		public function populateScenarioModel(scenXML:XML):Boolean
		{
			
			Logger.debug("popuplateScenarioModel", this);
											
			applicationModel.showDebug = (scenXML.studentDebugAccess == "true")
			
			//get scenario meta-information
			scenarioModel.id = scenXML.id
			scenarioModel.scenID = scenXML.id
			scenarioModel.name = scenXML.name
			scenarioModel.shortDescription  = scenXML.shortDescription
			scenarioModel.description  = scenXML.description
			scenarioModel.goal = scenXML.goal
			
			//scenarioModel.thumbnailURL = scenXML.@thumbnailURL 
			
			
			//get longterm date info
			try
			{
				var startDate:Date = new Date()											
				startDate.month = scenXML.longtermStartDate.month - 1
				startDate.date = scenXML.longtermStartDate.date					
				longTermSimulationModel.startDate = startDate
				
				var stopDate:Date = new Date()				
				stopDate.month = scenXML.longtermStopDate.month - 1
				stopDate.date = scenXML.longtermStopDate.date
				longTermSimulationModel.stopDate = stopDate
							
				scenarioModel.allowLongTermDateChange  = (scenXML.allowLongTermDateChange  == "true")
			}
			catch(err:Error)
			{
				Logger.error("couldn't parse longterm date info: " + err.message, this);
			}
			
			
			//get realtime datetime info
			try
			{	
				var d:Date = new Date()
				d.month = scenXML.realtimeStartDateTime.month - 1
				d.date = scenXML.realtimeStartDateTime.date 
				d.hours = scenXML.realtimeStartDateTime.hour
				d.minutes = scenXML.realtimeStartDateTime.minute
				Logger.debug("setting shortTermSim realtime_start_datetime: " + d, this);
				scenarioModel.setRealTimeStartDate(d)
						
			}
			catch(e:Error)
			{
				Logger.error("couldn't change into date for simulation start datetime: " + scenXML.realtimeStartDatetime, this);
				scenarioModel.setRealTimeStartDate(new Date())
			}		
			
			scenarioModel.allowRealTimeDateTimeChange = (scenXML.allowRealTimeDateTimeChange == "true")
			
			//assets
			if (scenXML.scenarioMovie.url != "")
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
			scenarioModel.inputsVisible = (scenXML.inputsEnabled == "true")
			scenarioModel.inputsEnabled = (scenXML.inputsVisible == "true")
			scenarioModel.faultsVisible = (scenXML.faultsVisible == "true")
			scenarioModel.faultsEnabled = (scenXML.faultsEnabled == "true")
			
			/*
			//read in settings for output panel
			scenarioModel.useCustomOutputGraphs = (scenXML.outputPanel.@useCustomOutputGraphs == "true")
			
			//read in setttings for visualization window
			scenarioModel.enableDragSensor = (scenXML.visualizationPanel.@enableDragSensor == "true")
			scenarioModel.showValveInfoWindow = (scenXML.visualizationPanel.@showValveInfoWindow == "true")
			*/
				
			scenarioModel.sysNodesAC = new ArrayCollection()
			scenarioModel.sysVarsImportedFromLongTermAC = new ArrayCollection()
		
			//loop through all systemNodes
			for each (var systemNodeXML:XML in scenXML.sysVars.*){
				
				//create new SystemNode
				var sysNode:SystemNodeModel = new SystemNodeModel();
				sysNode.sysVarsArr = new ArrayCollection();
								
				//get properties
				//TEMP until sergio fixes the server
				var sysNodeID:String = systemNodeXML.@id
				if (sysNodeID=="CH") sysNodeID = "CHL"
				sysNode.id = sysNodeID
				sysNode.sortOrderIndex = getSysNodeSortIndex(sysNode.id)
				sysNode.name = systemNodeXML.@name;
				
				//add to scenarioModel
				scenarioModel.sysNodesAC.addItem(sysNode)
				//add to navigation (if we want to hide any nodes from
				//nav do a conditional add here based on node name)
				if (sysNode.id!="DCT" && sysNode.id!="RM")
				{					
					scenarioModel.sysNodesForNavAC.addItem(sysNode)
				}
				
				//parse this system node's sysVars
				for each (var sysVarXML:XML in systemNodeXML.*)
				{
					var sysVar:SystemVariable = new SystemVariable();
					
					for each (var propertyXML:XML in sysVarXML.*)
					{
						var propertyName:String = propertyXML.name()
						//manually cast to boolean if need be
						if (propertyName =="isFault" || 
							propertyName == "isPercentage" || 
							propertyName == "disabled" ||
							propertyName == "faultIsActive")
						{
							sysVar[propertyName] = (propertyXML.toString() == "true"); 
						}
						else 
						{
							sysVar[propertyName] = propertyXML.toString()		
						}
					}
					
					
					// TEMP : DISABLING ALL PARAMETERS AND ENABLING EVERYTHING ELSE
					if (sysVar.ioType==SystemVariable.PARAMETER)
					{
						sysVar.disabled = true
					}
					else
					{
						sysVar.disabled = false
					}
					
					sysVar.units = ApplicationModel.currUnits;
					sysVar.setConversionFunctions()
					sysVar.localValue = sysVar.currValue					
					sysVar.initiallyFaultIsActive = sysVar.faultIsActive
					
					
					
					//store system variable in main array
					scenarioModel.sysVarsArr.push(sysVar)
					//...and also in the arrayCollection with this node
					sysNode.sysVarsArr.addItem(sysVar)					
				}
			}
						
			scenarioModel.initShortTermImports()																	
			scenarioModel.initLongTermImports()						
			scenarioModel.setSort()
			
			Logger.debug("finished mapping XML to model", this)
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
			Logger.warn("getSysNodeIndex() unrecognized sysNodeID: " + sysNodeID, this)
			return 0
		}
		
		
		[Mediate(event="CloseScenarioEvent.CLOSE_SCENARIO")]
		public function onCloseScenario(event:CloseScenarioEvent):void
		{
			//if simulation is still running, stop it
			if (shortTermSimulationModel.currentState = ShortTermSimulationModel.STATE_RUNNING)
			{
				var stEvent:ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_STOP, true)
				Swiz.dispatchEvent(stEvent)
			}
			
			if (longTermSimulationModel.currentState = LongTermSimulationModel.STATE_RUNNING)
			{
				var ltEvent:LongTermSimulationEvent = new LongTermSimulationEvent(LongTermSimulationEvent.SIM_CANCEL, true)
				Swiz.dispatchEvent(ltEvent)
			}
			
			scenarioModel.init()
		    shortTermSimulationModel.init()
		    longTermSimulationModel.init()
		    shortTermSimulationDataModel.init()
		    longTermSimulationDataModel.init()
			applicationModel.scenarioLoaded = false
			applicationModel.viewing = ApplicationModel.PANEL_SELECT_SCENARIO
		}
		
		
		
		// FOR TESTING 
		public function loadDataForTest():void
		{
			populateScenarioModel(defaultScenariosModel.defaultScenarioXML)			
		}

		


	}
}