/// \file  recip.cc
/// \brief Reciprocal operator
///
/// Inverse recip__a_or_c checks for "divide by zero".
/// The "safe" reciprocal is 1/x except when x is zero then it is set to std::numeric_limits<double>::max().
///
/// If you need a numerically safe product operator, use safrecip.cc instead.
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a    "One input" ;
PORT c    "The other" ;

EQUATIONS {
    c = (a !=0 ? 1.0/a : LARGE) ;
    a = (c !=0 ? 1.0/c : LARGE) ;
}

FUNCTIONS {
    c = recip__c( a ) ;
    a = recip__a( c ) ;
}

#endif /* SPARK_PARSER */

#include <sstream>
#include "spark.h"


/// \namespace recip
/// \brief Namespace containing helper functions for the recip.cc class.
namespace recip {

    /// \brief Generic reciprocal formula producing result = 1/den
    /// Throws an exception when detecting a division by zero.
    inline double formula(const SPARK::TArgument& den)
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
        return 1.0/den;
    }

}; // namespace recip


/// \brief  Inverse for c = recip__c( a )
/// \return c = 1/a
/// \param  a
/// \pre    a != 0
EVALUATE( recip__c )
{
    ARGUMENT( 0, a );

    double c = recip::formula( a );

    RETURN( c ) ;
}


/// \brief  Inverse for a = recip__a( c )
/// \return a = 1/c
/// \param  c
/// \pre    c != 0
EVALUATE( recip__a )
{
    ARGUMENT( 0, c );

    double a = recip::formula( c );

    RETURN( a ) ;
}

