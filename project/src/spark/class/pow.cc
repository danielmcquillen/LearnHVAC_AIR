/// \file  pow.cc
/// \brief SPARK exponentiation object 
///
///  Abstract:        
///       The mathematical function of raising to a power.
///
///  Notes:           
///       Floating point is used for all arguments.
///
///  Acceptable input set:  
///       a = 10.0, b = 2.0
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT a    "Quantity being raised to a power" ;
/// - PORT b    "Exponent" ;
/// - PORT c    "a^b" ;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// c = pow__c( a, b )
/// \endcode
///
/// \code
/// a = pow__a( c, b )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

PORT a    "Quantity being raised to a power" ;
PORT b    "Exponent" ;
PORT c    "a^b" ;

EQUATIONS {
    c = a^b ;
}

FUNCTIONS {
    c = pow__c( a, b ) ;
    a = pow__a( c, b ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include <limits>

///////////////////////////////////////////////////////////
EVALUATE( pow__c )
{
    ARGDEF(0, a);
    ARGDEF(1, b);
    double c;

    if ((b == 0.5) && (a < 0.0)) 
        c = pow(fabs(a), b);
    else
        c = pow(a, b);
    RETURN( c ) ;
}
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
EVALUATE( pow__a )
{
    ARGDEF(0, c);
    ARGDEF(1, b);
    double a;
    
    if (b == 0.0)
        a = pow(c, std::numeric_limits<double>::max());
    else
        a = pow(c, 1.0/b);

    RETURN(  a ) ;
}
///////////////////////////////////////////////////////////
