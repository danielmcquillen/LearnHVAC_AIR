// ActionScript file


package com.mcquilleninteractive.particleengine
{
	
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.ShortTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.ColorSetting;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.core.UIComponent;
	
	import org.swizframework.Swiz;
	
	
	public class ParticleEngine extends UIComponent
	{
		public var currScene:String = ScenarioModel.SN_ROOF //simulation view always starts with roof
		public var timer:Timer
		public var count:Number
				
		//Make accessing constants a little more convenient
		public var SN_HC:String = ScenarioModel.SN_HC
		public var SN_CC:String =  ScenarioModel.SN_CC
		public var SN_FAN:String =  ScenarioModel.SN_FAN
		public var SN_FILTER:String =  ScenarioModel.SN_FILTER
		public var SN_MIXINGBOX:String = ScenarioModel.SN_MIXINGBOX 
		public var SN_VAV:String = ScenarioModel.SN_VAV
		public var SN_DIFFUSER:String = ScenarioModel.SN_DIFFUSER
		public var SN_ROOF:String	= ScenarioModel.SN_ROOF
		public var SN_BOILER:String	= ScenarioModel.SN_BOILER
		public var SN_CHILLER:String	= ScenarioModel.SN_CHILLER
		public var SN_COOLINGTOWER:String	= ScenarioModel.SN_COOLINGTOWER
		public var SN_SYSTEM:String = ScenarioModel.SN_SYSTEM
		public var SN_PLANT:String = ScenarioModel.SN_PLANT
		
		public var sysNode:String
		public var running:Boolean
		public var DISABLED_PE:Boolean = false; //set by admin panel 
		
		public var birthPace:Number
		public var particleMax:Number
		public var sysVarsArr:Array
		
		public var OABornProbability:Number
		public var bornProbability:Number
		
		public var particleMax_SYS:Number
		public var particleBirth_SYS:Number
		public var particleMax_MX:Number
		public var particleBirth_MX:Number
		public var particleMax_FAN:Number
		public var particleMax_DIF:Number
		public var particleBirth_DIF:Number
		public var particleMax_DEFAULT:Number
		public var particleBirth_DEFAULT:Number
		
		public var particleSize:Number = 20 
		public var particleAlive:Number = 0 
		public var iTimeS:Number = 1
		public var bColorChange:Boolean = true
		public var bSizeChange:Boolean  = true
		
		public var goalProbability:Array
		
		public var SYSgoalColorR:Array
		public var SYSgoalColorG:Array
		public var SYSgoalColorB:Array	
		
		public var HCgoalColorR:Array
		public var HCgoalColorG:Array
		public var HCgoalColorB:Array
			
		public var CCgoalColorR:Array
		public var CCgoalColorG:Array
		public var CCgoalColorB:Array
			
		public var FLTgoalColorR:Array
		public var FLTgoalColorG:Array
		public var FLTgoalColorB:Array
			
		public var MXgoalColorR:Array
		public var MXgoalColorG:Array
		public var MXgoalColorB:Array
			
		public var FANgoalColorR:Array
		public var FANgoalColorG:Array
		public var FANgoalColorB:Array
			
		public var DIFgoalColorR:Array
		public var DIFgoalColorG:Array
		public var DIFgoalColorB:Array
			
		public var VAVgoalColorR:Array
		public var VAVgoalColorG:Array
		public var VAVgoalColorB:Array
					
		public var returnProb:Number
		public var bornHeadGoal:Number
		public var bornTailGoal:Number
		public var iSize:Number	
		public var rGGrav:Number
		public var exhaustProb:Number
		public var goalHead:Array = new Array(15)
		public var goalTail:Array= new Array(15)
		public var goalPositionX:Array= new Array(15)
		public var goalPositionY:Array= new Array(15)
		public var goalFuzzyRadius:Array= new Array(15)
		public var goalNearRadius:Array= new Array(15)
		public var goalDriftStep:Array= new Array(15)
		public var goalTimeSlice:Array= new Array(15)
		public var goalGravity:Array= new Array(15)
		public var goalAlpha:Array= new Array(15)
		public var goalAlphaStep:Array= new Array(15)
		public var goalDecay:Array= new Array(15)
		public var goalColorR:Array= new Array(15)
		public var goalColorG:Array= new Array(15)
		public var goalColorB:Array= new Array(15)
		public var dieOnThisStep:Array= new Array(15)
		public var goalColorStep:Array= new Array(15)
		public var goalSize:Array= new Array(15)
		public var goalSizeStep:Array= new Array(15)
		
		private var cwArr:Array = []
		
		private var currSysVarValuesArr:Array 
		private var particleManager:ParticleManager
		
		private var _scenarioModel:ScenarioModel
		
		public function ParticleEngine():void
		{
			cacheAsBitmap = true
			
			//setup particle manager
			particleManager = ParticleManager.getInstance()
			particleManager.init(this)
						
			//setup timers
			timer = new Timer(50)
			timer.addEventListener("timer", onTimer)
		
			_scenarioModel = Swiz.getBean("scenarioModel") as ScenarioModel
		}
		
				
		public function setScene(systemNode:String):void
		{
			var restart:Boolean = false
			if (running)
			{
				stopPE()
				restart = true
			}
			initScene(systemNode)
			sysNode = systemNode
			if (restart)
			{
				startPE()
			}
			
			// TODO: for some obscure reason, MX doesn't show correct MXTAirRet when first 
			//       going to MX node, so update manually here
			if (systemNode==ScenarioModel.SN_MIXINGBOX)
			{
				var mxTAirRet:SystemVariable = _scenarioModel.getSysVar("MXTAirRet")
				if (mxTAirRet)
				{					
					setMXTAirRet(mxTAirRet.currValue)
				}
				else
				{
					Logger.error("Couldn't find MXTAirTRet system variable",this)
				}
			}
			
		}
		
		public function startPE():void
		{
			Logger.debug("#PE: startPE() current node: " + sysNode)
			
			//TODO: implement different air animations speeds...until then, just turn on or off 
			// depending on user settings
			var applicationModel:ApplicationModel = Swiz.getBean("applicationModel") as ApplicationModel
			if (DISABLED_PE || applicationModel.animationSpeed==ApplicationModel.ANIMATION_SPEED_NONE)
			{
				return
			} 
			
			running=true
			count = 0
			
			//Don't show anything if user is on one of the nodes that don't have animation
			if (sysNode==SN_ROOF || 
				sysNode==SN_CHILLER || 
				sysNode==SN_BOILER || 
				sysNode==SN_COOLINGTOWER ||
				sysNode==SN_PLANT) return
				
			this.visible = true
			timer.start()
			
			//manually call set functions to make sure initial colors are correct
			try
			{
				setHCTAirEnt(_scenarioModel.getSysVar("HCTAirEnt").currValue)
				setHCTAirLvg(_scenarioModel.getSysVar("HCTAirLvg").currValue)
				setCCTAirEnt(_scenarioModel.getSysVar("CCTAirEnt").currValue)
				setCCTAirLvg(_scenarioModel.getSysVar("CCTAirLvg").currValue)
				setFANTAirEnt(_scenarioModel.getSysVar("FANTAirEnt").currValue)
				setFANTAirLvg(_scenarioModel.getSysVar("FANTAirLvg").currValue)
				setMXRtnDampPos(_scenarioModel.getSysVar("MXRtnDampPos").currValue / 100)
				setVAVDampPos(_scenarioModel.getSysVar("VAVDampPos").currValue / 100)				
				setMXTAirRet(_scenarioModel.getSysVar("MXTAirRet").currValue)
				setSYSTAirDB(_scenarioModel.getSysVar("SYSTAirDB").currValue)
				setMXTAirMix(_scenarioModel.getSysVar("MXTAirMix").currValue)
				setVAVTAirEnt(_scenarioModel.getSysVar("VAVTAirEnt").currValue)
				setVAVTAirLvg(_scenarioModel.getSysVar("VAVTAirLvg").currValue)
				setVAVTAirLvg(_scenarioModel.getSysVar("VAVTAirLvg").currValue)
				setRMTemp(_scenarioModel.getSysVar("RMTemp").currValue)
				setSYSTAirDB(_scenarioModel.getSysVar("SYSTAirDB").currValue)
			}
			catch(e:Error)
			{
				Logger.debug("#PE: error trying to get initial currValues from _scenarioModel: "  + e.message)
			}
		}
		
		public function stopPE():void
		{
			Logger.debug("#PE: stopPE()") 
			stopAnim() 
			running = false
			visible = false
			count = 0		
		}
		
				
		public function onTimer(event:TimerEvent):void
		{
			animate()
		}

			
		//TEMP function name is setParticleEngine
		public function spe(evt:Object):void
		{
			if (evt.setting == "full" || evt.setting=="reduced"){
				if (evt.setting=="full")
				{
					particleMax_SYS = 170
					particleBirth_SYS = 10
					particleMax_MX =120
					particleBirth_MX = 2
					particleMax_FAN = 120
					particleMax_DIF = 70
					particleBirth_DIF = 2
					particleMax_DEFAULT = 50
					particleBirth_DEFAULT = 1
					DISABLED_PE = false
				}
				else
				{
					particleMax_SYS = 90
					particleBirth_SYS = 20
					particleMax_MX =60
					particleBirth_MX = 5
					particleMax_FAN = 60
					particleMax_DIF = 35
					particleBirth_DIF = 5
					particleMax_DEFAULT = 25
					particleBirth_DEFAULT = 5
					DISABLED_PE = false
				}
			}
			
			switch(sysNode)
			{
				case SN_SYSTEM:
					birthPace = particleBirth_SYS
					particleMax = particleMax_SYS
					break
				case SN_MIXINGBOX:
					birthPace = particleBirth_MX
					particleMax = particleMax_MX
				case SN_FAN:
					birthPace = particleBirth_DEFAULT
					particleMax = particleMax_MX
					break
				case SN_DIFFUSER:
					birthPace = particleBirth_DIF
					particleMax = particleMax_DIF
					break
				default:
					birthPace = particleBirth_DEFAULT
					particleMax = particleMax_DEFAULT
			}
			
			if (running==false && evt.currAHUStatus == ShortTermSimulationModel.STATE_RUNNING)
			{
				startPE()
			}
			else
			{
				//assume "none"
				stopPE()
			}
		}
		
		
		
		public function initPE():void
		{
			Logger.debug("#PE: initPE()")
			currSysVarValuesArr = []	
			sysVarsArr=[]
			
			//clear any existing binding
			while (cwArr.length>0)
			{
				ChangeWatcher(cwArr.pop()).unwatch()
			}
		
			//setup binding
			
			Swiz.addEventListener(ShortTermSimulationEvent.SIM_OUTPUT_RECEIVED, onUpdateOuputValues)
			
			Logger.debug("#PE: initPE() _scenarioModel: " + _scenarioModel)
	
			running = false
			sysVarsArr = []
	
			//particle max settings
			particleMax_SYS = 170
			particleBirth_SYS = 10
			particleMax_MX = 120
			particleBirth_MX = 2
			particleMax_FAN = 120
			particleMax_DIF = 70
			particleBirth_DIF = 2
			particleMax_DEFAULT = 50
			particleBirth_DEFAULT = 1
			DISABLED_PE = false
			
			//init variables
			count = 0
			
			initColors()
			initSysVars()
			
			sysNode = SN_HC //by convention, we just set to HC to start
			
		}
		
		public function onUpdateOuputValues(event:ShortTermSimulationEvent):void
		{
			
			try
			{
				setHCTAirEnt(_scenarioModel.getSysVar("HCTAirEnt").currValue)		
				setHCTAirLvg(_scenarioModel.getSysVar("HCTAirLvg").currValue)
				setCCTAirEnt(_scenarioModel.getSysVar("CCTAirEnt").currValue)
				setCCTAirLvg(_scenarioModel.getSysVar("CCTAirLvg").currValue)
				setFANTAirEnt(_scenarioModel.getSysVar("FANTAirEnt").currValue)
				setFANTAirLvg(_scenarioModel.getSysVar("FANTAirLvg").currValue)
				setMXRtnDampPos(_scenarioModel.getSysVar("MXRtnDampPos").currValue / 100)
				setVAVDampPos(_scenarioModel.getSysVar("VAVDampPos").currValue / 100)			
				setMXTAirRet(_scenarioModel.getSysVar("MXTAirRet").currValue)
				setSYSTAirDB(_scenarioModel.getSysVar("SYSTAirDB").currValue)
				setMXTAirMix(_scenarioModel.getSysVar("MXTAirMix").currValue)
				setVAVTAirEnt(_scenarioModel.getSysVar("VAVTAirEnt").currValue)
				setVAVTAirLvg(_scenarioModel.getSysVar("VAVTAirLvg").currValue)
				setRMTemp(_scenarioModel.getSysVar("RMTemp").currValue)
				setSYSTAirDB(_scenarioModel.getSysVar("SYSTAirDB").currValue)
			}
			catch(error:Error)
			{
				Logger.error("Had trouble locating at least one variable during updateValue()",this)
			}

			
		}
		
		/////////////////////
		// INTERNAL FUNCTIONS
		/////////////////////
		
		private function stopAnim():void
		{
			Logger.debug("#PE: stopAnim() called")
			timer.stop()
			particleManager.removeAllParticles()
		}
		
		
		//Setup initial goal color arrays
		private function initColors():void
		{
		
			Logger.debug("#PE:initColors()")
			SYSgoalColorR = new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
			SYSgoalColorG = new Array(100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100);
			SYSgoalColorB = new Array(41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41, 41);
			
			HCgoalColorR = new Array(100, 100, 255, 255, 255, 255, 255, 255);
			HCgoalColorG = new Array(100, 100, 100, 100, 150, 150, 150, 150);
			HCgoalColorB = new Array(255, 255, 100, 100, 150, 150, 150, 150);
			
			CCgoalColorR = new Array(255, 100, 100, 100, 255, 255, 255, 255);
			CCgoalColorG = new Array(100, 100, 100, 100, 150, 150, 150, 150);
			CCgoalColorB = new Array(255, 255, 255, 255, 150, 150, 150, 150);
			
			FLTgoalColorR = new Array(255, 255, 255, 255, 255, 255, 255, 255);
			FLTgoalColorG = new Array(100, 100, 100, 100, 100, 100, 100, 100);
			FLTgoalColorB = new Array(100, 100, 100, 100, 100, 100, 100, 100);
			
			MXgoalColorR = new Array(42, 42, 42, 42, 42, 42, 42, 42, 42, 42);
			MXgoalColorG = new Array(200, 200, 200, 200, 200, 200, 200, 200, 200, 200);
			MXgoalColorB = new Array(230, 230, 230, 230, 230, 230, 230, 230, 230, 230);
			
			FANgoalColorR = new Array(255, 255, 255, 255, 255, 255, 255, 255);
			FANgoalColorG = new Array(150, 150, 150, 150, 150, 150, 150, 150);
			FANgoalColorB = new Array(150, 150, 150, 150, 150, 150, 150, 150);
			
			DIFgoalColorR = new Array(0, 0, 0, 0, 0, 0, 0, 0);
			DIFgoalColorG = new Array(0, 0, 0, 0, 0, 0, 0, 0);
			DIFgoalColorB = new Array(0, 0, 0, 0, 0, 0, 0, 0);
			
			VAVgoalColorR = new Array(25, 25, 25, 25, 25, 25, 25);
			VAVgoalColorG = new Array(100, 100, 100, 100, 100, 100, 100);
			VAVgoalColorB = new Array(255, 255, 255, 255, 255, 255, 255);
		
		}

		
		private function initSysVars():void
		{
			//init array that holds current values
			//this array allows us to skip updates if there's no change in value
			currSysVarValuesArr = []
			currSysVarValuesArr["HCTAirEnt"] = -999
			currSysVarValuesArr["HCTAirLvg"] = -999
			currSysVarValuesArr["CCTAirEnt"] = -999
			currSysVarValuesArr["CCTAirLvg"] = -999
			currSysVarValuesArr["FANTAirEnt"] = -999
			currSysVarValuesArr["FANTAirLvg"] = -999
			currSysVarValuesArr["MXRtnDampPos"] = -999
			currSysVarValuesArr["MXTAirRet"] = -999
			currSysVarValuesArr["VAVTAirEnt"] = -999
			currSysVarValuesArr["VAVTAirLvg"] = -999
			currSysVarValuesArr["VAVDampPos"] = -999
			currSysVarValuesArr["RMTemp"] = -999
			currSysVarValuesArr["SYSTAirDB"] = -999
			
			//Setup default values for variables
			var sn:String = sysNode //keep ahold of curr sysNode since we need to manipulate it to set all the values correctly
			var colorObj:ColorTransform 
			
			// When init'ing the sysVars we have to init each scene before setting the sysvar values
			// This is because the main arrays  that describe particle behavior (like goalColorR)
			// are linked to sysNode specific arrays when the scene is changed. 
			// (e.g. goalColorR is assinged to HCgoalColorR when the scene is init'ed)
			
			// 
			
			//HC
			sysNode = SN_HC
			initScene(SN_HC)
			setHCTAirEnt(10)
			setHCTAirLvg(35)
			
			//CC
			sysNode = SN_CC
			initScene(SN_CC)
			setCCTAirEnt(35)
			setCCTAirLvg(-30)
			
			//FAN
			sysNode = SN_FAN
			initScene(SN_FAN)
			setFANTAirEnt(-30)
			setFANTAirLvg(-30)
			
			//MX
			sysNode = SN_MIXINGBOX
			initScene(SN_MIXINGBOX)
			setMXRtnDampPos(.9)
			setMXTAirRet(40)
			setSYSTAirDB(10)
			setMXTAirMix(30)
			
			//VAV
			sysNode = SN_VAV
			initScene(SN_VAV)
			setVAVTAirEnt(25)
			setVAVTAirLvg(45)
			setVAVDampPos(0)
			
			//SYSTEM
			sysNode = SN_SYSTEM
			initScene(SN_SYSTEM)
			setRMTemp(35)
			setSYSTAirDB(20)
		}
		
				
		// setters for sysVars used by PE
		// these are bound to sysVars within VizPanel
		// TODO: Must be a better way to do this
		public function setHCTAirEnt(sysVarValue:Number):void
		{
			if (sysVarValue==currSysVarValuesArr["HCTAirEnt"]) return
			
			var ct:ColorTransform = getColorObject("HCTAirEnt", sysVarValue)
			sysVarsArr["HCTAirEnt"] = ct
			
			if (sysNode == SN_HC || sysNode == SN_FILTER)
			{
				HCgoalColorR[0] = ct.redOffset
				HCgoalColorG[0] = ct.greenOffset
				HCgoalColorB[0] = ct.blueOffset
						
				//set the temp for the filter here to as it will be the same value
				for (var i:Number=0; i<4;i++)
				{
					FLTgoalColorR[i] = ct.redOffset
				    FLTgoalColorG[i] = ct.greenOffset
					FLTgoalColorB[i] = ct.blueOffset			
				}
			}	
		}
		
		public function setHCTAirLvg(sysVarValue:Number):void
		{

			if (sysVarValue==currSysVarValuesArr["HCTAirLvg"]) return
			
			var ct:ColorTransform = getColorObject("HCTAirLvg", sysVarValue)
			sysVarsArr["HCTAirLvg"] = ct
			
			if (sysNode == SN_HC || sysNode == SN_SYSTEM)
			{
				HCgoalColorR[1] = ct.redOffset
				HCgoalColorG[1] = ct.greenOffset
				HCgoalColorB[1] = ct.blueOffset
						
				//system view
				SYSgoalColorR[3] = ct.redOffset
				SYSgoalColorG[3] = ct.greenOffset
				SYSgoalColorB[3] = ct.blueOffset		
			}	
		}
		
		public function setCCTAirEnt(sysVarValue:Number):void
		{
			if (sysVarValue==currSysVarValuesArr["CCTAirEnt"]) return
			
			var ct:ColorTransform = getColorObject("CCTAirEnt",sysVarValue)
			sysVarsArr["CCTAirEnt"] = ct
			
			if (sysNode==SN_CC)
			{
				//change first half of CC
				CCgoalColorR[0] = ct.redOffset
				CCgoalColorG[0] = ct.greenOffset
				CCgoalColorB[0] = ct.blueOffset
			}	
		}
		
		public function setCCTAirLvg(sysVarValue:Number):void
		{
			if (sysVarValue==currSysVarValuesArr["CCTAirLvg"]) return
			
			var ct:ColorTransform = getColorObject("CCTAirLvg",sysVarValue)
			
			sysVarsArr["CCTAirLvg"] = ct
			
			if (sysNode == SN_CC || sysNode == SN_SYSTEM)
			{
				//change second half of CC
				CCgoalColorR[1] = ct.redOffset
				CCgoalColorG[1] = ct.greenOffset
				CCgoalColorB[1] = ct.blueOffset	
					
				//system view
				SYSgoalColorR[4] = ct.redOffset
				SYSgoalColorG[4] = ct.greenOffset
				SYSgoalColorB[4] = ct.blueOffset	
			}
		}
		
		public function setFANTAirEnt(sysVarValue:Number):void
		{
			if (sysVarValue==currSysVarValuesArr["FANTAirEnt"]) return
			
			var ct:ColorTransform = getColorObject("FANTAirEnt",sysVarValue)
			sysVarsArr["FANTAirEnt"] = ct
				
			if (sysNode == SN_FAN)
			{
				for (var i:Number=0;i<5;i++)
				{
					FANgoalColorR[i] = ct.redOffset
					FANgoalColorG[i] = ct.greenOffset
					FANgoalColorB[i] = ct.blueOffset
				}
			}
		}
		
		public function setFANTAirLvg(sysVarValue:Number):void
		{
			if (sysVarValue==currSysVarValuesArr["FANTAirLvg"]) return
			
			var ct:ColorTransform = getColorObject("FANTAirLvg",sysVarValue)
			sysVarsArr["FANTAirLvg"] = ct
			
			if (sysNode == SN_FAN || sysNode == SN_SYSTEM)
			{
				FANgoalColorR[5] = ct.redOffset
				FANgoalColorG[5] = ct.greenOffset
				FANgoalColorB[5] = ct.blueOffset
				for (var i:Number=5;i<=7;i++)
				{
					SYSgoalColorR[i] = ct.redOffset
					SYSgoalColorG[i] = ct.greenOffset
					SYSgoalColorB[i] = ct.blueOffset	
				}
			}	
		}
		
		public function setMXRtnDampPos(sysVarValue:Number):void
		{
			Logger.debug("setting setMXRtnDampPos to : " +sysVarValue,this)
			// Both Mixing Box and System View
			OABornProbability = 1 - sysVarValue
			bornProbability = sysVarValue
			Logger.debug("OABornProbability: " +OABornProbability,this)
			Logger.debug("bornProbability: " + bornProbability,this)
			
			if (sysNode == SN_MIXINGBOX)
			{
				//Mixing box
				goalProbability[1] = sysVarValue
			}	
			else if (sysNode == SN_SYSTEM)
			{				
				//System view
				goalProbability[13] = sysVarValue
			}
		}
		
		public function setMXTAirRet(sysVarValue:Number):void
		{
			if (sysVarValue==currSysVarValuesArr["MXTAirRet"]) return
			
			var ct:ColorTransform = getColorObject("MXTAirRet",sysVarValue)
			sysVarsArr["MXTAirRet"] = ct
			
			if (sysNode == SN_MIXINGBOX)
			{
				//change first third of CC
				for (var i:Number=0;i<2;i++)
				{
					MXgoalColorR[i] = ct.redOffset
					MXgoalColorG[i] = ct.greenOffset
					MXgoalColorB[i] = ct.blueOffset
				}
				MXgoalColorR[2] = ct.redOffset
				MXgoalColorG[2] = ct.greenOffset
				MXgoalColorB[2] = ct.blueOffset
						
				MXgoalColorR[9] = ct.redOffset
				MXgoalColorG[9] = ct.greenOffset
				MXgoalColorB[9] = ct.blueOffset
			}	
		}
		public function setSYSTAirDB(sysVarValue:Number):void
		{
			
			if (sysVarValue==currSysVarValuesArr["SYSTAirDB"]) return
			
			var ct:ColorTransform = getColorObject("SYSTAirDB",sysVarValue)
			sysVarsArr["SYSTAirDB"] = ct
			
			if (sysNode == SN_MIXINGBOX)
			{
				//change second third of CC
				MXgoalColorR[4] = ct.redOffset
				MXgoalColorG[4] = ct.greenOffset
				MXgoalColorB[4] = ct.blueOffset
			}
			else if (sysNode == SN_SYSTEM)
			{
				//system view
				SYSgoalColorR[0] = ct.redOffset
				SYSgoalColorG[0] = ct.greenOffset
				SYSgoalColorB[0] = ct.blueOffset		
			}
		}
		
				
		
		public function setMXTAirMix(sysVarValue:Number):void
		{
			
			if (sysVarValue==currSysVarValuesArr["MXTAirMix"]) return
			
			var ct:ColorTransform = getColorObject("MXTAirMix",sysVarValue)
			sysVarsArr["MXTAirMix"] = ct
			
			
			if (sysNode == SN_MIXINGBOX || sysNode == SN_SYSTEM)
			{
				//change final third of CC
				MXgoalColorR[3] = ct.redOffset
				MXgoalColorG[3] = ct.greenOffset
				MXgoalColorB[3] = ct.blueOffset
				MXgoalColorR[5] = ct.redOffset
				MXgoalColorG[5] = ct.greenOffset
				MXgoalColorB[5] = ct.blueOffset
				MXgoalColorR[6] = ct.redOffset
				MXgoalColorG[6] = ct.greenOffset
				MXgoalColorB[6] = ct.blueOffset
						
				//set color for system level view
				SYSgoalColorR[2] = ct.redOffset
				SYSgoalColorG[2] = ct.greenOffset
				SYSgoalColorB[2] = ct.blueOffset		
			}	
		}
		public function setVAVTAirEnt(sysVarValue:Number):void
		{
			
			if (sysVarValue==currSysVarValuesArr["VAVTAirEnt"]) return
			
			var ct:ColorTransform = getColorObject("VAVTAirEnt",sysVarValue)
			sysVarsArr["VAVTAirEnt"] = ct
			
			if (sysNode == SN_VAV)
			{
				for (var i:Number = 0; i<=6; i++)
				{
					if (i==2 || i ==3) continue
					VAVgoalColorR[i] = ct.redOffset
					VAVgoalColorG[i] = ct.greenOffset
					VAVgoalColorB[i] = ct.blueOffset
				}
			}	
		}
		public function setVAVTAirLvg(sysVarValue:Number):void
		{
			
			if (sysVarValue==currSysVarValuesArr["VAVTAirLvg"]) return
			
			var ct:ColorTransform = getColorObject("VAVTAirLvg",sysVarValue)
			sysVarsArr["VAVTAirLvg"] = ct
			
			if (sysNode == SN_VAV || sysNode == SN_DIFFUSER || sysNode == SN_SYSTEM)
			{
				VAVgoalColorR[2] = ct.redOffset
				VAVgoalColorG[2] = ct.greenOffset
				VAVgoalColorB[2] = ct.blueOffset
						
				VAVgoalColorR[3] = ct.redOffset
				VAVgoalColorG[3] = ct.greenOffset
				VAVgoalColorB[3] = ct.blueOffset
						
				//system view
				for (var i:Number=8; i<10;i++)
				{
					SYSgoalColorR[i] = ct.redOffset
					SYSgoalColorG[i] = ct.greenOffset
					SYSgoalColorB[i] = ct.blueOffset		
				}
					
				//diffuser view
				DIFgoalColorR[0] = DIFgoalColorR[1] = ct.redOffset
				DIFgoalColorG[0] = DIFgoalColorG[1] = ct.greenOffset
				DIFgoalColorB[0] = DIFgoalColorB[1] = ct.blueOffset	
			}
		}
		
		public function setVAVDampPos(sysVarValue:Number):void
		{
			if (sysNode == SN_VAV)
			{
				if (sysVarValue>=0 && sysVarValue<=1)
				{			
					goalProbability[1] = sysVarValue
				}
			}	
		}
		
		public function setRMTemp(sysVarValue:Number):void
		{
			if (sysVarValue==currSysVarValuesArr["RMTemp"]) return
			
			var ct:ColorTransform = getColorObject("RMTemp",sysVarValue)
			sysVarsArr["RMTemp"] = ct
			
			if (sysNode == SN_DIFFUSER || sysNode == SN_SYSTEM)
			{
				//system view
				SYSgoalColorR[1] = ct.redOffset
				SYSgoalColorG[1] = ct.greenOffset
				SYSgoalColorB[1] = ct.blueOffset		
			
				for (var i:Number=10;i<15;i++)
				{
					SYSgoalColorR[i] = ct.redOffset
					SYSgoalColorG[i] = ct.greenOffset
					SYSgoalColorB[i] = ct.blueOffset		
				}
						
				//diffuser view
				DIFgoalColorR[2] = ct.redOffset
				DIFgoalColorG[2] = ct.greenOffset
				DIFgoalColorB[2] = ct.blueOffset		
						
				DIFgoalColorR[4] = ct.redOffset
				DIFgoalColorG[4] = ct.greenOffset
				DIFgoalColorB[4] = ct.blueOffset		
			}	
		}
		
		
		
	
		
			
		
		/**********************************************************
		   This function is responsible for coloring the particles
		   based on current value of system variables.
		   Change the code below to change the color ranges
		***********************************************************/
		
		private function getColorObject(sysVarName:String, p_temp:Number):ColorTransform
		{
			
			// passing in sysVarName but not using it yet. May use if we need
			// to create different color schemes for air and water.
			
			var cf:ColorTransform =  ColorSetting.getTemperatureColor(p_temp, ApplicationModel.currUnits)
			return cf
		
		}
				
				
		public function initScene(sysNode:String):void
		{
			count = 0
			particleAlive = 0 
			iTimeS = 1
			bColorChange = true
			bSizeChange  = true
				
			switch(sysNode){
				
				case SN_SYSTEM:
					
					bornProbability = OABornProbability
					returnProb = 1 - OABornProbability
					bornHeadGoal = 0;
					bornTailGoal = 1;
					iSize = 5
					rGGrav = 1.7
					birthPace = particleBirth_SYS 
					particleMax = particleMax_SYS
					
					goalProbability = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, returnProb, 1, 1);
					goalHead = new Array(2, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 2, 0, 0);
					goalTail = new Array(2, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
					goalPositionX = new Array(270, 160, 275, 362, 413, 575, 600, 600, 525, 450, 420, 300, 275, 165, 165, -10);
					goalPositionY = new Array(10, 120, 120, 120, 120, 120, 150, 220, 220, 220, 350, 350, 225, 225, 125, 125);
					goalFuzzyRadius = new Array(15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15);
					goalNearRadius = new Array(5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5);
					goalDriftStep = new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
					goalTimeSlice = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 );
					goalGravity = new Array(rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav);
					goalAlpha = new Array(.7, .7, .7, .7, .7, .7, .7, .7, .7, .7, .7, .7, .7, .7, .7, .7, .7);
					goalAlphaStep = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 );
					goalDecay = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					goalColorR = SYSgoalColorR 
					goalColorG = SYSgoalColorG
					goalColorB = SYSgoalColorB
					dieOnThisStep = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1);
					goalColorStep = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 );
					goalSize = new Array(iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize);
					goalSizeStep = new Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2);
					
					break
				
				case SN_MIXINGBOX:
				
					bornHeadGoal = 0;
					bornTailGoal = 4;
					bornProbability = OABornProbability
					exhaustProb = OABornProbability
					iSize = 11
					rGGrav = 1.15
					birthPace = particleBirth_MX
					particleMax =  particleMax_MX
					
					goalProbability = new Array(1, exhaustProb, 1, 1, 1, 1, 1, 1, 1, 1);
					goalHead = new Array(1, 2, x, x, x, x, x, x, x, x)
					goalTail = new Array(1, 3, 6, 7, 5, 6, 7, 8, 9, 0)
					goalPositionX = new Array(285, 290, -50, 490, 492, 495, 595, 740, 740, 320);
					goalPositionY = new Array(530, 330, 290, 297, 10, 280, 285, 285, 550, 550);
					goalFuzzyRadius = new Array(10, 36, 30, 30, 5, 36, 30, 10, 10, 10);
					goalNearRadius = new Array(25, 36, 30, 30, 5, 36, 30, 25, 25, 25);
					goalDriftStep = new Array(10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
					goalTimeSlice = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
					goalGravity = new Array(rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav);
					goalAlpha = new Array(.7, .7, .7, .7, .7, .7, .7, .7, .7, .7);
					goalAlphaStep = new Array(1,1,1,1,1,1,1,1,1,1);
					goalDecay = new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
					goalColorR = MXgoalColorR
					goalColorG = MXgoalColorG
					goalColorB = MXgoalColorB
					dieOnThisStep = new Array(0, 0, 1, 0, 0, 0, 0, 0, 0, 0);
					goalColorStep = new Array(1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
					goalSize = new Array(iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize);
					goalSizeStep = new Array(2, 2, 50, 2, 2, 2, 2, 2, 2, 2);
					
					
					break
							
				case SN_HC:
					
					bornProbability = 1;
					bornHeadGoal = 0;
					bornTailGoal = 0;
					iSize = 15
					rGGrav = 1.15
					birthPace = particleBirth_DEFAULT
					particleMax =  particleMax_DEFAULT
					
					goalProbability = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalHead = new Array(1, 2, 3, 0, 0, 0, 0, 0);
					goalTail = new Array(1, 2, 3, 0, 0, 0, 0, 0);
					goalPositionX = new Array(-50, 360, 730, 0, 0, 0, 0, 0);
					goalPositionY = new Array(75, 110, 185, 0, 0, 0, 0, 0);
					goalFuzzyRadius = new Array(70, 70, 70, 0, 0, 0, 0, 0);
					goalNearRadius = new Array(70, 70, 70, 0, 0, 0, 0, 0);
					goalDriftStep = new Array(70, 70, 70, 10, 10, 10, 10, 10);
					goalTimeSlice = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalGravity = new Array(rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav);
					goalAlpha = new Array(.7, .7, .7, .7, .7, .7, .7, .7);
					goalAlphaStep = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalDecay = new Array(0, 0, 0, 0, 0, 0, 0, 0);
					goalColorR = HCgoalColorR 
					goalColorG = HCgoalColorG
					goalColorB = HCgoalColorB
					dieOnThisStep = new Array(0, 0, 1, 0, 0, 0, 0, 0);
					goalColorStep = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalSize = new Array(iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize);
					goalSizeStep = new Array(2, 2, 2, 2, 2, 2, 2, 2);
					
					break
				
				case SN_CC:
					
					bornProbability = 1;
					bornHeadGoal = 0;
					bornTailGoal = 0;
					iSize = 15
					rGGrav = 1.15
					birthPace = particleBirth_DEFAULT
					particleMax =  particleMax_DEFAULT
		
					goalProbability = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalHead = new Array(1, 2, 3, 0, 0, 0, 0, 0);
					goalTail = new Array(1, 2, 3, 0, 0, 0, 0, 0);
					goalPositionX = new Array(-50, 360, 730, 0, 0, 0, 0, 0);
					goalPositionY = new Array(115, 140, 215, 0, 0, 0, 0, 0);
					goalFuzzyRadius = new Array(70, 70, 70, 0, 0, 0, 0, 0);
					goalNearRadius = new Array(70, 70, 70, 0, 0, 0, 0, 0);
					goalDriftStep = new Array(70, 70, 70, 10, 10, 10, 10, 10);
					goalTimeSlice = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalGravity = new Array(rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav);
					goalAlpha = new Array(.7, .7, .7, .7, .7, .7, .7, .7);
					goalAlphaStep = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalDecay = new Array(0, 0, 0, 0, 0, 0, 0, 0);
					goalColorStep = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalColorR = CCgoalColorR 
					goalColorG = CCgoalColorG
					goalColorB = CCgoalColorB
					dieOnThisStep = new Array(0, 0, 1, 0, 0, 0, 0, 0);
					goalSize = new Array(iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize);
					goalSizeStep = new Array(2, 2, 2, 2, 2, 2, 2, 2);
					
					break
				
				case SN_FILTER:
							
					bornProbability = .5;
					bornHeadGoal = 0;
					bornTailGoal = 2;
					iSize = 15
					rGGrav = 1.15
					birthPace = particleBirth_DEFAULT
					particleMax =  particleMax_DEFAULT
		
					goalProbability = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalHead = new Array(1, 2, 3, 4, 2, 2, 2, 2);
					goalTail = new Array(1, 2, 3, 4, 5, 6, 7, 7);
					goalPositionX = new Array(-70, 730, -70, 730, 0, 0, 0, 0);
					goalPositionY = new Array(175, 185, 275, 245, 0, 0, 0, 0);
					goalFuzzyRadius = new Array(160, 60, 40, 60, 5, 36, 30, 10);
					goalNearRadius = new Array(30, 60, 40, 60, 5, 36, 30, 5);
					goalDriftStep = new Array(10, 10, 10, 10, 10, 10, 10, 10);
					goalTimeSlice = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalGravity = new Array(rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav);
					goalAlpha = new Array(.7, .7, .7, .7, .7, .7, .7, .7);
					goalAlphaStep = new Array(1, 1, 1, 1, 20, 10, 10, 10);
					goalDecay = new Array(0, 70, 0, 70, 0, 0, 0, 70);
					goalColorStep = new Array(1, 1, 1, 1, 1, 1, 100, 1);
					goalColorR = FLTgoalColorR 
					goalColorG = FLTgoalColorG
					goalColorB = FLTgoalColorB
					dieOnThisStep = new Array(0, 1, 0, 1, 0, 0, 0, 0);
					goalSize = new Array(iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize);
					goalSizeStep = new Array(2, 2, 2, 2, 2, 2, 2, 2);
					
					break
				
				
				case SN_FAN:
				
					bornProbability = 1
					bornHeadGoal = 0
					bornTailGoal = 0
					iSize = 15
					rGGrav = 1.15
					birthPace = particleBirth_DEFAULT
					particleMax =  particleMax_FAN
					
					goalProbability = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalHead = new Array(1, 2, 3, 4, 5, 6, 0, 0);
					goalTail = new Array(1, 2, 3, 4, 5, 6, 0, 0);
					goalPositionX = new Array(-50, 360, 370, 275, 730, 0, 0, 0);
					goalPositionY = new Array(235, 210, 290, 200, 215, 0, 0, 0);
					goalFuzzyRadius = new Array(70, 70, 20, 10, 10, 10, 0, 0);
					goalNearRadius = new Array(70, 70, 20, 10, 10, 10, 0, 0);
					goalDriftStep = new Array(70, 70, 70, 10, 10, 10, 10, 10);
					goalTimeSlice = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalGravity = new Array(rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav);
					goalAlpha = new Array(.7, .7, .7, .7, .7, .7, .7, .7);
					goalAlphaStep = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalDecay = new Array(0, 0, 0, 0, 0, 0, 0, 0);
					goalColorStep = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalColorR = FANgoalColorR 
					goalColorG = FANgoalColorG
					goalColorB = FANgoalColorB
					dieOnThisStep = new Array(0, 0, 0, 0, 1, 0, 0, 0);
					goalSize = new Array(iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize);
					goalSizeStep = new Array(2, 2, 2, 2, 2, 2, 2, 2);
		
					//Log.info('done setting fan')
					
					break
					
				case SN_VAV:
						
					iSize = 11
					rGGrav = 1.15
					birthPace = particleBirth_DEFAULT
					particleMax =  particleMax_DEFAULT
		
					// All particles for this view will start at the same place
					bornProbability = 1;
					bornHeadGoal = 0;
					bornTailGoal = 0;
					
					goalProbability = new Array(.5, .5, 1, 1, .5, 1, 1);
					goalHead = new Array(1, 6, x, x, 5, x, x);
					goalTail = new Array(4, 2, 3, 3, 6, 5, 6);
					goalPositionX = new Array(500, 500, 200, -40, 510, 750, 510);
					goalPositionY = new Array(-10, 170, 235, 235, 235, 265, 620);	
					goalFuzzyRadius = new Array(40, 40, 10, 10, 10, 10, 40);
					goalNearRadius = new Array(10, 40, 20, 10, 10, 10, 40)	
					goalDriftStep = new Array(20, 10, 10, 10, 30, 30, 30)
					goalTimeSlice = new Array(1, 1, 1, 1, 1, 1, 1);
					goalGravity = new Array(rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav);
					goalAlpha = new Array(.7, .7, .7, .7, .7, .7, .7);
					goalAlphaStep = new Array(1, 1, 1, 1, 1, 1, 1);
					goalDecay = new Array(0, 0, 0, 0, 0, 0, 0);
					dieOnThisStep = new Array(0, 0, 0, 1, 0, 1, 1);
					// for now we will assume color is that of mixed air (MA or SA).  
					goalColorR = VAVgoalColorR
					goalColorG = VAVgoalColorG
					goalColorB = VAVgoalColorB
					goalColorStep = new Array(1, 1, 1, 1, 1, 1, 1);
					goalSize = new Array(iSize, iSize, iSize, iSize, iSize, iSize, iSize);
					goalSizeStep = new Array(2, 2, 2, 2, 2, 2, 2);
					
					break
					
				
				case SN_DIFFUSER:		
				
					bornProbability = 1;
					bornHeadGoal = 0;
					bornTailGoal = 0;
					iSize = 4
					rGGrav = 1.5
					particleMax =  particleMax_DIF
					birthPace = particleBirth_DIF
					
					goalProbability = new Array(1, 1, .5, 1, 1, 1, 1, 1);
					goalHead = new Array(1, 2, 4, 5, 7, 8, 0, 0);
					goalTail = new Array(1, 2, 5, 6, 7, 8, 0, 0);
					goalPositionX = new Array(560, 350, 327, 327, 227, 380, 0, 0);
					goalPositionY = new Array(95, 86, 190, 410, 450, 450, 0, 0);
					goalFuzzyRadius = new Array(20, 15, 30, 140, 140, 120, 0, 0);
					goalNearRadius = new Array(15, 15, 15, 100, 100, 100, 0, 0);
					goalDriftStep = new Array(10, 10, 20, 20, 10, 10, 10, 10);
					goalTimeSlice = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalGravity = new Array(rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav, rGGrav);
					goalAlpha = new Array(.7, .7, .7, .7, .7, .7, .7, .7);
					goalAlphaStep = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalDecay = new Array(0, 0, 0, 0, 0, 0, 0, 0);
					goalColorStep = new Array(1, 1, 1, 1, 1, 1, 1, 1);
					goalColorR = DIFgoalColorR 
					goalColorG = DIFgoalColorG
					goalColorB = DIFgoalColorB
					dieOnThisStep = new Array(0, 0, 0, 0, 1, 1, 0, 0);
					goalSize = new Array(iSize, iSize, iSize, iSize, iSize, iSize, iSize, iSize);
					goalSizeStep = new Array(2, 2, 2, 2, 2, 2, 2, 2);
					
					break
				
				case SN_ROOF:
					//do nothing, no scene for roof view
					break
					
				
				default:
					Logger.warn("#PE: initScene(): unrecognized system node: " + sysNode)
					
			}
			
		}

		
		
		public function animate():void
		{
			if (particleManager.numParticlesAlive > particleMax) return
					
			count++;
			if( count > birthPace )
			{
				var initObj:Object = new Object()
						
				//particle.mycolor = new Color(particle);		
		
				var flip:Number
				if (Math.random() > bornProbability)		
				{
					flip = bornHeadGoal;
				}
				else
				{
					flip = bornTailGoal;
				}
				
				var angle:Number = Math.random() * (2 * Math.PI);
				var distance:Number = Math.random() * (goalFuzzyRadius[flip] - 1);
				initObj.xPos = goalPositionX[flip] + (distance * Math.cos(angle));
				initObj.yPos= goalPositionY[flip] + (distance * Math.sin(angle));
				initObj.goalGravity = goalGravity
				initObj.goalNearRadius = goalNearRadius
				initObj.goalHead = goalHead
				initObj.goalTail = goalTail
				initObj.dieOnThisStep = dieOnThisStep
				initObj.goalFuzzyRadius = goalFuzzyRadius
				initObj.goalProbability = goalProbability
				initObj.goalPositionX = goalPositionX
				initObj.goalPositionY = goalPositionY
				initObj.goalDriftStep = goalDriftStep
				initObj.goalColorR = goalColorR
				initObj.goalColorG = goalColorG
				initObj.goalColorB = goalColorB
				initObj.goalColorStep = goalColorStep
				initObj.goalAlpha = goalAlpha
				initObj.goalAlphaStep = goalAlphaStep
				initObj.radius = iSize
				initObj.currIndex = flip
				initObj.colorr = goalColorR[flip]
				initObj.colorg = goalColorG[flip]
				initObj.colorb = goalColorB[flip]		
				
				
				if (Math.random() > goalProbability[flip])
				{
					initObj.goal =  goalHead[flip];
				}
				else
				{
					initObj.goal =  goalTail[flip];
				}
		
				angle = Math.random() * (2 * Math.PI);
				distance = Math.random() * (goalFuzzyRadius[initObj.goal] - 1);
				initObj.targetx = uint(goalPositionX[initObj.goal] + (distance * Math.cos(angle)))
				initObj.targety = uint(goalPositionY[initObj.goal] + (distance * Math.sin(angle)))
				
				particleManager.createParticle(initObj)
				
				count = 0
				
			}
		
			
		}
		
		
			
		

	}
}

