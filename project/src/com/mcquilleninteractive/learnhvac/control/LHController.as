// ActionScript file


package com.mcquilleninteractive.learnhvac.control{
	
	import com.adobe.cairngorm.control.FrontController
	import com.mcquilleninteractive.learnhvac.command.*
	import com.mcquilleninteractive.learnhvac.event.*
	import com.mcquilleninteractive.learnhvac.util.Logger
	
		
	public class LHController extends FrontController {
		
		public function LHController(){
			initializeCommands()
		}
		
		public function initializeCommands():void{
			
			Logger.debug("#LHController: init'ing commands...")
			
			addCommand( LoginEvent.EVENT_LOGIN, LoginCommand )
			
			// NO MAPPING OF LOGOUT EVENT
			// each component is responsible for handling logout event locally,
			// while main Application class handles all the rest
		
			addCommand( ApplicationEvent.EVENT_SELECT_NEW_SCENARIO, SelectNewScenarioCommand)
		
			addCommand( GetScenarioListEvent.EVENT_GET_LOCAL_SCENARIO_LIST, GetLocalScenarioListCommand)
			addCommand( GetScenarioListEvent.EVENT_GET_REMOTE_SCENARIO_LIST, GetRemoteScenarioListCommand)
			addCommand( GetScenarioListEvent.EVENT_GET_DEFAULT_SCENARIO_LIST, GetDefaultScenarioListCommand)
			
			addCommand( LoadScenarioEvent.EVENT_LOAD_LOCAL_SCENARIO, LoadScenarioCommand)
			addCommand( LoadScenarioEvent.EVENT_LOAD_REMOTE_SCENARIO, LoadScenarioCommand)
			addCommand( LoadScenarioEvent.EVENT_LOAD_SCENARIO_XML, LoadScenarioCommand)
			
			addCommand( InputsUpdateEvent.EVENT_INPUTS_UPDATE, InputsUpdateCommand)
			
			addCommand( SetUnitsEvent.EVENT_SET_UNITS_TO_SI, SetUnitsCommand)
			addCommand( SetUnitsEvent.EVENT_SET_UNITS_TO_IP, SetUnitsCommand)
			
			addCommand( ResetInputsToInitialValuesEvent.EVENT_RESET_INPUTS_TO_INITIAL_VALUES, ResetInputsToInitialValuesCommand)
			
			addCommand( ShortTermSimulationEvent.EVENT_START_AHU, ShortTermSimulationCommand)
			// ShortTermSimulationCommand listens directly for an EVENT_CANCEL_START_AHU 
			addCommand( ShortTermSimulationEvent.EVENT_UPDATE_AHU, ShortTermSimulationCommand)
			addCommand( ShortTermSimulationEvent.EVENT_STOP_AHU, ShortTermSimulationCommand)
			
			addCommand( LongTermSimulationEvent.EVENT_RUN, LongTermSimulationCommand)
			
			addCommand( AddVarToGraphEvent.EVENT_ADD_EPLUS_VAR, AddVarToGraphCommand)
			addCommand( AddVarToGraphEvent.EVENT_ADD_SPARK_VAR, AddVarToGraphCommand)
			
			addCommand( ScenarioDataEvent.SAVE_SPARK_DATA_EVENT, SaveScenarioDataCommand)
			addCommand( ScenarioDataEvent.SAVE_EPLUS_DATA_EVENT, SaveScenarioDataCommand)
			addCommand( ScenarioDataEvent.LOAD_SPARK_DATA_EVENT, LoadScenarioDataCommand)
			addCommand( ScenarioDataEvent.LOAD_EPLUS_DATA_EVENT, LoadScenarioDataCommand)
			
			
			//code for test/debugging/admin			
			addCommand( DebugEvent.LOAD_TEST_EPLUS_DATA_EVENT, LoadTestEplusDataCommand)
			
		}
		
	}
	
	
	
		
	
}