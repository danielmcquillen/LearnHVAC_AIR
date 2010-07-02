package com.mcquilleninteractive.learnhvac.model.data
{
	import com.mcquilleninteractive.learnhvac.err.EPlusParseError;
	import com.mcquilleninteractive.learnhvac.model.EnergyPlusInputMemento;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.DateUtil;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.LongTermValuesForShortTermSimVO;
	
	import mx.collections.ArrayCollection;
	
	import org.swizframework.Swiz;
	
	[Bindable]
	public class EnergyPlusData extends BaseSimData implements IGraphDataModel
	{
		// type of data for analysis section
		public static const ENERGY_PLUS_DATA_TYPE:String = "energyPlusDataType"; // for graphing
				
		/* zoneDataArray is a three dimensional array that holds a LongTermValuesForShortTermSimVO object for each time increment of E+ data
		   The 3d array allows us to get the correct object for the current floor and zone selected by the user
		
		          zoneDataArr [rowIndex of EPlus Results][floorIndex][zoneIndex] -> contains LongTermValuesForShortTermSimVO for that zone		
		
		*/
		public var floorZoneDataArr:Array
		
		
		/* dataArr holds the actual data for each variable (e.g. dataAr[3] = [0,1,2,0,1....] where 3 is column index 3)*/
		public var dataArr:Array			
		
		//remember inputs that fed into this run
		public var energyPlusInputsMemento:EnergyPlusInputMemento
		
		//resultInputAC holds data that will be pushed back in short-term simulation.
		//These values are held in LongTermValuesForShortTermSimVO	
		public var resultInputAC:ArrayCollection = new ArrayCollection()	
				
		public var dateTimeID:String = "Date/Time"
					
		//AC used for graphing hourly data
		public var hourlyMeterDataAC:ArrayCollection = new ArrayCollection() 
		//AC used for graphing monthly data
		public var monthlyMeterDataAC:ArrayCollection = new ArrayCollection() 
		
		//the main .csv outputted by E+
		protected var _outputCSV:String			
		
		//another E+ .csv file with only meter data
		protected var _meterDataCSV:String					
		
		//special array that holds computed RmQSens array (add colums 4,6,8 from output)
		protected var rmQSENSArr:Array					
		
		//holds arrays that hold values for each variable
		protected var _dataStructureXML:XML 		
		
		protected var _scenarioModel:ScenarioModel
		
		protected var _currYear:String 
		
		
	
		
		public var tempData:String = "Date/Time,PER-1T LIGHTS\n0" +
								" 07/01  01:00:00,0.0\n" + 
								" 07/01  01:01:00,2.0\n" + 
								" 07/01  01:02:00,1.0\n" 
		
		public function EnergyPlusData() 
		{
			dataArr = []
			rmQSENSArr = []
			_dataStructureXML = createBaseXML()
			
			// use the current year for timecode of output
			_currYear = String(new Date().fullYear)	
			
			
		}
		
		protected function createBaseXML():XML
		{
			var xml:XML = 	<VizTool dataSourceType="" dataSourcePath="" >
									<Campus>
										<Building>										
											<Floor label="Floor 1">
												<Zone label="Zone 1"/>
												<Zone label="Zone 2"/>
												<Zone label="Zone 3"/>
												<Zone label="Zone 4"/>
												<Zone label="Zone 5"/>
											</Floor>											
											<Floor label="Floor 2">
												<Zone label="Zone 1"/>
												<Zone label="Zone 2"/>
												<Zone label="Zone 3"/>
												<Zone label="Zone 4"/>
												<Zone label="Zone 5"/>
											</Floor>											
											<Floor label="Floor 3">
												<Zone label="Zone 1"/>
												<Zone label="Zone 2"/>
												<Zone label="Zone 3"/>
												<Zone label="Zone 4"/>
												<Zone label="Zone 5"/>
											</Floor>
										</Building>
									</Campus>
								</VizTool>
			return xml
		}
			
		

		public function varExists(varID:String):Boolean
		{
			return (dataArr[varID]!=undefined)
		}
		
		public function get dataType():String
		{
			return ENERGY_PLUS_DATA_TYPE
		}
		
		public function get dataStructureXML():XML
		{
			return _dataStructureXML
		}
		
		public function set dataStructureXML(dataXML:XML):void
		{
			_dataStructureXML = dataXML
		}
		
		/** Finds the inputs for a given dateTime, floor and zone (will only match by the hour) */
		public function getLongTermInputs(dateTime:Date, floorOfInterest:uint, zoneOfInterest:uint):LongTermValuesForShortTermSimVO
		{				
			Logger.debug("getLongTermInputs() dateTime: " + dateTime, this)
			
			var dataArrLength:int = dataArr[dateTimeID].length
			var floorZoneDataArrLength:int = floorZoneDataArr.length			
			
			if (dataArrLength != floorZoneDataArrLength)
			{
				Logger.warn("dataArr and zoneDataArr are supposed to be same length but aren't. dataArr.length " + dataArrLength + " zoneDataArrLength: " + floorZoneDataArrLength, this)
			}
					
			if (dataArrLength == 0 ) return null
			
			for (var i:uint = 0; i< dataArrLength-1; i++)
			{			
								
				var d1:Date = new Date(dataArr[dateTimeID][i])
				
				if (dateTime <= d1)
				{					
					var vo:LongTermValuesForShortTermSimVO = LongTermValuesForShortTermSimVO(floorZoneDataArr[i][floorOfInterest-1][zoneOfInterest-1])
					if (vo==null)
					{
						Logger.error("getLongTermInputs() have date for row " + i + " (" + d1.toUTCString() + " ) but there's no LongTermValuesForShortTermSimVO in floorZoneDataArrLength", this)
						return null
					}
					else
					{
						return vo
					}
				}
			}
			
			return null
		}
		
		
		/** Return the value of the requested variable at the closest matching time to the supplied time 
		 * 
		 *  @param varName can be one of these values "RmQSENSE", "TAirOut", "TwAirOut"
		 * 
		 */
		public function getVarAtTime(varName:String, atTime:Date, currValue:Number):Number
		{
				
			//check that varName exists
			var len:int = dataArr.length
			if (varName!="RmQSENS" && varName!="TAirOut" && varName!="TwAirOut")
			{
				Logger.error("getVariableAtTime() unrecognized variable name: " + varName, this)
				return currValue 
			}
			
			if (atTime==null)
			{
				Logger.error("getVarAtTime() atTime cannot be null", this)
				return currValue
			}
			
			//select data array to look up value in 
			var dataSetArr:Array 
			if (varName=="RmQSENS")
			{
				dataSetArr = rmQSENSArr
			}
			else 
			{
				if (varName=="TAirOut") 
				{
					dataSetArr = dataArr["Environment:Outdoor Dry Bulb [C](Hourly)"]
				}
				else
				{
					dataSetArr = dataArr["Environment:Outdoor Wet Bulb [C](Hourly)"]
				}
			}
						
			
			//now look for value at time closes to time in argument
			var dateTimeArr:Array = dataArr[dateTimeID] //convenience
			len = dateTimeArr.length
			var outVal:Number //value of variable to return 
			for (var i:int=0;i<len;i++)
			{
				var d:Date = new Date(dateTimeArr[i])
				if (atTime.month == d.month && atTime.date == d.date)
				{
					outVal = dataSetArr[i]
					Logger.debug("getVarAtTime() matched month: " + atTime.month + " date: " + atTime.date + ". Matching requested hours: " + atTime.hours + " against "+ d.hours + " outVal: " + outVal, this)
					//find closest hour at or earlier than requested time
					if (atTime.hours <= d.hours)
					{
						Logger.debug("returning outVal: " + outVal + " for variable: " + varName,this)
						return outVal
					}
				}
			}
			
			return currValue
			
		}
		
		public function getVarData(varIDs:Array, includeTime:Boolean):Array
		{
				
			//build array for graph
			var returnArr:Array = new Array()
			var varID:String = null
			
			//use the time array for the length of array (all arrays should have same length)
			var valuesLength:Number = dataArr[dateTimeID].length
			for (var index:Number=0;index<valuesLength;index++)
			{
				var obj:Object = new Object()
				if (includeTime)
				{
					obj.time = dataArr[dateTimeID][index]	
				}
				//add all variables sent in argument array to dataprovider
				for (var j:Number = 0; j<varIDs.length; j++)
				{
					varID = varIDs[j]
					obj["value"+(j+1)] = dataArr[varID][index]
				}
				returnArr.push(obj)		
			}
			
			/*
			Logger.debug("getVarData: returnArr.length " + returnArr.length)
			var len:uint = returnArr.length
			Logger.debug(" getVarData: returnArr[0] " + returnArr[0])
			Logger.debug(" getVarData: returnArr[0] " + returnArr[len-1])
			Logger.debug(" getVarData: returnArr[0].time " + returnArr[0].time)
			Logger.debug(" getVarData: returnArr["+ (len-1) + "].time " + returnArr[len-1].time)
			*/ 
			return returnArr
		}
		
			
		/** Returns an ArrayCollection containing the input names and values for the long-term simulation */
		public function get inputListAC():ArrayCollection
		{
			//create an arraycollection with all values from memento for display in Analysis explorer
			if (energyPlusInputsMemento==null)
			{
				return null
			}
				
			var ac:ArrayCollection = new ArrayCollection()
			ac.addItem({name:"City",value:energyPlusInputsMemento.city})
			ac.addItem({name:"Region",value:energyPlusInputsMemento.region})
			ac.addItem({name:"Building length",value:energyPlusInputsMemento.buildingLength})
			ac.addItem({name:"Building width",value:energyPlusInputsMemento.buildingWidth})
			ac.addItem({name:"Story height",value:energyPlusInputsMemento.storyHeight})
			ac.addItem({name:"Floor of interest",value:energyPlusInputsMemento.floorOfInterest})
			
			
			ac.addItem({name:"Window type", value:energyPlusInputsMemento.windowType})
			ac.addItem({name:"Win. ratio West", value:energyPlusInputsMemento.windowRatioWest})
			ac.addItem({name:"Win. ratio East", value:energyPlusInputsMemento.windowRatioEast})
			ac.addItem({name:"Win. ratio North", value:energyPlusInputsMemento.windowRatioNorth})
			ac.addItem({name:"Win. ratio South", value:energyPlusInputsMemento.windowRatioSouth})
				
			ac.addItem({name:"Equipment peak load",value:energyPlusInputsMemento.equipPeakLoad})
			ac.addItem({name:"Lighting peak load",value:energyPlusInputsMemento.lightingPeakLoad})
			ac.addItem({name:"Area per person",value:energyPlusInputsMemento.areaPerPerson})
			ac.addItem({name:"Zone cooling SP",value:energyPlusInputsMemento.zoneCoolingSetpointTemp})
			ac.addItem({name:"Zone heating SP",value:energyPlusInputsMemento.zoneHeatingSetpointTemp})
			ac.addItem({name:"Min. VAV damper pos.",value:energyPlusInputsMemento.vavMinFlwRatio})
			ac.addItem({name:"Room sensible heat gain", value:energyPlusInputsMemento.rmQSens})
				
				
			/*
			ac.addItem({name:"Heating coil UA", value:energyPlusInputsMemento.hcUA})
			ac.addItem({name:"Cooling coil UA", value:energyPlusInputsMemento.ccUA})
			ac.addItem({name:"VAV heating coil UA", value:energyPlusInputsMemento.vavHcUA})
			*/
				
			
				
			return ac			
		}
		
		/**
		 *  Loads raw CSV output from E+ into structured format within this class 
		 *  
		 *  @param outCSV - a string with the entire contents of the eplusout.csv
		 *  @param meterCSV - a string with the entire contents of the eplusmeter.csv
		 * 
		*/
		public function loadData(outCSV:String, meterCSV:String = null):void
		{
						
			Logger.debug(" loadBasicOutput()", this)
			
			//make sure data holders are clear
			dataArr = []			
						
			_outputCSV = outCSV
			_meterDataCSV = meterCSV
					
			var parseErrors:Boolean = false
			var rowsArr:Array = _outputCSV.split("\n")
				
			//remove the last row, because its hour "24" will look like the next day to actionscript
			//so just kill that last hour
			rowsArr.pop()
			
			var rowsLen:Number = rowsArr.length 
			if (rowsLen<1)
			{
				throw new EPlusParseError("No rows found in output.csv", EPlusParseError.NO_DATA_ERROR)
			}
			Logger.debug("parsing "+ rowsArr.length + " rows of E+ data",this)
			//Create an entry in our hash for each variable as it's listed on first line
			var varNamesArr:Array = rowsArr.shift().split(",")
			Logger.debug("varNamesArr: " + varNamesArr, this)
			
			//setup timeArr in hash and temp lookup
			dataArr[dateTimeID] = new Array()
			varNamesArr[0] = dateTimeID //replace the date/time column title with our dateTimeID
			
			//setup variables in hash by looping through variable names
			var len:uint = varNamesArr.length
			for (var i:Number=1;i<len;i++) //start at 1 so we skip time column
			{
				dataArr[varNamesArr[i]] = new Array()
			}
						
			rowsLen = rowsLen-2 //we shifted off first row above, and we are starting from 0 index 			
			
			var floorZoneLookupArr:Array = createFloorZoneLookupArr(varNamesArr)
					
			var row:String
			var valsArr:Array
			floorZoneDataArr = new Array(rowsLen)
								
			for (var rowIndex:Number=0; rowIndex<rowsLen; rowIndex++)
			{				
												
				//parse data
				row = rowsArr.shift()
				valsArr = row.split(",")					
					
				var numCols:Number = valsArr.length
									
				//we need to capture temp and humidity right away, so hard-code these
				var dateInEpochSecs:Number = Date.parse(parseDateString(valsArr[0]))					
				dataArr[dateTimeID].push(dateInEpochSecs)
				var tAirOut:Number = valsArr[1]
				dataArr[varNamesArr[1]].push(tAirOut)
				var relativeHumidity:Number = valsArr[2]
				dataArr[varNamesArr[2]].push(relativeHumidity)
					
				//build floor/zone array for this line
				floorZoneDataArr[rowIndex] = new Array(3) //three floors
				for (var j:uint=0;j<3;j++)
				{
					floorZoneDataArr[rowIndex][j] = new Array(5) //five zones
					for (var k:uint=0;k<5;k++)
					{
						var vo:LongTermValuesForShortTermSimVO = new LongTermValuesForShortTermSimVO()
						vo.dateInEpochSecs = dateInEpochSecs
						floorZoneDataArr[rowIndex][j][k] = vo
					}
				}			
					
				
				for (var col:Number=3; col<numCols; col++)
				{	
					// store value in dataArr
					var val:Number = Number(valsArr[col])	
					var columnName:String = varNamesArr[col]	
																			
					if (dataArr[columnName]!=undefined) 
					{
						dataArr[columnName].push(val)
					}			
												
					// now, check if this column is related to a LongTermValuesForShortTermSimVO, 
					// if so, add value to VO via lookup
					if (floorZoneLookupArr[col]!=null) 
					{
						var obj:Object = floorZoneLookupArr[col]
						var vo:LongTermValuesForShortTermSimVO = floorZoneDataArr[rowIndex][obj.floor-1][obj.zone-1]
						vo.setValue(obj.voVarName, val)
						vo.rowIndex = rowIndex
						vo._tAirOut = tAirOut
						vo._rhOutside = relativeHumidity
						
					}								
				}
			}
			
			//now load meter data			
			if (_meterDataCSV=="")
			{
				Logger.warn("_meterDataCSV is empty", this)
			}
			else
			{			
				parseMeterLines(_meterDataCSV)
			}
								
			//keep a record of how parsing went										
			dataLoaded = !parseErrors
			
			//create a basic structure XML doc for the tree control
			_dataStructureXML = createBaseXML()
			len = varNamesArr.length
			for (var index:Number=0;index<len;index++)
			{
				var dataPoint:XML = <dataPoint/>
				dataPoint.@id = varNamesArr[index]
				dataPoint.@pointType = "EPLUS"
				dataPoint.@units = ""
				dataPoint.@label = varNamesArr[index]
				dataPoint.@description = ""
				
				var shortName:String = dataPoint.@label
				if (shortName.indexOf("CORE-")==0)
				{
					var floorNumber:uint = uint(shortName.charAt(5))
					var zoneNumber:uint = 5
					
					_dataStructureXML.Campus.Building.Floor[floorNumber-1].Zone[zoneNumber-1].appendChild(dataPoint)
				}
				else if (shortName.indexOf("PERIM-")==0)
				{
					floorNumber = uint(shortName.charAt(6))
					switch(shortName.charAt(8))
					{
						case "N": 
							zoneNumber = 1 
							break
						case "E":
							zoneNumber = 2
							break
						case "S":
							zoneNumber = 3
							break
						case "W":
							zoneNumber = 4;
							break;
						default:
							Logger.error("Unrecognized zone direction in EPlus output. shortName.charAt(8): " + shortName.charAt(8), this)
							zoneNumber = 1				
					}					
					_dataStructureXML.Campus.Building.Floor[floorNumber-1].Zone[zoneNumber-1].appendChild(dataPoint)
				}
				else
				{					
					_dataStructureXML.Campus.Building.appendChild(dataPoint)
				}
			}
			
		}
		
		protected function parseMeterLines(meterDataCSV:String):void
		{
			Logger.debug("parseMeterLines()", this)
			//parse meter output lines and add to dataArr
			//returns array of variable names parsed
			
			var hourlyDataArr:Array = []

			var monthlyDataArr:Array = [ 		{month:"JAN", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"FEB", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"MAR", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"APR", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"MAY", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"JUN", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"JUL", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"AUG", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"SEP", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"OCT", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"NOV", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0},
												{month:"DEC", fans:0, lighting:0, equipment:0, cooling:0, heating:0, pumps:0} ]
						
						
			var meterLinesArr:Array = meterDataCSV.split("\n")
			var len:Number = meterLinesArr.length
			Logger.debug("meterData output file is : "+ len + " lines long.", this)
			
			if (len<2)
			{
				Logger.debug("parseMeterLines() less than 2 lines, not parsing.", this)
				return 
			}
			
			//get first row and make array of variable names contained in columns
			var meterVarNames:Array = meterLinesArr.shift().split(",") 
			len = len - 1 
			
			
			// start at next line in CSV and grab values		
			var line:String
			var meterValsArr:Array
			
			for (var rowIndex:Number=0; rowIndex<len; rowIndex++)
			{
				try
				{
					//grab next line and parse into a value array
					line = meterLinesArr.shift()
					meterValsArr = line.split(",")
					
					//grab values from line, dividing by 3600 to get Watts
					
					var hourlyData:Object = {}
					hourlyData.date = parseDateString(meterValsArr[0], true)
					//Brian Coffey says to skip cols 2 and 3
					//hourlyData.gas = Number(meterValsArr[1])/3600
					//hourlyData.facility = Number(meterValsArr[2])/3600
					hourlyData.lighting = Number(meterValsArr[3])/3600
					hourlyData.equipment = Number(meterValsArr[4])/3600	
					hourlyData.fans = Number(meterValsArr[5])/3600	
					hourlyData.pumps = Number(meterValsArr[6])/3600	
					hourlyData.cooling = Number(meterValsArr[8])/3600	
					hourlyData.heating = Number(meterValsArr[9])/3600		
					hourlyData.total = hourlyData.lighting + hourlyData.equipment + hourlyData.fans + hourlyData.pumps + hourlyData.cooling + hourlyData.heating 
					hourlyDataArr.push(hourlyData)
					
					
					var monthIndex:Number = getMonthFromDate(meterValsArr[0])
					if (monthIndex==-1) continue
					monthlyDataArr[monthIndex].lighting += hourlyData.lighting
					monthlyDataArr[monthIndex].equipment += hourlyData.equipment	
					monthlyDataArr[monthIndex].fans += hourlyData.fans	
					monthlyDataArr[monthIndex].pumps += hourlyData.pumps	
					monthlyDataArr[monthIndex].cooling += hourlyData.cooling 
					monthlyDataArr[monthIndex].heating += hourlyData.heating											
				}
				catch(err:Error)
				{
					Logger.error("parseMeterLines() error reading row : " + rowIndex + " line : "  + line, this)
				}
			}
			
								
			//create arrayCollection for graphing 
			hourlyMeterDataAC = new ArrayCollection(hourlyDataArr)			
			monthlyMeterDataAC = new ArrayCollection(monthlyDataArr)			
			hourlyMeterDataAC.refresh()		
			monthlyMeterDataAC.refresh()
			
			var obj:Object = hourlyMeterDataAC.getItemAt(0)
			for (var s:String in obj)
			{
				Logger.debug("first object in hourlyMeterDataAC" + s + " : " + obj[s], this)
			}
		}
		
		protected function parseDateString(s:String, returnDateObj:Boolean=false):Object
		{
			s = s.slice(1) //slice off first space
			if (s.indexOf("  ")!=-1)
			{
				var a:Array = s.split("  ")
			}
			else
			{
				a = s.split(" ")
			}

			var dateString:String = a[0]+"/" + _currYear+ " " + a[1]
			if (returnDateObj)
			{
				return new Date(dateString)	
			}
			return dateString
		}
		
		
		/** returns a number 0-11 when given an EnergyPlus Meter data date */
		protected function getMonthFromDate(s:String):Number
		{
			var month:Number = Number(s.slice(1,3)) //slice off first space
			if (isNaN(month))
			{
				return -1
			}
			return month - 1
		}
		
		public function getVarName(varID:String):String
		{
			if (_scenarioModel==null) _scenarioModel = Swiz.getBean("scenarioModel") as ScenarioModel
			//If this is a SystemVariable, show display name, otherwise it's probably a E+ variable so cjust return id
			var sysVar:SystemVariable = _scenarioModel.getSysVar(varID)
			if (sysVar!=null)
			{				
				return sysVar.displayName	
			}
					
			return varID	
		}
		
		public function getUnits(varID:String):String
		{
			//EPlus not outputting units yet...
			return ""
		}
		
		public function get ePlusCSV():String
		{
			return _outputCSV
		}
		
		public function get startDateTimeString():String
		{
			var dateArr:Array = dataArr[dateTimeID]				
			var startDateTime:Date = new Date(dateArr[0])
			
			Logger.debug("getStartDateTime() dateArr.length: " + dateArr.length + " first date: " + startDateTime.month + " " + startDateTime.date, this)
			Logger.debug("DateUtil.formatDateTime(stopDateTime) " + DateUtil.formatDateTime(startDateTime), this)
				
			return DateUtil.formatDateTime(startDateTime)
		}
		
		public function get stopDateTimeString():String
		{
			var dateArr:Array = dataArr[dateTimeID]
			var lastIndex:uint = dateArr.length-1
			var stopDateTime:Date = new Date(dateArr[lastIndex])
			Logger.debug("getStopDateTime() dateArr.length: " + dateArr.length + " last date: " + stopDateTime.month + " " + stopDateTime.date, this)
			Logger.debug("DateUtil.formatDateTime(stopDateTime) " + DateUtil.formatDateTime(stopDateTime), this)
			return DateUtil.formatDateTime(stopDateTime)
		
		}
	
		/** Refresh all members that are affected by units change*/
		public function unitsRefresh():void
		{
			//this.sparkInputAC.refresh()	
		}
		
		
		protected function createFloorZoneLookupArr(varNamesArr:Array):Array
		{
			var floorZoneLookupArr:Array = new Array(colsLen)
			var colsLen:uint = varNamesArr.length
			
			for (var i:uint=1;i<colsLen;i++) //skip the dateTime column
			{
				
				var colName:String = varNamesArr[i]
				
				var isCore:Boolean = colName.indexOf("CORE-")==0
				var isPerim:Boolean = colName.indexOf("PERIM-")==0
				var floorNumber:uint
				var zoneNumber:uint 
				
				if (isCore || isPerim)
				{
					if (isCore)
					{
						floorNumber = uint(colName.charAt(5))
						zoneNumber = 5
					}
					else
					{
						floorNumber = uint(colName.charAt(6))
						switch(colName.charAt(8))
						{
							case "N": 
								zoneNumber = 1 
								break
							case "E":
								zoneNumber = 2
								break
							case "S":
								zoneNumber = 3
								break
							case "W":
								zoneNumber = 4;
								break;
							default:
								Logger.error("Unrecognized zone direction in EPlus output. shortName.charAt(8): " + colName.charAt(8), this)
								zoneNumber = 1				
						}			
					}	
					
					var varName:String = ""
					//if this column has one of the following names, add to lookup array
					if (colName.indexOf("Zone People Total Heat Gain")!=-1) 
					{
						varName = "_peopleHeatGain"
					}
					else if (colName.indexOf("Zone Lights Total Heat Gain")!=-1)
					{						
						varName = "_lightingHeatGain"
					}
					else if (colName.indexOf("Zone Electric Equipment Total Heat Gain")!=-1)
					{
						varName = "_electricEquipmentHeatGain"						
					}
					
					if (varName !="")
					{
						floorZoneLookupArr[i] = {floor:floorNumber, zone:zoneNumber, voVarName:varName }
					}
					
				}
			}	
				
			return floorZoneLookupArr	
				
		}
		
		
		
	}
}