package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.event.ZoneChangeEvent;
	import com.mcquilleninteractive.learnhvac.model.data.ZoneEnergyUseDataPoint;
	import com.mcquilleninteractive.learnhvac.util.Conversions;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import org.swizframework.Swiz;
	
	/** Class LongTermSimulationModel
	 * 
	 *  This class holds the data needed to configure
	 *  each run of the long-term simulation (E+). It does not hold the actual data
	 *  that results from each run (that happens in LongTermSimulationDataModel).
	 *  
	 *  TODO: Add a memento so that when users switches between runs, this
	 *        model will remember the settings for that run.
	 */
	
	[Bindable]
	public class LongTermSimulationModel extends EventDispatcher
	{
		public static const STATE_RUNNING:String = "longTermSimRunning"
		public static const STATE_OFF:String = "longTermSimOff"
			
		
		public static const SHELL_TYPE_NEW:String = "new"
			
		public static const WINDOW_STYLE_PUNCH:String = "punch";
		public static const WINDOW_STYLE_STRIP:String = "strip";
	
		public static const NORTH:String = "north"
		public static const SOUTH:String = "south"
		public static const WEST:String = "west"
		public static const EAST:String = "east" 
		
										
		/* *********** SIMULATION PROPERTIES *********** */
		
		public var currentState:String 
		public var runID:String 
		public var timeStepEP:int
		
		/* *********** ZONE AND FLOOR *********** */
		
		public var _zoneOfInterest:int
		public var floorOfInterest:int
		
		/* *********** ENVIRONMENT *********** */
		
		public var selectedWeatherFileName:String = "" //set by user to one of the values below...
		
		public var regionsAC:ArrayCollection = new ArrayCollection([	{label:"Pacific", data:"Pacific"},
																		{label:"Northeast", data:"Northeast"},
																		{label:"South", data:"South"}
																	]);


		public var pacificCitiesAC:ArrayCollection = new ArrayCollection([{label:"San Francisco", data:"USA_CA_San.Francisco.Intl.AP.724940_TMY3.epw"},
												{label:"Los Angeles", data:"USA_CA_Los.Angeles.Intl.AP.722950_TMY3.epw"},
												{label:"Phoenix", data:"USA_AZ_Phoenix-Deer.Valley.AP.722784_TMY3.epw"},
												{label:"Salem", data:"USA_OR_Salem-McNary.Field.726940_TMY3.epw"},
												{label:"Boise", data:"USA_ID_Boise.Air.Terminal.726810_TMY3.epw"},
												{label:"Helena", data:"USA_MT_Helena.Rgnl.AP.727720_TMY3.epw"}
												])

		public var northeastCitiesAC:ArrayCollection = new ArrayCollection([{label:"Baltimore", data:"USA_MD_Baltimore-Washington.Intl.AP.724060_TMY3.epw"},
												{label:"Burlington", data:"USA_VT_Burlington.Intl.AP.726170_TMY3.epw"},
												{label:"Chicago", data:"USA_IL_Chicago-Midway.AP.725340_TMY3.epw"},
												{label:"Duluth", data:"USA_MN_Duluth.Intl.AP.727450_TMY3.epw"},
												{label:"Fairbanks", data:"USA_AK_Fairbanks.Intl.AP.702610_TMY3.epw"}	
												]);
		
		public var southCitiesAC:ArrayCollection = new ArrayCollection([{label:"Miami", data:"USA_FL_Miami-Kendall-Tamiami.Executive.AP.722029_TMY3.epw"},
												{label:"Houston", data:"USA_TX_Houston-Bush.Intercontinental.AP.722430_TMY3.epw"},
												{label:"Memphis", data:"USA_TN_Memphis.Intl.AP.723340_TMY3.epw"},
												{label:"El Paso", data:"USA_TX_El.Paso.Intl.AP.722700_TMY3.epw"},
												{label:"Albuquerque", data:"USA_NM_Albuquerque.Intl.AP.723650_TMY3.epw"}	
												]);
		
		
		public var regionSelectedIndex:uint
		public var citySelectedIndex:uint
		
		
		/* *********** BUILDLING PROPERTIES *********** */
		
		public var windowTypesAC:ArrayCollection = new ArrayCollection( [	{label:"strip", data:"strip"},
																			{label:"punch", data:"punch"}
																			] )
		
		public var massLevelsAC:ArrayCollection = new ArrayCollection([ {label:"low", data:"low"},
																		{label:"medium", data:"medium"},
																		{label:"high", data:"high"} ])
	
		public var _storyHeight:Number 
		public var _buildingLength:Number 
		public var _buildingWidth:Number
		
		public var windowTypeSelectedIndex:uint 
		public var shell:String
		public var stories:int 	
		public var windowType:String
		public var northAxis:Number 		
		public var massLevelSelectedIndex:uint 	
		public var windowRatioNorth:Number;
		public var windowRatioSouth:Number 
		public var windowRatioEast:Number 
		public var windowRatioWest:Number
						
		public var _areaPerPerson:Number 
		public var _equipPeakLoad:Number
		public var _lightingPeakLoad:Number
		
			
		/* *********** DATE PROPERTIES *********** */
		
		public var startDate:Date
		public var stopDate:Date
				
		public var wddStartDate:Date 
		public var wddStopDate:Date 
		public var wddTypeOfDD:String 
		
		public var sddStartDate:Date 
		public var sddStopDate:Date 
		public var sddTypeOfDD:String 
				
		public var weekdayBegin:int 
		public var weekdayEnd:int 
		public var holidayBegin:int
		public var holidayEnd:int 
		
		public var ddCooling:String
		public var ddHeating:String
		public var ddOther:String	
				
		
		/* *********** PROPERTIES IMPORTED FROM SHORT-TERM *********** */
		 
		public var _zoneHeatingSetpointTemp:Number
		public var _zoneCoolingSetpointTemp:Number
		public var _supplyAirSetpointTemp:Number
		public var vavMinFlwRatio:Number
		public var rmQSens:Number
		public var vavHcQd:Number
		public var hcUA:Number
		public var ccUA:Number
		public var fanPwr:Number
		
		
		
		
		public function LongTermSimulationModel()
		{
			init()			
		}
		
		public function init():void
		{				
			
			currentState = STATE_OFF
			
			_zoneHeatingSetpointTemp = 0
			_zoneCoolingSetpointTemp = 0
			_supplyAirSetpointTemp = 0
			vavMinFlwRatio = 0
			rmQSens = 0
			vavHcQd = 0
			hcUA = 0
			ccUA = 0
			fanPwr= 0
			
			
									
			runID = LongTermSimulationDataModel.RUN_1 //default to run 1
			timeStepEP = 1
				
			zoneOfInterest = 1
			floorOfInterest = 2
		
			regionSelectedIndex = 0
			citySelectedIndex = 0
		
			_storyHeight = 3.6576 //12 feet
			_buildingLength = 30.48 
			_buildingWidth = 30.48
			
			windowTypeSelectedIndex = 0
			shell = LongTermSimulationModel.SHELL_TYPE_NEW
			stories = 3		
			windowType = LongTermSimulationModel.WINDOW_STYLE_STRIP
			windowTypeSelectedIndex = 0
			northAxis = 0;		
			massLevelSelectedIndex = 0		
			windowRatioNorth = .4;
			windowRatioSouth = .4;
			windowRatioEast = .4;
			windowRatioWest = .4;
							
			_areaPerPerson = 10.764		//1.0 in IP
			_equipPeakLoad = 10.764		//1.0 in IP
			_lightingPeakLoad = 23.69		//255 sq. ft
						
			weekdayBegin = 8
			weekdayEnd = 17
			holidayBegin = 10
			holidayEnd = 15	
			
			startDate = new Date("",0,1)
			stopDate = new Date("",0, 31)
					
			wddStartDate = new Date("",0,21)
			wddStopDate = new Date("", 0,21)
			wddTypeOfDD = "Winter Typical"
			
			sddStartDate = new Date("", 5,21)
			sddStopDate = new Date("", 5,21)
			sddTypeOfDD = "Summer Typical"
					
			weekdayBegin = 8
			weekdayEnd = 17
			holidayBegin = 10
			holidayEnd = 15	
		}		
				
		
		
		/** Generate an ArrayCollection containing the inputs to EnergyPlus.
		 *  This information is put into generic objects with {name:, value_SI:, value_IP}  
		 *  The arrayCollection is used in the Analysis section to show the user what the inputs were*/
		public function getEnergyPlusInputsMemento():EnergyPlusInputMemento
		{
			var mem:EnergyPlusInputMemento = new EnergyPlusInputMemento()
			mem._areaPerPerson = this._areaPerPerson
			mem._buildingLength = this._buildingLength
			mem._buildingWidth = this._buildingWidth
			mem._equipPeakLoad = this._equipPeakLoad
			mem._lightingPeakLoad = this._lightingPeakLoad
			mem._storyHeight = this._storyHeight
			mem.city = this.getCity()
			mem.citySelectedIndex = this.citySelectedIndex
			mem.region = this.region
			mem.regionSelectedIndex = this.regionSelectedIndex
			mem.floorOfInterest = this.floorOfInterest
			mem.massLevel = this.massLevel
			mem.massLevelSelectedIndex = this.massLevelSelectedIndex
			mem.northAxis = this.northAxis
			mem.shell= this.shell
			mem.startDate = this.startDate
			mem.stopDate = this.stopDate
			mem.stories = this.stories
			mem.timeStepEP = this.timeStepEP
			mem.windowRatioEast = this.windowRatioEast
			mem.windowRatioNorth = this.windowRatioNorth
			mem.windowRatioSouth = this.windowRatioSouth
			mem.windowRatioWest = this.windowRatioWest
			mem.windowType = this.windowType
				
			//modelica input variables			
			mem._zoneCoolingSetpointTemp = this._zoneCoolingSetpointTemp
			mem._zoneHeatingSetpointTemp = this._zoneHeatingSetpointTemp
			mem._supplyAirSetpointTemp = this._supplyAirSetpointTemp
			mem.vavMinFlwRatio = vavMinFlwRatio
			mem.rmQSens = rmQSens
			mem.fanPwr = fanPwr
			mem.vavHcQd = vavHcQd
			mem.hcUA = hcUA
			mem.ccUA = ccUA
				
				
			return mem
		}
		
		
		
		/* ****************************************** */
		/* *********** GETTER AND SETTERS *********** */
		/* ****************************************** */
	
		
		public function get zoneOfInterest():uint
		{
			return _zoneOfInterest
		}					
		public function set zoneOfInterest(val:uint):void
		{
			var fromZone:uint = _zoneOfInterest
			_zoneOfInterest = val
			var evt:ZoneChangeEvent = new ZoneChangeEvent(ZoneChangeEvent.ZONE_CHANGED, true)
			evt.toZone = val
			evt.fromZone = fromZone
			Swiz.dispatchEvent(evt)
		}
			
		public function get massLevel():String
		{
			return massLevelsAC.getItemAt(massLevelSelectedIndex).data
		}
				
		public function getCurrentZoneSize():Number
		{			
			//temp
			return 100
		}
						
		public function get region():String
		{
			return regionsAC.getItemAt(regionSelectedIndex).data
		}
		
		public function set region(v:String):void
		{
			for (var i:uint = 0; i<regionsAC.length; i++)
			{
				if (regionsAC.getItemAt(i).data == v)
					regionSelectedIndex = i
			}
		}
		
		public function getCity(removeSpaces:Boolean = false):String
		{
			//This is kind of hokey but works for now...
			switch (regionsAC.getItemAt(regionSelectedIndex).data)
			{
				case "Pacific":
					//return pacificCitiesAC.getItemAt(citySelectedIndex).data
					var cityName:String = pacificCitiesAC.getItemAt(citySelectedIndex).label
					break
				case "Northeast":				
					//return northeastCitiesAC.getItemAt(citySelectedIndex).data
					cityName = northeastCitiesAC.getItemAt(citySelectedIndex).label
					break
				case "South":
					//return southCitiesAC.getItemAt(citySelectedIndex).data
					cityName = southCitiesAC.getItemAt(citySelectedIndex).label				
					break
				default:
					Logger.error("unexpected region index", this)
			}
			//return regionsAC.getItemAt(regionSelectedIndex).data
			if (removeSpaces)
			{
				cityName = cityName.replace(" ","")
			}
			return cityName
		}
		
		public function get ratioBldg():Number
		{
			if (windowRatioNorth==0&&windowRatioEast==0&&windowRatioSouth==0&&windowRatioWest==0)
			{
				Logger.debug("Note: return 0 for window-to-wall ratio for building, since no facades have window-to-wall rations > 0.", this)
				return 0
			}
			return ((windowRatioNorth * wallAreaNorth) + (windowRatioEast * wallAreaEast) + (windowRatioSouth * wallAreaSouth) + (windowRatioWest * wallAreaWest)) / ( wallAreaNorth + wallAreaEast + wallAreaSouth + wallAreaWest )  
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
			if (ApplicationModel.currUnits=="IP")
			{
				return Conversions.metersToFeet(_storyHeight)				
			}
			else
			{
				return _storyHeight
			}
		}
		
		public function set storyHeight(v:Number):void
		{
			if (ApplicationModel.currUnits=="IP")
			{
				_storyHeight = Conversions.feetToMeters(v)				
			}
			else
			{
				_storyHeight = v
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
		
		public function set equipPeakLoad(v:Number):void
		{
			if (ApplicationModel.currUnits=="IP")
			{
				_equipPeakLoad = Conversions.wattsPerSqFttoWattsPerSqM(v)				
			}
			else
			{
				_equipPeakLoad = v
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
		
		public function set lightingPeakLoad(v:Number):void
		{
			if (ApplicationModel.currUnits=="IP")
			{
				_lightingPeakLoad = Conversions.wattsPerSqFttoWattsPerSqM(v)				
			}
			else
			{
				_lightingPeakLoad = v
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
		
		public function set areaPerPerson(v:Number):void
		{
			if (ApplicationModel.currUnits=="IP")
			{
				_areaPerPerson = Conversions.ft2ToM2(v)				
			}
			else
			{
				_areaPerPerson = v
			}
		}
		
				
        public function set zoneHeatingSetpointTemp(value:Number):void
        {
        	if (ApplicationModel.currUnits=="SI")
			{
				_zoneHeatingSetpointTemp = value
			}
			else
			{
				_zoneHeatingSetpointTemp = Conversions.farhToCel(value)
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
        
        public function set zoneCoolingSetpointTemp(value:Number):void
        {
        	if (ApplicationModel.currUnits=="SI")
			{
				_zoneCoolingSetpointTemp = value
			}
			else
			{
				_zoneCoolingSetpointTemp = Conversions.farhToCel(value)
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
		
		
		public function set supplyAirSetpointTemp(value:Number):void
		{
			if (ApplicationModel.currUnits=="SI")
			{
				_supplyAirSetpointTemp = value
			}
			else
			{
				_supplyAirSetpointTemp = Conversions.farhToCel(value)
			}
		}
		
		public function get supplyAirSetpointTemp():Number
		{
			if (ApplicationModel.currUnits=="SI")
			{
				return _supplyAirSetpointTemp
			}
			else
			{
				return Conversions.celToFarh(_supplyAirSetpointTemp)
			}
		}
		
		
				
		public function getWidthForElevation(currElevationView:String, units:String=""):Number
		{
			if (units=="") units = ApplicationModel.currUnits				
			var width:Number
			
			if (currElevationView == LongTermSimulationModel.NORTH || currElevationView == LongTermSimulationModel.SOUTH)
			{
				if (units=="SI")
				{
					width = _buildingWidth
				}
				else
				{
					width = buildingWidth
				}
			}
			else
			{
				if (units=="SI")
				{
					width = _buildingLength
				}
				else
				{
					width = buildingLength
				}	
			}
			return width
		}
		
		public function getWindowRatioForElevation(currElevationView:String):Number
		{
			var windowRatio:Number 
			switch (currElevationView)
			{
				case LongTermSimulationModel.NORTH:
					windowRatio = windowRatioNorth
					break
				case LongTermSimulationModel.SOUTH:
					windowRatio = windowRatioSouth
					break
				case LongTermSimulationModel.EAST:
					windowRatio = windowRatioEast
					break
				case LongTermSimulationModel.WEST:
					windowRatio = windowRatioWest
					break
				default:
					Logger.error("on_elevationViewChange() unrecognized _elevationView: " + currElevationView, this)
					return .5
			}	
			return windowRatio
		}
		
	

	}
}