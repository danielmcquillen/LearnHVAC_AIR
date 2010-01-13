/// \file  VAV_control.cc 
/// \brief VAV box control model. Given a control signal for the VAV box, it sends control signals to the VAV-box heating coil and to the VAV-box damper.
///
/// \todo 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - port    mVAVmax         "mass flow rate if damper is fully opened";
/// - port    VAVSignal         "VAV control signal, 0=ask for cooling, 1=ask for heating";
/// - port    CFMSP            "damper CFM setpoint" [-];
/// - port    HCcoilPosDemand           "Demanded Heating coil position" [-];
/// - port	previousVAVlevel     "previous control level (1 = full heating, 0 = full cooling, 0.4-0.6 = deadband)";
/// - port	currentVAVlevel     "previous control level (1 = full heating, 0 = full cooling, 0.4-0.6 = deadband)";
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// CFMSP, HCcoilPosDemand, currentVAVlevel = VAV_control( mVAVmax, VAVSignal,previousVAVlevel)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///     Peng Xu
///      2004.1
///    modified Brian Coffey, Feb 8, 2009
///
///////////////////////////////////////////////////////////////////////////////



#ifdef	spark_parser

//Inputs
port    mVAVmax         "mass flow rate if damper is fully opened";
port    VAVSignal         "VAV control signal, u output from PI controller";
port	previousVAVlevel     "previous control level (1 = full heating, 0 = full cooling, 0.4-0.6 = deadband)";


//Outputs
port    CFMSP            "damper CFM setpoint" [-];
port    HCcoilPosDemand           "Demanded Heating coil position" [-];
port	currentVAVlevel     "previous control level (1 = full heating, 0 = full cooling, 0.4-0.6 = deadband)";


functions {

	CFMSP, HCcoilPosDemand, currentVAVlevel = VAV_control( mVAVmax, VAVSignal, previousVAVlevel); 
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
using std::cout;
using std::endl;

///////////////////////////////////////////////////////////
EVALUATE (VAV_control)
{

ARGDEF(0, mVAVmax      	);
ARGDEF(1, VAVSignal 	);
ARGDEF(2, previousVAVlevel 	);

double	CFMSP;
double	HCcoilPosDemand;
double  currentVAVlevel;


currentVAVlevel = previousVAVlevel + VAVSignal ;
if (currentVAVlevel < 0.0) { currentVAVlevel = 0.0; }
if (currentVAVlevel > 1.0) { currentVAVlevel = 1.0; }


if (currentVAVlevel<=0.4) //ask for more cooling
{
CFMSP = ( 1.0-currentVAVlevel/0.4) * mVAVmax ;
HCcoilPosDemand = 0.0;
}
else if (currentVAVlevel<=0.6) //within deadband
{
CFMSP = 0.0;
HCcoilPosDemand=0.0;
}
else //ask for more heating
{
CFMSP = 0.0;
HCcoilPosDemand=(currentVAVlevel-0.6)/0.4;
}

//   cout << "CFMSP=" << CFMSP << endl;
//   cout << "HCcoilPosDemand=" << HCcoilPosDemand << endl;
//   cout << "currentVAVlevel=" << currentVAVlevel << endl;
//   cout << "VAVSignal=" << VAVSignal << endl;
   

BEGIN_RETURN
  CFMSP,          
  HCcoilPosDemand,
  currentVAVlevel  
END_RETURN

}

