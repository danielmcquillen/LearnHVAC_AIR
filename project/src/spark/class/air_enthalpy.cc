/// \file  air_enthalpy.cc
/// \brief Enthalpy, dry bulb, humidity relation.
/// 
/// Psychrometric relationship among the enthalpy, temperature,
/// and humidity ratio variables.  SI units.
///
/// \todo References to consts.h
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// 
/// - h               Enthalpy                                 [J/kg_dryAir]
/// - TDb             Dry bulb temperature                     [deg_C]
/// - w               Humidity ratio                           [kg_water/kg_dryAir]
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Inverses
///
/// \code
/// h = CP_AIR*TDb + (HF_VAP + CP_VAP*TDb)*w
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
/// - 050711 Chadi Maalouf (LEPTAB)
///     - Initial implementation.
/// 
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT h      "Enthalpy"   [J/kg_dryAir]
            INIT = 25194.2 
            MIN = -50300.0 
            MAX = 398412.5;
PORT TDb    "Dry bulb temperature"  [deg_C]
            INIT = 20.0 
            MIN = -50.0 
            MAX = 95.0 ;
PORT w      "Humidity ratio"  [kg_water/kg_dryAir]
            INIT = .002 
            MIN = 0  
            MAX = 0.1 ;


FUNCTIONS {
    h   = air_enthalpy__h( TDb, w ) ;
    TDb = air_enthalpy__TDb( h, w ) ;
    w   = air_enthalpy__w( h, TDb ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk2.h"

/// \name Inverse for (air_enthalpy)
//@{
/// \brief  Enthalpy relationship solved for h
EVALUATE( air_enthalpy__h )
{
    ARGUMENT(0, TDb ) ;
    ARGUMENT(1, w ) ;
    double  h = SPARK::hvactk2::enth(TDb,w);
    RETURN(  h ) ;
}


/// \name Inverse for (dry bulb temperature)
//@{
/// \brief  Enthalpy relationship solved for dry bulb temperature
EVALUATE( air_enthalpy__TDb )
{
    ARGUMENT(0, h ) ;
    ARGUMENT(1, w ) ;
    double  TDb = SPARK::hvactk2::drybulb(w,h);
    RETURN(  TDb ) ;
}
//@}


/// \name Inverse for (humidity ratio)
//@{
/// \brief Enthalpy relationship solved for w
EVALUATE( air_enthalpy__w )
{
    ARGUMENT(0, h ) ;
    ARGUMENT(1, TDb ) ;
    double  w = SPARK::hvactk2::humth(TDb,h);
    RETURN(  w ) ;
}
//@}
