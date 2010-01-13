/// \file  VAV_damper.cc
/// \brief VAV box damper model. Calculates the pressure drop and flow rate given a control signal and considering a number of possible faults.   
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - port	damp_pos       	"damper position (0=closed, 1=open)" 			[scalar] ; 
/// - port    p_drop          "pressure drop across the VAV box" [Pa];
/// - port    mVAVmax     "mass flow rate if damper is fully opened";
/// - port	StuckDamper;
/// - port	LeakyDamper;
/// - port	VAVFlowSensorOffset;
/// - port	FailedActuator;
/// - port	BoxTooBig;
/// - port	BoxTooSmall;
/// - port	mVAVreal   	"damper mass flow rate" 			      [kg/s] ; 
/// - port    mVAVmeas    "measured damper mass flow rate" [-];
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// mVAVreal, mVAVmeas = VAV_damper(damp_pos,p_drop,mVAVmax,StuckDamper,LeakyDamper,VAVFlowSensorOffset,FailedActuator,BoxTooBig,BoxTooSmall)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
/// Peng Xu 2004.1
///     - Initial implementation.
///     - Modified P Haves 12/1/07
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef	spark_parser

//Inputs
port	damp_pos       	"damper position (0=closed, 1=open)" 			[scalar] ; 
port    p_drop          "pressure drop across the VAV box" [Pa];
port    mVAVmax     "mass flow rate if damper is fully opened";
port	StuckDamper;
port	LeakyDamper;
//port	BadDmprPosSignal;
port	VAVFlowSensorOffset;
port	FailedActuator;
//port	BadReheatCoil;
//port	TooHighInletAirSP;
//port	TooLowInletAirSP;
port	BoxTooBig;
port	BoxTooSmall;

//Outputs
port	mVAVreal   	"damper mass flow rate" 			      [kg/s] ; 
port    mVAVmeas    "measured damper mass flow rate" [-];


functions {
	mVAVreal, mVAVmeas = VAV_damper(damp_pos,p_drop,mVAVmax,StuckDamper,LeakyDamper,VAVFlowSensorOffset,FailedActuator,BoxTooBig,BoxTooSmall);
	}


EQUATIONS {
}


#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>

///////////////////////////////////////////////////////////
EVALUATE (VAV_damper)
{
ARGDEF(0,	damp_pos 	);
ARGDEF(1,	p_drop	);
ARGDEF(2,	mVAVmax	);
ARGDEF(3,	StuckDamper	);
ARGDEF(4,	LeakyDamper	);
//ARGDEF(4,	BadDmprPosSignal	);
ARGDEF(5,	VAVFlowSensorOffset	);
ARGDEF(6,	FailedActuator	);
//ARGDEF(7,	BadReheatCoil	);
//ARGDEF(6,	TooHighInletAirSP	);
//ARGDEF(9,	TooLowInletAirSP	);
ARGDEF(7,	BoxTooBig	);
ARGDEF(8,	BoxTooSmall	);


// outputs
double  mVAVreal;
double  mVAVmeas;

//local variables
double damp_pos_real;
double p_drop_des = 200.0; //200Pa is the pressure drop at design condition
double f1=0.0;
double f2=0.0;
double f3=0.0;

damp_pos_real=damp_pos;

if(StuckDamper>=0.0) damp_pos_real=StuckDamper;
if(FailedActuator>=0.0) damp_pos_real=FailedActuator;

if(LeakyDamper>0.0) damp_pos_real=SPARK::max(LeakyDamper,damp_pos_real);

//f1=pow(p_drop/p_drop_des,0.5); //200Pa is the pressure drop at design condition
f1=1.0; // changed, Brian Coffey, March 3, 2009
f2=1.0-((1.0-damp_pos_real)*(1.0-damp_pos_real)); // quick open damper

// over- or under-sized box
f3=1.0;
if (BoxTooBig >0.0)
  f3=BoxTooBig;
if (BoxTooSmall >0.0)
  f3=BoxTooSmall;

mVAVreal=SPARK::max(mVAVmax*0.001, mVAVmax*f1*f2*f3);  //minimum airflow set as 0.1% of maximum air flow to prevent model from crashing

if (VAVFlowSensorOffset>-999.0)
  mVAVmeas = mVAVreal + VAVFlowSensorOffset*mVAVmax;
else
  mVAVmeas = mVAVreal;


BEGIN_RETURN
  mVAVreal,    
  mVAVmeas
END_RETURN

}

