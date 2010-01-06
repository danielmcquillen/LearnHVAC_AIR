package com.mcquilleninteractive.learnhvac.business
{
	
	/* Class SparkWriteIn
	*  Generates string for input.txt file used to start 
	*  spark or to change the input values while Spark is running
	*/
		
	public class SparkWriteIn{

		import com.mcquilleninteractive.learnhvac.util.Logger
		import com.mcquilleninteractive.learnhvac.model.LHModelLocator
		import com.mcquilleninteractive.learnhvac.model.ScenarioModel
		import com.mcquilleninteractive.learnhvac.model.SystemNodeModel
		import com.mcquilleninteractive.learnhvac.model.SystemVariable
	
		private var sysVars:Array  //holds variables to be included in input.txt
	
		public function SparkWriteIn()
		{
			
		}
	
			
		/* Function : getText
		*  gets the complete string that needs to be written out to the Spark input.txt file
		*
		*  Parameter:
		*  sparkStatus  -  indicates whether this is a continuation of the current simulation or a restart
		* 
		*  Returns:
		*  String to write to input.txt file
		*/
		public function getText(sparkStatus:String):String
		{
			//create and return spark input lines 
			var outText:String = makeText(sparkStatus)
			return outText
		}
	
		/* Function makeText
		*  Makes the long text string which will be written out to input.txt
		*  
		*	Returns:
		*  String to write to input.txt file
		*/
		private function makeText(sparkStatus:String):String
		{	
			var scenarioModel:ScenarioModel= LHModelLocator.getInstance().scenarioModel
			var outTextStr:String = ""
						
			// WRITE SPARKRUN line first, as there is a strange bug in spark which causes it to 
			// crash if SPARKRUN appears on the last line of input.txt
			switch(sparkStatus)
			{
				case SparkService.SPARK_CONTINUE:
					Logger.debug(" writing spark_continue line", this)
					outTextStr= outTextStr + "SPARKRUN:"+SparkService.SPARK_CONTINUE + "\n"
					break
					
				case SparkService.SPARK_ABORT:
					Logger.debug(" writing spark_abort line", this)
					outTextStr= outTextStr + "SPARKRUN:"+SparkService.SPARK_ABORT	+ "\n"
					break
				
				case SparkService.SPARK_RESET:
					Logger.debug(" writing spark_reset line", this)
					outTextStr= outTextStr + "SPARKRUN:"+SparkService.SPARK_RESET	+ "\n"	
					break
				
				default:
					Logger.error("makeText() Unrecognized sparkStatus: " + sparkStatus, this)
			}
					
			// Write all system variables destined for input.txt (i.e. only INPUT variables)
			for each (var sysNode:SystemNodeModel in scenarioModel.sysNodesArr)
			{
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{
					if (sysVar.typeID == SystemVariable.INPUT)
					{
						var	newLine:String = sysVar.name + ":" + sysVar.baseSIValue + "\n"
						outTextStr = outTextStr + newLine
						
						//reset varible so InputPanel no longer shows var as "dirty"
						sysVar.lastValue = sysVar.currValue
					}
				}
			}
						
			outTextStr = outTextStr + "\nend" //per peng's new SPARK late April 2007
							
			return outTextStr
			
		}
		
			
	}
}


