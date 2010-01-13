/// \file  select.cc
/// \brief Logical if-then-else operator using the relation c = s ? a : b
///
/// Chooses a if s > 0 or b otherwise.
///
/// \warning  Use with cautoin within strongly-connected components as it might
///                  discontinuity during the Newton iteration.
///
/// Acceptable input set:  
///  a = 1.0, b = 2.0, s = 0.0
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a        "One input" ;
PORT b        "The other input" ;
PORT s        "Decision variable" ;
PORT c        "Result" ;

EQUATIONS {
    c = s ? a : b ;
}

FUNCTIONS {
    c = select__c( s, a, b ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"


/// \brief  Inverse for c = select__c( s, a, b )
/// \return c = s ? a : b
/// \param  s
/// \param  a
/// \param  b
EVALUATE( select__c )
{
    ARGUMENT(0, s);
    ARGUMENT(1, a);
    ARGUMENT(2, b);
    double c;

    c = s ? a : b;
    RETURN( c ) ;
}

