package com.mcquilleninteractive.learnhvac.business
{
	
	/* 
	
	GraphManager
	---------------------------
	Manages the charts launched and modified by the students while using Learn HVAC.
	Links these charts to the model and manages modifications to them
	
	*/
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.mcquilleninteractive.learnhvac.event.ApplicationEvent;
	import com.mcquilleninteractive.learnhvac.event.GraphEvent;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.view.graphing.MiniGraphPanel;
	
	import flash.events.Event;
	
	import mx.managers.PopUpManager;
	
	public class GraphManager
	{

		private var graphs:Array
		private var graphID:Number = 0
		
		public function GraphManager()
		{
			CairngormEventDispatcher.getInstance().addEventListener(GraphEvent.EVENT_ADD_MINI_GRAPH, onAddMiniGraph, false, 0,true)
			CairngormEventDispatcher.getInstance().addEventListener(ApplicationEvent.EVENT_SELECT_NEW_SCENARIO, onSelectNewScenario, false, 0,true)
			graphs = new Array()
		}

		public function onAddMiniGraph(event:GraphEvent):void
		{
			Logger.debug("#Adding Graph with id:  " + graphID)
			var graph:MiniGraphPanel = MiniGraphPanel(PopUpManager.createPopUp(event.host, MiniGraphPanel, false))
			graph.addEventListener("panelClosed",onGraphPanelClosed)
			graph.graphID = graphID
			PopUpManager.centerPopUp(graph)
			graphs.push(graph)
		}
		
		public function hideMiniGraphs():void
		{
			for each (var graph:MiniGraphPanel in graphs)
			{
				graph.visible = false
			}
		}
		
		public function showMiniGraphs():void
		{			
			for each (var graph:MiniGraphPanel in graphs)
			{
				graph.visible = true
			}
		}

		public function clearAllGraphs():void
		{
			while (graphs.length>0)
			{
				PopUpManager.removePopUp(graphs.pop())
			}
		}

		public function onGraphPanelClosed(event:Event):void
		{
			Logger.debug("#GraphManager: GraphPanelClosed. graphID: " + event.target.graphID)
			delete graphs[event.target.graphID]
		}

	
		public function onSelectNewScenario(event:ApplicationEvent):void
		{
			clearAllGraphs()
		}

	}
}