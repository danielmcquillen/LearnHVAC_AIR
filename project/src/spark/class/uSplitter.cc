/// \file  uSplitter.cc
/// \brief  splits a single combined control signal into control signals for heating coil, mixing box and cooling coil  
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT  s1	[-]		"u split point between CC and MX";
/// - PORT  s2	[-]		"u split point between MX and HC";
/// - PORT  prevControlLevel    [-]    "previous combined control level";
/// - PORT  PIcontrolSignalIn     [-]    "control signal from PI controller (positive = more cooling, negative = more heating)"
/// - PORT  uCC   [-]     "CC control signal";
/// - PORT  uMX   [-]     "MX control signal";
/// - PORT  uHC   [-]     "HC control signal";
/// - PORT  curControlLevel   [-]   "current combined control level";
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// uCC,uMX,uHC,curControlLevel = uSplitter(s1,s2,prevControlLevel,PIcontrolSignalIn)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
/// B Coffey Feb8-08
///     - Initial implementation.
///     - B Coffey, Sep24-08 - fixed MX operation so that OA damper always at minimum position during CC operation
///     - B Coffey, Feb8-09 - fixed it to be based on a positive or negative u value from PI controller that pushes uCombined up or down
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef	spark_parser

// INPUTS (in standard usage)
PORT  s1	[-]		"u split point between CC and MX";
PORT  s2	[-]		"u split point between MX and HC";
PORT  prevControlLevel    [-]    "previous combined control level";
PORT  PIcontrolSignalIn     [-]    "control signal from PI controller (positive = more cooling, negative = more heating)";
PORT  OAT 	[C]		"outside air temperature";
PORT  Tret  [C]		"return air temperature";
PORT  TsaSet  [C]		"supply air setpoint temperature";
PORT  fanTempRiseEst [C] 	"estimated fan temperature rise for economizer control";

// OUTPUTS (in standard usage)
PORT  uCC   [-]     "CC control signal";
PORT  uMX   [-]     "MX control signal";
PORT  uHC   [-]     "HC control signal";
PORT  curControlLevel   [-]   "current combined control level";

FUNCTIONS {
	uCC,uMX,uHC,curControlLevel = uSplitter(s1,s2,prevControlLevel,PIcontrolSignalIn,OAT,Tret,TsaSet,fanTempRiseEst);
}

#endif /* SPARK_TEXT */
#include "spark.h"
//#include <iostream.h>
//using std::cout;
//using std::endl;

EVALUATE (uSplitter)
{
 ARGDEF( 0,s1);
 ARGDEF( 1,s2);
 ARGDEF( 2,prevControlLevel);
 ARGDEF( 3,PIcontrolSignalIn);
 ARGDEF( 4,OAT);
 ARGDEF( 5,Tret);
 ARGDEF( 6,TsaSet);
 ARGDEF( 7,fanTempRiseEst);
 
//output variables
   double uCC;
   double uMX;
   double uHC;
   double curControlLevel;

//internal parameters

   double mode; // 1 = heating, 0 = cooling
   
//main code

   curControlLevel = prevControlLevel + PIcontrolSignalIn;
   if (curControlLevel < 0.0) { curControlLevel = 0.0; }
   if (curControlLevel > 1.0) { curControlLevel = 1.0; }
   
   
   if (curControlLevel > s1 ) {
      // CC operation  (and economizer may operate)
	  uCC = (curControlLevel - s1) / (1.0 - s1);
	  uHC = 0;
	  mode = 0;
   } 
   else if (curControlLevel > s2) {
      // deadband, in cooling mode (economizer may operate)
	  uCC = 0;
	  uHC = 0;
	  mode = 0;
   }
   else if (curControlLevel > (s2 - 0.05)) {
      // deadband, in heating mode (no economizer)
	  uCC = 0;
	  uHC = 0;
	  mode = 1;
   }
   else {
      // HC operation 
	  uCC = 0;
	  uHC = ((s2-0.05) - curControlLevel) / (s2-0.05);
	  mode = 1;
   }

	if (OAT > Tret) {
	  uMX = 0;
    }
	else {
	  if (mode > 0) {
	    uMX = 0;
	  }
	  else {
	    if (OAT > TsaSet - fanTempRiseEst) {
		  uMX = 1;
		}
		else {
	      uMX = (Tret - TsaSet + fanTempRiseEst) / (Tret - OAT);
		}
	  }
	}

//   cout << "uSplitter.curControlLevel=" << curControlLevel << endl;
//   cout << "uSplitter.prevControlLevel=" << prevControlLevel << endl;
//   cout << "uSplitter.PIcontrolSignalIn=" << PIcontrolSignalIn << endl;
   
//return
	
   BEGIN_RETURN
	uCC,    
	uMX,
	uHC,
	curControlLevel
   END_RETURN

}
