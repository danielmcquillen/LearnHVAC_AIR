/// \file effc1u.cc
/// \brief Ntu-effectiveness, stream 1 unmixed  
///
///  Abstract:        
///       This is the cross flow, first stream unmixed, effectiveness
///          model for a Ntu-effectiveness heat exchanger model from the
///          ASHRAE Toolkit.
///
///  Notes:           
///       In order to allow easier symbolic inversion, we express the
///         model slightly different from the usual Kays & London
///         formulation.  The interface variables are defined as if cMin
///         was in fact the capacity of stream 1, c1. These variables are
///         computable without if-then-else structures. Inside the
///         supporting C functions (the inverses), if cRatio is found to be
///         greater than 1.0 the following transformations are made to get
///         the "true" cRatio and Ntu, in terms of which Kays and London
///         developed their original eff(Ntu, cRatio) relationships:
///
/// -             cRatio = 1.0/cRatiop
/// -             ntu = ntup*cRatiop
/// -             eff = effp*cRatiop
///
///  Interface:       
/// -      ntup:     Reference number of transfer units UA/c1 (dimless)
/// -      effp:     Reference heat exchanger effectiveness q/(c1(t1 - t2))(fraction)
/// -      cRatiop:  Reference ratio c1/c2
///
///  Acceptable input set:  
/// -       ntup = 5, cRatiop  = 2
///
///  Equations:  
/// -       if (cRatiop < 1.0) {
/// -         cRatio = cRatiop;
/// -         ntu = ntup;
/// -      }
/// -      else {
/// -         cRatio = 1.0/cRatiop;
/// -         ntu = ntup * cRatiop;
/// -      }
/// -      if (fabs(cRatio) < SMALL)
/// -         eff = 1.0 - exp(-ntu);
/// -      else
/// -         eff = (cRatiop < 1.0) ? (1.0-exp(-cRatio*(1.0-exp(-ntu))))/cRatio:
/// -                                               1.0-exp(-(1.0-exp(-ntu*cRatiop))/cRatiop);
/// -      if (cRatiop < 1.0)
/// -         effp = eff;
/// -      else
/// -         effp = eff/ cRatiop;
///
///
///
///         NOTE:  This needs further study.  Must go back to Kays & London
///                to check basic formulas.... Toolkit subroutine looks
///                strange.  Also,  maybe it should be written directly in
///                terms of c1 instead of cmin etc. EFS 1/21/95
///
///        Abstract: This is cross flow, first stream (c1) unmixed,
///              Ntu-effectiveness model for a heat exchanger from the
///              ASHRAE Toolkit. However, in order to allow easier symbolic
///              inversion, we express the model in a slightly different
///              form.  The interface variables are defined as if cMin was
///              in fact c1. These ase computable without if-then-else
///              structures. If cRatio is found to be greater than 1.0 the
///              following transformations are made to get the "true"
///              cRatio and Ntu in terms of which Kays and London developed
///              their eff(Ntu, cRatio) relationships:
///
/// -                     cRatio = 1.0/cRatiop
/// -                     ntu    = ntup * cRatiop
/// -                     eff    = effp * cRatiop
///
///   Interface:
/// -         ntup:     Modified number of transfer units UA/c1 (dimless)
/// -         effp:     Heat exchanger modified effectiveness q/(c1*(t1 - t2))(fraction)
/// -         cRatiop:   Ratio c1/c2
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////

 
#ifdef SPARK_PARSER


PORT ntup       "Reference number of transfer units UA/c1"               [-]
                INIT = 1 ;
PORT effp       "Reference heat exchanger effectiveness q/(c1(t1 - t2))" [-]
                INIT = 0.5    MIN = 0.0    MAX = 1.0 ;
PORT cRatiop    "Reference ratio c1/c2"                                  [-]
                INIT = 1 ;

FUNCTIONS {
    effp = effc1u__effp( ntup, cRatiop ) ;
    ntup = effc1u__ntup( effp, cRatiop ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"
#include <sstream>


EVALUATE( effc1u__effp )
{
    ARGDEF(0, ntup );
    ARGDEF(1, cRatiop );
    // Local variables
    double effp;
    double cRatio, ntu,  eff;

    if (cRatiop <= 1.0) {
        cRatio = cRatiop;
        ntu = ntup;
    }
    else {
        cRatio = 1.0/cRatiop;
        ntu = ntup * cRatiop;
    }

    if (ntu < SMALL)
        eff = 0.0;
    else if (fabs(cRatio) < SMALL)
        eff = 1.0 - exp(-ntu);
    else
        eff = cRatio <= 1.0 ?
              (1.0-exp(-cRatio*(1.0-exp(-ntu))))/cRatio:
              1.0-exp(-(1.0-exp(-ntu*cRatiop))/cRatiop);
    if (cRatiop <= 1.0)
        effp = eff;
    else
        effp = eff/ cRatiop;

    RETURN( effp  ) ;
}


EVALUATE( effc1u__ntup )
{
    ARGDEF(0, effp );
    ARGDEF(1, cRatiop );
    // Local variables
    double ntup;
    double cRatio, ntu,  eff, eta;

    if (cRatiop <= 1.0) {
       cRatio = cRatiop;
       eff    = effp;
    }
    else {
        cRatio = 1.0/cRatiop;
        eff    = effp * cRatiop;
        if (eff > 1.0) {
            std::ostringstream Msg;

            Msg << "eff = effp * cRatio = " << double(eff) << " must be <= 1.0" << std::ends;
            ERROR_LOG( ME, Msg.str() );

            // Reset efficiency to "typical" value and proceed.
            // Out-of-bound value for eff probably occurred because of 
            // bad initial values !
            eff = 0.5;
       }
    }

    if (fabs(cRatio) < SMALL)
        ntu = ((1.0-eff) > SMALL) ? log(1.0/(1.0 - eff)) : SMALL;
    else {
        if (cRatio <= 1.0) {
            eta = 1.0 - log(1.0/(1.0 - eff*cRatio))/cRatio;
            if (eta <= 0.0) {
                std::ostringstream Msg;
                Msg << "Error 1: " << std::endl
                    << "   eff    = " << double(eff) << std::endl
                    << "   cRatio = " << double(cRatio) << std::endl
                    << "   eta    = " << double(eta) << std::ends;
                ERROR_LOG( ME, Msg.str() );
            }
            else
            ntu = log(1.0/eta);
         }
         else {
            eta = 1.0 - log(1.0/(cRatio*(1.0 - eff)));
            if (eta <= 0.0) {
                std::ostringstream Msg;
                Msg << "Error 2: " << std::endl
                    << "   eff    = " << double(eff) << std::endl
                    << "   cRatio = " << double(cRatio) << std::endl
                    << "   eta    = " << double(eta) << std::ends;
                ERROR_LOG( ME, Msg.str() );

                // Reset efficiency to "typical" value and continue
                // Out-of-bound value for eff probably occurred because of 
                // bad initial values !
                eff = 0.5;
            }
            else
                ntu = log(1.0/eta)/cRatio;
         }
    }
    if (cRatiop <= 1.0)
        ntup = ntu;
    else
        ntup = ntu / cRatiop;

    RETURN( ntup ) ;
}

