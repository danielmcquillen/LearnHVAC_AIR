/// \file  cpair.cc
/// \brief Specific heat of air
///
/// Specific heat of air as a function of humidity ratio.
///
/// Acceptable input set:  
///     w = 0.01
///


#ifdef SPARK_PARSER

PORT CpAir    "Specific heat of air"    [J/(kg_dryAir*deg_C)]
                INIT = 1    MIN = 0.01    MAX = 5000 ;
PORT w        "Humidity ratio"          [kg_water/kg_dryAir]
                INIT = 0.002    MIN = 0        MAX = 0.1 ;

EQUATIONS{  
    CpAir = CP_AIR + w * CP_VAP ;
}

FUNCTIONS {
    CpAir = CpAir__Cpair( w ) ;
    w     = CpAir__w( CpAir ) ;
}


#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"

/*
 *                 cp_air.cc C functions
 *
 *       cp = CP_AIR + wAir*CP_VAP
 */

EVALUATE( CpAir__Cpair )
{
    ARGDEF(0, w ) ;
    double cp;
    cp = CP_AIR + w*CP_VAP;
    RETURN( cp ) ;
}

EVALUATE( CpAir__w )
{
    ARGDEF(0, cp ) ;
    double w;
    w = (cp - CP_AIR)/CP_VAP;
    RETURN( w ) ;
}
