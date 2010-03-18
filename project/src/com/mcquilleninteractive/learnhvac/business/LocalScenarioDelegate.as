package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.ScenarioListItemVO;
	
	import flash.filesystem.*;
	
	import mx.collections.ArrayCollection;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class LocalScenarioDelegate extends EventDispatcher
	{
		public static const LOCAL_SCENARIOS_LOADED:String = "localScenarioLoaded"
		public static const NO_LOCAL_SCENARIOS_FOUND:String = "noLocalScenariosFound"
		
		private var service:Object
		private var _localScenarioListAC:ArrayCollection
		
		public function LocalScenarioDelegate()
		{
		}
		
		public function get localScenarioListAC():ArrayCollection
		{
			return _localScenarioListAC
		}
		
				
		public function loadScenarioList():ArrayCollection
		{
		
			//get list of files in scenarios folder
			var xmlFilesDir:File = File.applicationDirectory.resolvePath("scenarios")
			var xmlFilesArr:Array = xmlFilesDir.getDirectoryListing()
					
			if (xmlFilesArr.length==0)
			{
				dispatchEvent(new Event(LocalScenarioDelegate.NO_LOCAL_SCENARIOS_FOUND))
			}
		
			var filesLoaded:Number = 0
			var filesError:Number = 0
			var fileCount:Number = 0
			var totalScenarios:Number = xmlFilesArr.length
			Logger.debug("xmlFiles.length: "+ xmlFilesArr.length, this)
		
			_localScenarioListAC = new ArrayCollection()
		
			for (var index:Number=0;index<totalScenarios; index++)
			{
				//try to load next file
				var scenFile:File = xmlFilesArr[index]
				
				var stream:FileStream = new FileStream()
				stream.open(scenFile, FileMode.READ)
				
				var scenContent:String = stream.readUTFBytes(stream.bytesAvailable)							
				var currScenXML:XML = new XML(scenContent)				
				var scenObj:ScenarioListItemVO = new ScenarioListItemVO()
							
				scenObj.fileName = scenFile.name
				Logger.debug("filename: " + scenObj.fileName,this)
				scenObj.scenID = currScenXML.@id
				scenObj.name = currScenXML.@name
				scenObj.shortDescription = currScenXML.@shortDescription
				scenObj.sourceType = ScenarioListItemVO.SOURCE_LOCAL_FILE
				
				// grab name of thumbnail. If the user grabbed this xml straight from the web
				// this thumbnail URL probably has a complete web URL (e.g. http://www.learnhvac.org:3000/thumbnails/mypic.jpg")
				// so remove everything except what's between the last "/" and then end of the string
				var t:String = currScenXML.@thumbnailURL
				t = t.slice(t.lastIndexOf("/")+1	)
				scenObj.thumbnailURL = File.applicationDirectory.resolvePath("scenarios/thumbnails/" + t).nativePath
				Logger.debug("thumbnailURL : " + scenObj.thumbnailURL, this)
				_localScenarioListAC.addItem(scenObj)						
			}			
			return _localScenarioListAC				
		}
	
	
		public function loadLocalScenario( fileName:String):XML
		{
			Logger.debug("loadLocalScenario: path: " + fileName, this)
			var scenFile:File = File.applicationDirectory.resolvePath("scenarios/" + fileName)
			if (!scenFile.exists)
			{
				throw new Error("File doensn't exist")
			}
			
			var stream:FileStream = new FileStream()
			stream.open(scenFile, FileMode.READ)
			var content:String = stream.readUTFBytes(stream.bytesAvailable)					
			var scenXML:XML = new XML(content)
			return scenXML
		}
		
		
		
	}
}