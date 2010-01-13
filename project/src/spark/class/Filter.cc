/// \file  Filter.cc
/// \brief  The filter model calculates the pressure drop across the filter. 
/// filterPressureDrop = c * massFlowRate^2
///  c is an empirical constant, set to 0.01.
/// The model also includes parameters for two faults: a partly clogged filter (which increases the pressure drop); and a bad sensor (which introduces an offset in the sensed pressure drop).
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT    FltmAirEnt; 
/// - PORT    FltmAirLvg; 
/// - PORT    FltpreDrop " pressure drop" ; 
/// - PORT    FltBadDPSensor; 
/// - PORT    FltLeakyFilter;
/// - PORT    FltPartlyClogged; 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// FltmAirEnt, FltpreDrop = Filter(FltmAirLvg, FltBadDPSensor, FltLeakyFilter, FltPartlyClogged)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

//PORT
PORT    FltmAirEnt; 
PORT    FltmAirLvg; 
PORT    FltpreDrop " pressure drop" ; 
PORT    FltBadDPSensor; 
PORT    FltLeakyFilter;
PORT    FltPartlyClogged; 


EQUATIONS {
}

FUNCTIONS {
FltmAirEnt, FltpreDrop = Filter(FltmAirLvg, FltBadDPSensor, FltLeakyFilter, FltPartlyClogged);
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>

///////////////////////////////////////////////////////////
EVALUATE (Filter)
{

ARGDEF(0,	FltmAirLvg); 
ARGDEF(1,	FltBadDPSensor	);
ARGDEF(2,	FltLeakyFilter	);
ARGDEF(3,	FltPartlyClogged	);

double	FltmAirEnt;
double	FltpreDrop;

FltmAirEnt = FltmAirLvg;

double c = 0.01;
double FltpreDrop1=0.0;

FltpreDrop1 = c * FltmAirLvg *FltmAirLvg ;

if (FltPartlyClogged >=1.0)
FltpreDrop1 = FltPartlyClogged * FltmAirLvg *FltmAirLvg ;

if (FltBadDPSensor >=-900.0)
FltpreDrop = FltBadDPSensor + FltpreDrop1;
else 
FltpreDrop=FltpreDrop1;

BEGIN_RETURN
FltmAirEnt,
FltpreDrop
END_RETURN
}























































