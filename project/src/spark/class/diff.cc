/// \file  diff.cc
/// \brief  Generic difference relation  
///
///  Notes:           
///       Same as sum, but interfaces are named differently 
///
///  Acceptable input set:  
///       a = 2, b = 1
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT a        "Subtrahend" ;
/// - PORT b        "Subtractor" ;
/// - PORT c        "Difference" ;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// c = a - b
/// \endcode
///
/// \code
/// a = diff__a( c, b )
/// \endcode
///
/// \code
/// a = diff__a( c, b )
/// \endcode
///
/// \code
/// c = diff__difference( a, b )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER


PORT a        "Subtrahend" ;
PORT b        "Subtractor" ;
PORT c        "Difference" ;


EQUATIONS {
    c = a - b ;
}

FUNCTIONS {
        a = diff__a( c, b ) ;
        a = diff__a( c, b ) ;
        c = diff__difference( a, b ) ;
}


#endif /* SPARK_PARSER */
#include "spark.h"

///////////////////////////////////////////////////////////////////////////////
EVALUATE( diff__difference )
{
    ARGDEF(0, a);
    ARGDEF(1, b);
    double c;

    c = a - b;

    RETURN( c );
}
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
EVALUATE( diff__a )
{
    ARGDEF(0, c);
    ARGDEF(1, b);
    double a;

    a = c + b;

    RETURN( a );
}
///////////////////////////////////////////////////////////////////////////////
