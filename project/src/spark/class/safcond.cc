/// \file  safcond.cc
/// \brief Numerically robust generic conductance relation.
///  
/// Enforces the product of difference relationship that occurs in heat conduction and elsewhere. 
///
/// \note Used variously whenever quantity is proportional to the difference between two other quantities,  
///       such as heat transfer.
///

#ifdef SPARK_PARSER

PORT c      "Conducted quantity" ;
PORT p1     "Potential 1" ;
PORT p2     "Potential 2" ;
PORT k      "Proportional factor" ;

EQUATIONS {
    c = k * (p1 - p2) ;
}

FUNCTIONS {
    DEFAULT_RESIDUAL = safcond__residual( c, p1, p2, k );
    c = safcond__c( p1, p2, k ) ;
}

#endif /* SPARK_PARSER */

#include "spark.h"


/// \brief Conductor Function  safcond__q(p1, p2, k)
/// 
///  c = k * (p1 - p2)
EVALUATE( safcond__c )
{
    ARGDEF(0, p1 ) ;
    ARGDEF(1, p2 ) ;
    ARGDEF(2, k ) ;
    double c;

    c = k * (p1 - p2) ;
    
    RETURN( c ) ;
}

/// \brief Conductor Function  safcond__residual(c, p1, p2, k)
/// 
///  k  = c/(p1 - p2)
///  p1 = c/k + p2
///  p2 = -c/k + p1
EVALUATE( safcond__residual )
{
    ARGDEF(0, c ) ;
    ARGDEF(1, p1 ) ;
    ARGDEF(2, p2 ) ;
    ARGDEF(3, k ) ;
    
    double residual = c - k * (p1 - p2) ;

    RETURN( residual ) ;
}

