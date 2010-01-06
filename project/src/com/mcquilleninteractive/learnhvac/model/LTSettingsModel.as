package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.util.Conversions;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class LTSettingsModel extends EventDispatcher
	{
		
		public static const SHELL_TYPE_NEW:String = "new"
		
		public static const WINDOW_STYLE_PUNCH:String = "punch";
		public static const WINDOW_STYLE_STRIP:String = "strip";
	
		public static const NORTH:String = "north"
		public static const SOUTH:String = "south"
		public static const WEST:String = "west"
		public static const EAST:String = "east" 

		public var buildingPropertiesEnabled:Boolean = false
		
		public var runID:String

		public function LTSettingsModel()
		{
			var arr:Array = [  	{label:"low", data:"low"},
								{label:"medium", data:"medium"},
								{label:"high", data:"high"} ]
			
			massLevelsAC = new ArrayCollection(arr)
		}

		/* *********** ZONE AND FLOOR *********** */
		
		
		private var _zoneOfInterest:uint = 1
		private var _floorOfInterest:uint = 2

		public function set zoneOfInterest(val:uint):void
		{
			_zoneOfInterest = val
		}

		public function get zoneOfInterest():uint
		{
			return _zoneOfInterest
		}
		
		public function set floorOfInterest(val:uint):void
		{
			_floorOfInterest = val
		}

		public function get floorOfInterest():uint
		{
			return _floorOfInterest
		}
	
		public function getCurrentZoneSize():Number
		{
			//temp
			return 100
		}




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
		
		
		public var regionSelectedIndex:uint = 0
		public var citySelectedIndex:uint = 0
				
		/* *********** BUILDLING PROPERTIES *********** */
		
		public var windowTypesAC:ArrayCollection = new ArrayCollection( [	{label:"punch", data:"punch"},
																			{label:"strip", data:"strip"}] )
		public var windowTypeSelectedIndex:uint = 0
		
		public var shell:String = LTSettingsModel.SHELL_TYPE_NEW
		public var stories:Number = 3
		public var _storyHeight:Number = 3.6576 //12 feet
		public var _buildingLength:Number = 24.38 
		public var _buildingWidth:Number = 38.1
		
		public var windowStyle:String = LTSettingsModel.WINDOW_STYLE_PUNCH
		public var northAxis:Number = 0;
		
		public var massLevelSelectedIndex:uint = 0
		
		public var windowRatioNorth:Number = .4;
		public var windowRatioSouth:Number = .4;
		public var windowRatioEast:Number = .4;
		public var windowRatioWest:Number = .4;
		
		public var massLevelsAC:ArrayCollection 
		
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
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
			{
				_buildingWidth = Conversions.feetToMeters(v)				
			}
			else
			{
				_buildingWidth = v
			}
		}
		
		
		/* *********** LOADS PROPERTIES *********** */
		
		public var _equipPeakLoad:Number = 10.7639104		//1.0
		public var _lightingPeakLoad:Number = 10.7639104 	//1.0 
		public var _areaPerPerson:Number = 23.69  			//255 sq ft / person
		
		public function get equipPeakLoad():Number
		{
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
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
			if (LHModelLocator.currUnits=="IP")
			{
				_areaPerPerson = Conversions.ft2ToM2(v)				
			}
			else
			{
				_areaPerPerson = v
			}
		}
		
		
		
		/* *********** DATE PROPERTIES *********** */
		
		public var startDate:Date = new Date("",0,1)
		public var stopDate:Date = new Date("",0, 31)
				
		public var wddStartDate:Date = new Date("",0,21)
		public var wddStopDate:Date = new Date("", 0,21)
		public var wddTypeOfDD:String = "Winter Typical"
		
		public var sddStartDate:Date = new Date("", 5,21)
		public var sddStopDate:Date = new Date("", 5,21)
		public var sddTypeOfDD:String = "Summer Typical"
				
		public var weekdayBegin:Number = 8
		public var weekdayEnd:Number = 17
		public var holidayBegin:Number = 10
		public var holidayEnd:Number = 15	
		
		public var ddCooling:String
		public var ddHeating:String
		public var ddOther:String
				
		
		/* *********** ZONE HEATING AND COOLING PROPERTIES *********** */
		 
       	protected var _zoneHeatingSetpointTemp:Number
		protected var _zoneCoolingSetpointTemp:Number
		
				
        public function set zoneHeatingSetpointTemp(value:Number):void
        {
        	if (LHModelLocator.currUnits=="SI")
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
        	if (LHModelLocator.currUnits=="SI")
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
        	if (LHModelLocator.currUnits=="SI")
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
        	if (LHModelLocator.currUnits=="SI")
			{
				return _zoneCoolingSetpointTemp
			}
			else
			{
				return Conversions.celToFarh(_zoneCoolingSetpointTemp)
			}
        }
  
     
		
		/* *********** SIMUULATION PROPERTIES *********** */
				
		public var timeStepEP:Number = 1
		
		/*		
			private function onBuildingAgeChange():void
			{
				var units:String = LHModelLocator.currUnits
				
				
				switch (cboBuildingAge.selectedItem.data)
				{
					case "old":
						if (units=="SI")
						{
							txtLightingPeakLoad.text = "16.4"
							txtEquipPeakLoad.text = "5.38"
						}
						else
						{
							txtLightingPeakLoad.text = "1.5"
							txtEquipPeakLoad.text = ".5"
						}
						break
						
					case "recent":
						if (units=="SI")
						{
							txtLightingPeakLoad.text = "13.99"
							txtEquipPeakLoad.text = "8.07"
						}
						else
						{
							txtLightingPeakLoad.text = "1.3"
							txtEquipPeakLoad.text = ".75"
						}
						break
						
					case "new":
						if (units=="SI")
						{
							txtLightingPeakLoad.text = "10.76"
							txtEquipPeakLoad.text = "10.76"
						}
						else
						{
							txtLightingPeakLoad.text = "1.0"
							txtEquipPeakLoad.text = "1.0"
						}
						break
						
					default:
						Logger.error("#LTS: onBuildingAgeChange() unrecognized data: " + cboBuildingAge.selectedItem.data)
				}				
			}*/
		
		
		

	}
}