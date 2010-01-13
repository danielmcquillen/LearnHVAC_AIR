/// \file  cap_rate.cc
/// \brief Moist air capacitance rate.
/// 
/// Calculates capacitance rate for moist air heat exchanger.
/// 
/// \note Used in airhx.cm
/// 
/// Acceptable input set:  
///     mAir = 1
///     w = 0.01
/// 
///////////////////////////////////////////////////////////////////////////////
/// \par Equations:
///
/// \code
/// cap = mAir * (CP_AIR + w * CP_VAP)
/// \endcode
///

#ifdef SPARK_PARSER

PORT mAir     "Dry air mass flow rate"        [kg_dryAir/s]
        INIT = 1    MIN = 0    MAX = 1000 ;
PORT w        "Air humidity ratio"            [kg_water/kg_dryAir]
        INIT = 0.01    MIN = 0    MAX = 0.1 ;
PORT cap      "Capacitance rate"              [W/deg_C] ;


EQUATIONS {
    cap = mAir * (CP_AIR + w * CP_VAP) ;
}

FUNCTIONS {
    cap  = cap_rate__cap( mAir, w ) ;
    mAir = cap_rate__mAir( cap, w ) ;
    w    = cap_rate__w( cap, mAir) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"

/// \brief  Inverse for cap  = cap_rate__cap( mAir, w )
/// \return cap = mAir * (CP_AIR + w * CP_VAP)
/// \param  mAir
/// \param  w
EVALUATE( cap_rate__cap )
{
    ARGDEF( 0, mAir );
    ARGDEF( 1, w );
    double cap;

    cap = mAir * (CP_AIR + w * CP_VAP);
    RETURN( cap ) ;
}

/// \brief  Inverse for mAir = cap_rate__mAir( cap, w )
/// \return mAir = cap / (CP_AIR + w * CP_VAP)
/// \param  cap
/// \param  w
EVALUATE( cap_rate__mAir )
{
    ARGDEF( 0, cap );
    ARGDEF( 1, w );
    double mAir;

    mAir = cap / (CP_AIR + w * CP_VAP);
    RETURN( mAir ) ;
}

/// \brief  Inverse for w = cap_rate__w( cap, mAir)
/// \return w = (cap/mAir - CP_AIR)/ CP_VAP
/// \param  cap
/// \param  mAir
EVALUATE( cap_rate__w )
{
    ARGDEF( 0, cap );
    ARGDEF( 1, mAir );
    double w;

    w = fabs(mAir) > SMALL ? (cap/mAir - CP_AIR)/ CP_VAP : LARGE;
    RETURN( w ) ;
}
