/// \file   cond.cc
/// \brief  Generic conductance relation used throughout the HVAC toolkit.
///
/// Enforces the product of difference relationship that occurs in heat conduction and elsewhere. 
///
/// All inverses of the relationship are defined:
/// \code
///   q = U12*(T1 - T2)
/// \endcode
///
/// \note Used variously whenever quantity is proportional to the difference between two other quantities,  
///       such as heat transfer.
///

#ifdef SPARK_PARSER

PORT q        "Conducted quantity" ;
PORT T1       "Potential 1" ;
PORT T2       "Potential 2" ;
PORT U12      "Proportional factor" ;

EQUATIONS {
    q = U12*(T1 - T2);
}

FUNCTIONS {
    q   = cond_q( T1, T2, U12 ) ;
    T1  = cond_T1( q, T2, U12 ) ;
    T2  = cond_T2( q, T1, U12 ) ;
    U12 = cond_U12( q, T1, T2 ) ;
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include "hvactk.h"
#include <sstream>

/// \brief  EVALUATE callback for q
/// \return q = U12*(T1 - T2)
EVALUATE( cond_q )
{
    ARGDEF(0, T1 ) ;
    ARGDEF(1, T2 ) ;
    ARGDEF(2, U12 ) ;
    double q;

    q = U12*(T1 - T2);
    RETURN( q ) ;
}


/// \brief  EVALUATE callback for T1 
/// \return T1 = q/U12 + T2
EVALUATE( cond_T1 )
{
    ARGDEF(0, q ) ;
    ARGDEF(1, T2 ) ;
    ARGDEF(2, U12 ) ;
    double T1;

    if (fabs(q) <= SMALL) {
        T1 = T2;
    }
    else {
        if (fabs(U12) <= SMALL) {
            std::ostringstream Msg;
            Msg << "Proportional factor " << U12.GetName() << " less than " << SMALL << "!" << std::ends;
            ERROR_LOG( ME, Msg.str() );

            T1 = q/SMALL + T2;
        }
        else {
            T1= q/U12 + T2;
        }
    }
    RETURN( T1 );
}


/// \brief  EVALUATE callback for T2
/// \return T2 = -q/U12 + T1
EVALUATE( cond_T2 )
{
    ARGDEF(0, q );
    ARGDEF(1, T1 );
    ARGDEF(2, U12 );
    double T2;

    if (fabs(q) <= SMALL) {
        T2 = T1;
    }
    else {
        if (fabs(U12) <= SMALL) {
            std::ostringstream Msg;
            Msg << "Proportional factor " << U12.GetName() << " less than " << SMALL << "!" << std::ends;
            ERROR_LOG( ME, Msg.str() );

            T2 = T1 - q/SMALL;
        }
        else {
            T2= T1 - q/U12;
        }
    }
    RETURN( T2 ) ;
}

/// \brief  EVALUATE callback for U12
/// \return U12 = q/(T1 - T2)
EVALUATE( cond_U12 )
{
    ARGDEF(0, q ) ;
    ARGDEF(1, T1 ) ;
    ARGDEF(2, T2 ) ;
    double U12;
    double d;

    if (fabs(q) <= SMALL) {
        U12 = 0.0;
    }
    else {
        d = T1 - T2;
        if (fabs(d) <= SMALL) {
            std::ostringstream Msg;
            Msg << "Potential difference (" << T1.GetName() << "-" << T2.GetName() << ")"
                << " less than " << SMALL << "!" << std::ends;
            ERROR_LOG( ME, Msg.str() );

            U12 = q/SMALL;
        }
        else {
            U12 = q/d;
        }
    }
    RETURN( U12 ) ;
}
