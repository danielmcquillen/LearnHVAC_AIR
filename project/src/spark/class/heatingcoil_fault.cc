/// \file  heatingcoil_fault.cc
/// \brief  
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT    Status [-];
/// - PORT	StuckValve [-];
/// - PORT	BootLeakage [-];
/// - PORT	OversizedValve [-];
/// - PORT	LeakyValve [-];
/// - PORT	ObstructedPipe [-];
/// - PORT	UndersizedCoil [-];
/// - PORT	FouledCoil [-];
/// - PORT 	pos  "Valve control signal (0-1)"[-] ;
/// - PORT	mLiqOpen [kg_water/s];
/// - PORT	UADes [W/k];

/// - PORT 	A "Valve authority (0-1)"		[-] ;
/// - PORT 	fLeak "Fractional valve leakage"	[-] ;
/// - PORT 	posReal "Real valve position (0-1)" [-] ; 
/// - PORT	mLiqOpenReal [kg_water/s];
/// - PORT	UAReal [W/k];
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// A,fLeak,posReal,mLiqOpenReal,UAReal = heatingcoil_fault (StuckValve,BootLeakage,OversizedValve,LeakyValve,ObstructedPipe,UndersizedCoil,FouledCoil,Status,pos,mLiqOpen,UADes)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER


//Inputs
PORT    Status [-];
PORT	StuckValve [-];
PORT	BootLeakage [-];
PORT	OversizedValve [-];
PORT	LeakyValve [-];
PORT	ObstructedPipe [-];
PORT	UndersizedCoil [-];
PORT	FouledCoil [-];
PORT 	pos  "Valve control signal (0-1)"[-] ;
PORT	mLiqOpen [kg_water/s];
PORT	UADes [W/k];

//Outputs
PORT 	A "Valve authority (0-1)"		[-] ;
PORT 	fLeak "Fractional valve leakage"	[-] ;
PORT 	posReal "Real valve position (0-1)" [-] ; 
PORT	mLiqOpenReal [kg_water/s];
PORT	UAReal [W/k];


EQUATIONS {
}

FUNCTIONS {
A,fLeak,posReal,mLiqOpenReal,UAReal = heatingcoil_fault (StuckValve,BootLeakage,OversizedValve,LeakyValve,ObstructedPipe,UndersizedCoil,FouledCoil,Status,pos,mLiqOpen,UADes);
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>

///////////////////////////////////////////////////////////
EVALUATE (heatingcoil_fault)
{

ARGDEF(0,	StuckValve);
ARGDEF(1,	BootLeakage);
ARGDEF(2,	OversizedValve);
ARGDEF(3,	LeakyValve);
ARGDEF(4,	ObstructedPipe);
ARGDEF(5,	UndersizedCoil);
ARGDEF(6,	FouledCoil);
ARGDEF(7,	Status);
ARGDEF(8,	pos );
ARGDEF(9,	mLiqOpen );
ARGDEF(10,	UADes );

double A;      
double fLeak;  
double posReal;
double mLiqOpenReal;
double UAReal;

double A_nofault = 0.5;

A = A_nofault;
fLeak = 0.0;
posReal = pos;
UAReal = UADes;
mLiqOpenReal = mLiqOpen;

if (Status == 0.0) {
  mLiqOpenReal = 0.0001*mLiqOpen;
  posReal = 0.0;
  }
else if (ObstructedPipe >= 0.0)
  mLiqOpenReal = mLiqOpen * ObstructedPipe;

if (OversizedValve > 1.0) 
  A = 1. / ( 1. + (( (1.0-A_nofault)/A_nofault) * OversizedValve * OversizedValve) ) ;

if (LeakyValve > 0.0) 
  fLeak = LeakyValve;

if (BootLeakage > 0.0) // Valve is normally open
  posReal = SPARK::max(posReal, BootLeakage);

if (StuckValve >=0.0)
  posReal = StuckValve;

if (UndersizedCoil >= 0.0)
  UAReal = UADes * (1-UndersizedCoil);

if (FouledCoil >=0.0)
  UAReal = UADes * (1-FouledCoil);

if ((FouledCoil >=0.0) && (UndersizedCoil >=0.0))
  UAReal = UADes * (1-FouledCoil) * (1-UndersizedCoil);

posReal = SPARK::max(posReal, 0.0001); // avoid zero flow
  
BEGIN_RETURN
  A,      
  fLeak,
  posReal,
  mLiqOpenReal,
  UAReal
END_RETURN
    
}


