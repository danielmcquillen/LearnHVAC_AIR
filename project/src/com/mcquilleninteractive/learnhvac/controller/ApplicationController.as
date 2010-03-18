package com.mcquilleninteractive.learnhvac.controller
{
	
	
	import com.mcquilleninteractive.learnhvac.event.GetScenarioListEvent;
	import com.mcquilleninteractive.learnhvac.event.LoggedInEvent;
	import com.mcquilleninteractive.learnhvac.event.LogoutEvent;
	import com.mcquilleninteractive.learnhvac.event.SetUnitsCompleteEvent;
	import com.mcquilleninteractive.learnhvac.event.SetUnitsEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.collections.ArrayCollection;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.AbstractController;
	
	public class ApplicationController  extends AbstractController
	{
		[Autowire]
		public var applicationModel:ApplicationModel
		
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		public function ApplicationController()
		{
		}

		[Mediate(event="LoggedInEvent.LOGGED_IN")]
		public function loggedIn(event:LoggedInEvent):void
		{
			applicationModel.loggedIn = true
			applicationModel.viewing = ApplicationModel.PANEL_SELECT_SCENARIO	
			
			if (ApplicationModel.testMode)
			{
				var evt : GetScenarioListEvent = new GetScenarioListEvent(GetScenarioListEvent.GET_DEFAULT_SCENARIO_LIST, true);
				Swiz.dispatchEvent( evt );
			}	
		}
		
		[Mediate(event="LogoutEvent.LOGOUT")]
		public function onLogout(event:LogoutEvent):void
		{
			//do all cleanup necessary when user logs out...
			Logger.debug("onLogout()",this)
			applicationModel.loggedIn = false
			
			//setup for next login						
			applicationModel.viewing = ApplicationModel.PANEL_SELECT_SCENARIO
			
		}



		[Mediate(event="SetUnitsEvent.SET_UNITS")]
		public function setUnits(event:SetUnitsEvent):void
		{
											
			Logger.debug("#SetUnitsCommand: model's units are : " + ApplicationModel.currUnits)
			Logger.debug("#SetUnitsCommand: setting units to : " + event.units)
						
			if (event.units != ApplicationModel.currUnits)
			{
				// change model units first, so that components that bind to units can 
				// be set correctly before values change
				ApplicationModel.currUnits = event.units
				
				//TODO: should probably change all sysVars to simple listen to the scenModel property for units
				//      However, I'm not sure what this would do to speed...so for now I'm changing sysVars individually...
				Logger.debug("#ScenarioModel: changing units on variables to : " + event.type)
				//loop through system variables and change units
				var sysNodesAC:ArrayCollection = scenarioModel.sysNodesAC
				
				for each (var sysNode:SystemNodeModel in sysNodesAC)
				{
					for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
					{
						sysVar.units = event.units
						if (ApplicationModel.currUnits=="IP") sysVar.updateHistoryIP()
						sysVar.resetToInitialValue()
					}
				}
				Logger.debug("#SetUnitsCommand: model's units are now : " + ApplicationModel.currUnits)
			}
			
			
			var evt:SetUnitsCompleteEvent = new SetUnitsCompleteEvent(SetUnitsCompleteEvent.UNITS_CHANGED, true)
			evt.units = event.units			
			Swiz.dispatchEvent(evt)	
		
		}

	}
}