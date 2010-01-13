/// \file  safprod.cc
/// \brief Numerically robust product operator c = a * b
///
/// Use in place of prod.cc whenever division by zero arises. 
///
/// \note  Numerically more costly than prod.cc because if matched against the ports a or b
///        it will force the variables to be break variables.
///
/////////////////////////////////////////////////////////////////////////////////////////
/// \attention COPYRIGHT (C) 2005 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
/////////////////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT a    "Multiplicand" ;
PORT b    "Multiplicand" ;
PORT c    "Product" ;

EQUATIONS {
    c = a * b ;
}

FUNCTIONS {
    DEFAULT_RESIDUAL = safprod__residual( a, b, c )
        // [DC/LBNL] 051205 -- Bug in sparkparser! @@@@ 
        PREPARE safprod__prepare( a, b, c );
    
    c = safprod__c( a, b ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"


/// \brief  Direct inverse for c = safprod__c( a, b )
/// \return c = a * b
/// \param  a
/// \param  b
EVALUATE( safprod__c )
{
    ARGUMENT(0, a);
    ARGUMENT(1, b);
    double c;
    
    c = a * b;

    RETURN( c ) ;
}


/// \brief PREPARE callback for residual inverse.
///
/// Sets the scale for the residual function.
///
/// \param c
///
/// \todo Do the same in safsquare.cc and safrecip.cc
PREPARE( safprod__prepare )
{
    ARGUMENT(0, a);
    ARGUMENT(1, b);
    ARGUMENT(2, c);

    /// Derive typical magnitude for the residual function
    double Typ_F = SPARK::delta_scaling(
        c.GetTyp(),
        c,
        a * b
    );
    
    std::ostringstream Msg;
    Msg << "Typ_F = " << Typ_F << std::endl;
    RUN_LOG( ME, Msg.str() );

    // @@@@ BUG IN PARSER!
    ME.SetResidualScale( 0, Typ_F );
}


/// \brief  Default residual inverse for all ports but c
/// \return residual = c - a * b
/// \param  a
/// \param  b
/// \param  c
EVALUATE( safprod__residual )
{
    ARGUMENT(0, a);
    ARGUMENT(1, b);
    ARGUMENT(2, c);
    TARGET(0, F);  // a or b
    double residual;
    
    /// Derive typical magnitude for the residual function
    double Typ_F = SPARK::delta_scaling(
        c.GetTyp(),
        c,
        a * b
    );
    ME.SetResidualScale( 0, Typ_F );

    residual = c - a * b;

    RETURN( residual ) ;
}

 