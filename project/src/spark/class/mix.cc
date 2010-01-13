/// \file  mix.cc
/// \brief  calculates the mixed air temperature and humidity based on outside air and return air conditions and control systems for the outside air and return air dampers
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT    pos		"Damper position(-) (0 to 1, 1 = 100% outside air, 0 = 100% return air) " ;
/// - PORT    TOut	"Outside air temperature" 						[C]   ;
/// - PORT    wOut     "Outside air humidity ratio" 						[kg_water/kg_dryAir]   ;
/// - PORT    TRet	"Return air humidity ratio" 						[C];
/// - PORT    wRet	"Return air humidity ratio" [kg_water/kg_dryAir];
/// - PORT	minOAfrac;
/// - PORT	LeakOADamper;
/// - PORT	LeakRADamper;
/// - PORT	StuckActuator;
/// - PORT	ReverseActionAct;
/// - PORT    TMix	 "Mixed air temperature"	[C];
/// - PORT    TMixReal "Mixed air temperature sensor"	[-];
/// - PORT    wMix	 "Mixed air humidity ratio"[kg_water/kg_dryAir];
/// - PORT    OAPosDamper;
/// - PORT    RAPosDamper;
/// - PORT    EAPosDamper;

/// - PORT    OAPosDamperReal;
/// - PORT    RAPosDamperReal;
/// - PORT    EAPosDamperReal;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// TMix, TMixReal, wMix, OAPosDamper,RAPosDamper,EAPosDamper,OAPosDamperReal,RAPosDamperReal,EAPosDamperReal = Mix(pos,TOut,wOut,TRet,wRet,minOAfrac,LeakOADamper,LeakRADamper,StuckActuator,ReverseActionAct )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
///     - unknown initial creation
///     - Sept 24, 2008 - Brian Coffey - removed code that kept damper at min position when outside air temp above return air temp
///
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER


//PORT
PORT 	controlSignal  "Control signal(-) (0 to 1, steady-state damper position)" ;
PORT 	prevPos  "Damper position(-) at previous timestep";
PORT 	actuatorSpeed  "Actuator opening/closing speed, increment per timestep";
PORT    pos		"Damper position(-) (0 to 1, 1 = 100% outside air, 0 = 100% return air) " ;
PORT    TOut	"Outside air temperature" 						[C]   ;
PORT    wOut     "Outside air humidity ratio" 						[kg_water/kg_dryAir]   ;
PORT    TRet	"Return air humidity ratio" 						[C];
PORT    wRet	"Return air humidity ratio" [kg_water/kg_dryAir];
PORT	minOAfrac;
PORT	LeakOADamper;
//PORT	BadPosOADamper;
//PORT	StuckOADamper;
PORT	LeakRADamper;
PORT	StuckActuator;
//PORT	DeafActuator;
//PORT	BadSensor;
//PORT	MismatchDampAct;
PORT	ReverseActionAct;

// outputs
PORT    TMix	 "Mixed air temperature"	[C];
PORT    TMixReal "Mixed air temperature sensor"	[-];
PORT    wMix	 "Mixed air humidity ratio"[kg_water/kg_dryAir];
PORT    OAPosDamper;
PORT    RAPosDamper;
PORT    EAPosDamper;

PORT    OAPosDamperReal;
PORT    RAPosDamperReal;
PORT    EAPosDamperReal;


EQUATIONS {
}

FUNCTIONS {
TMix, TMixReal, wMix, OAPosDamper,RAPosDamper,EAPosDamper,OAPosDamperReal,RAPosDamperReal,EAPosDamperReal,pos = Mix(controlSignal,prevPos,actuatorSpeed,TOut,wOut,TRet,wRet,minOAfrac,LeakOADamper,LeakRADamper,StuckActuator,ReverseActionAct );
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>

///////////////////////////////////////////////////////////
EVALUATE (Mix)
{

  ARGDEF(0,	controlSignal	);
  ARGDEF(1,	prevPos	);
  ARGDEF(2,	actuatorSpeed	);
  ARGDEF(3,	TOut	);
  ARGDEF(4, wOut	);
  ARGDEF(5,	TRet	);
  ARGDEF(6, wRet	);
  ARGDEF(7, minOAfrac);
  ARGDEF(8,	LeakOADamper	);
  ARGDEF(9,	LeakRADamper	);
  ARGDEF(10,	StuckActuator	);
  ARGDEF(11,	ReverseActionAct	);
  //ARGDEF(4,	BadPosOADamper	);
  //ARGDEF(5,	StuckOADamper	);
  //ARGDEF(8,	DeafActuator	);
  //ARGDEF(9,	BadSensor	);
  //ARGDEF(10,	MismatchDampAct	);

  double 	pos;
  double 	TMix;
  double 	TMixReal;
  double 	wMix;
  double 	OAPosDamper;
  double 	RAPosDamper;
  double 	EAPosDamper;
  double 	OAPosDamperReal;
  double 	RAPosDamperReal;
  double 	EAPosDamperReal;

  double 	posReal;

  
  if (prevPos < controlSignal) {
    pos = SPARK::min(controlSignal, prevPos + actuatorSpeed);
  }
  else if (prevPos > controlSignal) {
    pos = SPARK::max(controlSignal, prevPos - actuatorSpeed);
  }
  else {
    pos = controlSignal;
  }	
  
  posReal=SPARK::max(minOAfrac, (SPARK::min(1,pos))); //set minimum damper position ; 

  // had an embedded control operation - removed BCoffey-Sept24-08
  //if (TRet<=TOut)
  //  posReal = minOAfrac; //set damper position to minimum if the system is in cooling mode

  //faulty behavior
  if (StuckActuator>=0.0)
    posReal=StuckActuator;

  if (ReverseActionAct>=0.0)
    posReal=1.0-posReal;

  OAPosDamper = posReal;
  OAPosDamperReal = OAPosDamper;

  RAPosDamper = 1.0-posReal;
  RAPosDamperReal = RAPosDamper;

  EAPosDamper = posReal;
  EAPosDamperReal = EAPosDamper;
  
// leaking OA damper  - assume (small) leak in EA damper unimportant since there are alternative paths for exhaust air
  if (LeakOADamper>=0.0) {
    OAPosDamper=posReal    ;
    OAPosDamperReal = SPARK::max(LeakOADamper,OAPosDamper);
	RAPosDamper = 1.0-posReal;
    RAPosDamperReal = RAPosDamper;
	//cout<<"Mix:RAPosDamper="<<RAPosDamper<<endl;
	//cout<<"Mix:RAPosDamperReal="<<RAPosDamperReal<<endl;
    EAPosDamper = posReal;
    EAPosDamperReal = EAPosDamper;
    }

// leaking RA damper  
  if (LeakRADamper>=0.0) {
    OAPosDamper=posReal;
    OAPosDamperReal = OAPosDamper;
	RAPosDamper = 1.0-posReal;
    RAPosDamperReal = SPARK::max(LeakRADamper,RAPosDamper);
    EAPosDamper = posReal;
    EAPosDamperReal = EAPosDamper;
    }

// leaking OA and RA dampers  	
  if (LeakOADamper>=0.0 && LeakRADamper>=0.0) {
    OAPosDamper=posReal    ;
    OAPosDamperReal = SPARK::max(LeakOADamper,OAPosDamper);
	RAPosDamper = 1.0-posReal;
    RAPosDamperReal = SPARK::max(LeakRADamper,RAPosDamper);
    EAPosDamper = posReal;
    EAPosDamperReal = EAPosDamper;
  }
  
// assume that dry bulb temperature, rather than enthalpy, is a conserved quantity  
  TMix = (TOut*OAPosDamperReal + TRet*RAPosDamperReal)/(OAPosDamperReal+RAPosDamperReal);
  wMix = (wOut*OAPosDamperReal + wRet*RAPosDamperReal)/(OAPosDamperReal+RAPosDamperReal);

  TMixReal = TMix;  // assume ideal sensor
    
	//cout<<"Mix:RAPosDamperReal="<<RAPosDamperReal<<endl;
	
  BEGIN_RETURN
    TMix,           
    TMixReal,     
    wMix,           
    OAPosDamper,    
    RAPosDamper,    
    EAPosDamper,    
    OAPosDamperReal,
    RAPosDamperReal,
    EAPosDamperReal,
	pos
  END_RETURN

}





















































