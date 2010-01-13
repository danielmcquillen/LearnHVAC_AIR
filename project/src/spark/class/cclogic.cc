/// \file  cclogic.cc
/// \brief Dry versus wet coil decision logic 
///         Includes simple anti-windup and limiting of the output to the range 0-1
///
///  Identification:  Dry versus wet coil decision logic
///                          cclogic.cc
///
///  Abstract:        
///       Implements logic for selecting results of either wet or dry
///           calculations in the ccsim.cm cooling/dehumidification coil model.
///
///  Acceptable input set:  
/// -       TLiq = 10, TSurf = 12, TDp = 18, qDry = 1000, qWet = 1200
///
///  Equations:  
/// -       if (qDry < qWet)
/// -         if (TDp < TLiq)
/// -            s = 0;  use dry
/// -         else
/// -            s = 1;  use wet
/// -      else
/// -         if (TDp < TSurf)
/// -            s = 0;  use dry
/// -         else
/// -            s = 1;  use wet
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

PORT TLiq    "Coil entering liquid temperature"         [deg_C] ;
PORT TSurf   "entrance surface temperature"             [deg_C] ;
PORT TDp     "Coil entering dewpoint temperature"       [deg_C] ;
PORT qDry    "Cooling calculated with dry assumption"   [W]
                INIT = 300    MIN = -10000    MAX = 10000 ;
PORT qWet    "Cooling calculated with wet assumption"   [W]
                INIT = 300    MIN = -10000    MAX = 10000 ;
PORT s       "Signal: 1 -> wet  0-> dry"                [wetDry_code]
                INIT = 1    MIN = 0        MAX = 1 ;

FUNCTIONS {
    s = cclogic__s( TLiq, TSurf, TDp, qDry, qWet ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"

/* Special logic for switch function for the CCSIM model */

EVALUATE( cclogic__s )
{
    ARGDEF(0, tLiq ) ;
    ARGDEF(1, tSurf ) ;
    ARGDEF(2, tDP ) ;
    ARGDEF(3, qDry ) ;
    ARGDEF(4, qWet ) ;
    double s;

    if (qDry < qWet)
       if (tDP < tLiq)
          s = 0; /* use dry */
       else
          s = 1; /* use wet */
    else
       if (tDP < tSurf)
          s = 0; /* use dry */
       else
          s = 1; /* use wet */
    RETURN( s ) ;
}
