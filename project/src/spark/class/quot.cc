/// \file  quot.cc
/// \brief SPARK quotient object
///
/// Inverse quot__b_or_c checks for "divide by zero" and returns 
/// numerator/std::numeric_limits<double>::min() if it detects a division by zero
/// condition.
///
/// If you need a numerically safe product operator, use safquot.cc instead.
/// 

#ifdef SPARK_PARSER

PORT a    "Numerator" ;
PORT b    "Denominator" ;
PORT c    "Quotient" ;

EQUATIONS {
    c = (b != 0 ? a/b : a/SMALL) ;
    b = (c != 0 ? a/c : a/SMALL) ;
    a = b * c ;
}

FUNCTIONS {
    c = quot__b_or_c( a, b ) ;
    b = quot__b_or_c( a, c ) ;
    a = quot__a( b, c ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include <limits>
#include <sstream>
#include <iostream>
using std::cout;
using std::endl;

// b = a / c
// c = a / b
// General form: result = num / den
EVALUATE( quot__b_or_c )
{
    ARGDEF(0, num);
    ARGDEF(1, den);
    double result;

//	std::cout << "quot says hi." << "\n";
    
    if  (den != 0.0) {
        result = num/den;
    }
    else {
//        std::ostringstream Msg;
//        Msg << "Denominator " << den.GetName() << " equal to 0.0!" << std::ends;
//        RUN_LOG( THIS_OBJECT, Msg.str() );

//        result = num/std::numeric_limits<double>::min();
    }
    
    RETURN( result ) ;
}


// a = b * c
EVALUATE( quot__a )
{
    ARGDEF(0, b);
    ARGDEF(1, c);
    double a;

//	std::cout << "quot says hi." << "\n";
    
    a = b * c;

    RETURN( a ) ;
}
