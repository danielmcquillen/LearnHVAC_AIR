package com.mcquilleninteractive.learnhvac.view.graphing
{
	import com.mcquilleninteractive.learnhvac.model.data.IGraphDataModel;
	
	import mx.controls.Tree;
			
	public class DataTree extends Tree
	{		
		public var graphDataModel:IGraphDataModel //reference to relevant GraphDataModel object 		
		public var type:String
					
		public function DataTree()
		{
			super()
		}

	}
}