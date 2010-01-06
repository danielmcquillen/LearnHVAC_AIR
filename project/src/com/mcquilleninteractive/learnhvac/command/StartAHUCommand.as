// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command
	import com.adobe.cairngorm.control.CairngormEvent
	import com.mcquilleninteractive.learnhvac.model.LHModelLocator
	import com.mcquilleninteractive.learnhvac.event.AHUEvent
	import com.mcquilleninteractive.learnhvac.business.ShortTermSimulationDelegate
	
	/**
	 * @version	$Revision: $
	 */
	public class StartAHUCommand implements Command
	{
	
		public function StartAHUCommand()
		{		
			//do nothing
		}
	
		public function execute( event : CairngormEvent ): void	
		{
			var simDelegate:ShortTermSimulationDelegate = new ShortTermSimulationDelegate(this)
			simDelegate.startAHU()
		}
		
	}

}