package com.mcquilleninteractive.learnhvac.business
{
	
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	
	public class SparkReadOut
	{
				
		public function SparkReadOut()
		{
		}
		
		
		// Read only the first line of the SPARK output
		// and return the step number
		public function getCurrStep(outString:String):Number
		{
			var firstColon:Number = outString.indexOf(":")
			var firstDot:Number = outString.indexOf(".")
			var step:String = outString.slice(firstColon+1,firstDot)
			
			return Number(step)
		}
		
		// Parse the text read in from a SPARK output.txt file	
		// Populate scenarionModel with results from each line
		// a line in output.txt will look like this : [sysVarName]:[value]  ... for example: HCTAirEnt:87	
		
		public function parseOutput(outString:String):Number
		{
			
			var t:Date = new Date()			
			var scenModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			
			var sysVars:Array = []
			var outLines:Array = outString.split("\n")
			
			var step:Number = 0
			
			//Log.info("#GetLocalScenarioListCommand: parseOutput() read " + outLines + " lines from output.txt")
			
			var count:Number = outLines.length
			
			//First line is always "step"
			//This value maps to the Tstep sysVar, so write it explicitly
			var line:String = outLines[0]
			var parts:Array = line.split(":")
			scenModel.setSysVarValue("Tstep", Number(parts[1]), true)
			
			//Now, step through all remaining lines and update respective sysVar
			var value:Number
			for (var i:Number=1; i<count; i++){
				
				//split a line and use the first part as
				//sysVarName and second as the value.
				//Make sure to remove newline after end of value
				
				line = outLines[i]
				if (line.indexOf(":")!=-1){
					parts = line.split(":")
					if (parts[0] !="" && parts[0] != undefined){
						//update scenarioModel with values
						try
						{
							value = Number(parts[1])						
						}
						catch(e:Error)
						{
							Logger.error("#SparkReadOut: couldn't convert sysVar: " + parts[0] + " value: " + parts[1].slice(0,-1))
						}
						scenModel.setSysVarValue(parts[0].toString(), value, true)
					}					
				}					
			}
			
			return i
						
		}
		
		
		
	}
}