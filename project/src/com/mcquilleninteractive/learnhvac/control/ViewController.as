package com.mcquilleninteractive.learnhvac.control

{
	import mx.core.UIComponent
	import com.adobe.cairngorm.control.CairngormEventDispatcher;

   	public class ViewController extends UIComponent
   	{    
    	private var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
   
   		protected function addListener(eventName:String, func:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
       		dispatcher.addEventListener(eventName, func, useCapture, priority, useWeakReference);
    	} 
   }
}