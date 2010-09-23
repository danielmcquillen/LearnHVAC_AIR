package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.model.data.EnergyPlusData;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.LongTermValuesForShortTermSimVO;
	
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
	 *  run, either long-term or short-term. That data is held in the 
	 *  LongTermSimulationDataModel and ShortTermSimulationDatamodel, or in the ScenarioSimulationData 
	 *  when the output data is a combination of both or a product of neither
	 * 
	 *  Most visual displays will listen to this model for updates and get retrieve this model's
	 *  data to display when those updates happen.
	 */
	
	[Bindable]
	public class ScenarioModel extends EventDispatcher
	{		
		
		[Autowire]
		public var shortTermSimulationModel:ShortTermSimulationModel
		
		[Autowire]
		public var shortTermSimulationDataModel:ShortTermSimulationDataModel
		
		[Autowire]
		public var longTermSimulationModel:LongTermSimulationModel
				
		[Autowire]
		public var longTermSimulationDataModel:LongTermSimulationDataModel
		
		
			
		//Output from short-term sim
		public static var SHORT_TERM_OUTPUT_LOADED:String = "shortTermDataLoaded"
		
		//system node identifiers
		public static var SN_HC:String = "HC" 			
		public static var SN_CC:String = "CC"			
		public static var SN_FAN:String = "FAN"			
		public static var SN_FILTER:String = "FLT"		
		public static var SN_MIXINGBOX:String = "MX"	
		public static var SN_VAV:String = "VAV"
		public static var SN_DIFFUSER:String = "DIF"
		public static var SN_ROOF:String = "RF"			//Roof view -- three-quarters view
		public static var SN_SYSTEM:String = "SYS"		//System view -- entire system is visible in head-on view
		public static var SN_CHILLER:String = "CHL"
		public static var SN_BOILER:String = "BOI"
		public static var SN_COOLINGTOWER:String = "CTW"
		public static var SN_PLANT:String = "PLT"
		public static var SN_DCT:String = "DCT"
		public static var SN_RM:String = "RM"
		public static var _sysNodes:Array
		
		//views available in analysis section (toggles viewstack)
		public static var ANALYSIS_ALL_DATA:Number = 0
		public static var ANALYSIS_ENERGY:Number = 1
		
		public static var LT_IMPORT_NONE:String = "none"
		
		//holds all system variables
		public var sysVarsArr:Array = [] 
		
		// for holding scenario data
		public var sysNodesAC:ArrayCollection 			= new ArrayCollection()			// array to hold sysNodes (which hold system variables)
		public var sysNodesForNavAC:ArrayCollection 	= new ArrayCollection()			// another array to hold sysNodes used for user navigation (e.g. SPARK not included)
		
		public var sysVarsImportedFromLongTermAC:ArrayCollection = new ArrayCollection()// holds group of SysVars that are imported from LongTerm into ShortTerm sim
		public var sysVarsImportedFromShortTermAC:ArrayCollection = new ArrayCollection()//holds group of SystVars that are imported form ShortTerm into LongTerm sim
		
		//CONFIGURE THIS TO CHANGE WHICH VARS ARE TO BE IMPORTED FROM LONG-TERM INTO SHORT-TERM
		//TODO: add SYSRmQSens to this list when we implement parameters			
		public var longTermVarsToImportArr:Array = [	"SYSTAirDB",
														"SYSRHOutside"]
		
														
		//CONFIGURE THIS TO CHANGE WHICH VARS ARE TO BE IMPORTED FROM SHORT-TERM INTO LONG-TERM
		public var shortTermVarsToImportArr:Array = [	"SYSTRmSPHeat",
														"SYSTRmSPCool",
											  			"SYSTSupS",
														"HCUA",
														"CCUA",
														"VAVMinFlwRatio",
														"VAVRhcQd" ]; 
		// OTHER CLASS PROPERTIES
			
		// values for short-term simulation
		public var currNode:String  					//node user is viewing
		public var currNodeIndex:Number = 0				//index of node user is viewing (index within sysNodesAC) 
		
		
		// meta-information for scenario externally loaded
		public var id:int 								//primary key ID of scenario
		public var scenID:String 						//Text-based ID for scenario
		public var name:String 
		public var shortDescription:String
		public var description:String
		public var goal:String							//as in didactic goal as described by Instructor
		public var thumbnailURL:String
		public var movieURL:String						//URL of a movie that explains a certain concept
		
		//dates 
		public var allowLongTermDateChange:Boolean = true
		public var allowRealTimeDateTimeChange:Boolean = true
		public var WDDStartDate:Date = new Date("01/21/2009 12:00:00 AM")
		public var WDDStopDate:Date = new Date("01/21/2009 11:59:59 PM")
		public var SDDStartDate:Date = new Date("08/21/2009 12:00:00 AM")
		public var SDDStopDate:Date = new Date("08/21/2009 11:59:59 PM")
	
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

		public var lookupArr:Array = [] 			//This makes finding system variables quicker after the first search through the nodes
		
		//Tells scenario model which long term simulation to import variables from into short-term sim (selected by user)
		//Values are LT_IMPORT_NONE, LongTermSimulationDataModel.RUN_1, or LongTermSimulationDataModel.RUN_2
		protected var _importLongTermVarsFromRun:String = LT_IMPORT_NONE
		
		protected var _floorOfInterest:uint = 1
		protected var _zoneOfInterest:uint = 1
		protected var _inputSysVarsArr:Array = []
		protected var _outputSysVarsArr:Array = []
		
		/////////////////////////////////////
		// CONSTRUCTOR FUNCTIONS
		/////////////////////////////////////
		
		public function ScenarioModel():void
		{			
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
		
		public function init():void
		{
			clearScenario()
		}
		
		public function resetAll():void
		{
			Logger.debug("resetAll().", this)
			clearScenario()	
		}
		
		public function clearScenario():void
		{
			//wipe out all info from ScenarioModel
			//TODO: need to call destroy() functions on node and sysvar objects
			Logger.debug("Clearing scenario()",this)
			sysVarsArr = []
			lookupArr = []
			_inputSysVarsArr = []
			_outputSysVarsArr = []
			
			sysNodesAC.removeAll()
			sysNodesForNavAC.removeAll()	
			sysVarsImportedFromLongTermAC.removeAll()
			sysVarsImportedFromShortTermAC.removeAll()
			
			if (shortTermSimulationModel)
			{
				shortTermSimulationModel.init()
			}
			if (longTermSimulationModel)
			{
				longTermSimulationModel.init()
			}
		}
		
		
		
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
		
		public function set importLongTermVarsFromRun(run:String):void
		{
			_importLongTermVarsFromRun = run
			//if the run is changed, make sure to import the correct values immediately if they're available
			importLongTermVars()
		}
		
		public function get importLongTermVarsFromRun():String
		{
			return _importLongTermVarsFromRun
		}
	
		
		public function getSysVar(sysVarName:String):SystemVariable
		{
			
			//first look in lookupArr to see if variable has quick reference
			if (lookupArr[sysVarName]!= null && lookupArr[sysVarName]!=undefined)
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
			return null
		}
			
			
		public function getInputSysVars():Array
		{
			if (_inputSysVarsArr.length!=0)
			{
				//TODO: only send input variables that have changed
				return _inputSysVarsArr
			}
			for each (var sysNode:SystemNodeModel in sysNodesAC)
			{
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{
					if (sysVar.ioType == SystemVariable.INPUT)
					{
						_inputSysVarsArr.push(sysVar)
					}
					
				}	
			}			
			_inputSysVarsArr.sortOn("index", Array.NUMERIC)
			return _inputSysVarsArr
		}
		
		public function getOutputSysVars():Array
		{
			if (_outputSysVarsArr.length!=0)
			{
				//TODO: only send input variables that have changed
				return _outputSysVarsArr
			}
			for each (var sysNode:SystemNodeModel in sysNodesAC)
			{
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{
					if (sysVar.ioType == SystemVariable.OUTPUT)
					{
						_outputSysVarsArr.push(sysVar)
					}
					
				}	
			}
			_outputSysVarsArr.sortOn("index", Array.NUMERIC)
			return _outputSysVarsArr
		}
			
	
		
		/* Function setValue
		*  Locates a system variable and sets current value to new value
		*/
		public function setSysVarValue(sysVarName:String, sysVarValue:Number, usingSIUnits:Boolean = false):void
		{
			var value:Number = Number(sysVarValue);
			if (isNaN(value))
			{
				Logger.warn("setSysVarValue() couldn't cast parameter " + sysVarValue + " to number")
				return	
			}
			
			//The first time a sysVariable is looked up, we'll add it to our
			//quick lookup table. We'll then use that lookup table for all future 
			//updates. 
			
			//use lookup if exists
			var sysVar:SystemVariable = lookupArr[sysVarName]
			if (sysVar!=null)
			{
				if (usingSIUnits)
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
				if (usingSIUnits)
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
					currNodeIndex = i
					nodeFound = true	
				}
			}
			if (!nodeFound)
			{
				Logger.warn("setCurrNode() was called with unrecognizeable nodeID: " + nodeID, this)
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
			
			var stepArr:Array = shortTermSimulationModel.stepArr
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
			if (importLongTermVarsFromRun==ScenarioModel.LT_IMPORT_NONE) return 
												
			var ePlusData:EnergyPlusData = longTermSimulationDataModel.getEnergyPlusData(importLongTermVarsFromRun)	
						
			if (ePlusData==null)
			{
				Logger.error("importLongTermVars() no ePlus data to import", this)
				return
			}
			
			var incomingLTvalues:LongTermValuesForShortTermSimVO  = ePlusData.getLongTermInputs(shortTermSimulationModel.currDateTime, _floorOfInterest, _zoneOfInterest)
						
			if (incomingLTvalues==null)
			{
				Logger.warn("shortTermInputsVO returned from ePlusData was null.", this)
				return
			}
			else
			{				
				//make sure to grab "base" values, which are SI units, from sparkInputs
								
				var rmQSensVar:SystemVariable = getSysVar("SYSRmQSens")
				rmQSensVar.baseSIValue = incomingLTvalues.getRmQSens("SI")
				rmQSensVar.localValue = rmQSensVar.currValue
					
				var tAirOut:SystemVariable = getSysVar("SYSTAirDB")
				tAirOut.baseSIValue = incomingLTvalues._tAirOut
				tAirOut.localValue = tAirOut.currValue	
				
				var rhOut:SystemVariable = getSysVar("SYSRHOutside")
				rhOut.baseSIValue = incomingLTvalues._rhOutside
				rhOut.localValue = rhOut.currValue	
					
						
			}
		}
		
		
		/* Sets up the ArrayColletion that holds variables that need to be imported from E+. This
		   is done after scenario is loaded */		  
		public function initLongTermImports():void
		{
			this.sysVarsImportedFromLongTermAC = new ArrayCollection()	
			for each (var name:String in longTermVarsToImportArr)
			{
				var sysVar:SystemVariable = getSysVar(name)
				if (sysVar)
				{
					sysVar.isImportedFromLongTermSimToShortTermSim = true
					sysVarsImportedFromLongTermAC.addItem(sysVar)
				}
				else
				{
					Logger.error("initLongTermImports() couldn't find sysVar for name:" + name,this)
				}
			}
		}
		
		public function initShortTermImports():void
		{
			this.sysVarsImportedFromShortTermAC = new ArrayCollection()
			for each (var name:String in shortTermVarsToImportArr)
			{
				var sysVar:SystemVariable = getSysVar(name)
				if (sysVar)
				{
					sysVar.isImportedFromShortTermSimToLongTermSim = true
					this.sysVarsImportedFromShortTermAC.addItem(sysVar)
				}
				else
				{
					Logger.error("initShortTermImports() Couldn't find sysVar: " + name + " to initialize",this)
				}
			}
		} 
		 	 			
		public function setRealTimeStartDate(d:Date):void
		{
			Logger.debug("setRealTimeStartDate()",this)
			this.shortTermSimulationModel.setRealTimeStartDate(d)
			importLongTermVars()
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
		
	
	
		public function traceSystemVariables():void
		{
			Logger.debug("**********************************",this)
			Logger.debug("Tracing system variables in model:",this)
			Logger.debug("**********************************",this)
			for each (var sysNode:SystemNodeModel in sysNodesAC)
			{
				Logger.debug("  NODE: " + sysNode.name + " ID: " + sysNode.id,this)
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{
					Logger.debug("      " + sysVar.name + " : " + sysVar.currValue,this)
				}
			}	
		}		
			
	}
}