/// \file  eq31.cc
/// \brief Eq. 31 of ASHRAE HOF, Ch. 6
///
/// -  Abstract:        
/// -       Enforces Eq 31 of ASHRAE HOF, Ch. 6.  Used in wet bulb calculation.
/// -
/// -  Acceptable input set:  
/// -       h = 46000, w = 0.01,  TWb = 18, wSStar = 0.012
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT h        "Enthalpy"                [J/kg_dryAir]
/// -                 INIT = 25194.2    MIN = -50300.0    MAX = 398412.5 ;
/// - 
/// - PORT w        "Humidity ratio"          [kg_water/kg_dryAir]
/// -                 INIT = .002    MIN = 0        MAX = 0.1 ;
/// - 
/// - PORT TWb      "Wet bulb temperature"    [deg_C]
/// -                 INIT = 20.0    MIN = -50.0    MAX = 95.0 ;
/// - 
/// - PORT wSStar   "Humidity ratio star"     [kg_water/kg_dryAir]
/// -                 INIT = .002    MIN = 0        MAX = 0.1 ;
/// - 
/// - PORT hSStar   "Enthalpy star"           [J/kg_dryAir]
/// -                 INIT = 25194.2    MIN = -50300.0    MAX = 398412.5 ;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// h + (wSStar - w) * CP_WAT * TWb = hSStar
/// \endcode
///
/// \code
/// h      = eq31__h(  w, TWb, wSStar, hSStar )
/// \endcode
///
/// \code
/// w      = eq31__w(  h, TWb, wSStar, hSStar )
/// \endcode
///
/// \code
/// TWb    = eq31__TWb( h, w,  wSStar, hSStar )
/// \endcode
///
/// \code
/// wSStar = eq31__wSStar( h, w,  TWb, hSStar )
/// \endcode
///
/// \code
/// hSStar = eq31__hSStar( h, w,  TWb, wSStar )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

PORT h        "Enthalpy"                [J/kg_dryAir]
                INIT = 25194.2    MIN = -50300.0    MAX = 398412.5 ;

PORT w        "Humidity ratio"          [kg_water/kg_dryAir]
                INIT = .002    MIN = 0        MAX = 0.1 ;

PORT TWb      "Wet bulb temperature"    [deg_C]
                INIT = 20.0    MIN = -50.0    MAX = 95.0 ;

PORT wSStar   "Humidity ratio star"     [kg_water/kg_dryAir]
                INIT = .002    MIN = 0        MAX = 0.1 ;

PORT hSStar   "Enthalpy star"           [J/kg_dryAir]
                INIT = 25194.2    MIN = -50300.0    MAX = 398412.5 ;

EQUATIONS {
    h + (wSStar - w) * CP_WAT * TWb = hSStar ;
}

FUNCTIONS {
         h      = eq31__h(  w, TWb, wSStar, hSStar ) ;
         w      = eq31__w(  h, TWb, wSStar, hSStar ) ;
         TWb    = eq31__TWb( h, w,  wSStar, hSStar ) ;
         wSStar = eq31__wSStar( h, w,  TWb, hSStar ) ;
         hSStar = eq31__hSStar( h, w,  TWb, wSStar ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"


EVALUATE( eq31__h )
{
    ARGDEF(0, w ) ;
    ARGDEF(1, t_star ) ;
    ARGDEF(2, ws_star ) ;
    ARGDEF(3, hs_star ) ;
    double h;

    h = hs_star - (ws_star - w) * CP_WAT * t_star;
    RETURN( h ) ;
}

EVALUATE( eq31__w )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, t_star ) ;
    ARGDEF(2, ws_star ) ;
    ARGDEF(3, hs_star ) ;
    double w;
    w = ws_star - (hs_star - h)/(CP_WAT*t_star);
    RETURN( w ) ;
}

EVALUATE( eq31__TWb )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, w ) ;
    ARGDEF(2, ws_star ) ;
    ARGDEF(3, hs_star ) ;
    double t_star;

    t_star = (hs_star - h)/(CP_WAT*(ws_star - w));
    RETURN( t_star ) ;
}

EVALUATE( eq31__wSStar )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, w ) ;
    ARGDEF(2, t_star ) ;
    ARGDEF(3, hs_star ) ;
    double ws_star;

    ws_star = w + (hs_star - h)/(CP_WAT*t_star);
    RETURN( ws_star ) ;
}

EVALUATE( eq31__hSStar )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, w ) ;
    ARGDEF(2, t_star ) ;
    ARGDEF(3, ws_star ) ;
    double hs_star;

    hs_star = h + (ws_star - w) * CP_WAT * t_star;
    RETURN( hs_star ) ;
}
