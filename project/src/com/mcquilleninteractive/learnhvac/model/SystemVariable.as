
package com.mcquilleninteractive.learnhvac.model
{
	
	import com.mcquilleninteractive.learnhvac.util.Conversions;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	
	[Bindable]
	public class SystemVariable
	{
		
		public static var INPUT:String = "INPUT"
		public static var OUTPUT:String = "OUTPUT"
		
		public static var FAULT_SLIDER:String = "SLIDER"
		public static var FAULT_CHECKBOX:String = "CHECKBOX"
		
		public var importedFromEnergyPlus:Boolean = false 		//This property is currently set locally after loading scenario and not through scenario description
		
		public var name:String
		public var display_name:String
		public var description:String
		public var typeID:String //INPUT or OUTPUT
		public var applicationID:String // PUBLIC or PRIVATE
		private var _faultIsActive:Boolean = false
				
		public var min_value:Number
		public var _low_value:Number
		public var _high_value:Number 
		public var max_value:Number
		public var atol:String
		public var disabled:Boolean = false
		private var _output_graph_no:Number
		public var isImportedFromLongTermSim:Boolean = false
		public var isExportedToLongTermSim:Boolean = false
		
		//CONVERSIONS
		private var _unit_si:String
		private var _si_to_ip:String
		private var _unit_ip:String
		private var convertSItoIP:Function
		private var convertIPtoSI:Function
					
		//for fault variables
		public var subsection:String // used for grouping faults in fault panels
		public var is_fault:Boolean
		public var is_percentage:Boolean = false // whether slider shows percentage for fault value or real fault value
		private var _zone_position:String // for colored bar in slider
		private var _left_label:String // for slider (see class for details)
		private var _right_label:String // for slier (see class for details)
		private var _fault_widget_type:String // for slider (see class for details)
		private var _target_fault:String // name of fault that fault item targets 
		
		//Holds initial SI value of variable provided by scenario
		private var _initial_value:Number
		
		//Holds the current SI value of the variable
		private var _baseSIValue:Number = 0		
		
		public var _units:String = LHModelLocator.UNITS_IP
		public var lastValue:Number //used as part of interface highlighting...Remembers the last value of this variable sent to SPARK		
		
		//history for graphing
		//currently saving history as an array of values
		//this array is graphed against the time array held by the scenarioModel
		private var _historySI:Array = []	// holds history for current simulation
		private var _historyIP:Array = [] // holds history for current simulation in IP ... only populated/refreshed when requested by graph
		
		private var model:LHModelLocator
		private var scenModel:ScenarioModel
	         
		// create a ChangeWatcher.
		public var watcher:ChangeWatcher

		public function SystemVariable()
		{			
			scenModel = LHModelLocator.getInstance().scenarioModel
			watcher =  BindingUtils.bindSetter(recordValue, scenModel, "currStep")
		}
	
		//this getter is used for labels
		public function get visible():Boolean
		{
			if (applicationID=="PUBLIC")
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
			_baseSIValue = _initial_value
		}
		
		/**  Adds conversions functions based on units SI and IP strings. Function assumes that _unit_si and _unit_ip attributes have already been set. */
		public function setConversionFunctions():void
		{	
			Logger.debug("setConversionFunction: sysVarName: " + name, this)	
			if (this._unit_si=="" || this._unit_ip=="")
			{
				Logger.debug("no conversion function needed",this)
				return
			}				
			convertSItoIP = Conversions.getConversionFunction(this._unit_si, this._unit_ip)
			convertIPtoSI = Conversions.getConversionFunction(this._unit_ip, this._unit_si)		
			
		}
		
	
		/** Sets initial value for variable. Expects SI value.*/
		public function set initial_value(value:Number):void
		{
			if (isNaN(value)) 
			{
				Logger.warn("System variable " + this.name + " initial_value() was NaN")
				value=0
			}
			_initial_value = value
			_baseSIValue = _initial_value
		}
		
		/** Gets initial value for variable. Always returns SI value */
		public function get initial_value():Number
		{
			return _initial_value
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
			
			if (!this.faultIsActive && this.is_fault)
			{
				return -999
			}
			
			return _baseSIValue
		}
			
		
			
		public function set currValue(value:Number):void
		{				
			if(_units==LHModelLocator.UNITS_IP && convertIPtoSI!=null)
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
			if(_units==LHModelLocator.UNITS_IP && convertSItoIP!=null)
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
				case LHModelLocator.UNITS_IP:
					return unit_ip
				case LHModelLocator.UNITS_SI:
					return unit_si
				case LHModelLocator.UNITS_NONE:
					return ""
				default:
					Logger.error("SystemVariable: " + this.name + ". Unrecognized _units:" + _units)
			}
			return ""
		}
		
		/* Format the units string when "getting' ... e.g add degree sign to F or C*/				
		public function get unit_si():String
		{
			switch (this._unit_si)
			{
				case "C":
					return "\u00B0C"
				case "W/oC":
					return "W/\u00B0C"
				default:
					return _unit_si
			}
		}
		
		public function set unit_si(p_units:String):void
		{
			_unit_si = p_units
		}
		
		
		/* Format the units string when "getting' ... e.g add degree sign to F or C*/
		public function get unit_ip():String
		{			
			switch (this._unit_ip)
			{
				case "F":
					return "\u00B0F"
				case "Btu/hr.oF":
					return "Btu/hr.\u00B0F"
				default:
					return _unit_ip
			}
		}
		
		public function set unit_ip(p_units:String):void
		{
			_unit_ip = p_units
		}
		
		
			
		public function set low_value(value:Number):void
		{			
			_low_value = value
		}
		
		public function get low_value():Number
		{
			if(_units == LHModelLocator.UNITS_IP && convertSItoIP!=null)
			{
				return convertSItoIP(_low_value)
			} 
			else
			{
				return _low_value
			} 
		}
		
		public function set high_value(value:Number):void{
			_high_value = value
		}
		
		public function get high_value():Number
		{
			if(_units == LHModelLocator.UNITS_IP && convertSItoIP!=null)
			{
				return convertSItoIP(_high_value)
			} 
			else
			{
				return _high_value
			} 
		}
		
		public function isValid():Boolean
		{
			//Logger.debug("#SysVar: isValid() checking :" + name + " : lowValue: "+ low_value + " currValue: " + currValue + " highValue: " + high_value)
			if (currValue<low_value || currValue >high_value)
			{
				return false
			}
			else
			{
				return true
			}
		}
		
		
		// GET/SET: si_to_ip
		public function get si_to_ip():String
		{
			return _si_to_ip
		}
		public function set si_to_ip(p_si_to_ip:String):void
		{
			_si_to_ip = p_si_to_ip
		}
	
		// GET/SET: output_graph_no
		public function get output_graph_no():Number
		{
			return _output_graph_no
		}
		
		public function set output_graph_no(graph_no:Number):void
		{
			var castVal:Number = Number(graph_no)
			if (isNaN(castVal)){
				//set to undefined
				_output_graph_no = undefined
			} else {
				_output_graph_no = castVal				
			}
		}
		
		// GET/SET: zone_position
		public function set zone_position(p_zone_position:String):void
		{
			
			if (p_zone_position == "LEFT" || p_zone_position == "CENTER" || p_zone_position == "NO_GRADIENT"){
				_zone_position= p_zone_position
			} else if (p_zone_position=="") {
				_zone_position = undefined
			} else {
				Logger.debug("#SystemVariable: sysVar:" + name +" invalid zone_position: " + p_zone_position)
			}
			
		}
		
		public function get zone_position():String
		{
			return _zone_position
		}
				
		// GET/SET: left_label
		public function set left_label(p_left_label:String):void
		{
			_left_label= p_left_label
		}
		public function get left_label():String{
			return _left_label
		}
		
		// GET/SET: right_label
		public function set right_label(p_right_label:String):void
		{
			_right_label= p_right_label
		}
		public function get right_label():String
		{
			return _right_label
		}
		
		// GET/SET: fault_widget_type
		public function set fault_widget_type(p_fault_widget_type:String):void
		{
			
			p_fault_widget_type = p_fault_widget_type.toUpperCase()
			
			if (p_fault_widget_type == "SLIDER" || p_fault_widget_type == "CHECKBOX")
			{
				_fault_widget_type= p_fault_widget_type
			} 
			else 
			{
				Logger.error("#SystemVariable: sysVar " + name + " unrecongized faultWidgetType : " + p_fault_widget_type)
			}
			
		}
		
		public function get fault_widget_type():String
		{
			return _fault_widget_type
		}
		

		
		// Function: min_max_labels
		// Convenience function to get labels for slider in fault panel
		public function get left_right_labels():Array
		{
			var r:Array = [left_label, right_label]
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
		
		private function roundToThirdFig(val:Number):Number{
			if (val==0) return 0;
			val = val*1000
			val = Math.round(val)
			val = val/1000
			return val
		}
	
		public function get hasConversion():Boolean
		{
			return (si_to_ip!=null && si_to_ip != "")
		}
	
		// This is a utility function that outside classes can call
		// to convert a number based on this variable's conversion factors
		public function convert(p_value:Number, p_toUnits:String):Number
		{
			Logger.debug("convert() value: " + p_value + " units: " + p_toUnits, this)
			if(p_toUnits==LHModelLocator.UNITS_SI && convertIPtoSI!=null)
			{
				return convertIPtoSI(p_value)
			} 
			else if (p_toUnits==LHModelLocator.UNITS_IP && convertSItoIP!=null)
			{
				return convertIPtoSI(p_value)		
			}
			else
			{
				return p_value
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
		
		
		public function destroy():void
		{
			watcher.unwatch(); 
    		model = null
			scenModel = null
		}
		
	}
}




