
import com.adobe.cairngorm.control.CairngormEvent;
import com.adobe.cairngorm.control.CairngormEventDispatcher;
import com.adobe.onair.logging.FileTarget;
import com.adobe.onair.logging.TextAreaTarget;
import com.mcquilleninteractive.learnhvac.business.GraphManager;
import com.mcquilleninteractive.learnhvac.event.LoggedInEvent;
import com.mcquilleninteractive.learnhvac.event.LoginEvent;
import com.mcquilleninteractive.learnhvac.event.LogoutEvent;
import com.mcquilleninteractive.learnhvac.model.LHModelLocator;
import com.mcquilleninteractive.learnhvac.model.DefaultScenariosModel;
import com.mcquilleninteractive.learnhvac.settings.LearnHVACSettings;
import com.mcquilleninteractive.learnhvac.util.HTMLToolTip;
import com.mcquilleninteractive.learnhvac.util.Logger;

import flash.data.EncryptedLocalStore
import flash.filesystem.*
import mx.logging.Log;
import mx.logging.LogEventLevel;
import mx.logging.targets.TraceTarget;
import mx.managers.PopUpManager;
import mx.managers.ToolTipManager;
import flash.events.Event;


//for logging...

private var traceTarget:TraceTarget
private var textAreaTarget:TextAreaTarget
private var fileTarget:FileTarget


//settings file (this was for AIR-based app)
//private static const SETTINGS_PATH:String = "app-storage:/settings.db"

//application settings
private var settings:LearnHVACSettings
		
[Bindable]
public var model : LHModelLocator = LHModelLocator.getInstance();
		

private function onAppComplete():void
{
    loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);	
}

private function onUncaughtError(e:UncaughtErrorEvent):void
{
    if (e.error is Error)
    {
        var error:Error = e.error as Error;
        Logger.error("Uncaught Error: " + error.errorID + " name: " + error.name + " message " + error.message, this);
    }
    else
    {
        var errorEvent:ErrorEvent = e.error as ErrorEvent;
        Logger.error("Uncaught Error: errorEvent.errorID: " + errorEvent.errorID, this);
    }
}




/*************** Event handlers *****************/


private function onPreInit():void
{
}

public function onInit():void
{
	
	var ml:LHModelLocator = LHModelLocator.getInstance()
		
	//setup HTML tool tips
	ToolTipManager.toolTipClass = HTMLToolTip;
	
	//get settings
	initSettings()

	//init Log
	initLog()
	Logger.debug("#LH: logging is all setup!")

	//if this is first run, copy installed files to working directories
	//check if this is first install
	var firstInstallDataBA:ByteArray = EncryptedLocalStore.getItem("firstInstallDate")
	if (firstInstallDataBA==null)
	{
		ml.isFirstStartup = true
		doFirstStartup()
	}

	//TEMP 
	doFirstStartup()

	//set proxy port from settings
	ml.proxyPort = settings.proxyPort
	
	//listeners
	CairngormEventDispatcher.getInstance().addEventListener("scenarioLoaded",onScenarioLoaded)
	CairngormEventDispatcher.getInstance().addEventListener(LoggedInEvent.EVENT_LOGGED_IN, onLoggedIn)
	CairngormEventDispatcher.getInstance().addEventListener(LogoutEvent.EVENT_LOGOUT, onLogout)
	
	//setup graphs
	ml.graphManager = new GraphManager()
	
	//default scenarios
	ml.defaultScenarioList = new DefaultScenariosModel()
		
	//finally, start server list query
	//Logger.debug("#LearnHVAC app: launching getServerListEvent")
	//var cgEvent : GetServerListEvent = new GetServerListEvent(GetServerListEvent.EVENT_GET_SERVER_LIST)
	//CairngormEventDispatcher.getInstance().dispatchEvent( cgEvent )
	
}

public function onCC():void
{
	//intercept close function
	this.addEventListener(Event.CLOSING, onAppClose, false, 0, true)			
}	

public function onLoggedIn(event:CairngormEvent):void
{
	
	Logger.debug("#LearnHVAC app: onLoggedIn called...trying to stop SplashScreen")
	loginPanel.visible = false
	loginPanel.splashScreen.stopAnim()
	mainCanvas.visible = true
}

public function onLogout(event:LogoutEvent):void
{
	//do all cleanup necessary when user logs out...
	Logger.debug("#App: onLogout called")
	//pnlSim.onLogout()	
	loginPanel.visible = true
	loginPanel.splashScreen.startAnim()
	model.viewing = LHModelLocator.PANEL_SELECT_SCENARIO
	loginPanel.visible = true
	mainCanvas.visible = false
	
}



public function onScenarioLoaded(event:Event):void
{

}


public function onSimulation():void
{
	
}


/*************** Init Functions *****************/




public function initSettings():void
{
	settings = new LearnHVACSettings()
}

public function initLog():void
{
	
		
		
	if(settings.logToTrace)
	{
		traceTarget = createTraceTarget()
		traceTarget.level = LogEventLevel.DEBUG
		Log.addTarget(traceTarget)
	}
	
	if(settings.logToFile)
	{
		fileTarget = createFileTarget()
		fileTarget.level = LogEventLevel.DEBUG
		Log.addTarget(fileTarget)
	}
	
	
	
}



private function createTraceTarget():TraceTarget
{
	var t:TraceTarget = new TraceTarget();
	t.includeDate = true;
	t.includeTime = true;
	t.includeLevel = true;
	t.level = LogEventLevel.DEBUG;
	return t;
}


private function createFileTarget():FileTarget
{
	
	var f:FileTarget = new FileTarget();
	f.includeDate = true;
	f.includeTime = true;
	f.includeLevel = true;
	f.level = LogEventLevel.DEBUG;
	return f;
	
}


/*************** Core Functions *****************/


protected function doFirstStartup():void
{ 
		Logger.debug("Doing first startup tasks",this)		
		//record the date first installed
		var d:Date = new Date()
		var dateBA:ByteArray = new ByteArray()
		dateBA.writeUTFBytes(d.toString())
		EncryptedLocalStore.setItem("firstInstallDate", dateBA)
		
		
		//copy the spark to the storage directory		
		var sparkFile:File = File.applicationDirectory.resolvePath("spark")
		var copySparkFile:File = File.userDirectory.resolvePath("Local Settings/Application Data/LearnHVAC/spark")
		Logger.debug("Moving spark to : " +  copySparkFile.nativePath, this) 
		copySparkFile.createDirectory()
		sparkFile.copyTo(copySparkFile, true)
				
		//copy the energyplus to the storage directory	
		var eplusFile:File = File.applicationDirectory.resolvePath("energyplus")
		var copyEplusFile:File = File.userDirectory.resolvePath("Local Settings/Application Data/LearnHVAC/energyplus")
		Logger.debug("Moving EnergyPlus to: " + copyEplusFile.nativePath, this) 
		copyEplusFile.createDirectory()
		eplusFile.copyTo(copyEplusFile, true)		
		
		
}

protected function onAppClose(event:Event):void
{
	Logger.debug("intercepting close ",this)
	
	//TODO: kill running spark or E+ processes
	Logger.debug("forcing spark to stop ",this)
	var ml:LHModelLocator = LHModelLocator.getInstance()
	ml.scenarioModel.sparkService.stopSpark()
	
	
}





