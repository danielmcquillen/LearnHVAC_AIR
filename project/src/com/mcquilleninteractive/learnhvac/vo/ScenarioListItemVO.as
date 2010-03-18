package com.mcquilleninteractive.learnhvac.vo
{
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class ScenarioListItemVO extends EventDispatcher
	{
		public static const SOURCE_REMOTE:String = "remoteSource"
		public static const SOURCE_LOCAL_FILE:String = "localFileSource"
		public static const SOURCE_DEFAULT:String = "defaultSource"
		
		public var sourceType:String
		
		public var id:int
		public var scenID:String
		public var name:String
		public var description:String
		public var shortDescription:String
		public var thumbnailURL:String
		public var level:Number
		public var scenarioXML:XML
		public var fileName:String
		
		public function ScenarioListItemVO()
		{
		}

	}
}