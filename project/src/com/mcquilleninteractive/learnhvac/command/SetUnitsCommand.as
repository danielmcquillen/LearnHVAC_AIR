// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.event.SetUnitsCompleteEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.collections.ArrayCollection;
	
	public class SetUnitsCommand implements Command
	{
	
		public function SetUnitsCommand(){}
	
		public function execute( event : CairngormEvent ): void	{
			
			var model:LHModelLocator= LHModelLocator.getInstance()
			var scenarioModel:ScenarioModel = model.scenarioModel
						
			Logger.debug("#SetUnitsCommand: model's units are : " + LHModelLocator.currUnits)
			Logger.debug("#SetUnitsCommand: setting units to : " + event.type)
						
			if (event.type != LHModelLocator.currUnits)
			{
				// change model units first, so that components that bind to units can 
				// be set correctly before values change
				LHModelLocator.currUnits = event.type
				
				//TODO: should probably change all sysVars to simple listen to the scenModel property for units
				//      However, I'm not sure what this would do to speed...so for now I'm changing sysVars individually...
				Logger.debug("#ScenarioModel: changing units on variables to : " + event.type)
				//loop through system variables and change units
				var sysNodesArr:ArrayCollection = scenarioModel.sysNodesArr
				for each (var sysNode:SystemNodeModel in sysNodesArr)
				{
					for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
					{
						sysVar.units = event.type
						if (LHModelLocator.currUnits=="IP") sysVar.updateHistoryIP()
						sysVar.resetToInitialValue()
					}
				}
				Logger.debug("#SetUnitsCommand: model's units are now : " + LHModelLocator.currUnits)
			}
			
			//update any other models or controls that are affected by changes in units
			scenarioModel.ePlusRunsModel.onUnitsChange(LHModelLocator.currUnits)
			
			CairngormEventDispatcher.getInstance().dispatchEvent(new SetUnitsCompleteEvent(SetUnitsCompleteEvent.UNITS_CHANGED, event.type))	
			
		}
		
	}

}