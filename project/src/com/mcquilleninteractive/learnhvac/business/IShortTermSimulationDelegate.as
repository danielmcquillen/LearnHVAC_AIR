package com.mcquilleninteractive.learnhvac.business
{
	import flash.events.IEventDispatcher;
	
	public interface IShortTermSimulationDelegate extends IEventDispatcher
	{							
		function start():void			
		function stop():void		
		function update():void			
		function onOutputReceived():void
	}
}