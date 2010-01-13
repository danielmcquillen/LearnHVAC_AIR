/// \file euler_formula.cc 
/// \brief Euler explicit integration formula.
///
///        1st-order scheme
///        a.k.a. Backward Euler scheme
///        a.k.a. Open Euler scheme
///
/// Usage:
///        - used inside the macro class euler.cm. 
///        - NOT suited for stiff problems
///        - NOT suited for high accuracy requirement
///
/// Initialization:
///        - dynamic variable x must get an initial value
///        - derivative xdot is initialized through the 
///          initial time solution.
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

CLASSTYPE  INTEGRATOR ;

PORT    x       "dynamic variable";     
PORT    x_init  "initial value for dynamic variable";
// Only use previous values of this variable
PORT    xdot    "time-derivative of dynamic variable"; 
PORT    dt      "integration time step"; 

EQUATIONS {
    x = euler_formula( x_init, xdot, dt ) ;
    BAD_INVERSES = x_init, xdot, dt ;
}

FUNCTIONS {
    x = euler_formula( x_init, xdot, dt);
}

#endif    // SPARK_PARSER

#include "spark.h"


EVALUATE( euler_formula )
{
    ARGUMENT( 0, x_init );
    ARGUMENT( 1, xdot ) ;
    ARGUMENT( 2, dt ) ;
    TARGET( 0, x ) ;
    double  result;
    
    const SPARK::TProblem& Problem = me.GetProblem();

    if ( Problem.IsStaticStep() ) {  // No integration
        result = x_init;
    }
    else {  // Perform the actual integration
        result = x[1] + dt*xdot[1];
    }

    RETURN( result );
}

