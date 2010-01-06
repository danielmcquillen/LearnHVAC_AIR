
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.business.UserDelegate;
	import com.mcquilleninteractive.learnhvac.event.LoggedInEvent;
	import com.mcquilleninteractive.learnhvac.event.LoginEvent;
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.UserVO;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;

	public class SelectNewScenarioCommand implements Command
	{
		
		public function execute(event : CairngormEvent) : void
		{
			Logger.debug("#SelectNewScenarioCommand: selecting new scenario...")
			var model : LHModelLocator = LHModelLocator.getInstance();
			model.viewing = LHModelLocator.PANEL_SELECT_SCENARIO
			
		}
		
			
	}
}