/// \file  capratel.cc
/// \brief Capacitance rate for water
/// 
/// Calculates capacitance rate for water side of heat exchanger.
/// Product of mass flow rate and heat capacity of water.
/// 
/// \note Used in wet coil objects.
/// 
/// Acceptable input set:  
///     mWater = 1
/// 


#ifdef SPARK_PARSER

PORT mWater    "Entering water mass flow rate"      [kg_water/s]
        INIT = 0.01    MIN = 0    MAX = 0.1 ;
PORT cap       "Capacitance rate"                   [W/deg_C] ;


EQUATIONS {
    cap = mWater * CP_WATER ;
}

FUNCTIONS {
    cap    = capratel__cap( mWater ) ;
    mWater = capratel__mWater( cap ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"

/*  Water capacity rate for water side of heat excahnger */

EVALUATE( capratel__cap )
{
    ARGDEF( 0, mWater );
    double cap;

    cap = mWater * CP_WAT;
    RETURN( cap ) ;
}

/*  Water capacity rate for water side of heat excahnger */

EVALUATE( capratel__mWater )
{
    ARGDEF( 0, cap );
    double mWater;
    mWater = cap / CP_WAT;
    RETURN( mWater ) ;
}
