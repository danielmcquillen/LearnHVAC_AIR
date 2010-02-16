
import com.adobe.onair.logging.FileTarget;
import com.adobe.onair.logging.TextAreaTarget;
import com.mcquilleninteractive.learnhvac.event.LoggedInEvent;
import com.mcquilleninteractive.learnhvac.model.ApplicationModel;
import com.mcquilleninteractive.learnhvac.model.ScenarioLibraryModel;
import com.mcquilleninteractive.learnhvac.model.ScenarioModel;
import com.mcquilleninteractive.learnhvac.settings.LearnHVACSettings;
import com.mcquilleninteractive.learnhvac.util.HTMLToolTip;
import com.mcquilleninteractive.learnhvac.util.Logger;

import testSuites.testSuite1.*;
import org.flexunit.listeners.UIListener;
import org.flexunit.runner.FlexUnitCore;

import flash.data.EncryptedLocalStore;
import flash.events.Event;
import flash.filesystem.*;

import mx.logging.Log;
import mx.logging.LogEventLevel;
import mx.logging.targets.TraceTarget;
import mx.managers.ToolTipManager;

import net.digitalprimates.fluint.ui.TestRunner;

import org.swizframework.Swiz;

[Bindable]
private var _applicationModel:ApplicationModel

[Bindable]
private var _scenarioModel:ScenarioModel
private var _ascenarioLibraryModel:ScenarioLibraryModel

private var traceTarget:TraceTarget
private var textAreaTarget:TextAreaTarget
private var fileTarget:FileTarget
private var settings:LearnHVACSettings
private var core:FlexUnitCore;


/*************** lifecycle event handlers *****************/


private function onPreInit():void
{	
	initSettings()	
	initLog()	
	Logger.debug("getting beans...", this)
	_applicationModel = Swiz.getBean("applicationModel") as ApplicationModel
	_ascenarioLibraryModel = Swiz.getBean("scenarioLibraryModel") as ScenarioLibraryModel
	_scenarioModel = Swiz.getBean("scenarioModel") as ScenarioModel
}

public function onInit():void
{
	ToolTipManager.toolTipClass = HTMLToolTip;
	

	Logger.debug("#LH: logging is all setup!")

	//if this is first run, copy installed files to working directories
	//check if this is first install
	var firstInstallDataBA:ByteArray = EncryptedLocalStore.getItem("firstInstallDate")
	if (firstInstallDataBA==null)
	{
		_applicationModel.isFirstStartup = true
		doFirstStartup()
	}

	//set proxy port from settings
	_applicationModel.proxyPort = settings.proxyPort
	
}

public function onCC():void
{
	//intercept close function
	this.addEventListener(Event.CLOSING, onAppClose, false, 0, true)	
	
	//TESTING: UNCOMMENT TO RUN TESTS
	runTests()		
}	

protected function runTests():void
{
	core = new FlexUnitCore();
	core.addListener(new UIListener(uiListener));
	core.run( TestSuite1 );
}

private function onAppComplete():void
{
    loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaughtError);	
}


/*************** event handlers *****************/

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

[Mediate(event="LoggedInEvent.LOGGGED_IN")]
public function onLoggedIn(event:LoggedInEvent):void
{	
	Logger.debug("onLoggedIn called...trying to stop SplashScreen", this)
	loginPanel.visible = false
	loginPanel.splashScreen.stopAnim()
	mainCanvas.visible = true
}




protected function onAppClose(event:Event):void
{
	Logger.debug("intercepting close ",this)	
	//TODO: kill running modelica or E+ processes
	
	
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
		var copySparkFile:File = File.userDirectory.resolvePath(ApplicationModel.baseStoragePath + "spark")
		if (copySparkFile.exists==false)
		{
			copySparkFile.createDirectory()
		}
		Logger.debug("Moving spark to : " +  copySparkFile.nativePath, this) 
		copySparkFile.createDirectory()
		sparkFile.copyTo(copySparkFile, true)
				
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
		
		//copy the included scenarios to the storage directory	
		var scenariosFile:File = File.applicationDirectory.resolvePath("scenarios")
		var copyScenariosFile:File = File.userDirectory.resolvePath(ApplicationModel.baseStoragePath + "scenarios")
		if (copyScenariosFile.exists==false)
		{
			copyScenariosFile.createDirectory()
		}
		Logger.debug("Moving scenarios to: " + copyScenariosFile.nativePath, this) 
		copyScenariosFile.createDirectory()
		scenariosFile.copyTo(copyScenariosFile, true)
		
		
}





