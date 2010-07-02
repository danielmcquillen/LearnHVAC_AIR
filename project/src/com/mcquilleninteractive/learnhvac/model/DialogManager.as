package com.mcquilleninteractive.learnhvac.model
{
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.view.popups.*;
	import com.mcquilleninteractive.learnhvac.view.shortterm.OutputPanel;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.core.Application;
	import mx.managers.PopUpManager;	
	public class DialogManager
	{
	
		private static var _instance:DialogManager					//hold singleton instance
		private static var _localInstantiation:Boolean;			//simple internal flag for proper creation of singleton
		
		//hold refs to dialogs that should only have one instance visible at a time
		private var _outputPopUp:OutputPanel = null;
		private var _watchPopUp:WatchPanel = null;
		private var _moviePopUp:MovieViewer = null;
		private var	_hcLiquidsSchematic:HCLiquidsSchematicPanel = null
		private var _ccLiquidsSchematic:CCLiquidsSchematicPanel  = null
		private var _miniGraphsPopUpArr:Array = [];
		private var _sysEnergyGraph:SystemEnergyGraph = null
		private var _zoneEnergyGraph:ZoneEnergyGraph = null
		private var _popUpsArr:Array = [	"_outputPopUp", 
											"_watchPopUp",
											"_moviePopUp",
											"_hcLiquidsSchematic",
											"_ccLiquidsSchematic",
											"_miniGraphsPopUpArr",
											"_sysEnergyGraph",
											"_zoneEnergyGraph" ] 
		
		public function DialogManager()
		{
		}

		
		public function showOutputPanel():void
		{
			if (_outputPopUp)
			{
				_outputPopUp.visible = true
			}
			else
			{
				_outputPopUp = new OutputPanel()
				_outputPopUp.addEventListener(Event.CLOSE, onOutputPanelClose)
				PopUpManager.addPopUp(_outputPopUp,  Application.application as DisplayObject, false);
			}			
			_outputPopUp.x=385
			_outputPopUp.y=660
			_outputPopUp.width=670
			_outputPopUp.height=200	
		}
				
		public function onOutputPanelClose(event:Event):void
		{
			_outputPopUp.removeEventListener(Event.CLOSE, onOutputPanelClose)
			PopUpManager.removePopUp(_outputPopUp)
			_outputPopUp = null
		}
		
		public function showWatchPanel():void
		{
			if (_watchPopUp)
			{
				_watchPopUp.visible = true
			}
			else
			{
				_watchPopUp = new WatchPanel()
				_watchPopUp.addEventListener(Event.CLOSE, onWatchPanelClose)
				PopUpManager.addPopUp(_watchPopUp,  Application.application as DisplayObject, false);
			}			
			_watchPopUp.x=9
			_watchPopUp.y=660	
			_watchPopUp.width=366
			_watchPopUp.height=203
		}
		
		public function onWatchPanelClose(event:Event):void
		{
			_watchPopUp.removeEventListener(Event.CLOSE, onWatchPanelClose)
			PopUpManager.removePopUp(_watchPopUp)
			_watchPopUp = null
		}
		
		
		public function showMovieViewer():void
		{
			if (_moviePopUp)
			{
				_moviePopUp.visible = true
			}
			else
			{
				_moviePopUp = new MovieViewer()
				_moviePopUp.addEventListener(Event.CLOSE, onMovieViewClose)
				PopUpManager.addPopUp(_moviePopUp,  Application.application as DisplayObject, false);
				PopUpManager.centerPopUp(_moviePopUp)
			}			
			PopUpManager.centerPopUp(_moviePopUp)
		}
		
		public function onMovieViewClose(event:Event):void
		{
			_moviePopUp.removeEventListener(Event.CLOSE, onMovieViewClose)
			PopUpManager.removePopUp(_moviePopUp)
			_moviePopUp = null
		}
		
		public function showHCLiquidsSchematic():void
		{
			if (_hcLiquidsSchematic)
			{
				_hcLiquidsSchematic.visible = true
			}
			else
			{
				_hcLiquidsSchematic = new HCLiquidsSchematicPanel()
				_hcLiquidsSchematic.addEventListener(Event.CLOSE, onHCLiquidsSchematicClose)
				PopUpManager.addPopUp(_hcLiquidsSchematic, Application.application as DisplayObject, false)
				PopUpManager.centerPopUp(_hcLiquidsSchematic)
			}
		}
		
		public function onHCLiquidsSchematicClose(event:Event):void
		{
			_hcLiquidsSchematic.removeEventListener(Event.CLOSE, onHCLiquidsSchematicClose)
			PopUpManager.removePopUp(_hcLiquidsSchematic)
			_hcLiquidsSchematic = null
		}
		
		public function showCCLiquidsSchematic():void
		{		
			if (_ccLiquidsSchematic)
			{
				_ccLiquidsSchematic.visible = true
			}
			else
			{		
				_ccLiquidsSchematic = new CCLiquidsSchematicPanel()
				_ccLiquidsSchematic.addEventListener(Event.CLOSE, onCCLiquidsSchematicClose)
				PopUpManager.addPopUp(_ccLiquidsSchematic, Application.application as DisplayObject, false)
				PopUpManager.centerPopUp(_ccLiquidsSchematic)
			}
		}
		
		public function onCCLiquidsSchematicClose(event:Event):void
		{
			_ccLiquidsSchematic.removeEventListener(Event.CLOSE, onCCLiquidsSchematicClose)
			PopUpManager.removePopUp(_ccLiquidsSchematic)
			_ccLiquidsSchematic = null
		}
		
		
		public function showSystemEnergyGraph():void
		{		
			if (_sysEnergyGraph)
			{
				_sysEnergyGraph.visible = true
			}
			else
			{		
				_sysEnergyGraph = new SystemEnergyGraph()
				_sysEnergyGraph.addEventListener(Event.CLOSE, onSysEnergyGraphClose)
				PopUpManager.addPopUp(_sysEnergyGraph, Application.application as DisplayObject, false)
				PopUpManager.centerPopUp(_sysEnergyGraph)
			}
		}
		
		public function onSysEnergyGraphClose(event:Event):void
		{
			Logger.debug("onSysEnergyGraphClose() _sysEnergyGraph: " + _sysEnergyGraph, this)
			_sysEnergyGraph.removeEventListener(Event.CLOSE, onSysEnergyGraphClose)
			PopUpManager.removePopUp(_sysEnergyGraph)
			_sysEnergyGraph = null
		}
			
		public function showZoneEnergyGraph():void
		{		
			if (_zoneEnergyGraph)
			{
				_zoneEnergyGraph.visible = true
			}
			else
			{		
				_zoneEnergyGraph = new ZoneEnergyGraph()
				_zoneEnergyGraph.addEventListener(Event.CLOSE, onZoneEnergyGraphClose)
				PopUpManager.addPopUp(_zoneEnergyGraph, Application.application as DisplayObject, false)
				PopUpManager.centerPopUp(_zoneEnergyGraph)
			}
		}
		
		public function onZoneEnergyGraphClose(event:Event):void
		{
			_zoneEnergyGraph.removeEventListener(Event.CLOSE, onZoneEnergyGraphClose)
			PopUpManager.removePopUp(_zoneEnergyGraph)
			_zoneEnergyGraph = null
		}
		
		
		
		public function hideAll():void
		{
			var len:int = _popUpsArr.length
						
			for (var i:uint=0;i<len;i++)
			{	
				if (this[_popUpsArr[i]])
					this[_popUpsArr[i]].visible = false
			}
		}
		
		public function showAll():void
		{
			var len:int = _popUpsArr.length
						
			for (var i:uint=0;i<len;i++)
			{	
				if (this[_popUpsArr[i]])
					this[_popUpsArr[i]].visible = true
			}
		}
		
		public function removeAllPopUps():void
		{
			
			var len:int = _popUpsArr.length
			
			for (var i:uint=0;i<len;i++)
			{	
				if (this[_popUpsArr[i]])	
					try
					{		
						PopUpManager.removePopUp(this[_popUpsArr[i]])
						this[_popUpsArr[i]] = null
					}
					catch(error:Error)
					{
						Logger.error("Couldn't remove popup: " + this[_popUpsArr[i]], this)
					}
			}	
			
			_outputPopUp = null
			_watchPopUp = null
			_moviePopUp = null
			
		}
		
		
		
		
	}
}