package com.mcquilleninteractive.learnhvac.business 
{
	
	import com.mcquilleninteractive.learnhvac.command.GetLocalScenarioListCommand;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	import com.mcquilleninteractive.learnhvac.vo.ScenarioListItemVO;
	
	import flash.filesystem.*;
	
	import mx.collections.ArrayCollection;
	
	public class LocalScenarioListLoader
	{
				
		private var cmd:GetLocalScenarioListCommand
		private var service:Object
		
		public function LocalScenarioListLoader(command : GetLocalScenarioListCommand)
		{
			this.cmd = command;
		}
		
		public function loadScenarioList():void
		{
		
			//get list of files in scenarios folder
			var xmlFilesDir:File = File.applicationDirectory.resolvePath("scenarios")
			var xmlFilesArr:Array = xmlFilesDir.getDirectoryListing()
			
		
			if (xmlFilesArr.length==0)
			{
				//no files found
				cmd.noLocalFilesFound()
			}
		
			var filesLoaded:Number = 0
			var filesError:Number = 0
			var fileCount:Number = 0
			var totalScenarios:Number = xmlFilesArr.length
			Logger.debug("#ScenarioListLoaderLocal: xmlFiles.length: "+ xmlFilesArr.length)
		
			var scenarioListAC:ArrayCollection = new ArrayCollection()
		
			for (var index:Number=0;index<totalScenarios; index++)
			{
				//try to load next file
				var scenFile:File = xmlFilesArr[index]
				
				var stream:FileStream = new FileStream()
				stream.open(scenFile, FileMode.READ)
				var scenContent:String = stream.readUTFBytes(stream.bytesAvailable)
							
				var currScenXML:XML = new XML(scenContent)
				
				var scenObj:ScenarioListItemVO = new ScenarioListItemVO()
			
				try
				{
					scenObj.fileName = scenFile.name
					Logger.debug("#LSLL: filename: " + scenObj.fileName)
					scenObj.scenID = currScenXML.@id
					scenObj.name = currScenXML.@name
					scenObj.short_description = currScenXML.@short_description
					scenObj.sourceType = ScenarioListItemVO.SOURCE_LOCAL_FILE
					
					// grab name of thumbnail. If the user grabbed this xml straight from the web
					// this thumbnail URL probably has a complete web URL (e.g. http://www.learnhvac.org:3000/thumbnails/mypic.jpg")
					// so remove everything except what's between the last "/" and then end of the string
					var t:String = currScenXML.@thumbnail_URL
					t = t.slice(t.lastIndexOf("/")+1	)
					scenObj.thumbnail_URL = File.applicationDirectory.resolvePath("scenarios/thumbnails/" + t).nativePath
					Logger.debug("#LocalScenarioListLoader: thumbnailURL : " + scenObj.thumbnail_URL)
					scenarioListAC.addItem(scenObj)
				}
				catch (e:Error)
				{
					Logger.error("#LocalScenarioListLoader: trouble grabbing attributes for scenario:" + scenFile.nativePath + " error: "+ e.message)
				}
						
			}
			
			if (scenarioListAC.length>0)
			{
				cmd.scenariosLoaded(scenarioListAC)
			}
			else
			{
				cmd.noLocalFilesFound()
			}
			
		
		}
	
		
		
		
	}
}