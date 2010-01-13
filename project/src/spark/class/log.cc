/// \file  log.cc
/// \brief SPARK log base-e object.
///
/// The mathematical function of log base e.
///

#ifdef SPARK_PARSER

PORT a        "argument" ;
PORT b        "log base-e of argument" ;

EQUATIONS {
    b = log_e(a) ;
}

FUNCTIONS {
    b = log__b( a ) ;
    a = log__a( b ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include <limits>

EVALUATE( log__b )
{
    ARGDEF(0, a);
    double result;

    if ( a <= 0.0) // Basic safeguard to avoid runtime error
        result = - std::numeric_limits<double>::max();
    else
        result = log(a);
    
    RETURN(  result ) ;
}


EVALUATE( log__a )
{
    ARGDEF(0, b);
    double result;
    
    result = exp(b);
    RETURN( result ) ;
}
