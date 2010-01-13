package com.mcquilleninteractive.learnhvac.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.mcquilleninteractive.learnhvac.business.GraphManager;
	import com.mcquilleninteractive.learnhvac.vo.UserVO;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class LHModelLocator implements ModelLocator 
	{
		private static var modelLocator:LHModelLocator
		
		// Use this to flag to run LH in test mode:
		// - reads in E+ files directly (doesn't do E+ calculations)
		// - skips login
		
		public var buildVersion:String = "1.0.1"
		public var isFirstStartup:Boolean = false
		
		public static var testMode:Boolean = false	

		public static function getInstance():LHModelLocator
		{
			if (modelLocator == null)
			{
				modelLocator = new LHModelLocator()
				modelLocator.scenarioModel = new ScenarioModel()
			}
			return modelLocator
						
		}
		
		public function LHModelLocator()
		{
			if (modelLocator != null)
			{
				throw new Error("Only one LHModelLocator instance should be instantiated")
			}			
		}
		
		public static function currentTempUnits():String
		{
			//convenience function for getting degrees F or degrees C text
			if (LHModelLocator.currUnits==LHModelLocator.UNITS_IP)
			{
				return "\u00B0F"
			}
			else
			{
				return "\u00B0C"
			}
		}
		
		
		// available values for the main viewstack
		// defined as contants to help uncover errors at compile time instead of run time
		public static const PANEL_SELECT_SCENARIO : Number = 0
		public static const PANEL_LONG_TERM_SIMULATION : Number =	1
		public static const PANEL_SHORT_TERM_SIMULATION : Number =	2
		public static const PANEL_ANALYSIS : Number = 3
				
		//Location of scenarios
		public static const SCENARIOS_LIST_LOCAL : String = "Scenario List : Local file system"
		public static const SCENARIOS_LIST_REMOTE : String = "Scenario List : Server"
		public static const SCENARIOS_LIST_DEFAULT : String= " Scenario List : Default"
		public var scenarioListLocation:String 
		
		// viewstack starts out on the login screen
		public var viewing : Number = PANEL_SELECT_SCENARIO
		
		// SUB MODELS
		public var scenarioModel : ScenarioModel 
		public var user : UserVO
		public var currScenarioList:ArrayCollection; // from either server or local
		public var graphManager:GraphManager
		public var defaultScenarioList : DefaultScenariosModel 
		
		// SERVER INFO
		public var serverList:ArrayCollection
		public var instructorSiteURL:String = "http://client.learnhvac.org/weborb"
		
		// PROXY PORT
		public var proxyPort:String
		
		// FLAGS and such
		public var scenarioLoaded:Boolean = false 
		public var loggedInAsGuest:Boolean = false
		public var simBtnEnabled:Boolean = false
		public var bldgSetupEnabled:Boolean = false
		public var showFramesPerSecondBar:Boolean = false
		public var debug:Boolean = false
		public var logToFile:Boolean = false
		
		// Vars for managing communication with SPARK
		public static var ANIMATION_SPEED_FULL:String = "full"
		public static var ANIMATION_SPEED_REDUCED:String = "reduced"
		public static var ANIMATION_SPEED_NONE:String = "none"
		
		public var sparkStartupDelay:Number = 20
		public var sparkIntervalDelay:Number = .9
		public var sparkMaxReadsPerStep:Number = 30 //number of times SparkService will read same step increment before assuming SPARK is dead
		public var animationSpeed:String = LHModelLocator.ANIMATION_SPEED_FULL
		
		//flag for start units -- this is static to allow for quicker access
		public static var currUnits:String = LHModelLocator.UNITS_IP //always start with IP
		
		
		// CONSTANTS
		// .....................................................
		
		
		// FLAGS
		public static const UNITS_NONE : String = ""
		public static const UNITS_IP : String= "IP"
		public static const UNITS_SI : String = "SI"
		
		//Roles
		public static var ROLE_GUEST:Number = 0
		public static var ROLE_STUDENT:Number = 1
		public static var ROLE_TEACHER:Number = 2
		public static var ROLE_ADMINISTRATOR:Number = 3
		
		// Default units
		// Enable/disable localization
		public static var LOCALIZATION:Boolean = false
	
		//colors for charts	
		public static const chart1Var1Color:Number = 0x419f2e
		public static const chart1Var2Color:Number = 0xffb03b
		
		public static const chart2Var1Color:Number = 0x234ca5
		public static const chart2Var2Color:Number = 0xb64926
	
		
		
		
	}
	
}

