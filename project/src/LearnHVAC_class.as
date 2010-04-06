
import com.mcquilleninteractive.learnhvac.event.ApplicationEvent;
import com.mcquilleninteractive.learnhvac.util.Logger;

import flash.filesystem.*;
import mx.logging.Log;
import org.swizframework.Swiz;

/*************** lifecycle event handlers *****************/


private function onPreInit():void
{		
	Log.addTarget(traceTarget)
	Logger.debug("onPreInit()",this)
	Swiz.dispatchEvent(new ApplicationEvent(ApplicationEvent.INIT_APP, true))
}


private function onAppComplete():void
{
	Swiz.dispatchEvent(new ApplicationEvent(ApplicationEvent.START_APP, true))	
}


/*************** event handlers *****************/

/*
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
*/



