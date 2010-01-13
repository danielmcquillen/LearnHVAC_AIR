/// \file  humratio.cc
/// \brief Humidity ratio vs partial pressure of vapor
/// 
/// Psychrometric relationship between humidity ratio  and partial
/// pressure of water vapor.  SI units.
/// 
/// Acceptable input set:  
///     w = 0.01, PAtm = 101325
/// 


#ifdef SPARK_PARSER

PORT PAtm   "Atmospheric pressure"             [Pa]
                INIT = 101325    MIN = 0        MAX = 110000 ;
PORT Pw     "Partial pressure of water vapor"  [Pa]
                INIT = 101325    MIN = 0        MAX = 110000 ;
PORT w      "Humidity ratio"                   [kg_water/kg_dryAir]
                INIT = .002      MIN = 0        MAX = 0.1 ;

EQUATIONS {
    w =  MW_RATIO * Pw/(PAtm - Pw) ;
}

FUNCTIONS {
        Pw = humratio__Pw( w, PAtm ) ;
        w  = humratio__w( Pw, PAtm ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"

/*    Functions to support SPARK object file humratio.cc
 *
 *   Abstract: Humidity ratio of moist air as function of
 *             atmospheric pressure and water vapor pressure.
 *               Eq. 6.20, ASHRAE HOF.   Used in humratio.cc.
 *   Interface:
 *                w:   Humidity ratio (kg-water/kg-dry-air)
 *               Pw:   Partial pressure of water vapor (Pascals)
 *             Patm:   Atmospheric pressure (Pascals)
 *   Equations:
 *              w = (MW_RATIO*Pw)/(Patm-Pw);
 *
 */

/*  Humratio relationship solved for pw */


EVALUATE( humratio__Pw )
{
    ARGDEF(0, w ) ;
    ARGDEF(1, Patm ) ;
    double Pw;

    Pw = Patm*w/(w + MW_RATIO);
    RETURN( Pw ) ;
}

/*  Humratio relationship solved for w */

EVALUATE( humratio__w )
{
    ARGDEF(0, Pw ) ;
    ARGDEF(1, Patm ) ;
    double w;

    w = (MW_RATIO*Pw)/(Patm-Pw);
    RETURN( w ) ;
}
