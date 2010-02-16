package testSuites.testSuite1.tests
{
	import com.mcquilleninteractive.learnhvac.business.LongTermSimulationDelegate;
	import com.mcquilleninteractive.learnhvac.controller.ScenarioController;
	import com.mcquilleninteractive.learnhvac.controller.ScenarioLibraryController;
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import org.flexunit.Assert;
	import org.swizframework.Swiz;
	/* Make sure that the properties that are set in the model are correctly passed to E+ */
	
	public class TestLongTermModelWrittenToEPlus
	{		
		private var _ltModel:LongTermSimulationModel
		private var _scenarioModel:ScenarioModel
		private var _scenarioLibraryController:ScenarioLibraryController
		private var _ltDelegate:LongTermSimulationDelegate
		
		[Before]
	    public function setUp():void 
	    {
	    	Logger.debug("#### Setting up!",this)
			//manually autowire via swiz
			_ltModel = Swiz.getBean("longTermSimulationModel") as LongTermSimulationModel
			_ltDelegate = Swiz.getBean("longTermSimulationDelegate") as LongTermSimulationDelegate
			_scenarioModel = Swiz.getBean("scenarioModel") as ScenarioModel
			_scenarioLibraryController = Swiz.getBean("scenarioLibraryController") as ScenarioLibraryController
	    	_scenarioLibraryController.loadDataForTest()
	    }
		
		[After]
	    public function tearDown():void 
	    {
	    	_ltDelegate = null
	    	_ltModel = null;
	    }
		
		[Test(description="Make sure that the properties that are set in the model are correctly passed to E+")]
		public function testModelValuesSentToEPlus():void
		{
			
			//set some new values on the model
			_scenarioModel.name = "TestName"
			_ltModel.regionSelectedIndex = 1	//northEast cities
			_ltModel.citySelectedIndex = 3		//Duluth		
				
			//create the output txt and make sure each line is correct	
			var output:String = _ltDelegate.buildOutputString()	
			var linesArr:Array = output.split("\n")
			
			Assert.assertEquals("##def1 LH_ScenarioName	   TestName", linesArr[5])
			Assert.assertEquals("##def1 LH_weatherFile      USA_MN_Duluth_TMY2.epw", linesArr[6])
			
		}
		
	
		

	}
}