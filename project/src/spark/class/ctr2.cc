/*+++
  Identification:  Cooling tower Fr vs. approach  dependency
                          ctr2.cc

  Abstract:        
       The correlation of cooling tower rating factor, Fr, vs. wet
           bulb temperature, approach temperature difference, and water
           temperature drop (range) is split into two parts.  The
           second,  modeled in this object, accounts for the dependency
           of Frr on approach temperature and wet bulb.

  Notes:           
       A "soft"  unit conversion has been done to allow SI at the
           interface.  The interface temperatures are converted from C
           to F,  and the Fr calculated by the DOE-2 correleation Fr is
           multiplied by (60 sec/min* 7.48 gal/ft3)/(62.4 lb/ft3 * 0.454
           kg/lb) to get an SI Fr. This conversion factor is called K in
           the model.  The over-all correlation in English IP units is:
           log(Fr_IP) = r1 + r2 where r1 and r2 are the two separate
           correlations.  In SI we then have:

           Fr_SI = K * Fr_IP
           log(Fr_SI) = log( K*Fr_IP)
           log(Fr_SI) = logK + r1 + r2
           log(Fr_SI) = (logK/2 + r1) + (logK/2 + r2)

           The coefficients for the correlations are taken from the
           DOE-2 User's Manual, Table V.6.

  Acceptable input set:  
       TWb = 18,  app = 5

---*/
#ifdef SPARK_PARSER

PORT TWb    "Ambiant {outside} air wet bulb temperature"                [deg_C]
                INIT = 20    MIN = -50    MAX = 50 ;
PORT r2     "Approach-dependent component of log"                       []
                INIT = 1 ;
PORT app    "Difference between leaving water temperature and wetbulb"  [deg_C]
                INIT = 20    MIN = -50    MAX = 50 ;


EQUATIONS {
    r2 =  b1 + b2*app + b3*app^2 + b4*TWb +b5*TWb^2 +b6*app*TWb ;
}

FUNCTIONS {
    r2    = ctr2__r2( app, TWb ) ;
    app    = ctr2__app( r2, TWb ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include <sstream>

#ifndef SI
# define  SI
#endif
#ifdef SI
#     define  logK 1.199843
      /* K = 15.842 = SEC_PER_MIN * GAL_PER_FT3/(RHO_WATER * KG_PER_LB) */
#     define  T_BASE 32.0
#     define  T_FACT 1.8
#else
#     define  logK 0.0
    /* K = 15.842 = SEC_PER_MIN * GAL_PER_FT3/(RHO_WATER * KG_PER_LB) */
#     define  T_BASE 0.0
#     define  T_FACT 1.0
#endif


static const double b1 =  0.895328;
static const double b2 = -0.116550;
static const double b3 =  0.001917;
static const double b4 = -0.001040;
static const double b5 = -0.000026;
static const double b6 =  0.000398;


EVALUATE( ctr2__r2 )
{
    ARGDEF(0, app );
    ARGDEF(1, tWB );
    // Local variables
    double r2;
    double tWB_f, app_f;

    tWB_f = T_BASE + tWB*T_FACT;
    app_f = app*T_FACT;
    r2 = logK/2.0 + b1 + b2*app_f + b3*app_f*app_f + b4*tWB_f +b5*tWB_f*tWB_f
         +b6*app_f*tWB_f;
    
    RETURN( r2 ) ;
}


EVALUATE( ctr2__app )
{
    ARGDEF(0, r2 );
    ARGDEF(1, tWB );
    // Local variables
    double app;
    double tWB_f, b, c, d;

    tWB_f = T_BASE + tWB*T_FACT;
    b = b2 + b6*tWB_f;
    c = logK/2.0 + b1 - r2 + b4*tWB_f +b5*tWB_f*tWB_f;
    d = b*b -4.0*b3*c;
    
    if (d>=0.0) {
        /* assume its the negative root */
        app = (-b-sqrt(d))/(2.0*b3*T_FACT);
    }
    else {
        std::ostringstream Msg;
        Msg << "Negative arg to sqrt in cooling tower ctr2_app." << std::endl
            << "   b  = " << b << std::endl
            << "   b3 = " << b3 << std::endl
            << "   c  = " << c << std::endl
            << "   tWB_f  = " << tWB_f << std::endl
            << "   TWB SI = " << tWB << std::endl
            << "   r2     = " << r2 << std::ends;

        REQUEST__ABORT_SIMULATION( Msg.str() );
    }

    RETURN( app ) ;
}

