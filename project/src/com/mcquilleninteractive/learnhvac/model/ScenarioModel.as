package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.util.DateUtil;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.SparkInputVarsVO;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	/** ScenarioModel
	 *  
	 *  The ScenarioModel contains all the data that describes a specific scenario.
	 *  It manages the state of each SystemVariable that defines a scenario, as well
	 *  as the accompanying educational material such as video, help text, etc. It
	 *  also manages the states of the views of components that are dependent on the
	 *  scenario definition for part or all of their initial state (e.g. the Scenario
	 *  as defined by the instructor may want the outputPanel hidden. That visibility is
	 *  controlled here).
	 *  
	 *  The ScenarioModel should not manage the data that's specific to a specific simulation
	 *  run, either long-term or short-term. That data is held in the LongTermSimulationModel
	 *  and ShortTermSimulationModel and the related LongTermSimulationDataModel and 
	 *  ShortTermSimulationDatamodel.
	 * 
	 *  Most visual displays will listen to this model for updates and get retrieve this model's
	 *  data to display when those updates happen.
	 */
	
	[Bindable]
	public class ScenarioModel extends EventDispatcher
	{
		
		
		// type of data for analysis section
		public static var SPARK_DATA_TYPE:String = "sparkDataType"; // for graphing
		public static var EPLUS_DATA_TYPE:String = "eplusDataType"; // for graphing
		
		[Autowire]
		public var shortTermSimulationDataModel:ShortTermSimulationDataModel
				
		[Autowire]
		public var longTermSimulationDataModel:LongTermSimulationDataModel
			
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
		
		
		// for holding scenario data
		public var sysNodesAC:ArrayCollection 			= new ArrayCollection()			// array to hold sysNodes (which hold system variables)
		public var sysNodesForNavAC:ArrayCollection 	= new ArrayCollection()			// another array to hold sysNodes used for user navigation (e.g. SPARK not included)
		public var sysVarsImportedFromLongTermAC:ArrayCollection = new ArrayCollection()// holds group of SysVars that are imported from LongTerm into ShortTerm sim
		public var varsToImportArr:Array = ["TAirOut","TwAirOut", "RmQSENS"]			//CONFIGURE THIS TO CHANGE WHICH VARS ARE TO BE IMPORTED FROM E+
					
		// OTHER CLASS PROPERTIES
			
		// values for short-term simulation
		public var currNode:String  					//node user is viewing
		public var currNodeIndex:Number = 0				//index of node user is viewing (index within sysNodesAC) 
		
		
		// meta-information for scenario externally loaded
		public var id:int 								//primary key ID of scenario
		public var scenID:String 						//Text-based ID for scenario
		public var name:String 
		public var short_description:String
		public var goal:String							//as in didactic goal as described by Instructor
		public var thumbnail_URL:String
		public var movieURL:String						//URL of a movie that explains a certain concept
		
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
		public var lookupArr:Array						//This makes finding system variables quicker after the first search through the nodes
		
		//Tells scenario model which long term simulation to import variables from into short-term sim (selected by user)
		//Values are LT_IMPORT_NONE, LongTermSimulationDataModel.RUN_1, or LongTermSimulationDataModel.RUN_2
		public var importLongTermVarsFromRun:String = LT_IMPORT_NONE
		
		protected var _floorOfInterest:uint = 1
		protected var _zoneOfInterest:uint = 1
		protected var _inputSysVarsArr:Array = []
		
		/////////////////////////////////////
		// CONSTRUCTOR FUNCTIONS
		/////////////////////////////////////
		
		public function ScenarioModel():void
		{															
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
            sysNodesAC.sort = numericDataSort;
            sysNodesForNavAC.sort = numericDataSort
            sysNodesAC.refresh();
            sysNodesForNavAC.refresh();

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
				for each (var sysNode:SystemNodeModel in sysNodesAC)
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
			
			
		public function getInputSysVars():Array
		{
			var returnArr:Array = []
			if (_inputSysVarsArr.length==0)
			{
				//TODO: only send input variables that have changed
				return _inputSysVarsArr
			}
			for each (var sysNode:SystemNodeModel in sysNodesAC)
			{
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{
					if (sysVar.typeID == SystemVariable.INPUT)
					{
						_inputSysVarsArr.push(sysVar)
					}
					
				}	
			}
			return _inputSysVarsArr
		}
			
		/* Function: initialize
		*  Initializes model, wiping out any current settings 
		*/
		public function initialize():void
		{
			clearScenario()
			lookupArr = []
			_inputSysVarsArr = []
		}
		
		public function clearScenario():void
		{
			//wipe out all info from ScenarioModel
			//TODO: need to call destroy() functions on node and sysvar objects
			sysNodesAC = new ArrayCollection()
			sysNodesForNavAC = new ArrayCollection()
			resetTimer()
		}
		
		public function resetAll():void
		{
			Logger.debug(": resetting.")
			clearScenario()
				
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
			for (var i:Number=0;i<sysNodesAC.length;i++)
			{
				if (sysNodesAC[i].id == nodeID)
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
		
			
		
		
		
				
		public function resetAllSysVarValueHistories():void
		{
			var len:Number = sysNodesAC.length
			for (var i:Number=0; i<len;i++)
			{
				var s:SystemNodeModel = sysNodesAC[i] as SystemNodeModel
				var len2:Number = sysNodesAC[i].sysVarsArr.length
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
			var ePlusData:EPlusData = longTermSimulationDataModel.getEPlusData(importLongTermVarsFromRun)	
						
			if (ePlusData==null)
			{
				Logger.error("importLongTermVars() no ePlus data to import", this)
				return
			}
			
			//try
			//{		
				sparkInputsVO = ePlusData.getSparkInputs(currDateTime, _floorOfInterest, _zoneOfInterest)
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
			var len:Number = sysNodesAC.length
			for (var i:Number=0; i<len;i++)
			{
				var s:SystemNodeModel = sysNodesAC[i] as SystemNodeModel
				var len2:Number = sysNodesAC[i].sysVarsArr.length
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
			Logger.debug("setRealTimeStartDate()",this)
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
			Logger.debug("zoneOfInterest()",this)
			_zoneOfInterest = val
			//longTermSimulationModel.zoneOfInterest = val
			importLongTermVars()				
		}
		
		
		public function set floorOfInterest(val:uint):void
		{
			_floorOfInterest = val				
		}
		
		//////////////////////////////////////
		// TIMER FUNCTIONS 
		//////////////////////////////////////
		
		public function updateTimer(step:Number):void
		{
			Logger.debug("updateTimer()",this)
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
						
			// import long-term variables on the hour 						
			if (currDateTime.minutes==0 && currDateTime.seconds== 0)
			{
				importLongTermVars()
				//automatically update spark variables to get imported variables into simulator
				var event : ShortTermSimulationEvent = new ShortTermSimulationEvent(ShortTermSimulationEvent.SIM_UPDATE);
				dispatchEvent(event);
			}		
								
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
			
	
		public function traceSystemVariables():void
		{
			Logger.debug("Tracing system variables in model:",this)
			for each (var sysNode:SystemNodeModel in sysNodesAC)
			{
				Logger.debug("  NODE: " + sysNode.name,this)
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{
					Logger.debug("      " + sysVar.name + " : " + sysVar.currValue,this)
				}
			}	
		}		
			
	}
}