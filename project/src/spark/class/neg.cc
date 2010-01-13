/// \file  neg.cc
/// \brief Negation operator using the relation c = -a
///
/// Enforces negation relation. Used for conservation laws when
/// x + y = 0 is needed.
///
/// Acceptable input set:  
/// a = 1
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a    "One argument" ;
PORT c    "The other" ;

EQUATIONS {
    a + c = 0 ;
}

FUNCTIONS {
    c = neg__c( a ) ;
    a = neg__a( c ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"


namespace neg {

    /// \brief Generic negation operator
    /// Defined once and used in each inverse for the sake of consistency!
    inline double Formula(double x) 
    {
        return -x;
    }

}; // namespace neg


/// \brief  Inverse for c = neg__c( a )
/// \return c = -a
/// \param  a
EVALUATE( neg__c )
{
    ARGUMENT( 0, a ) ;
    
    double  c = neg::Formula(a);

    RETURN( c ) ;
}


/// \brief  Inverse for a = neg__a( c )
/// \return a = -c
/// \param  c
EVALUATE( neg__a )
{
    ARGUMENT( 0, c ) ;
    
    double a = neg::Formula(c);

    RETURN( a ) ;
}


