/// \file  controller.cc
/// \brief Implements a controller that aims at satisfying y == y_target by varying 
///        the design parameter x so that y_min < y_target < y_max.
///
/// There are no bound-constraints on the design parameter in this implementation.
///
/// The control law is expressed in residual form and assumes that y = f(x).
///
/// \warning Make sure that y actually depends on x otherwise the Jacobian might 
///          become singular!
///
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

PORT x       "design variable";
PORT y       "current output";
PORT y_req   "required output";
PORT y_min   "minimum output";
PORT y_max   "maximum output";  


EQUATIONS {
    x = controller( x, y, y_req, y_min, y_max ) ;
}

FUNCTIONS {
    x = RESIDUAL controller__residual( x, y, y_req, y_min, y_max  )
        COMMIT controller__commit( x );
}

#endif /* SPARK_PARSER */
#include "spark.h"

#include <sstream>


// We make the assumption that y = y(x)
EVALUATE( controller__residual )
{
    ARGDEF( 0, x );
    ARGDEF( 1, y );
    ARGDEF( 2, y_req );
    ARGDEF( 3, y_min );
    ARGDEF( 4, y_max );

    double y_target;
    if ( y_req < y_min ) {
        y_target = y_min;
    }
    else if ( y_req > y_max ) {
        y_target = y_max;
    }
    else {
        y_target = y_req;
    }

    // To avoid singular Jacobian: this should never happen if y_min > 0
    if ( y_target == 0.0 ) {
        y_target = 1.0;
    }

    double residual =  y - y_target;
    
    RETURN( residual );
}


/// Checks the validity of the solution after the nonlinear solver has converged.
COMMIT( controller__commit )
{
    ARGDEF( 0, x );

    // Dectect non-physical solution outside of min/max range!
    if ( x < x.GetMin() || x > x.GetMax() ) {
//        std::ostringstream Msg;
//        Msg << "Variable " << x << " is out-of-range" << std::endl
//            << "  Minimum = " << x.GetMin() << std::endl
//            << "  Maximum = " << x.GetMax() << std::endl
//            << std::ends;

//        RUN_LOG( THIS_OBJECT, Msg.str() );
    }
}


