/// \file  coil_mixing.cc
/// \brief  
///         
///
/// \todo 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT	TLiqEntCoil		"Coil entering water temperature"	[deg_C] ;
/// - PORT	TLiqLvgCoil		"Coil leaving water temperature"	[deg_C] ;
/// - PORT	TLiqBypass	"By pass water temperature"	[deg_C] ;
/// - PORT	TLiqLvgValve	"Valve leaving water temperature"	[deg_C] ;
/// - PORT	TLiqEntValve	"Valve entering water temperature"	[deg_C] ;
/// - 
/// - PORT	mLiqEntCoil		"Coil entering water mass flow rate"	[kg_water/s] ;
/// - PORT	mLiqLvgCoil	"Coil leaving water mass flow rate"	[kg_water/s] ;
/// - PORT	mLiqBypass "By pass water mass flow rate"	[kg_water/s] ;
/// - PORT	mLiqLvgValve "Valve leaving water mass flow rate"	[kg_water/s] ;
/// - PORT	mLiqEntValve "Valve entering water mass flow rate"	[kg_water/s] ;
/// - 
/// - PORT	mLiqOpen	"Mass flow rate for open valve"		[kg_water/s] ;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// TLiqBypass,TLiqEntValve,TLiqLvgValve,mLiqLvgCoil, mLiqBypass,mLiqLvgValve,mLiqEntValve  = coil_mixing(TLiqEntCoil,TLiqLvgCoil,mLiqOpen,mLiqEntCoil)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER


PORT	TLiqEntCoil		"Coil entering water temperature"	[deg_C] ;
PORT	TLiqLvgCoil		"Coil leaving water temperature"	[deg_C] ;
PORT	TLiqBypass	"By pass water temperature"	[deg_C] ;
PORT	TLiqLvgValve	"Valve leaving water temperature"	[deg_C] ;
PORT	TLiqEntValve	"Valve entering water temperature"	[deg_C] ;

PORT	mLiqEntCoil		"Coil entering water mass flow rate"	[kg_water/s] ;
PORT	mLiqLvgCoil	"Coil leaving water mass flow rate"	[kg_water/s] ;
PORT	mLiqBypass "By pass water mass flow rate"	[kg_water/s] ;
PORT	mLiqLvgValve "Valve leaving water mass flow rate"	[kg_water/s] ;
PORT	mLiqEntValve "Valve entering water mass flow rate"	[kg_water/s] ;

PORT	mLiqOpen	"Mass flow rate for open valve"		[kg_water/s] ;

EQUATIONS {
}
FUNCTIONS {
TLiqBypass,TLiqEntValve,TLiqLvgValve,mLiqLvgCoil, mLiqBypass,mLiqLvgValve,mLiqEntValve  = coil_mixing(TLiqEntCoil,TLiqLvgCoil,mLiqOpen,mLiqEntCoil);
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>

///////////////////////////////////////////////////////////
EVALUATE (coil_mixing)
{

ARGDEF(0,	TLiqEntCoil);
ARGDEF(1,	TLiqLvgCoil);
ARGDEF(2,	mLiqOpen);
ARGDEF(3,	mLiqEntCoil);

double	TLiqBypass;
double	TLiqEntValve;
double	TLiqLvgValve;
double	mLiqLvgCoil;
double	mLiqBypass;
double	mLiqLvgValve;
double	mLiqEntValve;


mLiqLvgCoil = mLiqEntCoil;
mLiqBypass = mLiqOpen - mLiqEntCoil;
mLiqLvgValve = mLiqOpen;
mLiqEntValve = mLiqLvgCoil;

TLiqBypass = TLiqEntCoil;
TLiqEntValve = TLiqLvgCoil;
if (mLiqOpen > 0.0)
  TLiqLvgValve = (mLiqBypass*TLiqBypass + TLiqLvgCoil*mLiqEntCoil)/mLiqOpen;
else 
  TLiqLvgValve = TLiqLvgCoil;

BEGIN_RETURN
 TLiqBypass,
 TLiqEntValve,
 TLiqLvgValve,
 mLiqLvgCoil,     
 mLiqBypass,  
 mLiqLvgValve,
 mLiqEntValve 
END_RETURN
}
