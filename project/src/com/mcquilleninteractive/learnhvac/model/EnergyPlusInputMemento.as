package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.util.Conversions;
	
	/** This class remembers the inputs to EnergyPlus for a specific run */
	
	public class EnergyPlusInputMemento
	{
		public var runID:String 
		public var timeStepEP:int
				
		public var region:String
		public var city:String
		public var regionSelectedIndex:uint
		public var citySelectedIndex:uint
		
		public var zoneOfInterest:int
		public var floorOfInterest:int				
				
		public var windowTypeSelectedIndex:uint
		public var shell:String
		public var stories:int 	
		public var windowType:String
		public var northAxis:Number 		
		public var massLevel:String
		public var massLevelSelectedIndex:uint 	
		
		public var windowRatioEast:Number
		public var windowRatioNorth:Number
		public var windowRatioSouth:Number
		public var windowRatioWest:Number
					
		public var startDate:Date
		public var stopDate:Date
		
		public var vavMinFlwRatio:Number
		public var rmQSens:Number
		public var vavHcQd:Number
		public var hcUA:Number
		public var ccUA:Number
		public var fanPwr:Number
		
		//these properties have different SI and IP value
		
		public var _zoneHeatingSetpointTemp:Number
		public var _zoneCoolingSetpointTemp:Number
		public var _supplyAirSetpointTemp:Number
		public var _areaPerPerson:Number 
		public var _equipPeakLoad:Number
		public var _lightingPeakLoad:Number
		public var _storyHeight:Number 
		public var _buildingLength:Number 
		public var _buildingWidth:Number
		
		
		public function EnergyPlusInputMemento()
		{
		}
		
			
		public function get wallAreaNorth():Number
		{
			return buildingWidth*storyHeight
		}
		
		public function get wallAreaSouth():Number
		{
			return buildingWidth*storyHeight
		}
		
		public function get wallAreaEast():Number
		{
			return buildingLength*storyHeight
		}
		
		public function get wallAreaWest():Number
		{
			return buildingLength*storyHeight
		}
		
		public function get storyHeight():Number
		{
			if (ApplicationModel.currUnits=="SI")
			{
				return Conversions.metersToFeet(_storyHeight)				
			}
			else
			{
				return _storyHeight
			}
		}		
		
		public function get buildingLength():Number
		{
			if (ApplicationModel.currUnits=="IP")
			{
				return Conversions.metersToFeet(_buildingLength)				
			}
			else
			{
				return _buildingLength
			}
		}
		
		public function set buildingLength(v:Number):void
		{
			if (ApplicationModel.currUnits=="IP")
			{
				_buildingLength = Conversions.feetToMeters(v)				
			}
			else
			{
				_buildingLength = v
			}
		}
		
		public function get buildingWidth():Number
		{
			if (ApplicationModel.currUnits=="IP")
			{
				return Conversions.metersToFeet(_buildingWidth)				
			}
			else
			{
				return _buildingWidth
			}
		}
		
		public function set buildingWidth(v:Number):void
		{
			if (ApplicationModel.currUnits=="IP")
			{
				_buildingWidth = Conversions.feetToMeters(v)				
			}
			else
			{
				_buildingWidth = v
			}
		}
				
		public function get equipPeakLoad():Number
		{
			if (ApplicationModel.currUnits=="IP")
			{
				return Conversions.wattsPerSqMtoWattsPerSqFt(_equipPeakLoad)				
			}
			else
			{
				return _equipPeakLoad
			}
		}
				
		public function get lightingPeakLoad():Number
		{
			if (ApplicationModel.currUnits=="IP")
			{
				return Conversions.wattsPerSqMtoWattsPerSqFt(_lightingPeakLoad)				
			}
			else
			{
				return _lightingPeakLoad
			}
		}
				
		public function get areaPerPerson():Number
		{
			if (ApplicationModel.currUnits=="IP")
			{
				return Conversions.m2ToFt2(_areaPerPerson)				
			}
			else
			{
				return _areaPerPerson
			}
		}
				
		public function get zoneHeatingSetpointTemp():Number
		{
			if (ApplicationModel.currUnits=="SI")
			{
				return _zoneHeatingSetpointTemp
			}
			else
			{
				return Conversions.celToFarh(_zoneHeatingSetpointTemp)
			}
		}
				
		public function get zoneCoolingSetpointTemp():Number
		{
			if (ApplicationModel.currUnits=="SI")
			{
				return _zoneCoolingSetpointTemp
			}
			else
			{
				return Conversions.celToFarh(_zoneCoolingSetpointTemp)
			}
		}
		
		
		public function get supplyAirSetpointTemp():Number
		{
			if (ApplicationModel.currUnits=="SI")
			{
				return this._supplyAirSetpointTemp
			}
			else
			{
				return Conversions.celToFarh(_supplyAirSetpointTemp)
			}
		}
		
		
		
		
	}
}