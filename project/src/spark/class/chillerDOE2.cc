/// \file  chillerDOE2.cc
/// \brief 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
///
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

//INPUTS

port	evapInletTemp			" Chilled Water Inlet Temperature " [C];
port 	evapFlowRate 			" Chilled Water flow rate " [m3/s];
port 	evapOutletTempSP		" Chilled Water Outlet Setpoint Temperature " [C];
port	condInletTemp			" Condensor Water Inlet Temperature " [C];
port 	condFlowRate 			" Condensor Water flow rate " [m3/s];
port 	requestedLoad 			" Requested load " [W] ;
port 	ratedCapacity 			" Rated capacity of the chiller " [W] ;
port 	ratedEIR 				" Rated EIR of chiller " [W] ;
port 	pumpEfficiency 			" Pump efficiency " [W] ;
port 	timestep				" Simulation timestep " [s] ;

port	evapOutletTemp  		" Chilled Water Outlet Temperature " [C];
port 	condOutletTemp 			" Condensor Water Outlet Temperature " [C];
port	coolingPower 			" Cooling power " [W] ;
port	compPower 				" Compressor power consumption " [W] ;
port	pumpPower 				" Chilled water pump power consumption " [W] ;


EQUATIONS {
	}

FUNCTIONS {
evapOutletTemp, condOutletTemp, coolingPower, compPower, pumpPower  = chillerDOE2 (evapInletTemp, evapFlowRate, evapOutletTempSP, condInletTemp, condFlowRate, requestedLoad, ratedCapacity, ratedEIR, pumpEfficiency, timestep);
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>


///////////////////////////////////////////////////////////
EVALUATE (chillerDOE2)
{

ARGDEF(0,	evapInletTemp	);
ARGDEF(1,	evapFlowRate	);
ARGDEF(2,	evapOutletTempSP	);
ARGDEF(3,	condInletTemp	);
ARGDEF(4,	condFlowRate	);
ARGDEF(5,	requestedLoad	);
ARGDEF(6,	ratedCapacity	);
ARGDEF(7,	ratedEIR	);
ARGDEF(8,	pumpEfficiency	);
ARGDEF(9,	timestep	);

// output variables
double evapOutletTemp;
double condOutletTemp;
double coolingPower;
double compPower;
double pumpPower;

// local variables
double availCapacity;
double currentEIR;
double evapHeatRateToSP;
double plr;

// constants
double densWater = 1000; //kg/m3
double cpWater = 0.0041813; // J/kg.K

// biquadratic curve for Capacity as a function of evaporator outlet temperature and condensor inlet temperature
// taken from example in the eplus 2.2 input-output reference manual
double aCT = 0.257896;
double bCT = 0.0289016;
double cCT = -0.00021708;
double dCT = 0.0468684;
double eCT = -0.00094284;
double fCT = -0.00034344;

// biquadatic curve for EIR as a function of evaporator outlet temperature and condensor inlet temperature
// taken from example in the eplus 2.2 input-output reference manual
double aET = 0.933884;
double bET = -0.058212;
double cET = 0.00450036;
double dET = 0.00243;
double eET = 0.000486;
double fET = -0.001215;

// quadratic curve for EIR as a function of part load ratio
// taken from example in the eplus 2.2 input-output reference manual
double aEPL = 0.222903;
double bEPL = 0.313387;
double cEPL = 0.463710;

// determine the available capacity, which is a function of the evaporator inlet temperature
// note that this is currently using the evaporator outlet setpoint, rather than iterating on the evaporator outlet temperature
availCapacity = ratedCapacity * (aCT + bCT*evapOutletTempSP + cCT*(evapOutletTempSP*evapOutletTempSP) + dCT*condInletTemp + eCT*(condInletTemp*condInletTemp) + fCT*evapOutletTempSP*condInletTemp);

// calculate the evaporator heat transfer rate required to bring the entering 
// chilled water temperature down to the leaving chilled water set point temperature
evapHeatRateToSP = (evapInletTemp - evapOutletTempSP) * evapFlowRate * (densWater*cpWater/timestep);

// check to ensure that there is enough available capacity to meet the setpoint
if ( evapHeatRateToSP < availCapacity ) {
   // if enough capacity
   // evaporator outlet temp is equal to the setpoint
   evapOutletTemp = evapOutletTempSP; 
   // calculate the condenser outlet temp based on this heat transfer rate
   condOutletTemp = condInletTemp + evapHeatRateToSP / (condFlowRate * (densWater*cpWater/timestep));
   // calculate the current EIR, which is a function of the temperatures and the part-load ratio
   // note that this is currently using the evaporator outlet setpoint, rather than iterating on the evaporator outlet temperature
   plr = evapHeatRateToSP / availCapacity;
   currentEIR = ratedEIR * (aET + bET*evapOutletTempSP + cET*(evapOutletTempSP*evapOutletTempSP) + dET*condInletTemp + eET*(condInletTemp*condInletTemp) + fET*evapOutletTempSP*condInletTemp) * (aEPL + bEPL*plr + cEPL*plr*plr) ;
   // calculate the compresser power consumption, based on the current EIR and the evaporator heat transfer rate
   compPower = currentEIR * evapHeatRateToSP;
   // cooling power for output
   coolingPower = evapHeatRateToSP;
}
else {
   // if not enough capacity
   // calculate the evaporator outlet temp
   evapOutletTemp = evapInletTemp - availCapacity / (evapFlowRate * (densWater*cpWater/timestep)); 
   // calculate the condenser outlet temp based on this heat transfer rate
   condOutletTemp = condInletTemp + availCapacity / (condFlowRate * (densWater*cpWater/timestep));
   // calculate the current EIR, which is a function of the temperatures
   // note that this is currently using the evaporator outlet setpoint, rather than iterating on the evaporator outlet temperature
   currentEIR = ratedEIR * (aET + bET*evapOutletTempSP + cET*(evapOutletTempSP*evapOutletTempSP) + dET*condInletTemp + eET*(condInletTemp*condInletTemp) + fET*evapOutletTempSP*condInletTemp);
   // calculate the compresser power consumption, based on the current EIR and the evaporator heat transfer rate
   compPower = currentEIR * availCapacity;
   // cooling power for output
   coolingPower = availCapacity;
}

// calculate pump power based on chilled water flow rate
pumpPower = evapFlowRate * pumpEfficiency;


// return
BEGIN_RETURN
  evapOutletTemp,
  condOutletTemp,
  coolingPower,
  compPower,
  pumpPower
END_RETURN
}


