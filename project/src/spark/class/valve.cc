/// \file  valve.cc 
/// \brief Flow circuit with non-linear/square valve and series flow resistance.
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// -   Interface:       
/// -       pos:     Valve position[]
/// -       mLiq:    Mass flow rate [Kg/s]
/// -       A:       Valve authority []
/// -       mLiqOpen:Mass flow rate for open valve [kg/s]
/// -       fLeak:   Fractional leakage []
/// - 
/// -   Acceptable input set:  
/// -        pos = 0.5, A = 0.5, mLiqOpen = 1,  fLeak = 0.05
/// - 
/// -   Recommended matches:  
/// -           None
/// - 
/// -   Suggested breaks:  
/// -           None
/// - 
/// -   Local variables:  
/// -        fInher:  inherited valve resistance ratio
/// -       fInstall: Installed flow rate factor      
/// - 
/// -   Equations: 
/// - 	fInher = ((1-fLeak)*pos^2 + fLeak;
/// - 	fInstall = 1/ (a/(fInher^2) + (1-a) )^0.5 (fInher !=0)
/// - 		 = 0 (fInher = 0);
/// - 	mLiq = mLiqOpen *fInstall;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// mLiq = valve_mLiqCoil (pos, A, mLiqOpen, fLeak)
/// \endcode
///
/// \code
/// mLiqCoil = valve_mLiqCoil(pos,A,mLiqOpen,fLeak)
/// \endcode
///
/// \code
/// pos = valve_pos(mLiqCoil,A,mLiqOpen,fLeak)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_TEXT
// ==== PORTS ====
port pos	"Valve position, between 0-1"	[] ;
port mLiqCoil	"Mass flow rate"	 [kg_water/s];
port A		"Valve authority, between 0-1"	[] ;
port mLiqOpen	"Mass flow rate for open valve"		[kg_water/s] ;
port fLeak	"Fractional leakage"	[] ;


EQUATIONS { mLiq = valve_mLiqCoil (pos, A, mLiqOpen, fLeak) ;
	  }

// ==== FUNCTIONS ====
FUNCTIONS {
	mLiqCoil = valve_mLiqCoil(pos,A,mLiqOpen,fLeak) ;
	pos = valve_pos(mLiqCoil,A,mLiqOpen,fLeak) ;
	  }
#endif /* SPARK_TEXT */
#include "spark.h"

EVALUATE(valve_mLiqCoil)
{
    ARGDEF(0,pos) ;
    ARGDEF(1,A) ;
    ARGDEF(2,mLiqOpen) ;
    ARGDEF(3,fLeak) ;
    
    double fInher ;
    double fInstall;
    double mLiqCoil;

    fInher = (1-fLeak)*pos*pos + fLeak ;
    
    if (fInher !=0)
    fInstall = 1/ pow ( (A/(fInher*fInher) + (1-A) ), 0.5 );
    else
    fInstall = 0.0001;
    
    mLiqCoil = mLiqOpen *fInstall;
   
    RETURN(mLiqCoil);
}
    
EVALUATE(valve_pos)
{
  ARGDEF(0,mLiqCoil) ;
  ARGDEF(1,A) ;
  ARGDEF(2,mLiqOpen) ;
  ARGDEF(3,fLeak) ;
    
  double fInher ;
  double fInstall;
  double pos;

  fInstall = SPARK::min((mLiqCoil/mLiqOpen),1.0) ;
  if (fInstall == 0)
    pos =0;
  else
  {
    fInher=pow(A/(1/(fInstall*fInstall)-(1-A)), 0.5);
	pos=pow((fInher-fLeak)/(1-fLeak),0.5);
  	}  
    RETURN(pos);
}
    

 








