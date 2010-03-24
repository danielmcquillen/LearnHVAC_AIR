package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.business.GraphManager;
	import com.mcquilleninteractive.learnhvac.vo.UserVO;
	
	import mx.collections.ArrayCollection;
	import flash.events.EventDispatcher
	import com.mcquilleninteractive.learnhvac.vo.ScenarioListItemVO;
	
	[Bindable]
	public class ApplicationModel extends EventDispatcher
	{
		public static const baseStoragePath:String = "Local Settings/Application Data/LearnHVAC/"
		
		// ATTRIBUTES FOR CONTROLLING TEST/MOCK MODE
		//This flag will cause certain functions to auto-submit (login)
		public static var testMode:Boolean = true
		//(e.g. existing E+ output is loaded rather than running simulation)		
		public static var mockEPlusData:Boolean = false
		
		// REGULAR CLASS ATTRIBUTES
		
		// available values for the main viewstack
		// defined as contants to help uncover errors at compile time instead of run time
		public static const PANEL_SELECT_SCENARIO : Number = 0
		public static const PANEL_LONG_TERM_SIMULATION : Number =	1
		public static const PANEL_SHORT_TERM_SIMULATION : Number =	2
		public static const PANEL_ANALYSIS : Number = 3
		
		
		public var viewing:uint = PANEL_SELECT_SCENARIO	
		public var isFirstStartup:Boolean = false				
		public var loggedIn: Boolean = false
		
				
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
		
		public var animationSpeed:String = ApplicationModel.ANIMATION_SPEED_FULL
		
		//flag for start units -- this is static to allow for quicker access
		public static var currUnits:String = ApplicationModel.UNITS_IP //always start with IP
		
		
		// CONSTANTS
		// .....................................................
		
		
		// FLAGS
		public static const UNITS_NONE : String = ""
		public static const UNITS_IP : String= "IP"
		public static const UNITS_SI : String = "SI"
		
		// Default units
		// Enable/disable localization
		public static var LOCALIZATION:Boolean = false
	
		//colors for charts	
		public static const chart1Var1Color:Number = 0x419f2e
		public static const chart1Var2Color:Number = 0xffb03b
		
		public static const chart2Var1Color:Number = 0x234ca5
		public static const chart2Var2Color:Number = 0xb64926
	
		
		
		public function ApplicationModel()
		{
		}
		
		public static function currentTempUnits():String
		{
			//convenience function for getting degrees F or degrees C text
			if (ApplicationModel.currUnits==ApplicationModel.UNITS_IP)
			{
				return "\u00B0F"
			}
			else
			{
				return "\u00B0C"
			}
		}
		
		
	}
	
}

