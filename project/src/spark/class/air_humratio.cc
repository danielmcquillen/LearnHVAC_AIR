/// \file  air_humratio.cc
/// \brief Computes humidity ratio from water vapor partial pressure and 
///        atmospheric pressure.
///
/// \todo References to consts.h
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// 
/// - w          Humidity ratio [kg_water/kg_dryAir]
/// - pVapWat    Partial pressure of water vapor [Pa]
/// - pAtm       Atmospheric pressure [Pa]
///
///////////////////////////////////////////////////////////////////////////////
/// \par    Inverses
///
/// \code
/// w =  MW_RATIO * pVapWat/(pAtm - pVapWat)
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

PORT pAtm "Atmospheric pressure"                [Pa]
        INIT = 101325 
        MIN = 0  
        MAX = 110000 ;
PORT pVapWat  "Partial pressure of water vapor" [Pa]
        INIT = 101325 
        MIN = 0  
        MAX = 110000 ;
PORT w  "Humidity ratio"                        [kg_water/kg_dryAir]
        INIT = .002 
        MIN = 0  
        MAX = 0.1 ;


FUNCTIONS {
    pVapWat = air_humratio__pVapWat( w, pAtm ) ;
    w       = air_humratio__w( pVapWat, pAtm ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk2.h"

/// \name Inverse for (vapor pressure)
//@{
/// \brief  Humratio relationship solved for pVapWat
EVALUATE( air_humratio__pVapWat )
{
    ARGUMENT(0, w ) ;
    ARGUMENT(1, pAtm ) ;
    double pVapWat;

    pVapWat = pAtm*w/(w + SPARK::hvactk2::MW_RATIO);
    RETURN(  pVapWat ) ;
}
//@}

/// \name Inverse for (humidity ratio)
//@{
/// \brief  Humratio relationship solved for  w 
EVALUATE( air_humratio__w )
{
    ARGUMENT(0, pVapWat ) ;
    ARGUMENT(1, pAtm ) ;
    double w;

    w = (SPARK::hvactk2::MW_RATIO*pVapWat)/(pAtm-pVapWat);
    RETURN(  w ) ;
}
//@}
