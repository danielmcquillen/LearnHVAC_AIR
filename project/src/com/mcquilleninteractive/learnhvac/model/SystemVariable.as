
package com.mcquilleninteractive.learnhvac.model
{
	
	import com.mcquilleninteractive.learnhvac.util.Conversions;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	
	[Bindable]
	public class SystemVariable
	{
		
		
		//viewType settings
		public static var OUTPUT:String = "OUTPUT"
		public static var INPUT:String = "INPUT"
		public static var PARAMETER:String = "PARAMETER"

		//faultWidgetType settings
		public static var FAULT_SLIDER:String = "SLIDER"
		public static var FAULT_CHECKBOX:String = "CHECKBOX"
		
		//ioType settings
		public static var VIEW_TYPE_PUBLIC:String = "PUBLIC"
		public static var VIEW_TYPE_PRIVATE:String = "PRIVATE";
				
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		//order for input into or output from Modelica
		public var index:Number 
		
		//This property is currently set locally 
		//after loading scenario and not through scenario description
		public var importedFromEnergyPlus:Boolean = false 		
		
		public var name:String 
		public var displayName:String
		public var description:String = ""
		
		//if INPUT, INPUT_PARAMETER or INPUT_VARIABLE
		private var _ioType:String
		
		// PUBLIC or PRIVATE
		private var _viewType:String 
		
		private var _faultIsActive:Boolean = false
		//Holds the initial disabled state as set by the instructor
		public var initiallyFaultIsActive:Boolean = true
			
				
		public var minValue:Number = 0
		public var _lowValue:Number = 0
		public var _highValue:Number = 0
		public var maxValue:Number = 0
		public var atol:String = ""
		public var disabled:Boolean = false
		private var _outputGraphNo:Number
		public var isImportedFromLongTermSimToShortTermSim:Boolean = false
		public var isImportedFromShortTermSimToLongTermSim:Boolean = false
		
		//CONVERSIONS
		private var _unitSI:String
		private var _SItoIP:String
		private var _unitIP:String
		private var convertSItoIP:Function
		private var convertIPtoSI:Function
					
		//for fault variables
		public var subsection:String // used for grouping faults in fault panels
		public var isFault:Boolean = false
		public var isPercentage:Boolean = false // whether slider shows percentage for fault value or real fault value
		private var _zonePosition:String // for colored bar in slider
		private var _leftLabel:String // for slider (see class for details)
		private var _rightLabel:String // for slier (see class for details)
		private var _faultWidgetType:String // for slider (see class for details)
		private var _targetFault:String // name of fault that fault item targets 
		
		//Holds initial SI value of variable provided by scenario
		private var _initialValue:Number = 0
			
		//Holds the current SI value of the variable
		private var _baseSIValue:Number = 0		
		
		public var _units:String = ApplicationModel.UNITS_IP
		
		//holds the value the user entered in the input panel before clicking "update"
		//if it's valid, it will become the currValue, if not, the update will be prevented
		public var localValue:Number 
		
		//history for graphing
		//currently saving history as an array of values
		//this array is graphed against the time array held by the scenarioModel
		private var _historySI:Array = []	// holds history for current simulation
		private var _historyIP:Array = [] // holds history for current simulation in IP ... only populated/refreshed when requested by graph
		
	         
		// create a ChangeWatcher.
		public var watcher:ChangeWatcher

		public function SystemVariable()
		{			
			watcher =  BindingUtils.bindSetter(recordValue, scenarioModel, "currStep")
		}
	
		//this getter is used for labels
		public function get visible():Boolean
		{
			if (viewType=="PUBLIC" || viewType=="public")
			{
				return true
			}	
			else
			{
				return false
			}
		}
		
		public function resetToInitialValue():void
		{
			baseSIValue = initialValue
			localValue = currValue
			faultIsActive = initiallyFaultIsActive
			
		}
		
		/**  Adds conversions functions based on units SI and IP strings. Function assumes that _unitSI and _unitIP attributes have already been set. */
		public function setConversionFunctions():void
		{	
			if (this._unitSI=="" || this._unitIP=="" || this._unitSI==this._unitIP)
			{
				return
			}				
			convertSItoIP = Conversions.getConversionFunction(this._unitSI, this._unitIP)
			convertIPtoSI = Conversions.getConversionFunction(this._unitIP, this._unitSI)		
			
		}
		
	
		public function set viewType(value:String):void
		{
			_viewType = value.toUpperCase()
		}
		public function get viewType():String
		{
			return _viewType
		}
		
		public function set ioType(value:String):void
		{
			_ioType = value.toUpperCase()
		}
		public function get ioType():String
		{
			return _ioType
		}
		
		/** Sets initial value for variable. Expects SI value.*/
		public function set initialValue(value:Number):void
		{
			if (isNaN(value)) 
			{
				Logger.warn("System variable " + this.name + " initial_value() was NaN")
				value=0
			}
			_initialValue = value
			_baseSIValue = _initialValue
		}
		
		/** Gets initial value for variable. Always returns SI value */
		public function get initialValue():Number
		{
			return _initialValue
		}
			
		/** Sets baseSIValue for variable. Expects SI value */	
		public function set baseSIValue(value:Number):void
		{
			if (isNaN(value)) 
			{
				Logger.warn("System variable " + this.name + " baseSIValue() was NaN")
				value=0
			}
			_baseSIValue = value	
		}
		
		/** Gets baseSIValue for variable. Returns SI value */
		public function get baseSIValue():Number
		{
			
			if (!this.faultIsActive && this.isFault)
			{
				return -99999999
			}
			
			return _baseSIValue
		}
			
		
			
		public function set currValue(value:Number):void
		{				
			if(_units==ApplicationModel.UNITS_IP && convertIPtoSI!=null)
			{
				//use conversion function if it exists for this sysVar
				_baseSIValue = convertIPtoSI(value)
			}
			else 
			{
				_baseSIValue = value
			}
			
		}
		
		public function get currValue():Number
		{												
			if(_units==ApplicationModel.UNITS_IP && convertSItoIP!=null)
			{
				return convertSItoIP(_baseSIValue)
			}
			else 
			{
				return _baseSIValue
			}
		}
	
		/* Sets the units for this variable : "SI" or "IP" */
		public function set units(u:String):void
		{
			if (_units != u)
			{
				_units = u;
			}
			
				
		}
		
		/* Returns the string representing the type of units for this variable (e.g. "Btu/h") */
		public function get units():String
		{
			switch (_units)
			{
				case ApplicationModel.UNITS_IP:
					return unitIP
				case ApplicationModel.UNITS_SI:
					return unitSI
				case ApplicationModel.UNITS_NONE:
					return ""
				default:
					Logger.error("SystemVariable: " + this.name + ". Unrecognized _units:" + _units)
			}
			return ""
		}
		
		/* Format the units string when "getting' ... e.g add degree sign to F or C*/				
		public function get unitSI():String
		{
			switch (this._unitSI)
			{
				case "C":
					return "\u00B0C"
				case "W/oC":
					return "W/\u00B0C"
				default:
					return _unitSI
			}
		}
		
		public function set unitSI(value:String):void
		{
			_unitSI = value
		}
		
		
		/* Format the units string when "getting' ... e.g add degree sign to F or C*/
		public function get unitIP():String
		{			
			switch (this._unitIP)
			{
				case "F":
					return "\u00B0F"
				case "Btu/hr.oF":
					return "Btu/hr.\u00B0F"
				default:
					return _unitIP
			}
		}
		
		public function set unitIP(value:String):void
		{
			_unitIP = value
		}
		
		
			
		public function set lowValue(value:Number):void
		{			
			_lowValue = value
		}
		
		public function get lowValue():Number
		{
			if(_units == ApplicationModel.UNITS_IP && convertSItoIP!=null)
			{
				return convertSItoIP(_lowValue)
			} 
			else
			{
				return _lowValue
			} 
		}
		
		public function set highValue(value:Number):void
		{
			_highValue = value
		}
		
		public function get highValue():Number
		{
			if(_units == ApplicationModel.UNITS_IP && convertSItoIP!=null)
			{
				return convertSItoIP(_highValue)
			} 
			else
			{
				return _highValue
			} 
		}
		
		public function isLocalValueValid():Boolean
		{
			if (localValue<lowValue || localValue >highValue)
			{
				return false
			}
			else
			{
				return true
			}
		}
		
		public function isValid():Boolean
		{
			if (currValue<lowValue || currValue >highValue)
			{
				return false
			}
			else
			{
				return true
			}
		}
		
		
		public function get SItoIP():String
		{
			return _SItoIP
		}
		public function set SItoIP(value:String):void
		{
			_SItoIP = value
		}
	
		public function get outputGraphNo():Number
		{
			return _outputGraphNo
		}
		
		public function set outputGraphNo(value:Number):void
		{
			if (isNaN(value))
			{				
				_outputGraphNo = undefined
			}
			else 
			{
				_outputGraphNo = value				
			}
		}
		
		// GET/SET: zone_position
		public function set zonePosition(value:String):void
		{
			
			if (value == "LEFT" || value == "CENTER" || value == "NO_GRADIENT"){
				_zonePosition= value
			} else if (value=="") {
				_zonePosition = undefined
			} else {
				Logger.debug("#SystemVariable: sysVar:" + name +" invalid zone_position: " + value)
			}
			
		}
		
		public function get zonePosition():String
		{
			return _zonePosition
		}
				
		// GET/SET: left_label
		public function set leftLabel(value:String):void
		{
			_leftLabel= value
		}
		public function get leftLabel():String{
			return _leftLabel
		}
		
		// GET/SET: right_label
		public function set rightLabel(value:String):void
		{
			_rightLabel= value
		}
		public function get rightLabel():String
		{
			return _rightLabel
		}
		
		// GET/SET: fault_widget_type
		public function set faultWidgetType(value:String):void
		{
			
			value = value.toUpperCase()
			
			if (value == "SLIDER" || value == "CHECKBOX")
			{
				_faultWidgetType= value
			} 
			else 
			{
				Logger.error("#SystemVariable: sysVar " + name + " unrecongized faultWidgetType : " + value)
			}
			
		}
		
		public function get faultWidgetType():String
		{
			return _faultWidgetType
		}
		

		
		// Function: min_max_labels
		// Convenience function to get labels for slider in fault panel
		public function get leftRightLabels():Array
		{
			var r:Array = [leftLabel, rightLabel]
			return r	
		}
		
		public function set faultIsActive(state:Boolean):void
		{
			_faultIsActive = state
		}
		
		public function get faultIsActive():Boolean
		{
			return _faultIsActive
		}
			
		
		
		public function clearHistory():void
		{
			_historySI = []
			_historyIP = []
		}
		
		private function roundToThirdFig(value:Number):Number{
			if (value==0) return 0;
			value = value*1000
			value = Math.round(value)
			value = value/1000
			return value
		}
	
		public function get hasConversion():Boolean
		{
			return (SItoIP!=null && SItoIP != "")
		}
	
		// This is a utility function that outside classes can call
		// to convert a number based on this variable's conversion factors
		public function convert(value:Number, toUnits:String):Number
		{
			Logger.debug("convert() value: " + value + " units: " + toUnits, this)
			if(toUnits==ApplicationModel.UNITS_SI && convertIPtoSI!=null)
			{
				return convertIPtoSI(value)
			} 
			else if (toUnits==ApplicationModel.UNITS_IP && convertSItoIP!=null)
			{
				return convertIPtoSI(value)		
			}
			else
			{
				return value
			}
		}
		
		
		// Sometimes we just want the IP value, regardless of what units we're using
		public function get IPValue():Number
		{
			if (convertSItoIP!=null)
			{
				return convertSItoIP(this._baseSIValue)
			}
			else
			{
				return _baseSIValue
			}
		}
		
		
		//record the value for this system variable, even if there is no change
		//(essential for proper graphing against other variables)
		public function recordValue(step:Number):void
		{
			if (step>0) _historySI.push(_baseSIValue)
			
			if (_units=="IP")
				if (step>0) _historyIP.push(this.currValue)
				
		}	
		
		public function get historySI():Array
		{
			return _historySI
		}
		
		//When we get the IP history, we only convert if the steps has changes
		public function get historyIP():Array
		{
			return _historyIP
		}

		
		//updates the historyIP array by converting values in historySI
		public function updateHistoryIP():void
		{
			var len:int = 0
			_historyIP = []
			for (var i:int = 0; i<len; i++)
			{
				_historyIP.push(this.convert(_historySI[i], "IP"))
			}
			
		}
		
		
		/* Updates the system variable to the value entered by the user*/
		public function updateFromLocal():void
		{
			this.currValue = this.localValue
		}
		
		public function destroy():void
		{
			watcher.unwatch(); 
			scenarioModel = null
		}
		
		
	
	}
}




