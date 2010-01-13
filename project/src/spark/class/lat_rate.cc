/// \file  at_rate.cc
/// \brief Latent heat rate object. 
///   Abstract:        
///        Calculates latent heat capacitance rate, defined as the
///            multiplier on humidity ratio difference to calculate the
///            associated energy rate.  Used in moisture balance for zone
///            model.
/// 
///   Acceptable input set:  
///        mAir = 1
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT mAir    "Air mass flow rate"        [kg_dryAir/s]
/// -                 INIT = 1.0    MIN = 0.0    MAX = 1000.0 ;
/// - PORT cap    "Latent capacitance rate"    [W/(kg_water/kg_dryAir)] ;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// cap = mAir * HF_VAP
/// \endcode
///
/// \code
/// cap  = lat_rate__cap( mAir )
/// \endcode
///
/// \code
/// mAir = lat_rate__mAir( cap )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

PORT mAir    "Air mass flow rate"        [kg_dryAir/s]
                INIT = 1.0    MIN = 0.0    MAX = 1000.0 ;
PORT cap    "Latent capacitance rate"    [W/(kg_water/kg_dryAir)] ;


EQUATIONS {
    cap = mAir * HF_VAP ;
}

FUNCTIONS {
        cap  = lat_rate__cap( mAir ) ;
        mAir = lat_rate__mAir( cap ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"

EVALUATE( lat_rate__cap )
{
    ARGDEF(0, mAir ) ;
    double cap;

    cap = mAir * HF_VAP;
    RETURN( cap ) ;
}

EVALUATE( lat_rate__mAir )
{
    ARGDEF(0, cap ) ;
    double mAir;

    mAir = cap/HF_VAP;
    RETURN( mAir ) ;
}
