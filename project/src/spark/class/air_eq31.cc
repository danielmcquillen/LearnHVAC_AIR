/// \file  air_eq31.cc
/// \brief Enforces Eq 31 of ASHRAE HOF, Ch. 6.  Used in wet bulb calculation.
///
///  Acceptable input set:  
///       h = 46000, w = 0.01,  TWb = 18, wSStar = 0.012
///
///    3/1/2007
///      Modified by E F Sowell to use RESIDUAL form for the TWb port. 
///      This allows calculation of TWb at RH = 1.0.
///
///       Abstract:   Functions supporting eq31.cc used in wet bulb object.
///                    Based on Equation 31,  ASHRAE 31, HOF,  Ch. 6.
///        Interface:
/// -              h:         Enthalpy (J/kg)
/// -              w:         Humidity ratio ((kg-water/kg-dry-air))
/// -              t_star:    Wet bulb temperature (deg C)
/// -              ws_star:   Humidity ratio star ((kg-water/kg-dry-air))
/// -              hs_star:   Enthalpy star (J/kg)
///        Equations:
/// -                h + (ws_star - w) * CP_WAT * t_star= hs_star
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
    h + (wSStar - w) * SPARK::hvactk2::CP_WAT * TWb = hSStar ;
}

FUNCTIONS {
         h      = eq31__h(  w, TWb, wSStar, hSStar ) ;
         w      = eq31__w(  h, TWb, wSStar, hSStar ) ;
         TWb    = RESIDUAL eq31__Residual( h, w,  wSStar, hSStar, TWb ) ;
         wSStar = eq31__wSStar( h, w,  TWb, hSStar ) ;
         hSStar = eq31__hSStar( h, w,  TWb, wSStar ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "spark_math.h"
#include "hvactk2.h"


EVALUATE( eq31__h )
{
    ARGDEF(0, w ) ;
    ARGDEF(1, t_star ) ;
    ARGDEF(2, ws_star ) ;
    ARGDEF(3, hs_star ) ;
    double h;

    h = hs_star - (ws_star - w) * SPARK::hvactk2::CP_WAT * t_star;
    RETURN( h ) ;
}

EVALUATE( eq31__w )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, t_star ) ;
    ARGDEF(2, ws_star ) ;
    ARGDEF(3, hs_star ) ;
    double w;
    w = ws_star - (hs_star - h)/(SPARK::hvactk2::CP_WAT*t_star);
    RETURN( w ) ;
}

EVALUATE( eq31__Residual )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, w ) ;
    ARGDEF(2, ws_star ) ;
    ARGDEF(3, hs_star ) ;
    ARGDEF(4, t_star ) ;
    double Residual;
    double delta_w ;
    delta_w = ws_star - w;
    Residual = t_star*(SPARK::hvactk2::CP_WAT*delta_w) - (hs_star - h);
    RETURN( Residual ) ;
}

EVALUATE( eq31__wSStar )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, w ) ;
    ARGDEF(2, t_star ) ;
    ARGDEF(3, hs_star ) ;
    double ws_star;

    ws_star = w + (hs_star - h)/(SPARK::hvactk2::CP_WAT*t_star);
    RETURN( ws_star ) ;
}

EVALUATE( eq31__hSStar )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, w ) ;
    ARGDEF(2, t_star ) ;
    ARGDEF(3, ws_star ) ;
    double hs_star;

    hs_star = h + (ws_star - w) * SPARK::hvactk2::CP_WAT * t_star;
    RETURN( hs_star ) ;
}
