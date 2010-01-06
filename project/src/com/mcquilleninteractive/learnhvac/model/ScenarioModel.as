package com.mcquilleninteractive.learnhvac.model
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.business.SparkService;
	import com.mcquilleninteractive.learnhvac.business.TestModeSparkService
	import com.mcquilleninteractive.learnhvac.business.ISparkService
	import com.mcquilleninteractive.learnhvac.event.AHUEvent;
	import com.mcquilleninteractive.learnhvac.event.SparkEvent;
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.util.DateUtil;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.SparkInputVarsVO;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	[Bindable]
	public class ScenarioModel extends EventDispatcher
	{
		
		/////////////////////////////////////
		// STATIC VARIABLES
		/////////////////////////////////////
		
		// type of data for analysis section
		public static var SPARK_DATA_TYPE:String = "sparkDataType" // for graphing
		public static var EPLUS_DATA_TYPE:String = "eplusDataType" // for graphing
		
		//state of AHU 
		public static var AHU_ON:String = "AHUon"
		public static var AHU_OFF:String = "AHUoff"
		public static var AHU_PAUSED:String = "AHUpaused"
				
		//Output from short-term sim
		public static var SHORT_TERM_OUTPUT_LOADED:String = "shortTermDataLoaded"
		
		//system node identifiers
		public static var SN_HC:String = "HC" 			//Heating Coil
		public static var SN_CC:String = "CC"			//Cooling Coil
		public static var SN_FAN:String = "Fan"			//This is lower case because for some reason the SPARK variables have lowercase Fan
		public static var SN_FILTER:String = "Flt"		//This is lower case because for some reason the SPARK variables have lowercase Flt
		public static var SN_MIXINGBOX:String = "MX"	
		public static var SN_VAV:String = "VAV"
		public static var SN_DIFFUSER:String = "DIF"
		public static var SN_ROOF:String = "RF"			//Roof view -- three-quarters view
		public static var SN_SYSTEM:String = "SYS"		//System view -- entire system is visible in head-on view
		public static var SN_SPARK:String = "SPK"		
		public static var SN_CHILLER:String = "CHL"
		public static var SN_BOILER:String = "BOI"
		public static var SN_COOLINGTOWER:String = "CTW"
		public static var SN_PLANT:String = "PLT"
		public static var _sysNodes:Array
		
		//views available in analysis section (toggles viewstack)
		public static var ANALYSIS_ALL_DATA:Number = 0
		public static var ANALYSIS_ENERGY:Number = 1
		
		public static var LT_IMPORT_NONE:String = "none"
		
		/////////////////////////////////////
		// INSTANCE VARIABLES
		/////////////////////////////////////
				
		// CHILDREN MODELS
		// for holding EPlus and Spark data for graphing
		public var ePlusRunsModel:EPlusRunsModel
		public var sparkRunsModel:SparkRunsModel	
		
		// MAIN ARRAYS 
		// for holding scenario data
		public var sysNodesArr:ArrayCollection 			= new ArrayCollection()			// array to hold sysNodes (which hold system variables)
		public var sysNodesForNavArr:ArrayCollection 	= new ArrayCollection()			// another array to hold sysNodes used for user navigation (e.g. SPARK not included)
		public var sysVarsImportedFromLongTermAC:ArrayCollection = new ArrayCollection()// holds group of SysVars that are imported from LongTerm into ShortTerm sim
		public var varsToImportArr:Array = ["TAirOut","TwAirOut", "RmQSENS"]			//CONFIGURE THIS TO CHANGE WHICH VARS ARE TO BE IMPORTED FROM E+
					
		// OTHER CLASS PROPERTIES
			
		// values for short-term simulation
		public var currNode:String  					//node user is viewing
		public var currNodeIndex:Number = 0				//index of node user is viewing (index within sysNodesArr) 
		public var sparkService:ISparkService
		public var ahuStatus:String 
		
		// meta-information for scenario externally loaded
		public var id:String 
		public var scenID:String 
		public var name:String 
		public var short_description:String
		public var goal:String
		public var thumbnail_URL:String
		public var movieURL:String
		
		//dates 
		public var allow_longterm_date_change:Boolean = true
		private var _realtime_start_datetime:Date = new Date("01/15/2009 12:00:00 PM")
		public var allow_realtime_datetime_change:Boolean = true
		public var WDD_start_date:Date = new Date("01/21/2009 12:00:00 AM")
		public var WDD_stop_date:Date = new Date("01/21/2009 11:59:59 PM")
		public var SDD_start_date:Date = new Date("08/21/2009 12:00:00 AM")
		public var SDD_stop_date:Date = new Date("08/21/2009 11:59:59 PM")
	
		// Short-term panel: inputArea settings
		public var inputsVisible:Boolean = true
		public var inputsEnabled:Boolean = true
		public var faultsVisible:Boolean = true
		public var faultsEnabled:Boolean = true
		
		// Short-term panel: visualization area settings
		public var enableDragSensor:Boolean = true
		public var showValveInfoWindow:Boolean = true
		public var movieAvailable:Boolean = false
		public var movieToolTip:String = "View movie for this scenario" //can change to Movie Not Available...
		
		// Short-term panel: output area settings
		public var useCustomOutputGraphs:Boolean = true
			
		// Analysis panel
		public var analysisView:Number = ANALYSIS_ALL_DATA	
				
		// convenience counter
		public var numVariables:Number = 0

		//timing variables
		public var currDateTime:Date					//set to realtime_start_datetime and then incremented while spark is running
		public var elapsedTime:Number = 0				//amount of time elapsed in SPARK seconds (incremented each step by current timescale) 
		public var step:Number = 0						//spark step, increments each spark iteration (1,2,3..)				
		public var currStep:Number = 0					//current step 					
		public var stepArr:Array = [0]					//holds each increment in array for graphing time axis
		public var timeScale:Number = 1					//timescale is changed by user...multiplies 1 second increment
		public var currTime:String = "00:00:00"			//string representation of time (visual components bind to this)
		public var epochTimeArr:Array					//array of epoch seconds representating DATE and time of each step for graphing 
		
			
		//Long-term variables
		public var ltSettingsModel:LTSettingsModel = new LTSettingsModel()
		
		public var lookupArr:Array						//This makes finding system variables quicker after the first search through the nodes
		
		//Tells scenario model which long term simulation to import variables from into short-term sim (selected by user)
		//Values are LT_IMPORT_NONE, EPlusRunsModel.RUN_1, or EPlusRunsModel.RUN_2
		public var importLongTermVarsFromRun:String = LT_IMPORT_NONE
		
		/////////////////////////////////////
		// CONSTRUCTOR FUNCTIONS
		/////////////////////////////////////
		
		public function ScenarioModel():void
		{
			
			Logger.debug(": created")
			//not sure why these variables aren't init'ing properly when set as part of the class member declaration
			
			
			//TESTMODE
			if (LHModelLocator.testMode)
			{
				sparkService = new TestModeSparkService(this)
			}
			else
			{				
				sparkService = new SparkService(this)
			}
					
			ePlusRunsModel = new EPlusRunsModel()
			sparkRunsModel = new SparkRunsModel()
						
			CairngormEventDispatcher.getInstance().addEventListener(SparkEvent.SPARK_INTERVAL_TIMEOUT, onSparkEvent, false, 0,true)
			CairngormEventDispatcher.getInstance().addEventListener(SparkEvent.SPARK_STARTUP_TIMEOUT, onSparkEvent, false, 0,true)
			CairngormEventDispatcher.getInstance().addEventListener(SparkEvent.SPARK_CRASHED, onSparkEvent, false, 0,true)
			CairngormEventDispatcher.getInstance().addEventListener(SparkEvent.SPARK_OFF, onSparkEvent, false, 0,true)
			CairngormEventDispatcher.getInstance().addEventListener(SparkEvent.SPARK_ON, onSparkEvent, false, 0,true)
			
			initialize()
		}
				
		/////////////////////////////////////
		// STATIC FUNCTIONS
		/////////////////////////////////////
		
		public static function get sysNodes():Array
		{
			if (_sysNodes == null)
			{
				_sysNodes = []
				_sysNodes[SN_HC] = "HEATING COIL"
				_sysNodes[SN_CC] = "COOLING COIL"
				_sysNodes[SN_FAN] = "FAN"
				_sysNodes[SN_FILTER] = "FILTER"
				_sysNodes[SN_MIXINGBOX] = "MIXING BOX"
				_sysNodes[SN_VAV] = "VAV"
				_sysNodes[SN_DIFFUSER] = "DIFFUSER"
				_sysNodes[SN_BOILER] = "BOILER"
				_sysNodes[SN_CHILLER] = "CHILLER"
				_sysNodes[SN_COOLINGTOWER] = "COOLING TOWER"
				_sysNodes[SN_ROOF] = "ROOF"
				_sysNodes[SN_SYSTEM] = "SYSTEM"
			}
			return _sysNodes		
		
		}
		
		
		/////////////////////////////////////
		// INSTANCE FUNCTIONS
		/////////////////////////////////////
		
		public function setSort():void
		{
			/* Create the SortField object for the "data" field in the ArrayCollection object, and make sure we do a numeric sort. */
            var dataSortField:SortField = new SortField();
            dataSortField.name = "sortOrderIndex";
            dataSortField.numeric = true;

            /* Create the Sort object and add the SortField object created earlier to the array of fields to sort on. */
            var numericDataSort:Sort = new Sort();
            numericDataSort.fields = [dataSortField];

            /* Set the ArrayCollection object's sort property to our custom sort, and refresh the ArrayCollection. */
            this.sysNodesArr.sort = numericDataSort;
            this.sysNodesForNavArr.sort = numericDataSort
            this.sysNodesArr.refresh();
            this.sysNodesForNavArr.refresh();

		}
		
	
		
		public function getSysVar(sysVarName:String):SystemVariable
		{
			//Logger.debug(": getSysVar() looking for : " + sysVarName)
					
			//first look in lookupArr to see if variable has quick reference
			if (lookupArr[sysVarName]!= null)
			{
				return lookupArr[sysVarName]				
			}
			else //try to find variable by looping through model
			{
				for each (var sysNode:SystemNodeModel in sysNodesArr)
				{
					for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
					{
						if (sysVar.name == sysVarName)
						{
							lookupArr[sysVarName] = sysVar
							return sysVar
						}
					}
				}	
			}			
			Logger.error("getSysVar() can't find variable : " + sysVarName, this)
			return null
		}
			
			
		/* Function: initialize
		*  Initializes model, wiping out any current settings 
		*/
		public function initialize():void
		{
			clearScenario()
			ahuStatus = ScenarioModel.AHU_OFF
			lookupArr = []
		}
		
		public function clearScenario():void
		{
			//wipe out all info from ScenarioModel
			//TODO: need to call destroy() functions on node and sysvar objects
			sysNodesArr = new ArrayCollection()
			sysNodesForNavArr = new ArrayCollection()
			resetTimer()
		}
		
		public function resetAll():void
		{
			Logger.debug(": resetting.")
			clearScenario()
			ahuStatus = ScenarioModel.AHU_OFF
				
		}
		
		/* Function setValue
		*  Locates a system variable and sets current value to new value
		*/
		public function setSysVarValue(sysVarName:String, sysVarValue:Number, incomingFromSpark:Boolean = false):void
		{
			var value:Number = Number(sysVarValue);
			if (isNaN(value))
			{
				Logger.warn(": setSysVarValue() couldn't cast parameter " + sysVarValue + " to number")
				return	
			}
			
			//The first time a sysVariable is looked up, we'll add it to our
			//quick lookup table. We'll then use that lookup table for all future 
			//updates. This should increase the speed of spark reads.
			
			//use lookup if exists
			var sysVar:SystemVariable = lookupArr[sysVarName]
			if (sysVar!=null)
			{
				if (incomingFromSpark)
				{
					sysVar.baseSIValue = value
				}
				else
				{
					sysVar.currValue = value
				}
			}
			else //create lookup then use 
			{
				sysVar = getSysVar(sysVarName)
				if (incomingFromSpark)
				{
					sysVar.baseSIValue = value
				}
				else
				{
					sysVar.currValue = value
				}
				
				lookupArr[sysVarName] = sysVar
			}
			
		}
		
		public function getSysVarValue(sysVarName:String):Number
		{
			if (lookupArr[sysVarName]!=null)
			{
				return SystemVariable(lookupArr[sysVarName]).currValue
			}
			else
			{
				var s:SystemVariable = getSysVar(sysVarName)
				return s.currValue
			}
		}
		
		
		public function setCurrNode(nodeID:String):void
		{
			Logger.debug("setCurrNode() nodeID: " + nodeID, this)
			currNode = nodeID
			
			//don't update if ROOF, since this doesn't have representation in sysNodes
			if (nodeID==ScenarioModel.SN_ROOF)
			{
				return
			}
			
			var nodeFound:Boolean = false
			for (var i:Number=0;i<sysNodesArr.length;i++)
			{
				if (sysNodesArr[i].id == nodeID)
				{
					Logger.debug("setCurrNode() currNodeIndex was set to : " + i, this) 
					currNodeIndex = i
					nodeFound = true	
				}
			}
			if (!nodeFound)
			{
				Logger.warn("setCurrNode() was called with unrecognizeable nodeID: " + nodeID, this)
			}
		}
		
		
		//////////////////////////////////////
		// AHU AND SPARK FUNCTIONS 
		//////////////////////////////////////
			
		public function startAHU():void
		{
			//Start the AHU system, which essentially means start SPARK
			//But don't broadcast that the AHU is started until we hear back
			//from the SparkService that SPARK started OK.
			Logger.debug("starting AHU", this)
			resetAllSysVarValueHistories()
			resetTimer()
			if (importLongTermVarsFromRun!=ScenarioModel.LT_IMPORT_NONE) importLongTermVars()
			sparkService.startSpark()
		}
		
		
		public function stopAHU():void
		{
			//Stop the AHU system, which essentially means stop SPARK
			//But don't broadcast that the AHU is stopped until we hear back
			//from the SparkService that SPARK stopped OK.
			Logger.debug("stopping AHU", this)
			sparkService.stopSpark()
		}
		
		public function updateAHU():void
		{
			sparkService.updateSpark()
		}
		
		public function cancelStartAHU():void
		{
			sparkService.stopSpark() //currently this is same as stop but may need to become a different function
		}
		
		
		// Listen for events from SPARK and respond and also issue events for entire AHU.
		// Most components should be shielded from SPARK events and really only listen here
		// for AHU events (only a few components listen directly to SparkService's SparkEvents, such as the SPARK icon in the corner of the viz window).			
		public function onSparkEvent(evt:SparkEvent):void
		{
			
			Logger.debug("sparkStatus called. type: " + evt.type + " code: " + evt.code + " msg: " + evt.msg, this)
			
			switch(evt.type)
			{
				case SparkService.SPARK_ON:
					ahuStatus = ScenarioModel.AHU_ON
					CairngormEventDispatcher.getInstance().dispatchEvent(new AHUEvent(AHUEvent.EVENT_AHU_STARTED))
					break
				case SparkService.SPARK_STARTUP_TIMEOUT:
				case SparkService.SPARK_INTERVAL_TIMEOUT:
				case SparkService.SPARK_CRASHED:
				case SparkService.SPARK_OFF:
					ahuStatus = ScenarioModel.AHU_OFF
					CairngormEventDispatcher.getInstance().dispatchEvent(new AHUEvent(AHUEvent.EVENT_AHU_STOPPED))
					break
				default:
					Logger.warn("onSparkEvent() unrecognized evt type: " + evt.type, this)
			}
			
			
		}
		
		/** Updates scenario properties each time a short-term (SPARK) output is read in */
		public function loadShortTermOutputComplete(step:Number):void
		{
			updateTimer(step);
			
			//only import long-term variables on the hour 						
			if (currDateTime.minutes==0 && currDateTime.seconds== 0)
			{
				importLongTermVars()
				//automatically update spark variables to get imported variables into simulator
				var updateEvent : ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.EVENT_UPDATE_AHU);
				CairngormEventDispatcher.getInstance().dispatchEvent(updateEvent);
			}			
			
			//tell anybody who cares that the short term simulation output is complete
			var cgEvent:CairngormEvent = new CairngormEvent(ScenarioModel.SHORT_TERM_OUTPUT_LOADED)
			CairngormEventDispatcher.getInstance().dispatchEvent(cgEvent)
		}
		
		
		 
		//update every spark variable so that it records value
		//(don't want to do this with binding because then I have to manage event listeners)
		/*
		private function recordAllSysVarValues():void
		{
			Logger.debug("ScenarioModel: recordAllSysVarValues() ~~~~~~~~~~~~~~~~~~~ ")
			var len:Number = sysNodesArr.length
			for (var i:Number=0; i<len;i++)
			{
				var len2:Number = sysNodesArr[i].sysVarsArr.length
				for (var j:Number=0; j<len2; j++)
				{
					Logger.debug("recording value for sysVar: " +sysNodesArr[i].sysVarsArr[j].name )
					sysNodesArr[i].sysVarsArr[j].recordValue()
				}
			}
		} 
		*/
		
		
		private function resetAllSysVarValueHistories():void
		{
			var len:Number = sysNodesArr.length
			for (var i:Number=0; i<len;i++)
			{
				var s:SystemNodeModel = sysNodesArr[i] as SystemNodeModel
				var len2:Number = sysNodesArr[i].sysVarsArr.length
				for (var j:Number=0; j<len2; j++)
				{
					s.sysVarsArr[j].clearHistory()
					s.sysVarsArr[j].recordValue(0) //record the current vlaue into the [0] history slot
				}
			}
		}
		 
		public function getVarData(varIDs:Array, includeTime:Boolean):Array
		{
			//right now, we only provide objects with value and time data for one systemVariable.
			//later, we might provide data for more than one systemVariable similar to EPlusModel
				
			if (varIDs.length<=0) 
			{
				Logger.error("getVarData() varIDs array argument was empty", this)
				return null
			}
					
			//build array for graph
			var returnArr:Array = new Array()
			var varID:String = null
			
			//get references to each of the system variables specified by the IDs in the varIDs argument
			var sysVarsArr:Array = new Array()
			for (var i:Number=0; i<varIDs.length; i++)
			{
				var sysVar:SystemVariable = this.getSysVar(varIDs[i])
				if (sysVar==null) 
				{
					Logger.debug("getVarData(): couldn't find sysVar by ID: " + varIDs[i], this)
					continue
				}
				sysVarsArr.push(sysVar)
			}
			
			var valuesLength:Number = stepArr.length
			for (var index:Number=0;index<valuesLength;index++)
			{
				var obj:Object = new Object()
				if (includeTime)
				{
					obj.time = stepArr[index]	
				}
				//add all variables sent in argument array to dataprovider
				for (var j:Number = 0; j<sysVarsArr.length; j++)
				{
					obj["valueVar"+(j+1)] = sysVarsArr[j].history[index]
				}
				returnArr.push(obj)		
			}
			
			
			return returnArr
			

		} 
		
		/** Imports a set of E+ data into current systemVariables.
		 * 
		 * */
		public function importLongTermVars():void
		{	
			Logger.debug ("importLongTermVars() importLongTermVarsFromRun: " + importLongTermVarsFromRun)
				
			if (importLongTermVarsFromRun==ScenarioModel.LT_IMPORT_NONE) return 
															
			var sparkInputsVO:SparkInputVarsVO 
			var ePlusData:EPlusData = ePlusRunsModel.getEPlusData(importLongTermVarsFromRun)	
						
			if (ePlusData==null)
			{
				Logger.error("importLongTermVars() no ePlus data to import", this)
				return
			}
			
			//try
			//{		
				sparkInputsVO = ePlusData.getSparkInputs(currDateTime, this.ltSettingsModel.floorOfInterest, this.ltSettingsModel.zoneOfInterest)
			//}
			//catch(err:Error)
			//{
			//	Logger.error(": importLongTermVars() error: " + err)
			//	return
			//}
			
			if (sparkInputsVO==null)
			{
				Logger.warn("sparkInputsVO returned from ePlusData was null.", this)
				return
			}
			else
			{				
				//make sure to grab "base" values, which are SI units, from sparkInputs
								
				var rmQSensVar:SystemVariable = getSysVar("RmQSENS")
				rmQSensVar.baseSIValue = sparkInputsVO.getRmQSens("SI")
				
				var tAirOut:SystemVariable = getSysVar("TAirOut")
				tAirOut.baseSIValue = sparkInputsVO._tAirOut
				
				var twAirOut:SystemVariable = getSysVar("TwAirOut")
				twAirOut.baseSIValue = sparkInputsVO._twAirOut
						
			}
		}
		
		
		/* Sets up the ArrayColletion that holds variables that need to be imported from E+. This
		   is done after scenario is loaded */		  
		public function initLongTermImports():void
		{
			this.sysVarsImportedFromLongTermAC = new ArrayCollection()	
			for each (var name:String in varsToImportArr)
			{
				sysVarsImportedFromLongTermAC.addItem(this.getSysVar(name))
			}
		}
		 
		 
		/* This is more of a utility function: it returns a collection of systemVariables that are imported from E+*/
		public function getLongTermExportSysVars():ArrayCollection
		{
			var resultAC:ArrayCollection = new ArrayCollection()
			var len:Number = sysNodesArr.length
			for (var i:Number=0; i<len;i++)
			{
				var s:SystemNodeModel = sysNodesArr[i] as SystemNodeModel
				var len2:Number = sysNodesArr[i].sysVarsArr.length
				for (var j:Number=0; j<len2; j++)
				{
					var sysVar:SystemVariable = s.sysVarsArr[j]
					if (sysVar.isExportedToLongTermSim) resultAC.addItem(sysVar)
				}
			}
			return resultAC
		}
				
		public function setRealTimeStartDate(d:Date):void
		{
			_realtime_start_datetime = d
			this.currDateTime = d
			currTime = DateUtil.formatTime(currDateTime)
			importLongTermVars()
		}
		
		public function get realtime_start_datetime():Date
		{
			return _realtime_start_datetime
		}
		
		
		public function set zoneOfInterest(val:uint):void
		{
			this.ltSettingsModel.zoneOfInterest = val
			importLongTermVars()				
		}
		
		
		public function set floorOfInterest(val:uint):void
		{
			this.ltSettingsModel.floorOfInterest = val
			importLongTermVars()				
		}
		
		//////////////////////////////////////
		// TIMER FUNCTIONS 
		//////////////////////////////////////
		
		public function updateTimer(step:Number):void{
			
			//record each step for graphing purposes, but increment time according
			//to the timeScale property (e.g. if timeScale is 5, add 5 seconds on each update, not one)
			
			currStep = step
			stepArr.push(currStep)
			if (currStep!=0)
			{
				currDateTime.seconds = currDateTime.seconds + timeScale
			}
			
			epochTimeArr.push(Date.parse(currDateTime.toString()))
			currTime = DateUtil.formatTime(currDateTime)
						
			Logger.debug("currTime:" + currTime)
		}

	
		public function resetTimer():void
		{
			/* Resets timer to the start datetime defined in the scenario 
			   and stored in the realtime_start_datetime variable */
			Logger.debug("resetTimer()  realtime_start_datetime: " + realtime_start_datetime, this)
			step = 0
			epochTimeArr = []
			if (realtime_start_datetime != null)
			{
				currDateTime = new Date(realtime_start_datetime.toString())
			}
			else
			{
				Logger.warn("tried to resetTime() but there's no realtime_start_datetime", this)
				currDateTime = new Date()			
			}
			updateTimer(0)
		}
			
			
			
	}
}