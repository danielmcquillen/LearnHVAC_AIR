package com.mcquilleninteractive.learnhvac.view.skins
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Graphics;
    
    import mx.skins.ProgrammaticSkin;
    import mx.utils.ColorUtil;

    public class ControlBarSkin extends ProgrammaticSkin
    {
         [ Embed( source='assets/img/metal_bg_pattern.png' ) ]
         private var backgroundImageClass    :Class;
        private var backgroundBitmapData    :BitmapData;
        
        private var tileWidth    :int;
        private var tileHeight    :int;

        public function ControlBarSkin()
        {
            super();             
 
             var backgroundImage:Bitmap = new backgroundImageClass();
    
             tileWidth    = backgroundImage.width;
             tileHeight    = backgroundImage.height;
             
              backgroundBitmapData = new BitmapData(    tileWidth,    
                                                       tileHeight );
                        
             backgroundBitmapData.draw( backgroundImage );
        }

        override protected function updateDisplayList(    w:Number,
                                                        h:Number ):void
        {
            super.updateDisplayList( w, h );
            
            graphics.clear();
               
            graphics.beginBitmapFill( backgroundBitmapData );     
            //graphics.drawRect( 0, 0, w, h );            // repeat x and y
    	     //graphics.drawRect( 0, 0, tileWidth, h );    // repeat-y
    		graphics.drawRect( 0, 0, w, tileHeight );    // repeat-x
        }
    }
}