// ActionScript file


package com.mcquilleninteractive.particleengine
{
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import mx.core.UIComponent;
	
	public class ParticleManager 
	{		
		// SINGLETON CODE
		
		private static var particleManager:ParticleManager
			
		public static function getInstance():ParticleManager
		{
			if (particleManager == null)
			{
				particleManager = new ParticleManager()
			}
			return particleManager
						
		}
		
		public function ParticleManager()
		{
			if (particleManager != null)
			{
				throw new Error("Only one ParticleManager instance should be instantiated")
			}			
		}
		
		// INSTANCE CODE

		public var numParticlesAlive:Number = 0
		private var allParticles:Array;
		private var recycleArr:Array;
		private var engineRef:UIComponent
		
				
		public function init(eRef:UIComponent):void {
					
			engineRef = eRef
			allParticles = []
			recycleArr = []	
			
		}
		
		public function createParticle(initObject:Object):void 
		{
			var slot:int = getNextSlot();				
			allParticles[slot] = new Particle().init(slot, initObject);	
			engineRef.addChild(allParticles[slot]);
			numParticlesAlive ++
		}
		
		public function removeParticle(p:Particle):void 
		{
			engineRef.removeChild(p)
			recycleArr.push(p.pid)
			numParticlesAlive --
		}
		
		public function removeAllParticles():void
		{
			Logger.debug("#PM: removeAllParticles() called.")
			for (var i:int = 0; i < allParticles.length; i++)
			{
				
				var p:Particle = allParticles[i] as Particle
				try
				{
					removeParticle(p)
				}
				catch(e:Error)
				{
					//no harm done
				}
			}
						
		}
		
		private function getNextSlot():int
		{
			if (recycleArr.length > 0) {
				return int(recycleArr.pop());
			}
			else {
				return allParticles.length;
			}		
		}
		
		
		
		
		
		
		
	}
		
}

