/// \file  max2.cc
/// \brief Maximum operator c = max(a, b)
///
/// Enforces minimum of two variables.
///
/// Acceptable input set:  
///  a = 10, b = 5
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a        "One input" ;
PORT b        "The other" ;
PORT c        "Maximum of the two" ;

EQUATIONS {
    c = max(a, b) ;
}

FUNCTIONS {
    c = max2( a, b ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"

/// \brief  Inverse for c = max2( a, b )
/// \return c = max(a, b)
/// \param  a
/// \param  b
EVALUATE( max2 )
{
    ARGUMENT( 0, a ) ;
    ARGUMENT( 1, b ) ;

    double c = SPARK::max(a,b) ;

    RETURN( c ) ;
}
