package com.mcquilleninteractive.learnhvac.controller
{
	
	
	import com.mcquilleninteractive.learnhvac.event.ApplicationEvent;
	import com.mcquilleninteractive.learnhvac.event.GetScenarioListEvent;
	import com.mcquilleninteractive.learnhvac.event.LoggedInEvent;
	import com.mcquilleninteractive.learnhvac.event.LogoutEvent;
	import com.mcquilleninteractive.learnhvac.event.SetUnitsCompleteEvent;
	import com.mcquilleninteractive.learnhvac.event.SetUnitsEvent;
	import com.mcquilleninteractive.learnhvac.event.SettingsEvent;
	import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
	import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
	import com.mcquilleninteractive.learnhvac.model.SystemNodeModel;
	import com.mcquilleninteractive.learnhvac.model.SystemVariable;
	import com.mcquilleninteractive.learnhvac.settings.LearnHVACSettings;
	import com.mcquilleninteractive.learnhvac.util.AboutInfo;
	import com.mcquilleninteractive.learnhvac.util.HTMLToolTip;
	import com.mcquilleninteractive.learnhvac.util.Logger;
	
	import flash.data.EncryptedLocalStore;
	import flash.events.Event;
	import flash.filesystem.*;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.managers.ToolTipManager;
	
	import org.swizframework.Swiz;
	import org.swizframework.controller.AbstractController;
	
	public class ApplicationController  extends AbstractController
	{
		[Autowire]
		public var applicationModel:ApplicationModel
		
		[Autowire]
		public var scenarioModel:ScenarioModel
		
		public function ApplicationController()
		{
		}
		
		[Mediate(event="ApplicationEvent.INIT_APP")]
		public function initApp(event:ApplicationEvent):void
		{
			Logger.logToFile = applicationModel.logToFile	
			Logger.debug("initApp()",this)
			
			//init settings
			//TODO: load settings from file...
			//for now just set properties and then launch an event as if these were read in
			var settings:LearnHVACSettings = new LearnHVACSettings()	
			//eventually units will be read in from settings
			ApplicationModel.currUnits = "SI"
						
			var evt:SettingsEvent = new SettingsEvent(SettingsEvent.SETTINGS_LOADED, true)
			Swiz.dispatchEvent(evt)
								
			//if this is first run, copy helper files to working directories
			var ba:ByteArray = EncryptedLocalStore.getItem("lastInstalledVersion")	
						
			if (ba==null || ba.readUTFBytes(ba.bytesAvailable)!=AboutInfo.applicationVersion)
			{
				Logger.debug("New version installed ... now copying helper files...",this)
				copyHelperFiles()		
				//record the latest version number
				ba = new ByteArray()
				ba.writeUTFBytes(AboutInfo.applicationVersion)
				EncryptedLocalStore.setItem("lastInstalledVersion", ba)		
			}
			
			
			//set proxy port from settings
			applicationModel.proxyPort = settings.proxyPort
			
			//setup tooltips
			ToolTipManager.toolTipClass = HTMLToolTip;	
			
			Application.application.addEventListener(Event.CLOSING, onAppClose, false, 0, true)	
			
					
		}
		
		[Mediate(event="ApplicationEvent.START_APP")]
		public function startApp(event:ApplicationEvent):void
		{
			Logger.logToFile = applicationModel.logToFile	
			
			//check for correct flash version
			Logger.debug("Flash player version: " + AboutInfo.flashPlayerVersion, this)
			var versionMajor:String = AboutInfo.flashPlayerVersion.substr(4,2)
			if (versionMajor!="10")
			{
				Alert.show("Please install Flash Player 10 before using Learn HVAC.","Flash Version Error")
			}
			//TESTING: UNCOMMENT TO RUN TESTS
			//runTests()			
		}


		[Mediate(event="LoggedInEvent.LOGGED_IN")]
		public function loggedIn(event:LoggedInEvent):void
		{
			applicationModel.loggedIn = true
			applicationModel.viewing = ApplicationModel.PANEL_SELECT_SCENARIO				
			if (ApplicationModel.testMode)
			{
				var evt : GetScenarioListEvent = new GetScenarioListEvent(GetScenarioListEvent.GET_DEFAULT_SCENARIO_LIST, true);
				Swiz.dispatchEvent( evt );
			}	
		}
		
		[Mediate(event="LogoutEvent.LOGOUT")]
		public function onLogout(event:LogoutEvent):void
		{
			//do all cleanup necessary when user logs out...
			Logger.debug("onLogout()",this)
			applicationModel.loggedIn = false
			
			//setup for next login						
			applicationModel.viewing = ApplicationModel.PANEL_SELECT_SCENARIO
			
		}



		[Mediate(event="SetUnitsEvent.SET_UNITS")]
		public function setUnits(event:SetUnitsEvent):void
		{											
						
			if (event.units != ApplicationModel.currUnits)
			{
				// change model units first, so that components that bind to units can 
				// be set correctly before values change
				ApplicationModel.currUnits = event.units
				
				//TODO: should probably change all sysVars to simple listen to the scenModel property for units
				//      However, I'm not sure what this would do to speed...so for now I'm changing sysVars individually...
				Logger.debug("#ScenarioModel: changing units on variables to : " + event.type)
				//loop through system variables and change units
				var sysNodesAC:ArrayCollection = scenarioModel.sysNodesAC
				
				for each (var sysNode:SystemNodeModel in sysNodesAC)
				{
					for each (var sysVar:SystemVariable in sysNode.sysVarsArr)
					{
						sysVar.units = event.units
						if (ApplicationModel.currUnits=="IP") sysVar.updateHistoryIP()
						sysVar.resetToInitialValue()
					}
				}
				Logger.debug("#SetUnitsCommand: model's units are now : " + ApplicationModel.currUnits)
			}
			
			
			var evt:SetUnitsCompleteEvent = new SetUnitsCompleteEvent(SetUnitsCompleteEvent.UNITS_CHANGED, true)
			evt.units = event.units			
			Swiz.dispatchEvent(evt)	
		
		}


				
		protected function copyHelperFiles():void
		{ 
			Logger.debug("copyHelperFiles()",this)		
			
			var baseStorageDir:File = File.userDirectory.resolvePath(ApplicationModel.baseStoragePath)
			if (baseStorageDir.exists==false)
			{
				baseStorageDir.createDirectory()
			}
							
			//copy the modelica File to the storage directory		
			var modelicaFile:File = File.applicationDirectory.resolvePath("modelica")
			var copyModelicaFile:File = File.userDirectory.resolvePath(ApplicationModel.baseStoragePath + "modelica")
			if (copyModelicaFile.exists==false)
			{
				copyModelicaFile.createDirectory()
			}
			Logger.debug("Moving modelica to : " +  copyModelicaFile.nativePath, this) 
			copyModelicaFile.createDirectory()
			try
			{
				modelicaFile.copyTo(copyModelicaFile, true)
			}
			catch(error:Error)
			{
				Logger.error("Couldn't copy modelica files: Error: " + error,this)
			}	
			//copy the energyplus to the storage directory	
			var eplusFile:File = File.applicationDirectory.resolvePath("energyplus")
			var copyEplusFile:File = File.userDirectory.resolvePath(ApplicationModel.baseStoragePath + "energyplus")
			if (copyEplusFile.exists==false)
			{
				copyEplusFile.createDirectory()
			}
			Logger.debug("Moving EnergyPlus to: " + copyEplusFile.nativePath, this) 
			copyEplusFile.createDirectory()
			eplusFile.copyTo(copyEplusFile, true)		
			
			//Don't need the following since we're embedding scenarios directly in code for now
			//copy the included scenarios to the storage directory	
			/*
			var scenariosFile:File = File.applicationDirectory.resolvePath("scenarios")
			
			Logger.debug("scenariosFile: " + scenariosFile.nativePath + " exists: " +scenariosFile.exists.toString(), this) 	
			var copyScenariosFile:File = File.userDirectory.resolvePath(ApplicationModel.baseStoragePath + "scenarios")
			if (copyScenariosFile.exists==false)
			{
				copyScenariosFile.createDirectory()
			}
			Logger.debug("Moving scenarios to: " + copyScenariosFile.nativePath, this) 		
			scenariosFile.copyTo(copyScenariosFile, true)
			*/
			
		}

		protected function runTests():void
		{
			//core = new FlexUnitCore();
			//core.addListener(new UIListener(uiListener));
			//core.run( TestSuite1 );
		}	

		public function onAppClose(event:Event):void
		{
			Logger.debug("intercepting close ",this)	
			//TODO: kill running modelica or E+ processes			
		}
		


	}
}