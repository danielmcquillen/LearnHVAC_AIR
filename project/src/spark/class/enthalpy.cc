/// \file  enthalpy.cc
/// \brief Enthalpy, dry bulb, humidity relation.
///
/// Psychrometric relationship among the enthalpy, temperature,
/// and humidity ratio variables.  SI units.
///
/// Acceptable input set:  
///     TDb = 20, w = 0.01
///


#ifdef SPARK_PARSER

PORT h        "Enthalpy"                    [J/kg_dryAir]
                INIT = 25194.2    MIN = -50300.0    MAX = 398412.5;
PORT TDb      "Dry bulb temperature"        [deg_C]
                INIT = 20.0       MIN = -50.0       MAX = 95.0 ;
PORT w        "Humidity ratio"              [kg_water/kg_dryAir]
                INIT = .002       MIN = 0           MAX = 0.1 ;


EQUATIONS {
    h = CP_AIR * TDb + w * (CP_VAP * TDb + HF_VAP) ; 
}

FUNCTIONS {
    h   = enthalpy__h( TDb, w ) ;
    TDb = enthalpy__TDb( h, w ) ;
    w   = enthalpy__w( h, TDb ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"

/*    Functions to support SPARK object file enthalpy.cc
 *
 *   Abstract: Enthalpy of moist air.  Eq. 6.30, ASHRAE
 *             HOF.   Used in enthalpy.cc.
 *   Interface:
 *               w:   Humidity ratio (kg-water/kg-dry-air)
 *              db:   Dry bulb temperature (deg-C)
 *               h:   Enthalpy (J/kg-dry-air)
 *   Equations:
 *               h = CP_AIR*db + (HF_VAP + CP_VAP*db)*w;
 *
 */
/*========================================================================*/

/*
 *      Enthalpy relationship solved for h
 *                 hfdbw
 */
EVALUATE( enthalpy__h )
{
    ARGDEF(0, db ) ;
    ARGDEF(1, w ) ;
    double h;

    h = CP_AIR*db + (HF_VAP + CP_VAP*db)*w;
    RETURN( h ) ;
}

/*
 *      Enthalpy relationship solved for db
 *                   dbfhw
 */
EVALUATE( enthalpy__TDb )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, w ) ;
    double db;

    db = (h - HF_VAP*w)/(CP_AIR + CP_VAP*w);
    RETURN( db ) ;
}

/*
 *       Enthalpy relationship solved for w
 *                   wfhdb
 */
EVALUATE( enthalpy__w )
{
    ARGDEF(0, h ) ;
    ARGDEF(1, db ) ;
    double w;

    w = (h - CP_AIR*db)/(HF_VAP + CP_VAP*db);
    RETURN( w ) ;
}
