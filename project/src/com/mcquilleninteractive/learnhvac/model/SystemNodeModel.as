package com.mcquilleninteractive.learnhvac.model
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class SystemNodeModel
	{
		
		public var id:String;
		public var name:String;
		public var sysVarsArr:ArrayCollection;
		public var sortOrderIndex:uint
		
		public function SystemNodeModel()
		{
			
		}
		
	}
}