/// \file  room.cc
/// \brief This model uses a very simple heat balance approach to determine T(t) given T(t-1) and the heat gains from t-1 to t.
/// TRoom = TRoomP + ( QSENS*dt + UARoom*(TOut-TRoomP)*dt + mAir*cpAir*(TSup-TRoomP) ) / (cRoomAir*1000);
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - port	TSup			" Supply air dry bulb temperature                   " [C];
/// - port	mAir			" Supply dry air mass flow rate                  " [kg/s];
/// - port	QSENS		" internal and solar sensible heat gains " [kW]; //always >=zero
/// - port	TRoom		" Room temperature                      INIT=15.0            " [C];
/// - port    TwRoom          	"room air wet bulb temperature"                      [c];
/// - port    TRoomP         	"room temperature at previous step"           INIT=21.0       [c];
/// - port    TOut           		"outside air temperature"  [c];
/// - port	UARoom		"UA of the room" [W/C]; 
/// - port	cRoomAir		"thermal capacitance of the room (air plus furniture)" [kJ/C]; 
/// - port	dt			"timestep" [s];
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// TRoom, TwRoom = room (TSup,mAir,QSENS, TRoomP, TOut )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
///    - unknown starting point
///    - cleaned up and exposed UA and cRoomAir variables, added a dt variable, Brian Coffey, Sept 24, 2008
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

//INPUTS

port	TSup		" Supply air dry bulb temperature                   " [C];
port	mAir		" Supply dry air mass flow rate                  " [kg/s];
port	QSENS		" internal and solar sensible heat gains " [W]; //always >=zero
port	TRoom		" Room temperature " [C];
port    TwRoom      "room air wet bulb temperature"                      [c];
port    TRoomP      "room temperature at previous step"           INIT=21.0       [c];
port    TOut        "outside air temperature"  [c];
port	UARoom		"UA of the room" [W/C]; 
port	cRoomAir	"thermal capacitance of the room (air plus furniture)" [kJ/C]; 
port	dt			"timestep" [s];


EQUATIONS {
	}

FUNCTIONS {
TRoom, TwRoom = room (TSup,mAir,QSENS, TRoomP, TOut, UARoom, cRoomAir, dt );
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>


///////////////////////////////////////////////////////////
EVALUATE (room)
{

ARGDEF(0,	TSup	);
ARGDEF(1,	mAir	);
ARGDEF(2,	QSENS	);
ARGDEF(3,	TRoomP	);
ARGDEF(4,   TOut	);
ARGDEF(5,   UARoom	);
ARGDEF(6,   cRoomAir);
ARGDEF(7,   dt);

// output variables
double TRoom;
double TwRoom;

// local variables
double cpAir = 1012; // J/kg.C

// main code

TRoom = TRoomP + ( QSENS*dt + UARoom*(TOut-TRoomP)*dt + mAir*cpAir*(TSup-TRoomP) ) / (cRoomAir*1000);

TwRoom = TRoom - 5.0;


// old code ... used for numerical reasons?
//Denom = 1 + (UA + mAir *1.01 *1000)/cRoomAir;
//TRoom1= (TRoomP + (QSENS + UA*TOut + mAir *1.01 *1000*TSup )/cRoomAir)/Denom;


// return

BEGIN_RETURN
  TRoom,
  TwRoom
END_RETURN
}


