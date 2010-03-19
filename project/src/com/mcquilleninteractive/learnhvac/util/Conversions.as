package com.mcquilleninteractive.learnhvac.util
{
	public class Conversions
	{
		public function Conversions()
		{}
			
		//SI
		public static var UNITS_METERS:String = "m"
		public static var UNITS_CENTIMETERS:String = "cm"
		public static var UNITS_MILLIMETERS:String = "cm"
		
		//IP
		public static var UNITS_FEET:String = "ft"
		public static var UNITS_INCHES:String = "ft"
		
		
		// Handles converting values from SI-IP or IP-SI
		// This function requires that the unit_si and unit_ip values of SysVar conform to expected strings (e.g. Fahrenheit is "F")
		public static function getConversionFunction(fromUnits:String, toUnits:String):Function
		{
			if (fromUnits=="" || toUnits=="")
			{
				throw new Error("must provide SI and IP units to get conversions")
			}
			
			var conversion:String = fromUnits + "_to_" + toUnits
						
			switch (conversion)
			{
				
				case "Pa_to_PSI":
					return Conversions.paToPSI
					break
				case "PSI_to_Pa":
					return Conversions.psiToPa
					break
				
				case "m3/s_to_CFM":
					return Conversions.m3PerSecToFt3PerMin	
					break		
				case "CFM_to_m3/s":
					return Conversions.ft3PerMinToM3PerSec
					break
				
				case "C_to_F":
					return Conversions.celToFarh
					break
				case "F_to_C":
					return Conversions.farhToCel	
					break
										
				case "K_to_F":
					return Conversions.kelvinToFahr
					break
				case "F_to_K":
					return Conversions.fahrToKelvin
					break
				
				case "m3/s_to_GPM":
					return Conversions.metersCubedPerSecToGallonsPerMin
					break
				case "GPM_to_m3/s":
					return Conversions.gallonsPerMinToMetersCubedPerSec
					break
				
				case "W/oC_to_Btu/hr.oF":
					return Conversions.wattsPerCToBtuPerHrF
					break
				case "Btu/hr.oF_to_W/oC":
					return Conversions.btuPerHrFToWattsPerC
					break
				
				case "kg/s_to_GPM":
					return Conversions.kgPerSecToGalPerMin
					break
				case "GPM_to_kg/s":
					return Conversions.galPerMinToKgPerSec
					break
				
				
				case "kg/s_to_CFM":
					return Conversions.kgPerSecToFt3PerMin
					break
				case "CFM_to_kg/s":
					return Conversions.ft3PerMinToKgPerSec
					break
				
				case "W_to_Btu/h":
					return Conversions.wattsToBtuPerHour
					break
				case "Btu/h_to_W":
					return Conversions.BtuPerHourToWatts	
					break	
					
				case "Pa_to_In.W":
					return paToInchesWater
					break
				case "In.W_to_Pa":
					return inchesWaterToPa
					break
								
				default:
					Logger.warn("#Conversions: getConversionFunction() unrecognized units: " + conversion)
					 
			}
			
			return null
			
						
		}
		
					
		/* CONVERSION FUNCTIONS */
		
		
		public static function fahrToKelvin(v:Number):Number
		{
			v = v / 1.8
			return v
		}	
		
		public static function kelvinToFahr(v:Number):Number
		{
			v = v * 1.8 
			return v
		}		
			
		public static function farhToCel(v:Number):Number
		{
			v = (v - 32) / 1.8
			return v
		}	
		
		public static function celToFarh(v:Number):Number
		{
			v =  (v * 1.8 ) + 32
			return v
		}	
		
		public static function paToPSI(v:Number):Number
		{
			v = v * 1.45e-4
			return v
		}
		
		public static function psiToPa(v:Number):Number
		{
			v = v / 1.45e-4
			return v
		}
		
		public static function m3PerSecToFt3PerMin(v:Number):Number
		{
			v = v * 2118.64 	 
			return v
		}

		public static function ft3PerMinToM3PerSec(v:Number):Number
		{
			v = v / 2118.64 	 
			return v
		}

		public static function paToInchesWater(v:Number):Number
		{
			v = v / 249.1
			return v
		}
		
		public static function inchesWaterToPa(v:Number):Number
		{
			v = v * 249.1
			return v
		}
		
		public static function kgPerSecToGalPerMin(v:Number):Number
		{
			v = v * 15.88
			return v
		}	
		
		public static function galPerMinToKgPerSec(v:Number):Number
		{
			v = v / 15.88
			return v
		}	
		
		public static function kgPerSecToFt3PerMin(v:Number):Number
		{
			v = v * 1765.7
			return v
		}	
		
		public static function ft3PerMinToKgPerSec(v:Number):Number
		{
			v = v / 1765.7
			return v
		}	
		
		public static function wattsPerCToBtuPerHrF(v:Number):Number
		{
			v = v * 1.895
			return v
		}	
		
		public static function btuPerHrFToWattsPerC(v:Number):Number
		{
			v = v / 1.895
			return v
		}	
		
		
		public static function metersCubedPerSecToGallonsPerMin(v:Number):Number
		{
			v = v * 2118.88  	 
			return v
		}
		
		public static function gallonsPerMinToMetersCubedPerSec(v:Number):Number
		{
			v = v / 2118.88  	 
			return v
		}
		
		
		public static function wattsToBtuPerHour(v:Number):Number
		{
			v = v * 3.41214163 //why is this listed as SI*0.2931 for RmHeatGain
			return v
		}
		
		public static function BtuPerHourToWatts(v:Number):Number
		{
			v = v / 3.41214163
			return v
		}
			
		public static function feetToMeters(v:Number):Number
		{
			v = v * 0.3048 
			return v
		}
			
		public static function metersToFeet(v:Number):Number
		{	
			v = v * 3.2808399
			return v
		}
			
		public static function inchesToCentimeters(v:Number):Number
		{
			v = 2.54 * v 
			return v
		}	
		
		public static function inchesToMillimeters(v:Number):Number
		{
			v = 25.4 * v 
			return v
		}
		
		public static function inchesToFeet(v:Number):Number
		{
			v = v * 0.0833333333
			return v
		}
			
		public static function centimetersToInches(v:Number):Number
		{
			v = v * 0.393700787
			return v
		}
		
		public static function millimetersToInches(v:Number):Number
		{
			v = v * 0.0393700787
			return v
		}
		
		public static function centimetersToFeet(v:Number):Number
		{
			v = v * 0.032808399
			return v
		}
			
		public static function wattsPerSqMtoWattsPerSqFt(v:Number):Number
		{
			return v / 10.7639104
		}
		
		public static function wattsPerSqFttoWattsPerSqM(v:Number):Number
		{
			return v * 10.7639104
		}
		
		public static function m2ToFt2(v:Number):Number
		{
			return v * 10.7639104 
		}
				
		public static function ft2ToM2(v:Number):Number
		{
			return v / 10.7639104
		}
		
					
		public static function roundToDecimals(value:Number, numDecimals:Number):Number
		{
			if (numDecimals<1) return value
			var f:Number = 10*numDecimals
			value = value * f
			value = Math.round(value)
			value = value / f
			return value
		}
		
		/** gives all strings representing numbers the same number of decimals, even if they are 0 */
		public static function normalizeDecimalPlaceString(displayValue:String, numberOfDecimals:Number = 2):String
		{
			var zerosToAdd:uint = 0
			if (displayValue.indexOf(".")!=-1)
			{
				var decimals:String = displayValue.split(".")[1]
				if (decimals.length<numberOfDecimals)
				{
					zerosToAdd = numberOfDecimals - decimals.length
				} 
				
			}
			else
			{
				if (numberOfDecimals>0) displayValue+="."
				zerosToAdd = numberOfDecimals
			}
			for (var i:uint; i< zerosToAdd; i++)
			{
				displayValue+="0"
			}
			return displayValue	
		}
	
		
		
	}
}