/// \file  bfd.cc
/// \brief 2nd-order implicit Adams formula.
///
/// a.k.a. the 2nd-order Adams-Moulton formula
/// a.k.a. the trapezoidal rule
/// a.k.a. the backward-forward difference formula
///
/// \par Usage:
/// - scheme NOT suited for high-accuracy requirement
/// - scheme suited for mildly stiff problems
///
/// \par Initialization:
/// - initial condition is required for the dynamic variable x 
/// - initial value of the derivative xdot computed  during the initial time solution
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

CLASSTYPE  INTEGRATOR ;

PORT    x       "dynamic variable";     
PORT    x_init  "initial value for dynamic variable";
PORT    xdot    "time-derivative of dynamic variable"; 
PORT    dt      "integration time step"; 

EQUATIONS {
    x = bfd( x_init, xdot, dt);
    BAD_INVERSES = x_init, xdot, dt ;
}

FUNCTIONS {
    x = EVALUATE  bfd_formula( x_init, xdot, dt );
}

#endif    // SPARK_PARSER
#include "spark.h"


/// \brief  Integration formula for the 2nd-order Adams-Moulton scheme (implicit scheme)
/// \return x = bfd( x_init, xdot, dt)
/// \param  x_init   Initial value of the dynamic variable
/// \param  xdot     Time-derivative of the dynamic variable
/// \param  dt       Current time increment
EVALUATE( bfd_formula )
{
    ARGUMENT( 0, x_init );
    ARGUMENT( 1, xdot ) ;
    ARGUMENT( 2, dt ) ;
    TARGET( 0, x ) ;
    double  result;

    const SPARK::TProblem& Problem = me.GetProblem();

    // No integration performed is static step
    if ( Problem.IsStaticStep() ) {  
        result = x_init;
    }
    else {      
        result = x[1] + 0.5*dt*(xdot + xdot[1]);
    }

    RETURN( result );
}


