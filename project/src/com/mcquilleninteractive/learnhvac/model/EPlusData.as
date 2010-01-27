package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.err.EPlusParseError;
	import com.mcquilleninteractive.learnhvac.util.DateUtil;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.SparkInputVarsVO;
	
	import mx.collections.ArrayCollection;
	import org.swizframework.Swiz;
	
	[Bindable]
	public class EPlusData implements IGraphDataModel
	{
		
		protected var _scenarioModel:ScenarioModel
		
		public var longTermSimulationDataModel		:LongTermSimulationDataModel
		public var dataArr				:Array					//holds arrays that hold values for each variable
		public var dataXML				:XML 
		public var dataLoaded			:Boolean = true
		public var dateTimeID			:String = "Date/Time"
		
		public var hourlyMeterDataAC	:ArrayCollection = new ArrayCollection() //AC used for graphing hourly data
		public var monthlyMeterDataAC	:ArrayCollection = new ArrayCollection() //AC used for graphing monthly data
		
		private var currYear			:String 
		private var outputCSV			:String					//the main .csv outputted by E+
		private var meterDataCSV		:String					//another E+ .csv file with only meter data
		
		private var rmQSENSArr			:Array					//special array that holds computed RmQSens array (add colums 4,6,8 from output)
		
		/* 
			sparkInputAC holds data that will be used in short-term simulation.
		   Currently, this is { date: , rmQSens: , tAirOut:, twAirOut: }
		*/		
		public var sparkInputAC		:ArrayCollection	= new ArrayCollection()				
		
		// zoneDataArray is a three dimensional array 
		//     zoneDataArr [rowIndex of EPlus Results][floorIndex][zoneIndex] -> contains SparkInputVarVOs for that zone
		
		public var zoneDataArr:Array
		
		public function EPlusData(longTermSimulationDataModel:LongTermSimulationDataModel) 
		{
			dataArr = []
			rmQSENSArr = []
			dataXML = createBaseXML()
			this.longTermSimulationDataModel = longTermSimulationDataModel
			
			// use the current year for timecode of output
			currYear = String(new Date().fullYear)	
			
			
		}
		
		private function createBaseXML():XML
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
		
		
		/* Finds the spark inputs for a given dateTime (will only match by the hour) */
		public function getSparkInputs(dateTime:Date, floorOfInterest:uint, zoneOfInterest:uint):SparkInputVarsVO
		{
			
			
			Logger.debug("getSparkInputs() dateTime: " + dateTime, this)
			
			var dataArrLength:int = dataArr[dateTimeID].length
			var zoneDataArrLength:int = zoneDataArr.length			
			
			if (dataArrLength != zoneDataArrLength)
			{
				Logger.warn("dataArr and zoneDataArr are supposed to be same length but aren't. dataArr.length " + dataArrLength + " zoneDataArrLength: " + zoneDataArrLength, this)
			}
					
			if (dataArrLength == 0 ) return null
			
			for (var i:uint = 0; i< dataArrLength-1; i++)
			{			
								
				var d1:Date = new Date(dataArr[dateTimeID][i])
				
				if (dateTime <= d1)
				{					
					var vo:SparkInputVarsVO = SparkInputVarsVO(zoneDataArr[i][floorOfInterest-1][zoneOfInterest-1])
					if (vo==null)
					{
						Logger.error("getSparkInputs() have date for row " + i + " (" + d1.toUTCString() + " ) but there's no SparkInputVarsVO in zoneDataArr", this)
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
		
	
		public function getDataType():String
		{
			return ScenarioModel.EPLUS_DATA_TYPE
		}

		public function varExists(varID:String):Boolean
		{
			return (dataArr[varID]!=undefined)
		}
		
		public function getDataStructureXML():XML
		{
			return dataXML
		}
		
		/** Return the value of the requested variable at the closest matching time to the supplied time 
		 * 
		 *  @param varName can be one of these values "RmQSENSE", "TAirOut", "TwAirOut"
		 * */
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
		
			
		public function loadData(outputCSV:String, meterDataCSV:String = null):void
		{
			/*  
				Loads raw CSV output from E+ into structured format within this class 
			*/
			
			Logger.debug(" loadBasicOutput()", this)
			
			//make sure data holders are clear
			dataArr = []			
						
			//keep string for later saving
			this.outputCSV = outputCSV
					
			var parseErrors:Boolean = false
			var rowsArr:Array = outputCSV.split("\n")
			
			var rowsLen:Number = rowsArr.length 
			if (rowsLen<1)
			{
				throw new EPlusParseError("No rows found in output.csv", EPlusParseError.NO_DATA_ERROR)
			}
			
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
			
			//setup a quick reference from the indices of columns that relate to the SparkInputVarsVOs to the actual VO objects
			//This will speed up the process below when we step through each row (rather than parsing names on each row to find the relevant variables)
			var zoneColLookUpArr:Array = createZoneInfoLookupArr(varNamesArr)
					
			// Now start at next line in CSV and grab values, placing each in appropriate hash								
			// Start at row 1 so we skip the var names
			var row:String
			var valsArr:Array
			zoneDataArr = new Array(rowsLen)
			for (var rowIndex:Number=0; rowIndex<rowsLen; rowIndex++)
			{
				
				//create the VO that will be used by SPARK for this date...this VO does the translation from SI to IP if needed
				zoneDataArr[rowIndex] = new Array(3) //three floors
				for (var j:uint=0;j<3;j++)
				{
					zoneDataArr[rowIndex][j] = new Array(5) //five zones
					for (var k:uint=0;k<5;k++)
					{
						zoneDataArr[rowIndex][j][k] = new SparkInputVarsVO()
					}
				}		
								
				//grab next line and parse into a value array
				row = rowsArr.shift()
				valsArr = row.split(",")
										
				//loop through values and assign to appropriate array in hash											
				var cols:Number = valsArr.length
				
				var tAirOut:Number = 0
				var twAirOut:Number = 0
				
				for (var col:Number=0; col<cols; col++)
				{	
					//read in every value as a number except the first, which is Date/Time
					if (col==0)
					{					
						var dateInEpochSecs:Number = Date.parse(parseDateString(valsArr[0]))					
						dataArr[dateTimeID].push(dateInEpochSecs)
					} 				
					else 
					{
						
						// store value in dataArr
						var val:Number = Number(valsArr[col])	
						var columnName:String = varNamesArr[col]
						
						if (col==1) tAirOut = val
						if (col==2) twAirOut = val						
										
						if (dataArr[columnName]!=undefined) 
						{
							dataArr[columnName].push(val)
						}			
						
						if (col<3) continue
						
						// now, check if this column is related to a SparkInputVarsVO, 
						// if so, add value to VO via lookup
						if (zoneColLookUpArr[col]!=null)
						{
							//object has properies {floor: , zone: , voVarName: }
							var obj:Object = zoneColLookUpArr[col]
							var vo:SparkInputVarsVO = zoneDataArr[rowIndex][obj.floor-1][obj.zone-1]
							vo.setValue(obj.voVarName, val)
							vo.rowIndex = rowIndex
							vo._tAirOut = tAirOut
							vo._twAirOut = twAirOut
							
						}
						
						
						
					}						
					
				}
								
			}
			
			//now load meter data			
			if (meterDataCSV=="")
			{
				Logger.warn("meterDataCSV is empty", this)
			}
			else
			{			
				parseMeterLines(meterDataCSV)
			}
								
			//keep a record of how parsing went										
			dataLoaded = !parseErrors
			
			//create a basic structure XML doc for the tree control
			dataXML = createBaseXML()
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
					
					dataXML.Campus.Building.Floor[floorNumber-1].Zone[zoneNumber-1].appendChild(dataPoint)
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
					dataXML.Campus.Building.Floor[floorNumber-1].Zone[zoneNumber-1].appendChild(dataPoint)
				}
				else
				{					
					dataXML.Campus.Building.appendChild(dataPoint)
				}
			}
			
		}
		
		private function parseMeterLines(meterDataCSV:String):void
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
					//Brian Coffey says to skip lines 2 and 3
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
			
			Logger.debug("parseMeterLines() hourlyMeterDataAC :" + hourlyMeterDataAC.length, this)
			Logger.debug("parseMeterLines() monthlyMeterDataAC:" + monthlyMeterDataAC.length, this)
			var obj:Object = hourlyMeterDataAC.getItemAt(0)
			for (var s:String in obj)
			{
				Logger.debug("first object in hourlyMeterDataAC" + s + " : " + obj[s], this)
			}
		}
		
		private function parseDateString(s:String, returnDateObj:Boolean=false):Object
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

			var dateString:String = a[0]+"/" + currYear+ " " + a[1]
			if (returnDateObj)
			{
				return new Date(dateString)	
			}
			return dateString
		}
		
		
		/** returns a number 0-11 when given an EnergyPlus Meter data date */
		private function getMonthFromDate(s:String):Number
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
				return sysVar.display_name	
			}
					
			return varID	
		}
		
		public function getUnits(varID:String):String
		{
			//EPlus not outputting units yet...
			return ""
		}
		
		public function getEPlusCSV():String
		{
			return outputCSV
		}
		
		public function getStartDateTime():String
		{
			var startDateTime:Date = new Date(dataArr[dateTimeID][0])
			return DateUtil.formatDateTime(startDateTime)
		}
		
		public function getStopDateTime():String
		{
			var dateArr:Array = dataArr[dateTimeID]
			var stopDateTime:Date = new Date(dateArr[dateArr.length-1])
			return DateUtil.formatDateTime(stopDateTime)
		
		}
	
		
		public var tempData:String = "Date/Time,PER-1T LIGHTS\n0" +
									" 07/01  01:00:00,0.0\n" + 
									" 07/01  01:01:00,2.0\n" + 
									" 07/01  01:02:00,1.0\n" 
		
		
		/** Refresh all members that are affected by units change*/
		public function unitsRefresh():void
		{
			this.sparkInputAC.refresh()	
		}
		
		
		protected function createZoneInfoLookupArr(varNamesArr:Array):Array
		{
			var zoneColLookUpArr:Array = new Array(colsLen)
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
						zoneColLookUpArr[i] = {floor:floorNumber, zone:zoneNumber, voVarName:varName }
					}
					
				}
			}	
				
			return zoneColLookUpArr	
				
		}
		
		
		
	}
}