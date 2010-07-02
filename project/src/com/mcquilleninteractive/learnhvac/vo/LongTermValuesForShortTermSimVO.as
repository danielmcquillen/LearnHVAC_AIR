package com.mcquilleninteractive.learnhvac.vo
{
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.util.Conversions;
	
	public class LongTermValuesForShortTermSimVO
	{
		
		public var dateInEpochSecs:Number
		
		public var rowIndex:Number = 0
		public var _tAirOut:Number = 0
		public var _rhOutside:Number = 0
		public var _lightingHeatGain:Number = 1
		public var _electricEquipmentHeatGain:Number = 1
		public var _peopleHeatGain:Number = 1
		
						
		public function LongTermValuesForShortTermSimVO()
		{
		}
		
		public function setValue(varName:String, val:Number):void
		{
			if (this[varName]!=null)
			{
				this[varName] = val
			}
		}
		
		public function getRmQSens(units:String="SI"):Number
		{
			var rmQ:Number = (_lightingHeatGain + _electricEquipmentHeatGain + _peopleHeatGain) / 3600
			
			if (units== ApplicationModel.UNITS_SI)
			{
				return rmQ	
			}
			else
			{
				return Conversions.wattsToBtuPerHour(rmQ)
			}
		}
		
		

		public function get tAirOut():Number
		{
			if (ApplicationModel.currUnits == ApplicationModel.UNITS_SI)
			{
				return _tAirOut	
			}
			else
			{
				return Conversions.celToFarh(_tAirOut)
			}
		}
		
		public function set tAirOut(v:Number):void
		{
			if (ApplicationModel.currUnits == ApplicationModel.UNITS_SI)
			{
				_tAirOut = v
			}
			else
			{
				_tAirOut = Conversions.farhToCel(_tAirOut)
			}
		}

		public function get rhOutside():Number
		{
			return _rhOutside				
		}
		
		public function set rhOutside(v:Number):void
		{
			_rhOutside = v
		}

	}
}