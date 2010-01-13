/// \file lintrp.cc
/// \brief Linear interpolation using y = lobnd + x * (hibnd - lobnd)
///
/// Linearly interpolates the point (x,y) between the points
///  (0,lobnd) and (1,hibnd)
///
/// Acceptable input set:  
///  x = 0.5, lobnd = 1, hibnd  = 9
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT x        "One variable (in range 0 -1)"
                INIT = 0.5    MIN = 0.0    MAX = 1.0 ;
PORT y        "The other" ;
PORT lobnd    "y when x is 0" ;
PORT hibnd    "y when x is 1" ;

EQUATIONS {
    y = lobnd + x * (hibnd - lobnd) ;
}

FUNCTIONS {
    y     = lintrp__y( x, lobnd, hibnd ) ;
    x     = lintrp__x( y, lobnd, hibnd ) ;
    lobnd = lintrp__lobnd( x, y, hibnd ) ;
    hibnd = lintrp__hibnd( x, y, lobnd ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"

EVALUATE( lintrp__y )
{
    ARGUMENT( 0, x ) ;
    ARGUMENT( 1, lobnd ) ;
    ARGUMENT( 2, hibnd ) ;
    double y;

    y = (1 - x)*lobnd + x*hibnd;
    RETURN( y ) ;
}

EVALUATE( lintrp__x )
{
    ARGUMENT( 0, y ) ;
    ARGUMENT( 1, lobnd ) ;
    ARGUMENT( 2, hibnd ) ;
    double x;

    x = (y - lobnd)/(lobnd - hibnd);
    RETURN( x ) ;
}

EVALUATE( lintrp__lobnd )
{
    ARGUMENT( 0, x ) ;
    ARGUMENT( 1, y ) ;
    ARGUMENT( 2, hibnd ) ;
    double  lobnd ;

    lobnd = (y - hibnd*x)/(1-x);
    RETURN( lobnd ) ;
}

EVALUATE( lintrp__hibnd )
{
    ARGUMENT( 0, x ) ;
    ARGUMENT( 1, y ) ;
    ARGUMENT( 2, lobnd ) ;
    double  hibnd ;

    hibnd = (y - lobnd)/x + lobnd ;
    RETURN( hibnd ) ;
}
