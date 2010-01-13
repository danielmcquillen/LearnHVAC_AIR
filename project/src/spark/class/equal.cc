/// \file  equal.cc
/// \brief Equality operator.
///
/// The generic "pass-through" object 
///
/// Acceptable input set:  
///   a = 1
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a    "One variable" ;
PORT b    "The other" ;

EQUATIONS {
    a = b ;
}

FUNCTIONS {
    a = equal__a( b ) ;
    b = equal__b( a ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"


namespace equal {

    /// \brief  Generic equal operator
    inline double Formula(double x)
    {
        return x;
    }


}; // namespace equal



/// \brief  Inverse for a = equal__a( b )
/// \return a = -b
/// \param  b
EVALUATE( equal__a )
{
    ARGUMENT( 0, b );

    double a = equal::Formula(b);

    RETURN( a );
}


/// \brief  Inverse for b = equal__b( a )
/// \return b = -a
/// \param  a
EVALUATE( equal__b )
{
    ARGUMENT( 0, a );

    double b = equal::Formula(a);

    RETURN( b );
}


