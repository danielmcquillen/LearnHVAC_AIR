
package com.mcquilleninteractive.particleengine
{
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import com.mcquilleninteractive.learnhvac.util.Logger
		
	public class Particle extends Shape
	{
		private var radius:Number
		
		public var pid:Number
		public var goalGravity:Array
		public var goalNearRadius:Array
		public var goalHead:Array
		public var goalTail:Array
		public var dieOnThisStep:Array
		public var goalFuzzyRadius:Array
		public var goalProbability:Array
		public var goalPositionX:Array
		public var goalPositionY:Array
		public var goalDriftStep:Array
		
		public var slicenow:Number
		public var slicemax:Number = 1
		
		public var deltax:Number
		public var deltay:Number
		public var targetx:Number
		public var targety:Number
		public var distance:Number
		public var angle:Number
		public var vx:Number = 0
		public var vy:Number = 0
		
		public var bColorChange:Boolean = true
		public var bAlphaChange:Boolean = true
		public var bSizeChange:Boolean = false
	
		private var colorr:Number
		private var colorb:Number
		private var colorg:Number
		public var goalColorR:Array
		public var goalColorG:Array
		public var goalColorB:Array
		public var goalColorStep:Array
		public var colorsteps:Number
		
		public var alphadelta:Number
		public var alphasteps:Number
		public var goalAlphaStep:Array
		public var goalAlpha:Array
		public var newAlpha:Number
		
		private var currIndex:Number //current index in the host of arrays holding directions
		public var newGoal:Number
		public var rdelta:Number
		public var gdelta:Number
		public var bdelta:Number
		
		
		public var decay:Number
		public var driftcount:Number
		public var goal:Number
		public var sizedelta:Number
		public var driftsteps:Number = 10
	
		public function Particle()
		{
			
		}
		
		public function init(pid:int, initObj:Object):Particle {
			
			this.pid = pid;
			// instructions
			this.goalGravity = initObj.goalGravity
			this.goalNearRadius = initObj.goalNearRadius
			this.goalTail = initObj.goalTail
			this.goalHead = initObj.goalHead
			this.dieOnThisStep = initObj.dieOnThisStep
			this.goalFuzzyRadius = initObj.goalFuzzyRadius
			this.goalProbability = initObj.goalProbability
			this.goalPositionX = initObj.goalPositionX
			this.goalPositionY = initObj.goalPositionY
			this.goalDriftStep = initObj.goalDriftStep
			this.goalColorR = initObj.goalColorR
			this.goalColorG = initObj.goalColorG
			this.goalColorB = initObj.goalColorB
			this.goalColorStep = initObj.goalColorStep
			this.goalAlpha = initObj.goalAlpha
			this.goalAlphaStep = initObj.goalAlphaStep
			this.currIndex = initObj.currIndex
			this.goal = initObj.goal
			this.targetx = initObj.targetx
			this.targety = initObj.targety
			this.colorr = initObj.colorr
			this.colorg = initObj.colorg
			this.colorb = initObj.colorb
			
			// set the radius and position 
			radius = initObj.radius + Math.random() * .2 * initObj.radius;
			x = initObj.xPos;
			y = initObj.yPos;
						
			// listeners
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED, onRemoved);
						
			// render to screen
			draw(colorr, colorg, colorb);
			
			//initial alpha
			alpha = goalAlpha[currIndex]
					
			this.cacheAsBitmap = true
										
			return this
		}
		
		public function killMe():void 
		{
			ParticleManager.getInstance().removeParticle(this);	
		}
				
		private function onRemoved(event:Event):void {
			// clean up listeners
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.REMOVED, onRemoved);			
		}
		
		
		private function draw(r:Number,g:Number,b:Number):void 
		{
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, this.radius);
			graphics.endFill();
			transform.colorTransform = new ColorTransform(1, 1, 1, 1, r, g, b, 0);
		}
		
		public function onEnterFrame(event:Event):void
		{
				deltax = targetx - x;
				deltay = targety - y
				
				distance = Math.sqrt( Math.pow(deltax, 2) + Math.pow(deltay, 2) );
				
				vx += deltax / distance;
				vy += deltay / distance;
							
				vx = vx / goalGravity[goal];
				vy = vy / goalGravity[goal];
										
				if (distance < goalNearRadius[goal])
				{
					if (dieOnThisStep[goal]>0)
					{	
						killMe()
					}
					
					if (Math.random() > goalProbability[goal])
					{
						newGoal = goalHead[goal];	
					}
					else
					{
						newGoal = goalTail[goal];
					}
					
					angle = Math.random() * (2 * Math.PI);
					distance = Math.random() * (goalFuzzyRadius[goal] - 1);
						
					targetx = goalPositionX[newGoal] + (distance * Math.cos(angle));
					targety = goalPositionY[newGoal] + (distance * Math.sin(angle));
						
					// color steps only if asked for
					if (bColorChange)
					{	
						rdelta = goalColorR[goal] - colorr / goalColorStep[this.goal];
						gdelta = goalColorG[goal] - colorg / goalColorStep[this.goal];
						bdelta = goalColorB[goal] - colorb / goalColorStep[this.goal];
						colorsteps = goalColorStep[goal]
					}
					if (bAlphaChange)
					{
						alphadelta = goalAlpha[goal] - this.alpha
						alphasteps = goalAlphaStep[goal]
					}
					
					// assign drift
					//this.driftsteps = goalDriftStep[this.goal];
					driftcount = 0;
					
					// assign timeslice
					//this.slicemax = goalTimeSlice[this.goal];
		
					goal = newGoal;
				
			}
			
			x += vx / slicemax; 
			y += vy / slicemax;
			
			//update alpha
			
			if (bAlphaChange)
			{
				if (alphasteps>0)
				{
					alpha += alphadelta
					alphasteps--
				}
			}
			
			// Do color steps only if asked for 
			if (bColorChange)
			{
				if (colorsteps > 0)
				{
					colorr += rdelta;
					colorg += gdelta;
					colorb += bdelta;
						
					transform.colorTransform = new ColorTransform(1,1,1,alpha, colorr,colorg, colorb);
					colorsteps--;
				}
			}	
			
			
			
			// Do Size Steps only if asked for
			/*
			if (bSizeChange)
			{
				if (this.sizesteps > 0)
				{
					this.width += this.sizedelta;
					this.height += this.sizedelta;
				
					this.sizesteps--;
				}
			}
			*/		
			
			if (driftcount > driftsteps)
			{
				angle = Math.random() * (2 * Math.PI);
				distance = Math.random() * (goalFuzzyRadius[goal] - 1);
						
				targetx = goalPositionX[goal] + (distance * Math.cos(angle));
				targety = goalPositionY[goal] + (distance * Math.sin(angle));
				
				driftcount = 0;
			}
			
			driftcount++;
		}
	 
					
	}
	
}