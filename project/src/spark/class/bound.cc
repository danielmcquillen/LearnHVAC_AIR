/// \file  bound.cc
/// \brief Bound a value 
///         Includes simple anti-windup and limiting of the output to the range 0-1
///
///  Abstract:        
///       Bound a value by two extremes 
///
///  Acceptable input set:  
///       lo = 10,  hi = 20,  x = 5
///
/// \todo "bound says hi" - delete
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT lo        "Lower bound"   [] ;
/// - PORT hi        "Upper bound"   [] ;
/// - PORT x        "Input"         [] ;
/// - PORT y        "Output"        [] ;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// y = max(lo, min(hi, x))
/// \endcode
///
/// \code
/// y = bound__y(lo,hi,x)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

PORT lo        "Lower bound"   [] ;
PORT hi        "Upper bound"   [] ;
PORT x        "Input"         [] ;
PORT y        "Output"        [] ;

EQUATIONS {
        y = max(lo, min(hi, x)) ;
}

FUNCTIONS {
        y = bound__y(lo,hi,x) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include <iostream>
using std::cout;
using std::endl;

///////////////////////////////////////////////////////////
EVALUATE( bound__y )
{
    ARGDEF( 0, lo ) ;
    ARGDEF( 1, hi ) ;
    ARGDEF( 2, x ) ;
    double    y ;

	//cout << "bound says hi." << endl;
	
    y = SPARK::max(lo, SPARK::min(hi, x));
    RETURN( y ) ;
}
///////////////////////////////////////////////////////////
