/// \file  prod.cc
/// \brief Binary product operator c = a * b.
///
/// Inverses prod__a prod__b check for "divide by zero" and throw 
/// an exception if detected.
///
/// If you need a numerically safe product operator, use safprod.cc instead.
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a    "Multiplicand";
PORT b    "Multiplicand";
PORT c    "Product" ;

EQUATIONS {
    c = a * b ;
    a = (b != 0 ? c/b : error) ;
    b = (a != 0 ? c/a : error) ;
}

FUNCTIONS {
    c = prod__c( a, b ) ;
    a = prod__a( c, b ) ;
    b = prod__b( c, a ) ;
}

#endif /* SPARK_PARSER */

#include <sstream>
#include "spark.h"
#include "spark_exceptions.h"


/// \namespace prod
/// \brief Namespace containing helper functions for the prod.cc class.
namespace prod {

    /// \brief Generic quotient formula producing result = num/den
    /// Throws an exception when detecting a division by zero.
    inline double indirect_formula(double num, const SPARK::TArgument& den)
    {
        // Basic safeguard to avoid division by zero at runtime
        if ( den == 0.0 || SPARK::check_numerics( double(den) ) != SPARK::NumericalValueType_VALID ) {
            std::ostringstream Msg;
            Msg << "Denominator variable is equal to zero: " << den << std::ends;

            throw SPARK::XNumerics(
                __FILE__,
                Msg.str()
            );
        }
        return num/den;
    }

}; // namespace prod


/// \brief  Inverse for c = prod__c(a, b)
/// \return c = a * b
/// \param  a
/// \param  b
EVALUATE( prod__c )
{
    ARGUMENT(0, a);
    ARGUMENT(1, b);
    
    double c = a * b;

    RETURN( c ) ;
}


/// \brief  Inverse for a = prod__a(c, b)
/// \return a = c / b
/// \param  c
/// \param  b
/// \pre    b != 0
EVALUATE( prod__a )
{
    ARGUMENT(0, c);
    ARGUMENT(1, b);
   
    double a = prod::indirect_formula( c, b );
    
    RETURN( a ) ;
}


/// \brief  Inverse for b = prod__b( c, a)
/// \return b = c / a
/// \param  c
/// \param  a
/// \pre    a != 0
EVALUATE( prod__b )
{
    ARGUMENT(0, c);
    ARGUMENT(1, a);
    
    double b = prod::indirect_formula( c, a );
    
    RETURN( b );
}


