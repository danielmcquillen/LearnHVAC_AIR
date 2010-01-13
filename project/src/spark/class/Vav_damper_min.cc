/// \file VAV_damper_min.cc
/// \brief VAV box damper model. Calculates the damper position given an error in the minimum damper position.
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - port	damp_pos_con       	"damper position from control (0=closed, 1=open)" 			[-] ; 
/// - port	damp_pos_min_des	"design minimum damper position" [-];
/// - port	BadMinPosDamper		"error in minimum damper position" 			[-] ; 
/// - port    damp_pos_lim          "real damper position (0=closed, 1=open)";
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// damp_pos_lim = VAV_min(damp_pos_con,damp_pos_min_des,BadMinPosDamper)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
/// Peng Xu  2004.1
///     - Initial implementation.
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef	spark_parser

// inputs
port	damp_pos_con       	"damper position from control (0=closed, 1=open)" 			[-] ; 
port	damp_pos_min_des	"design minimum damper position" [-];
port	BadMinPosDamper		"error in minimum damper position" 			[-] ; 

// outputs
port    damp_pos_lim          "real damper position (0=closed, 1=open)";



functions {
	damp_pos_lim = VAV_min(damp_pos_con,damp_pos_min_des,BadMinPosDamper); 
	
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
EVALUATE (VAV_min)
{

ARGDEF(0, damp_pos_con   			);
ARGDEF(1, damp_pos_min_des   			);
ARGDEF(2, BadMinPosDamper   );

// outputs
double 	damp_pos_lim; 

// local variables
double 	damp_pos_min;

damp_pos_min = damp_pos_min_des;
if (BadMinPosDamper >999.0)
  damp_pos_min=damp_pos_min_des + BadMinPosDamper;
  
damp_pos_lim=SPARK::max(damp_pos_min, damp_pos_con);


RETURN (damp_pos_lim);


}

