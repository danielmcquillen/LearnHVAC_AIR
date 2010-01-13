/// \file  sercond.cc
/// \brief Conductors in series described by the relation 1/UTot = 1/U1 + 1/U2.
/// 
/// Computes overall conductance for two conductors in series.
/// 
/// Inverse for U1 becomes singular if U2 == UTot with U1->inf.
/// Inverse for U2 becomes singular if U1 == UTot with U2->inf.
///
/// \note Generic units so it can be used for either total or per unit area
///       conductance.
///
/// Acceptable input set:  
///   U1 > 0
///   U2 > 0
///   UTot > 0
///
/// Units of U1, U2 and UTot must match.
/// E.g., [W/deg_C] or [W/(m^2*deg_C)], ...
///


#ifdef SPARK_PARSER

PORT U1     "Conductance 1";
PORT U2     "Conductance 2";
PORT UTot   "Overall conductance";


EQUATIONS {
    1/UTot = 1/U1 + 1/U2 ;
}

FUNCTIONS {
    UTot = sercond__UTot( U1, U2 ) ;
    U1   = sercond__U1( UTot, U2 ) ;
    U2   = sercond__U2( UTot, U1 ) ;
}

#endif /* SPARK_PARSER */
#include <cassert>
#include "spark.h"


/// \brief Series conductors solved for UTot
/// \return    UTot = 1.0/(1.0/U1 + 1.0/U2)
/// \param     U1
/// \param     U2
EVALUATE( sercond__UTot )
{
    ARGUMENT(0, U1 ) ;
    ARGUMENT(1, U2 ) ;
    double UTot;

    double Num = U1 * U2;
    double Den = U1 + U2;

    if (Num == 0.0) {
        UTot = 0.0;
    }
    else {
        /// \note This should never happen since the only way Den==0 is when U1=U2=0.
        ///       If U1==0 or U2==0, then Num==0 and we never get here!
        assert( U1 > 0.0 );
        assert( U2 > 0.0 );
        assert( Den > 0.0 );
        UTot = Num/Den;
    }
    RETURN( UTot ) ;
}


/// \brief Series conductors solved for one U1
///
/// Explicit inverse:  U1 = (UTot * U2)/(U2 - UTot)
/// When UTot -> 0, U1 -> +0
/// When U2 -> 0,   U1 -> -0
///
/// \return    U1 = 1.0/(1.0/UTot - 1.0/U2)
/// \param     UTot
/// \param     U2
EVALUATE( sercond__U1 )
{
    ARGUMENT(0, UTot );
    ARGUMENT(1, U2 );
    double U1;

    double Num = UTot * U2;
    double Den = U2 - UTot;

    if (Num == 0.0) {
        U1 = 0.0;
    }
    else {
        assert( Den > 0.0 );
        U1 = Num/Den;
    }

    RETURN( U1 ) ;
}


/// \brief Series conductors solved for one U2
///
/// Explicit inverse:  U2 = (UTot * U1)/(U1 - UTot)
/// When UTot -> 0, U2 -> +0
/// When U1 -> 0,   U2 -> -0
///
/// \return    U2 = 1.0/(1.0/UTot - 1.0/U1)
/// \param     UTot
/// \param     U1
EVALUATE( sercond__U2 )
{
    ARGUMENT(0, UTot ) ;
    ARGUMENT(1, U1 ) ;
    double U2;

    double Num = UTot * U1;
    double Den = U1 - UTot;

    if (Num == 0.0) {
        U2 = 0.0;
    }
    else {
        // Detect singularity
        assert( Den > 0.0 );
        U2 = Num/Den;
    }

    RETURN( U2 ) ;
}




