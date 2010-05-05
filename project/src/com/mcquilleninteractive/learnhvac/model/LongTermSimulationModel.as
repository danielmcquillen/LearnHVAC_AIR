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
		public static const SHELL_TYPE_NEW:String = "new"
		
		public static const WINDOW_STYLE_PUNCH:String = "punch";
		public static const WINDOW_STYLE_STRIP:String = "strip";
	
		public static const NORTH:String = "north"
		public static const SOUTH:String = "south"
		public static const WEST:String = "west"
		public static const EAST:String = "east" 
		
		public var buildingPropertiesEnabled:Boolean = true
										
		/* *********** SIMULATION PROPERTIES *********** */
						
		protected var _runID:String 
		protected var _timeStepEP:int
		
		/* *********** ZONE AND FLOOR *********** */
		
		protected var _zoneOfInterest:int
		protected var _floorOfInterest:int
		
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
		
		
		protected var _regionSelectedIndex:uint
		protected var _citySelectedIndex:uint
		
		
		/* *********** BUILDLING PROPERTIES *********** */
		
		public var windowTypesAC:ArrayCollection = new ArrayCollection( [	{label:"punch", data:"punch"},
																			{label:"strip", data:"strip"}] )
		
		public var massLevelsAC:ArrayCollection = new ArrayCollection([ {label:"low", data:"low"},
																		{label:"medium", data:"medium"},
																		{label:"high", data:"high"} ])
	
		public var _storyHeight:Number 
		public var _buildingLength:Number 
		public var _buildingWidth:Number
		
		protected var _windowTypeSelectedIndex:uint
		protected var _shell:String
		protected var _stories:int 	
		protected var _windowStyle:String
		protected var _northAxis:Number 		
		protected var _massLevelSelectedIndex:uint 	
		protected var _windowRatioNorth:Number;
		protected var _windowRatioSouth:Number 
		protected var _windowRatioEast:Number 
		protected var _windowRatioWest:Number
						
		public var _areaPerPerson:Number 
		public var _equipPeakLoad:Number
		public var _lightingPeakLoad:Number = 23.69
		
			
		/* *********** DATE PROPERTIES *********** */
		
		protected var _startDate:Date
		protected var _stopDate:Date
				
		protected var _wddStartDate:Date 
		protected var _wddStopDate:Date 
		protected var _wddTypeOfDD:String 
		
		protected var _sddStartDate:Date 
		protected var _sddStopDate:Date 
		protected var _sddTypeOfDD:String 
				
		protected var _weekdayBegin:int 
		protected var _weekdayEnd:int 
		protected var _holidayBegin:int
		protected var _holidayEnd:int 
		
		protected var _ddCooling:String
		protected var _ddHeating:String
		protected var _ddOther:String	
				
		
		/* *********** ZONE HEATING AND COOLING PROPERTIES *********** */
		 
       	protected var _zoneHeatingSetpointTemp:Number
		protected var _zoneCoolingSetpointTemp:Number
		
		
		public function LongTermSimulationModel()
		{
			init()			
		}
		
		public function init():void
		{
			
			buildingPropertiesEnabled = false
									
			_runID = LongTermSimulationDataModel.RUN_1 //default to run 1
			_timeStepEP = 1
				
			_zoneOfInterest = 1
			_floorOfInterest = 2
		
			_regionSelectedIndex = 0
			_citySelectedIndex = 0
		
			_storyHeight = 3.6576 //12 feet
			_buildingLength = 30 
			_buildingWidth = 40
			
			_windowTypeSelectedIndex = 0
			_shell = LongTermSimulationModel.SHELL_TYPE_NEW
			_stories = 3		
			_windowStyle = LongTermSimulationModel.WINDOW_STYLE_PUNCH
			_northAxis = 0;		
			_massLevelSelectedIndex = 0		
			_windowRatioNorth = .4;
			_windowRatioSouth = .4;
			_windowRatioEast = .4;
			_windowRatioWest = .4;
							
			_areaPerPerson = 10.764		//1.0 in IP
			_equipPeakLoad = 10.764		//1.0 in IP
			 _lightingPeakLoad = 23.69		//255 sq. ft
						
			_weekdayBegin = 8
			_weekdayEnd = 17
			_holidayBegin = 10
			_holidayEnd = 15	
			
			_startDate = new Date("",0,1)
			_stopDate = new Date("",0, 31)
					
			_wddStartDate = new Date("",0,21)
			_wddStopDate = new Date("", 0,21)
			_wddTypeOfDD = "Winter Typical"
			
			_sddStartDate = new Date("", 5,21)
			_sddStopDate = new Date("", 5,21)
			_sddTypeOfDD = "Summer Typical"
					
			_weekdayBegin = 8
			_weekdayEnd = 17
			_holidayBegin = 10
			_holidayEnd = 15	
		}		
						
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
		
		
				
		
		public function get city():String
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
					var cityName:String = northeastCitiesAC.getItemAt(citySelectedIndex).label
					break
				case "South":
					//return southCitiesAC.getItemAt(citySelectedIndex).data
					var cityName:String = southCitiesAC.getItemAt(citySelectedIndex).label				
					break
				default:
					Logger.error("unexpected region index", this)
			}
			//return regionsAC.getItemAt(regionSelectedIndex).data
			cityName = cityName.replace(" ","")
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