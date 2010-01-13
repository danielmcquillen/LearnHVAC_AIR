/// \file  VAVsetpointmanager.cc
/// \brief 
///
/// \todo 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT  SP_Heat    [-]    "heating season setpoint";
/// - PORT  SP_Cool    [-]    "cooling season setpoint";
/// - PORT  HeatCoolMode    [-]    "mode (1=heating, 0=cooling)";
/// - PORT  w    [-]    "setpoint for output to PI controller";
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// u,i = PI(w,y,iP,Kp,Ki,fr,bias,dt)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
/// B Coffey, July 29, 2009
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef	spark_parser

// INPUTS
PORT  SP_Heat    [-]    "heating season setpoint";
PORT  SP_Cool    [-]    "cooling season setpoint";
PORT  HeatCoolMode    [-]    "mode (1=heating, 0=cooling)";

// OUTPUT
PORT  w    [-]    "setpoint for output to PI controller";


FUNCTIONS {
	w = VAVsetpointmanager(SP_Heat,SP_Cool,HeatCoolMode);
}

#endif /* SPARK_TEXT */
#include "spark.h"
//#include <iostream.h>
using std::cout;
using std::endl;

/// \name Evaluate function
//@{
/// \brief  
EVALUATE (VAVsetpointmanager)
{
 ARGDEF( 0,SP_Heat);
 ARGDEF( 1,SP_Cool);
 ARGDEF( 2,HeatCoolMode);
 
 //outputs
   double w;
//local variables


//main code

   if (HeatCoolMode == 0 ) {
      w = SP_Cool;
   } else {
      w = SP_Heat;
   }

//   cout << "PI.u=" << u << endl;
 
   BEGIN_RETURN
	w 
   END_RETURN

}


