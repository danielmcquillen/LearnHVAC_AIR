// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.event.SetUnitsEvent;
	import com.mcquilleninteractive.learnhvac.util.Logger
	
	/**
	 * @version	$Revision: $
	 */
	public class ResetInputsToInitialValuesCommand implements Command
	{
	
		public function ResetInputsToInitialValuesCommand(){
					
		}
	
		public function execute( event : CairngormEvent ): void	{
			
			Logger.debug("#ResetInputsToInitialValuesCommand() executed")
			
			var scenarioModel:ScenarioModel = LHModelLocator.getInstance().scenarioModel
			
			//cycle through all systemvariables and reset value to initial value
			for each (var sysNode:SystemNodeModel in scenarioModel.sysNodesArr)
			{
				for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
				{
					sysVar.resetToInitialValue()
				}	
			}
			
			
		}
		
	}

}