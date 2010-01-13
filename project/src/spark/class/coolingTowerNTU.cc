/// \file  coolingTowerNTU.cc
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

port 	TWb						" Outdoor Air Wet Bulb Temperature " [C] ;
port 	TLiqEnt					" Water Inlet Temperature " [C] ;
port 	mLiq 					" Water Flow Rate " [] ;
port 	mAir  					" Air flow "            [kg_dryAir/s] ; 
port 	UA						" UA of tower "    [] ; 
port 	mAirRated  				" Rated air flow "        [kg_dryAir/s] ;
port 	fanStatic  				" Fan static pressure "    [Pa] ;
port 	fanEff  				" Fan efficiency "    [] ;
port 	pumpHead  				" Water pump head "        [m] ;
port 	pumpEff  				" Water pump efficiency "        [] ;
port 	timestep				" Simulation timestep " [s] ;
port 	TWbOutPrev 				" Previous leaving air wet bulb temperature " [C] ;

//OUTPUTS
port 	TLiqLvg 				" Leaving water temperature "    [C] ;
port 	TWbOut 					" Leaving air wet bulb temperature "    [C] ;
port 	qTot 					" Total heat transfer rate  Positive for water cooling "    [W] ;
port 	pumpPower 				" Power consumed by pump "    [W] ;
port 	fanPower 				" Power consumed by fan "    [W] ;

EQUATIONS {
	}

FUNCTIONS {
TLiqLvg, TWbOut, qTot, pumpPower, fanPower  = coolingTowerNTU (TWb, TLiqEnt, mLiq, mAir, UA, mAirRated, fanStatic, fanEff, pumpHead, pumpEff, timestep, TWbOutPrev);
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>


///////////////////////////////////////////////////////////
EVALUATE (coolingTowerNTU)
{

ARGDEF(0, 	TWb			);
ARGDEF(1, 	TLiqEnt		);
ARGDEF(2, 	mLiq 		);
ARGDEF(3, 	mAir  		); 
ARGDEF(4, 	UA 			);
ARGDEF(5, 	mAirRated  	); 
ARGDEF(6, 	fanStatic  	); 
ARGDEF(7, 	fanEff  	); 
ARGDEF(8, 	pumpHead  	); 
ARGDEF(9, 	pumpEff  	);
ARGDEF(10, 	timestep	);
ARGDEF(11, 	TWbOutPrev	);

// output variables
double TLiqLvg;
double TWbOut;
double qTot;
double pumpPower;
double fanPower;

// local variables
double epsilon;
double Cmin;
double Cmax;
double Cwater;
double Cair;
double cpAirE;
double UAe;
double NTU;

// constants
double densWater = 1000; //kg/m3
double cpWater = 0.0041813; // J/kg.K
double cpAir = 0.0012; // J/kg.K


// energyplus engineering reference, page 571

cpAirE = cpAir; // note that this should be based on the enthalpy and temperature difference in-out, so should be iterative
UAe = UA * cpAirE/cpAir;

Cair = mAir * cpAirE; 
Cwater = mLiq * cpWater; // note that flow rates should be in kg/s
Cmin = Cair;
Cmax = Cwater;
NTU = UAe / Cmin;

epsilon = ( 1 - exp( - NTU * (1 - Cmin / Cmax ) ) ) / ( 1 - (Cmin / Cmax) * exp( - NTU * (1 - Cmin / Cmax ) ) );

qTot = epsilon * Cmin * (TLiqEnt - TWb) ;

TWbOut = TWb + qTot/Cair;
TLiqLvg = TLiqEnt - qTot/Cwater;

// fan and pump power calculations
pumpPower = mLiq * pumpHead * pumpEff;
fanPower = mAir * fanStatic * fanEff;

// return
BEGIN_RETURN
  TLiqLvg,
  TWbOut,
  qTot,
  pumpPower,
  fanPower
END_RETURN
}


