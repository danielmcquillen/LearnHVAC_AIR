/// \file  noop.cc
/// \brief 	Basically a pass-through object to fool the parser.
///        	It is used to force the firing of object that
///		produces a predictor for another object.
///		See wetbulb_accl for example usage.
///
///
///             E F Sowell   2/28/2007
///


#ifdef SPARK_PARSER

PORT x_in    "Input"    [];
PORT y_in    "Pass-through argument" [];
PORT y_out   "Output" [];

EQUATIONS{  
    y_out = y_in ;
}

FUNCTIONS {
    y_out = noop__y_out( x_in, y_in ) ;
}


#endif /* SPARK_PARSER */
#include "spark.h"

EVALUATE( noop__y_out )
{
    ARGDEF(0, x_in ) ; // not used
    ARGDEF(1, y_in ) ;
    double a;
     a = y_in;
    RETURN( a ) ;
}


