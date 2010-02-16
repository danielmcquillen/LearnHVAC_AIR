package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.event.ZoneChangeEvent;
	import com.mcquilleninteractive.learnhvac.util.Conversions;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import org.swizframework.Swiz;
	
	/** Class LongTermSimulationModel
	 * 
	 *  This class holds the data needed for each run of the long-term simulation (E+)
	 */
	
	[Bindable]
	public class LongTermSimulationModel extends EventDispatcher
	{
		public static const SHELL_TYPE_NEW:String = "new"
		
		public static const WINDOW_STYLE_PUNCH:String = "punch";
		public static const WINDOW_STYLE_STRIP:String = "strip";
	
		public static const NORTH:String = "north"
		public static const SOUTH:String = "south"
		public static const WEST:String = "west"
		public static const EAST:String = "east" 
		
		public var buildingPropertiesEnabled:Boolean = false
		
				
		public function LongTermSimulationModel()
		{			
		}
					
		/* *********** SIMULATION PROPERTIES *********** */
						
		protected var _runID:String = LongTermSimulationDataModel.RUN_1 //default to run 1
		protected var _timeStepEP:int = 1
		
		/* *********** ZONE AND FLOOR *********** */
		
		protected var _zoneOfInterest:uint = 1
		protected var _floorOfInterest:uint = 2
		
		/* *********** ENVIRONMENT *********** */
				
		public var regionsAC:ArrayCollection = new ArrayCollection([	{label:"Pacific", data:"Pacific"},
																		{label:"Northeast", data:"Northeast"},
																		{label:"South", data:"South"}
																	]);


		public var pacificCitiesAC:ArrayCollection = new ArrayCollection([{label:"San Francisco", data:"SanFrancisco"},
												{label:"Los Angeles", data:"LosAngeles"},
												{label:"Phoenix", data:"Phoenix"},
												{label:"Salem", data:"Salem"},
												{label:"Boise", data:"Boise"},
												{label:"Helena", data:"Helena"}
												])

		public var northeastCitiesAC:ArrayCollection = new ArrayCollection([{label:"Baltimore", data:"Baltimore"},
												{label:"Burlington", data:"Burlington"},
												{label:"Chicago", data:"Chicago"},
												{label:"Duluth", data:"Duluth"},
												{label:"Fairbanks", data:"Fairbanks"}	
												]);
		
		public var southCitiesAC:ArrayCollection = new ArrayCollection([{label:"Miami", data:"Miami"},
												{label:"Houston", data:"Houston"},
												{label:"Memphis", data:"Memphis"},
												{label:"El Paso", data:"ElPaso"},
												{label:"Albuquerque", data:"Albuquerque"}	
												]);
		
		
		protected var _regionSelectedIndex:uint = 0
		protected var _citySelectedIndex:uint = 0
		
		
		/* *********** BUILDLING PROPERTIES *********** */
		
		public var windowTypesAC:ArrayCollection = new ArrayCollection( [	{label:"punch", data:"punch"},
																			{label:"strip", data:"strip"}] )
		
		public var massLevelsAC:ArrayCollection = new ArrayCollection([ {label:"low", data:"low"},
																		{label:"medium", data:"medium"},
																		{label:"high", data:"high"} ])
	
		public var _storyHeight:Number = 3.6576 //12 feet
		public var _buildingLength:Number = 24.38 
		public var _buildingWidth:Number = 38.1
		
		protected var _windowTypeSelectedIndex:uint = 0
		protected var _shell:String = LongTermSimulationModel.SHELL_TYPE_NEW
		protected var _stories:int = 3		
		protected var _windowStyle:String = LongTermSimulationModel.WINDOW_STYLE_PUNCH
		protected var _northAxis:Number = 0;		
		protected var _massLevelSelectedIndex:uint = 0		
		protected var _windowRatioNorth:Number = .4;
		protected var _windowRatioSouth:Number = .4;
		protected var _windowRatioEast:Number = .4;
		protected var _windowRatioWest:Number = .4;
						
		public var _areaPerPerson:Number = 10.764		//1.0 in IP
		public var _equipPeakLoad:Number = 10.764		//1.0 in IP
		public var _lightingPeakLoad:Number = 23.69		//255 sq. ft
		
			
		/* *********** DATE PROPERTIES *********** */
		
		protected var _startDate:Date = new Date("",0,1)
		protected var _stopDate:Date = new Date("",0, 31)
				
		protected var _wddStartDate:Date = new Date("",0,21)
		protected var _wddStopDate:Date = new Date("", 0,21)
		protected var _wddTypeOfDD:String = "Winter Typical"
		
		protected var _sddStartDate:Date = new Date("", 5,21)
		protected var _sddStopDate:Date = new Date("", 5,21)
		protected var _sddTypeOfDD:String = "Summer Typical"
				
		protected var _weekdayBegin:int = 8
		protected var _weekdayEnd:int = 17
		protected var _holidayBegin:int = 10
		protected var _holidayEnd:int = 15	
		
		protected var _ddCooling:String
		protected var _ddHeating:String
		protected var _ddOther:String	
				
		
		/* *********** ZONE HEATING AND COOLING PROPERTIES *********** */
		 
       	protected var _zoneHeatingSetpointTemp:Number
		protected var _zoneCoolingSetpointTemp:Number
				
				
				
				
				
				
				
				
		
		/* ****************************************** */
		/* *********** GETTER AND SETTERS *********** */
		/* ****************************************** */
		
		public function get runID():String
		{
			return _runID
		}
		public function set runID(value:String):void
		{
			_runID = value
		}
		
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
			
		public function get floorOfInterest():uint
		{
			return _floorOfInterest
		}
		public function set floorOfInterest(val:uint):void
		{
			_floorOfInterest = val
		}
		
		public function get citySelectedIndex():uint
		{
			return _citySelectedIndex
		}
		public function set citySelectedIndex(val:uint):void
		{
			_citySelectedIndex = val
		}

		public function get timeStepEP():uint
		{
			return _timeStepEP
		}
		public function set timeStepEP(val:uint):void
		{
			_timeStepEP = val
		}

		public function get regionSelectedIndex():uint
		{
			return _regionSelectedIndex
		}
		public function set regionSelectedIndex(val:uint):void
		{
			_regionSelectedIndex = val
		}		
	
		public function getCurrentZoneSize():Number
		{			
			//temp
			return 100
		}
		
		
		public function get windowTypeSelectedIndex():uint
		{
			return _windowTypeSelectedIndex
		}
		
		public function set windowTypeSelectedIndex(value:uint):void
		{
			_windowTypeSelectedIndex = value
		}
		
		public function get shell():String
		{
			return _shell
		}		
		public function set shell(value:String):void
		{
			_shell = value
		}
		
		public function get stories():int
		{
			return _stories
		}		
		public function set stories(value:int):void
		{
			_stories = value
		}
		
		public function get windowStyle():String
		{
			return _windowStyle
		}		
		public function set windowStyle(value:String):void
		{
			_windowStyle = value
		}
	
		public function get northAxis():Number
		{
			return _northAxis
		}		
		public function set northAxis(value:Number):void
		{
			_northAxis = value
		}
	
		public function get massLevelSelectedIndex():uint
		{
			return _massLevelSelectedIndex
		}		
		public function set massLevelSelectedIndex(value:uint):void
		{
			_massLevelSelectedIndex = value
		}
		
		public function get windowRatioNorth():Number
		{
			return _windowRatioNorth
		}		
		public function set windowRatioNorth(value:Number):void
		{
			_windowRatioNorth = value
		}
		
		public function get windowRatioSouth():Number
		{
			return _windowRatioSouth
		}		
		public function set windowRatioSouth(value:Number):void
		{
			_windowRatioSouth = value
		}
				
		public function get windowRatioEast():Number
		{
			return _windowRatioEast
		}		
		public function set windowRatioEast(value:Number):void
		{
			_windowRatioEast = value
		}
		
		public function get windowRatioWest():Number
		{
			return _windowRatioWest
		}		
		public function set windowRatioWest(value:Number):void
		{
			_windowRatioWest = value
		}
		
		public function get massLevel():String
		{
			return massLevelsAC.getItemAt(massLevelSelectedIndex).data
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
		
		
				
		public function get weatherFile():String
		{							
			//set appropriate weatherfile
			switch(this.city)
			{
				case "Baltimore":
					return "USA_MD_Baltimore-Washington.Intl.AP_TMY3.epw"
					break
				case "Burlington":
					return "USA_VT_Burlington.Intl.AP_TMY3.epw"
					break
				case "Chicago":
					return "USA_IL_Chicago-OHare.Intl.AP_TMY3.epw"
					break
				case "Duluth":
					return "USA_MN_Duluth_TMY2.epw"
					break
				case "Fairbanks":
					return "USA_AK_Fairbanks_TMY2.epw"
					break
				case "Miami":
					return "USA_FL_Miami_TMY2.epw"
					break
				case "Houston":
					return "USA_TX_Houston-Intercontinental_TMY2.epw"
					break
				case "Memphis":
					return "USA_TN_Memphis_TMY2.epw"
					break
				case "ElPaso":
					return "USA_TX_El.Paso_TMY2.epw"
					break
				case "Albuquerque":
					return "USA_NM_Albuquerque_TMY2.epw"
					break
				case "SanFrancisco":
					return "USA_CA_San.Francisco_TMY2.epw"
					break
				case "LosAngeles":
					return "USA_CA_Los.Angeles_TMY2.epw"
					break
				case "Phoenix":
					return "USA_AZ_Phoenix_TMY2.epw"
					break
				case "Salem":
					return "USA_OR_Salem_TMY2.epw"
					break
				case "Boise":
					return "USA_ID_Boise_TMY2.epw"
					break
				case "Helena":
					return "USA_MT_Helena_TMY2.epw"
					break
				default:					
					Logger.error("unrecognized city. Setting to San Francisco", this)
					return "USA_CA_San.Francisco_TMY2.epw"
					
			}
		

		}
		
		public function get city():String
		{
			//This is kind of hokey but works for now...
			switch (regionsAC.getItemAt(regionSelectedIndex).data)
			{
				case "Pacific":
					return pacificCitiesAC.getItemAt(citySelectedIndex).data
					break
				case "Northeast":				
					return northeastCitiesAC.getItemAt(citySelectedIndex).data
					break
				case "South":
					return southCitiesAC.getItemAt(citySelectedIndex).data				
					break
				default:
					Logger.error("unexpected region index", this)
			}
			return regionsAC.getItemAt(regionSelectedIndex).data
		}
		
		public function get ratioBldg():Number
		{
			if (windowRatioNorth==0&&windowRatioEast==0&&windowRatioSouth==0&&windowRatioWest==0)
			{
				Logger.debug("#LongTermSimulationVO: Note: return 0 for window-to-wall ratio for building, since no facades have window-to-wall rations > 0.")
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
		
		public function get sddStartDate():Date { return _sddStartDate }
		public function set sddStartDate(value:Date):void { _sddStartDate = value }
		
		public function get sddStopDate():Date { return _sddStopDate }
		public function set sddStopDate(value:Date):void { _sddStopDate = value }
		
		public function get wddStartDate():Date { return _wddStartDate }
		public function set wddStartDate(value:Date):void { _wddStartDate = value }
		
		public function get wddStopDate():Date { return _wddStopDate }
		public function set wddStopDate(value:Date):void { _wddStopDate = value }
		
		public function get startDate():Date { return _startDate }
		public function set startDate(value:Date):void { _startDate = value }
		
		public function get stopDate():Date { return _stopDate }
		public function set stopDate(value:Date):void { _stopDate = value }
		
		public function get sddTypeOfDD():String { return _sddTypeOfDD }
		public function set sddTypeOfDD(value:String):void { _sddTypeOfDD = value }
		
		public function get wddTypeOfDD():String { return _wddTypeOfDD }
		public function set wddTypeOfDD(value:String):void  { _wddTypeOfDD = value }
		
		public function get weekdayBegin():int { return _weekdayBegin }
		public function set weekdayBegin(value:int):void  { _weekdayBegin = value }
		
		public function get weekdayEnd():int { return _weekdayEnd }
		public function set weekdayEnd(value:int):void  { _weekdayEnd = value }
		
		public function get holidayBegin():int { return _holidayBegin }
		public function set holidayBegin(value:int):void  { _holidayBegin = value }
		
		public function get holidayEnd():int { return _holidayEnd }
		public function set holidayEnd(value:int):void  { _holidayEnd = value }
		
		public function get ddCooling():String { return _ddCooling }
		public function set ddCooling(value:String):void  { _ddCooling = value }
		
		public function get ddHeating():String { return _ddHeating }
		public function set ddHeating(value:String):void  { _ddHeating = value }
		
		public function get ddOther():String { return _ddOther }
		public function set ddOther(value:String):void  { _ddOther = value }
		
				
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
  
     
	

	}
}