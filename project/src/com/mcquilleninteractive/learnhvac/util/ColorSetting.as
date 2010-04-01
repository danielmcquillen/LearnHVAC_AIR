package com.mcquilleninteractive.learnhvac.util
{                                   
	
	[Bindable]
	public class ColorSetting
	{
		/* 	Provides simple static methods to get color values for 
		   	ranges of temperatures (or other variables)
			Used by components like the PipeLiquid animations
		*/
		
		import flash.geom.ColorTransform
		import com.mcquilleninteractive.learnhvac.util.Logger
		
		public static var lightingColor:Number = 0xffd332;		
		public static var heatingColor:Number = 0xc83737;		
		public static var equipmentColor:Number = 0x43943a;
		
		public static var pumpsColor:Number = 0xe48701;
		public static var ltPumpsColor:Number = 0xd8a255;
		public static var dkPumpsColor:Number = 0x935701;		
		
		public static var coolingColor:Number = 0x1159a3;
		public static var ltCoolingColor:Number = 0x3b84cf;
		public static var dkCoolingColor:Number = 0x15416e;
		
		public static var fansColor:Number = 0x939495;
		
		public static var totalColor:Number = 0x000000;
				
						
			
		public function ColorSetting()
		{
		}
		
		public static function getTemperatureColor(temp:Number, units:String):ColorTransform
		{
			//Note: We should use Constant strings for SI and IP values as defined
			//      in the LHModelLocator, but since we need to use this class in 
			//      some CS3 components, we can't import classes that will cause
			//      CS3 to choke (Cairngorm). So, we'll just expect "SI" and "IP" strings
			
			var r:Number=0
			var g:Number=0
			var b:Number=0
			var ct:ColorTransform
			
			if (units=="IP")
			{
				//switch temp to SI
				temp = .555 * (temp-32)
			} 
			else if (units!="SI")
			{
				//show grey if we don't recognize units
				r = 125
				g = 125
				b = 125
			}
			
			/****************************************************
			   DEFINE COLORS FOR SI HERE
			****************************************************/
				
			if (temp<-17.8){
				r = 0
				g = 0
				b = 120
			} else if (temp <=-7){
				r = 0
				g = 0
				b = 120 + (12.2 * (temp + 17.8))  
			} else if (temp <=10){
				r = 3 *(temp+6.7)
				g = 6 *(temp+6.7)
				b = 255    
			} else if (temp<=18){
				r = 50 + (12*(temp-10))
				g = 100 + (12*(temp-10))
				b = 255
			} else if (temp<=26){
				r = 255
				g = 50 - (6*(temp-18.3))
				b = 100 - (12*(temp-18.3))
			} else if (temp<=38){
				r = 255-(5.4*(temp-26.7))
				g = 0
				b = 0
			} else {
				r = 195
				g = 0
				b = 0
			}
														
			r = Math.round(r)
			g = Math.round(g)
			b = Math.round(b)
			try
			{
				ct= new ColorTransform(1,1,1,1,r,g,b,0)
			}
			catch (e:Error)
			{
				trace("Error creating color transform r: " + r + " g: " +g + " b: " + b)
				r = 125
				g = 125
				b = 125
				ct = new ColorTransform(1,1,1,1,r,g,b,0)
			}
			
			return ct
			
		}
		

	}
}