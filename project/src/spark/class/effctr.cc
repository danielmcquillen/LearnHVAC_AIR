/// \file  effctr.cc
/// \brief Ntu-effectivess for counter flow
///         Includes simple anti-windup and limiting of the output to the range 0-1
///
/// -  Abstract:        
/// -       This is the counter flow effectiveness model for a
/// -          Ntu-effectiveness heat exchanger model from the ASHRAE
/// -          Toolkit.
/// -
/// -  Notes:           
/// -       In order to allow easier symbolic inversion, we express the
/// -         model slightly different from the usual Kays & London
/// -         formulation.  The interface variables are defined as if cMin
/// -         was in fact the capacity of stream 1, c1. These variables are
/// -         computable without if-then-else structures. Inside the
/// -         supporting C functions (the inverses), if cRatio is found to be
/// -         greater than 1.0 the following transformations are made to get
/// -         the "true" cRatio and Ntu, in terms of which Kays and London
/// -         developed their original eff(Ntu, cRatio) relationships:
/// -
/// -            cRatio = 1.0/cRatiop
/// -            ntu = ntup*cRatiop
/// -            eff = effp*cRatiop
/// -
/// -  Acceptable input set:  
/// -       ntup = 5, cRatiop  = 2
/// -
/// -  Equations:  
/// -       if (cRatiop < 1.0) {
/// -         cRatio = cRatiop;
/// -         ntu = ntup;
/// -      }
/// -      else {
/// -         cRatio = 1.0/cRatiop;
/// -         ntu = ntup * cRatiop;
/// -      }
/// -      if (fabs(cRatio - 1.0) <= SMALL)
/// -         eff = ntu/(ntu+1.0);
/// -      else if (fabs(cRatio) < SMALL)
/// -         eff = 1.0 - exp(-ntu);
/// -      else
/// -         eff = (1.0-exp(-ntu*(1.0 - cRatio))) /
/// -               (1.0-cRatio*exp(-ntu*(1.0 - cRatio)));
/// -      if (cRatiop < 1.0)
/// -         effp = eff;
/// -      else
/// -         effp = eff/cRatiop;///
///
///
/// -    effctr.c and ntuctr.c to support SPARK object: effctr.cc
/// -
/// -     Abstract: This is a counter flow effectiveness model for the
/// -               Ntu-effectiveness heat exchanger model from the ASHRAE
/// -               Toolkit. However, in order to allow easier symbolic
/// -               inversion, we express the model in a slightly different
/// -               form.  The interface variables are defined as if cMin was
/// -               in fact c1. These ase computable without if-then-else
/// -               structures. If cRatio is found to be greater than 1.0 the
/// -               following transformations are made to get the "true"
/// -               cRatio and Ntu in terms of which Kays and London
/// -               developed their eff(Ntu, cRatio) relationships:
/// -
/// -               cRatio = 1.0/cRatiop
/// -               ntu    = ntup * cRatiop
/// -               eff    = effp * cRatiop
/// -
/// -    Interface:
/// -          ntup:     Number of transfer units UA/c1 (dimless)
/// -          effp:     Heat exchanger modified effectiveness q/(c1*(t1 - t2)) (fraction)
/// -          cRatiop:  Ratio c1/c2
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT ntup       "Number of transfer units UA/c1"                [-]
                INIT = 1. ;
PORT effp       "Heat exchanger effectiveness q/(c1(t1 - t2))"  [-]
                INIT = 0.5    MIN = 0.0    MAX = 1.0 ;
PORT cRatiop    "Ratio c1/c2"                                   [-]
                INIT = 1. ;

FUNCTIONS {
    effp = effctr__effp( ntup, cRatiop ) ;
    ntup = effctr__ntup( effp, cRatiop ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"
#include <sstream>


EVALUATE( effctr__effp )
{
    ARGDEF(0, ntup );
    ARGDEF(1, cRatiop );
    // Local variables
    double effp;
    double cRatio, ntu,  eff, eta;

    if (cRatiop <= 1.0) {
        cRatio = cRatiop;
        ntu = ntup;
    }
    else {
        cRatio = 1.0/cRatiop;
        ntu = ntup * cRatiop;
    }

    if (fabs(cRatio - 1.0) <= SMALL)
        eff = ntu/(ntu+1.0);
    else if (fabs(cRatio) < SMALL)
        eff = 1.0 - exp(-ntu);
    else {
        eta = exp(-ntu*(1.0 - cRatio));
        eff = (1.0 - eta) / (1.0-cRatio*eta);
    }
    if (cRatiop <= 1.0)
        effp = eff;
    else
        effp = eff/ cRatiop;

    RETURN( effp ) ;
}


EVALUATE( effctr__ntup )
{
    ARGDEF(0, effp );
    ARGDEF(1, cRatiop );
    // Local variables
    double ntup;
    double cRatio, ntu,  eff, eta;

    if (cRatiop <= 1.0) {
        cRatio = cRatiop;
        eff = effp;
    }
    else {
        cRatio = 1.0/cRatiop;
        eff = effp * cRatiop;
        if (eff > 1.0) {
            // Write message to ErrorLog to notify user
            std::ostringstream Msg;
            Msg << "eff = effp * cRatio = " << double(eff) << " must be <= 1.0" << std::ends;
            ERROR_LOG( ME, Msg.str() );

            // Reset efficiency to "typical" value and continue
            // Out-of-bound value for eff probably occurred because of 
            // bad initial values !
            eff = 0.5;
        }
    }

    if (fabs(eff-1.0) < SMALL)
        ntu = LARGE;
    else if (fabs(cRatio - 1.0) <= SMALL)
        ntu = eff/(1.0 - eff);
    else if (fabs(cRatio) <= SMALL)
        ntu = log(1.0/(1.0 - eff));
    else {
        eta = (1.0 - eff)/(1.0 - cRatio*eff);
        ntu = log(1.0/eta)/(1.0 - cRatio);
    }

    if (cRatiop <= 1.0)
        ntup = ntu;
    else
        ntup = ntu / cRatiop;

    RETURN( ntup ) ;
}

