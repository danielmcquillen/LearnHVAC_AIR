package testSuites.testSuite1.tests
{
	import com.mcquilleninteractive.learnhvac.model.LongTermSimulationDataModel;
	import com.mcquilleninteractive.learnhvac.view.longterm.LongTermSimulationRunOptions;
	import mx.events.CalendarLayoutChangeEvent
	import flash.events.Event;
	
	import mx.controls.ComboBox;
	import mx.events.FlexEvent;
	import mx.events.ListEvent
	import mx.events.CalendarLayoutChangeEvent
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	import org.swizframework.Swiz;
	
	public class TestLTOptions
	{		
		private var _ltOptions:LongTermSimulationRunOptions
		
		[Before( async, ui )]
	    public function setUp():void 
	    {
			_ltOptions = new LongTermSimulationRunOptions()
			
			//manually autowire via swiz
			Swiz.autowire(_ltOptions)	
			
			Async.proceedOnEvent( this, _ltOptions, FlexEvent.CREATION_COMPLETE, 1000 );
			UIImpersonator.addChild( _ltOptions );
	    }
		
		[After(ui)]
	    public function tearDown():void 
	    {
	    	UIImpersonator.removeChild( _ltOptions );
	    	_ltOptions = null;
	    }
		
		[Test(async, description="")]
		public function testSimRunIDIsSetCorrectlyByUI():void
		{
			_ltOptions.longTermSimulationModel.runID = LongTermSimulationDataModel.RUN_1
		
			//should trigger onRunChange() when committed
			_ltOptions.cboRun.addEventListener( ListEvent.CHANGE, 
           										Async.asyncHandler( this, handleRunIDIsSetCorrectlyByUI, 
           													1000, null, handleEventNeverOccurred ), 
            									false, 0, true );
			var cboRun:ComboBox = _ltOptions.cboRun
			cboRun.selectedIndex = 1  //LongTermSimulationDataModel.RUN_2
			cboRun.dispatchEvent(new ListEvent(ListEvent.CHANGE))
				
		}
		
		public function handleRunIDIsSetCorrectlyByUI(event:Event, passThroughData:Object):void
		{
			Assert.assertEquals(LongTermSimulationDataModel.RUN_2, _ltOptions.longTermSimulationModel.runID)
		}
		
	
		
		public function testSimRunStartDates():void
		{				
			_ltOptions.dfStartDate.addEventListener( ListEvent.CHANGE, 
           											Async.asyncHandler( this, handleRunIDIsSetCorrectlyByUI, 
           													1000, null, handleEventNeverOccurred ), 
            										false, 0, true );
			_ltOptions.dfStartDate.selectedDate = new Date(2010, 0, 31); //Jan 31 
		}
		
		
		
		
		public function handleEventNeverOccurred(passThroughData:Object):void
		{
			 Assert.fail('Pending Event Never Occurred');
		}

	}
}