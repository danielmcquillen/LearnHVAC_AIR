/// \file  Uasplit.cc
/// \brief CLASSMACRO  coil_valve 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT ATot	"Total coil area -wet & dry-"		[m^2] ;
/// - PORT UExtW	"Wet coil air side -external- heat transfer coefficient" [W/deg_C] ;
/// - PORT UIntW	"Wet coil liquid side -internal- heat transfer coefficient" [W/deg_C] ;
/// - PORT	UA;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// ATot, UExtW, UIntW = UASplit (UA)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

/* CLASSMACRO  coil_valve	

*/
PORT ATot	"Total coil area -wet & dry-"		[m^2] ;
PORT UExtW	"Wet coil air side -external- heat transfer coefficient" [W/deg_C] ;
PORT UIntW	"Wet coil liquid side -internal- heat transfer coefficient" [W/deg_C] ;
PORT	UA;


EQUATIONS {
}
FUNCTIONS {
ATot, UExtW, UIntW = UASplit (UA);
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>

///////////////////////////////////////////////////////////
EVALUATE (UASplit)
{

ARGDEF(0,	UA	);

double	ATot	;
double	UExtW	;
double	UIntW	;

ATot	= 1.0;
//UExtW	=0.2*UA;
//UIntW	=0.8*UA; 

assert( UA > 0.0 );

UExtW	=1.25*UA;
UIntW	=5.0*UA; 

BEGIN_RETURN
  ATot	, 
  UExtW	,
  UIntW	 
END_RETURN              

}


