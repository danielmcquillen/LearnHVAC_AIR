/// \file  min2.cc
/// \brief Minimum operator c = min(a, b)
/// 
/// Enforces minimum of two links.
///
/// Acceptable input set:  
///  a = 10, b = 5
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a    "One input" ;
PORT b    "The other" ;
PORT c    "The minimum of (a, b)" ;

EQUATIONS {
    c = min(a, b) ;
}

FUNCTIONS {
    c = min2( a, b ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"


/// \brief  Inverse for c = min2( a, b )
/// \return c = min(a, b)
/// \param  a
/// \param  b
EVALUATE( min2 )
{
    ARGUMENT( 0, a ) ;
    ARGUMENT( 1, b ) ;

    double c = SPARK::min(a,b) ;

    RETURN( c ) ;
}
