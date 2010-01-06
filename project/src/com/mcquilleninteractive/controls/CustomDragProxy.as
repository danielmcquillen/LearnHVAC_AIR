/**
 * Derrick Grigg
 * dgrigg@rogers.com
 * http://www.dgrigg.com
 * created on Nov 3, 2006
 * 
 * Custom drag proxy that displays an image and a label
 * 
 * For use with the com.dgrigg.controls.DataGrid
 */

package com.mcquilleninteractive.controls {
   
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.geom.Point;
    import com.mcquilleninteractive.learnhvac.util.Logger
    import mx.controls.DataGrid;
    import mx.core.UIComponent;
    	
    public class CustomDragProxy extends UIComponent {
        
    	[Embed (source = '/assets/img/sysvar_icon.png')]
 		[Bindable] public var DragImage : Class;
        
        public function CustomDragProxy():void
        {
            super();
        }
        
        override protected function createChildren():void
        {
        	super.createChildren();
            
			var item:Object = mx.controls.DataGrid(owner).selectedItem;
            //var itemY:int = -50; //y position to place item at
            var dg:mx.controls.DataGrid = mx.controls.DataGrid(owner);
            var container: UIComponent = new UIComponent();

            addChild(DisplayObject(container));
 			
 			Logger.debug("mouseX: "+ mouseX)
 			Logger.debug("mouseX: "+ mouseY)
 			var p:Point = new Point(mouseX, mouseY)
 			p = globalToLocal(p)
 			
 			Logger.debug("after global to local: ")
 			Logger.debug("x: "+  p.x)
 			Logger.debug("y: "+  p.y)
 			
 			x = p.x
 			y = p.y
 			      
            var icon:Bitmap = new DragImage();
            container.addChild(icon);
            
         }
        
        private function handleComplete(event:Event):void
        {
           
        }
    }
}
