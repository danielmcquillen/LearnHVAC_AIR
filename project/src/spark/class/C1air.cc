/// \file  C1air.cc
/// \brief calculate C1 for air node 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - port WSUP    "Supply dry air mass flow rate                 "  [kg/s];
/// - port WINZ1   " Interzone 1 dry air mass flow rate            "  [kg/s];
/// - port WINZ2   " Interzone 2 dry air mass flow rate             " [kg/s];
/// - port WRET    " Extract dry air mass flow rate                  "[kg/s];
/// - port WLEAK   " Leakage air mass flow rate (positive out)      " [kg/kg];
/// - 
/// - port GSUP    " Supply air humidity ratio                     " [kg/kg];
/// - port GINZ1   " Interzone 1 air humidity ratio                " [kg/kg];
/// - port GINZ2   " Interzone 2 air humidity ratio                " [kg/kg];
/// - port GAMB    " Ambient humidity ratio                        " [kg/kg];
/// - 
/// - //PARAMETERS
/// - 
/// - port CRAIR   " Capacitance of room air node (unmodified)"       [kJ/K];
/// - port XCAP    " Room air capacity multiplier                     "  [-];
/// - port RWSR    " Direct resistance room air node <-> ambient     " [K/kW];
/// - port RISR    " Resistance room air node <-> room mass node     " [K/kW];
/// - 
/// - //OUTPUT
/// - port C1 ;
/// - PORT  w    [-]    "set-point";
/// - PORT  y    [-]    "measured variable";
/// - PORT  iP   [-]    "previous value of integral term";
/// - PORT  Kp   [-]    "proportional gain";
/// - PORT  Ki   [1/s]  "integral gain";
/// - PORT  fr   [-]    "override (0), forward (+1) or reverse (-1) acting";
/// - PORT  bias [-]    "offset, output in open loop";
/// - PORT  dt   [s]    "time step";
/// - PORT  u   [-]     "control signal";
/// - PORT  i   [-]  	  "integral term";
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// x = y + z
/// \endcode
///
/// \code
/// C1	= C1air_C1 (WSUP,WINZ1, WINZ2, WRET, WLEAK, CRAIR, XCAP, RWSR, RISR, GSUP, GINZ1, GINZ2, GAMB)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

port WSUP    "Supply dry air mass flow rate                 "  [kg/s];
port WINZ1   " Interzone 1 dry air mass flow rate            "  [kg/s];
port WINZ2   " Interzone 2 dry air mass flow rate             " [kg/s];
port WRET    " Extract dry air mass flow rate                  "[kg/s];
port WLEAK   " Leakage air mass flow rate (positive out)      " [kg/kg];

port GSUP    " Supply air humidity ratio                     " [kg/kg];
port GINZ1   " Interzone 1 air humidity ratio                " [kg/kg];
port GINZ2   " Interzone 2 air humidity ratio                " [kg/kg];
port GAMB    " Ambient humidity ratio                        " [kg/kg];

//PARAMETERS

port CRAIR   " Capacitance of room air node (unmodified)"       [kJ/K];
port XCAP    " Room air capacity multiplier                     "  [-];
port RWSR    " Direct resistance room air node <-> ambient     " [K/kW];
port RISR    " Resistance room air node <-> room mass node     " [K/kW];

//OUTPUT
port C1 ;

EQUATIONS { x = y + z ;
	  }

// ==== FUNCTIONS ====
FUNCTIONS {
	C1	= C1air_C1 (WSUP,WINZ1, WINZ2, WRET, WLEAK, CRAIR, XCAP, RWSR, RISR, GSUP, GINZ1, GINZ2, GAMB);
	  }
#endif /* SPARK_PARSER */

#include "spark.h"
/*
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
*/



double C1air_C1 ( ARGS)
{

	const double WSUP=ARG(0);
	const double WINZ1=ARG(1);
	const double WINZ2=ARG(2);
	const double WRET=ARG(3);
	const double WLEAK=ARG(4); 

	const double CRAIR=ARG(5);
	const double XCAP=ARG(6);
	const double RWSR=ARG(7);
	const double RISR=ARG(8);
	
	const double GSUP=ARG(9);
	const double GINZ1=ARG(10);
	const double GINZ2=ARG(11);
	const double GAMB=ARG(12);
 	 
	double WFAN;
        double DIWSUP; 
	double DIWINZ1; 
	double DIWINZ2; 
       	double DIWLEAK;
        double DIWRET  ;
        double DIWFAN  ;
        double CSUP    ;
        double CINZ1   ;
        double CINZ2   ;
        double CLEAK   ;
        double CRET    ;
        double CFAN   ; 
        double CRETL ;  
	double CR; 
	double C1;

 	double CPA=1.01; //dry air specific heat kJ/kg
	double CPG=100.0; //water vapor constant
	double CGA=1.0;

 	WFAN = WSUP + WINZ1 - WINZ2 - WLEAK - WRET;
        DIWSUP  = SPARK::max(0.0,WSUP); //0
        DIWINZ1 = SPARK::max(0.0,WINZ1); //0
        DIWINZ2 = SPARK::max(0.0,WINZ2); //0
        DIWLEAK = SPARK::max(0.0,WLEAK); //0
        DIWRET  = SPARK::max(0.0,WRET); //0
        DIWFAN  = SPARK::max(0.0,WFAN); //0
        CSUP    = DIWSUP*(CPA+GSUP*CPG);
        CINZ1   = DIWINZ1*(CPA+GINZ1*CPG);
        CINZ2   = DIWINZ2*(CPA+GINZ2*CPG);
        CLEAK   = DIWLEAK*(CPA+GAMB*CPG);
        CRET    = DIWRET*(CPA+GAMB*CPG);
        CFAN    = DIWFAN*(CPA+GAMB*CPG);

	CR = CRAIR*XCAP;

	C1= -(1./CR)*(1./RISR+1./RWSR+CSUP+CINZ1+CINZ2+CLEAK);
// +CRET+CFAN);
//	C1= -(1./CR)*(1./RISR+1./RWSR);


        return   C1;
}







































