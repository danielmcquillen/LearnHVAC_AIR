/// \file  effntu1.cc
/// \brief Exponential effectiveness vs. Ntu 
///
/// -   Abstract:        
/// -        The Ntu-effectiveness relationship for parallel flow and
/// -           infinite capacity flow in one stream. Used in the construction
/// -           of the humiditity exchanger model, humeff.cm. See also Kays
/// -           and London, Compact Heat Exchangers, McGraw-Hill,   1984.
///
/// -   Acceptable input set:  
/// -        ntu = 5
///
/// 
/// -    Abstract: C functions for SPARK object humeff.cm,
/// -              an effectiveness model for an evaporative humidifier.
/// -              Used in the construction of the model humex.cm.
/// -              See also Kays and London, Compact Heat Exchangers, McGraw-Hill,   1984.
/// 
/// -    Interface:
/// -          ntu:    Number of transfer units (dimensionless)
/// -          eff:    Humidity exchanger effectiveness (fraction)
/// -     Equations:
/// -                  eff = 1.0 - exp(-ntu)
/// 
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////



#ifdef SPARK_PARSER

PORT eff    "Humidity exchanger effectiveness"  [-]
                INIT = 0.5    MIN = 0.0    MAX = 1.0;
PORT ntu    "Number of transfer units"          [-]
                INIT = 1 ;

EQUATIONS {
    eff = 1 - exp(-ntu) ;
}

FUNCTIONS {
    eff = effntu1__eff( ntu ) ;
    ntu = effntu1__ntu( eff ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"


EVALUATE( effntu1__eff )
{
    ARGDEF(0, ntu );
    double eff;

    if (ntu < SMALL)
        eff = 0.0;
    else
        eff =  1.0 - exp(-ntu);
    RETURN( eff ) ;
}


EVALUATE( effntu1__ntu )
{
    ARGDEF(0, eff );
    double ntu;

    if (eff < 1.0)
        ntu = -log(1.0 - eff);
    else {
        std::ostringstream Msg;
        Msg << "Effectiveness " << double(eff) << "  must be <= 1.0" << std::ends;
        ERROR_LOG( ME, Msg.str() );

        // Reset efficiency to "typical" value and continue
        // Out-of-bound value for eff probably occurred because of 
        // bad initial values !
        ntu = -log(1.0 - 0.5); // equivalent to setting eff = 0.5
    }

    RETURN( ntu ) ;
}

