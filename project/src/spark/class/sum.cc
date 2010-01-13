/// \file  sum.cc
/// \brief Sum operator using the relation c = a + b
///
/// Acceptable input set:  
///    a = 2, b = 1
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a    "Summand 1" ;
PORT b    "Summand 2" ;
PORT c    "Sum" ;

EQUATIONS {
    c = a + b ;
}

FUNCTIONS {
    a = sum__a( c, b ) ;
    b = sum__b( c, a ) ;
    c = sum__c( a, b ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"

/// \brief  Inverse for a = sum__a( c, b )
/// \return a = c - b
/// \param  c
/// \param  b
EVALUATE( sum__a )
{
    ARGUMENT(0, c);
    ARGUMENT(1, b);
    double a ;

    a = c - b;
    RETURN( a ) ;
}


/// \brief  Inverse for b = sum__b( c, a )
/// \return b = c - a
/// \param  c
/// \param  a
EVALUATE( sum__b )
{
    ARGUMENT(0, c);
    ARGUMENT(1, a);
    double b ;

    b = c - a;
    RETURN( b ) ;
}


/// \brief  Inverse for c = sum__c( a, b )
/// \return c = a + b
/// \param  a
/// \param  b
EVALUATE( sum__c )
{
    ARGUMENT(0, a);
    ARGUMENT(1, b);
    double c;

    c = a + b;
    RETURN( c ) ;
}


