package com.mcquilleninteractive.learnhvac.model
{
	
	import com.mcquilleninteractive.learnhvac.vo.ScenarioListItemVO;
	import flash.utils.ByteArray;
	import mx.collections.ArrayCollection;
	
	
	[Bindable]
	public class DefaultScenariosModel
	{
				
		[Embed(source="/assets/scenarios/DefaultScenario.xml", mimeType="application/octet-stream")]
		public var basicScenarioXML:Class;
		
		public var defaultScenariosAC:ArrayCollection
		
		public function DefaultScenariosModel()
		{
			defaultScenariosAC = new ArrayCollection()
		
			var scenObj:ScenarioListItemVO = new ScenarioListItemVO();	
			scenObj.scenID = "DefaultBasicScenario";
			scenObj.name = "Basic Scenario";
			scenObj.shortDescription = "The basic scenario has all features enabled and is meant to provide a platform for experimentation with Learn HVAC.";
			scenObj.sourceType = ScenarioListItemVO.SOURCE_DEFAULT;
			//scenObj.thumbnailURL = "http://admin.learnhvac.org/thumbnails/pic_scenario_spring.png"
			
			//so stupid that I can't just embed the xml as mimeType='text/xml' or something 
			var ba:ByteArray = new basicScenarioXML() as ByteArray;			
			scenObj.scenarioXML = XML(ba.readUTFBytes(ba.length));
					
			defaultScenariosAC.addItem(scenObj)
		
		}
		
		public function get defaultScenarioXML():XML
		{
			var ba:ByteArray = new basicScenarioXML() as ByteArray;			
			return XML(ba.readUTFBytes(ba.length));
		}
		
		
		

	}
}