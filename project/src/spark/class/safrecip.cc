/// \file  safrecip.cc
/// \brief Numerically robust reciprocal operator c = 1/a
///
/// Use in place of recip.cc whenever division by zero arises. 
///
/// \note  Numerically more costly than recip.cc because it will force the matched variable to be 
///        a break variable.
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a    "One input" ;
PORT c    "The other" ;

EQUATIONS {
    a * c = 1.0 ;
}

FUNCTIONS {
    DEFAULT_RESIDUAL = safrecip__residual( a, c ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"

/// \brief  Default residual inverse for all ports
/// \return residual = 1.0 - a * c
/// \param  a
/// \param  c
EVALUATE( safrecip__residual )
{
    ARGUMENT( 0, a ) ;
    ARGUMENT( 1, c ) ;
    double residual ;

    residual = 1.0 - a * c ;

    RETURN( residual ) ;
}

