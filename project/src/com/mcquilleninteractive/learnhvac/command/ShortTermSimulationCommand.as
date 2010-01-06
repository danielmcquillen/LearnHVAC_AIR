// ActionScript file
package com.mcquilleninteractive.learnhvac.command{
	
	import com.adobe.cairngorm.commands.Command;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.business.ShortTermSimulationDelegate;
	import com.mcquilleninteractive.learnhvac.event.ShortTermSimulationEvent;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	public class ShortTermSimulationCommand implements Command
	{
	
		private var delegate:ShortTermSimulationDelegate
	
		public function ShortTermSimulationCommand()
		{		
			CairngormEventDispatcher.getInstance().addEventListener(ShortTermSimulationEvent.EVENT_CANCEL_START_AHU, onCancel)
		}
	
		public function onCancel(cgEvent:ShortTermSimulationEvent):void
		{
			Logger.debug("SHORT TERM SIM STARTUP CANCELLED", this)
			delegate.cancelStartAHU()
		}
	
		public function execute( event : CairngormEvent ): void	{
			Logger.debug("#ShortTermSimulationCommand: execute() event: " + event.type)
			delegate = new ShortTermSimulationDelegate(this);
			
			switch(event.type){
				
				case ShortTermSimulationEvent.EVENT_START_AHU:
					delegate.startAHU()
					break
				
				case ShortTermSimulationEvent.EVENT_STOP_AHU:
					delegate.stopAHU()
					delegate.copyDataForAnalysis()					
					break
					
				case ShortTermSimulationEvent.EVENT_UPDATE_AHU:
					delegate.updateAHU()
					break
				
			}
			
		}
		
	}

}