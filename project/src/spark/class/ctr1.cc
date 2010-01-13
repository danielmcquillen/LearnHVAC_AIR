/*+++
  Identification:  Cooling tower Fr vs. range dependency
                          ctr1.cc

  Abstract:        
       The correlation of cooling tower rating factor, Fr, vs. wet
           bulb temperature, approach temperature difference, and water
           temperature drop (range) is split into two parts.  The first,
           modeled in this object, accounts for the dependency of Fr on
           range and wet bulb.

  Notes:           
       A "soft"  unit conversion has been done to allow SI at the
           interface.  The interface temperatures are converted from C
           to F,  and the Fr calculated by the DOE-2 correleation Fr is
           multiplied by (60 sec/min* 7.48 gal/ft3)/(62.4 lb/ft3 * 0.454
           kg/lb) to get an SI Fr. This conversion factor is called K in
           the model.  The the over-all correlation in English IP units
           is: log(Fr_IP) = r1 + r2 where r1 and r2 are the two separate
           correlations.  In SI we then have:

            Fr_SI = K * Fr_IP
            log(Fr_SI) = log( K*Fr_IP)
            log(Fr_SI) = logK + r1 + r2
            log(Fr_SI) = (logK/2 + r1) + (logK/2 + r2)

           The coefficients for the correlations are taken from the
           DOE-2 User's Manual, Table V.6.

  Acceptable input set:  
       TWb = 18,  R = 10

---*/
#ifdef SPARK_PARSER

PORT TWb    "Ambiant {outside} air wet bulb temperature"    [deg_C]
                INIT = 20    MIN = -50    MAX = 95 ;
PORT r1     "R-dependent component of log"                  []
                INIT = 1 ;
PORT R      "Range (water temperature drop)"                [deg_C]
                INIT = 20    MIN = -50    MAX = 95 ;

EQUATIONS {
    r1 =  a1 + a2*R + a3*R^2 + a4*TWb +a5*TWb^2 +a6*R*TWb ;
}

FUNCTIONS {
    r1 = ctr1__r1( R, TWb ) ;
    R  = ctr1__R( r1, TWb ) ;
}


#endif /* SPARK_PARSER */
#include "spark.h"

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

static const double a1 =  1.484326;
static const double a2 =  0.129479;
static const double a3 = -0.004014;
static const double a4 = -0.054336;
static const double a5 =  0.000312;
static const double a6 = -0.000147;


EVALUATE( ctr1__r1 )
{
    ARGDEF(0, R );
    ARGDEF(1, tWB );
    // Local variables
    double r1;
    double tWB_f, R_f;
    
    tWB_f = T_BASE + tWB*T_FACT;
    R_f = R*T_FACT;
    r1 = logK/2.0 + a1 + a2*R_f + a3*R_f*R_f + a4*tWB_f +a5*tWB_f*tWB_f
                        +a6*R_f*tWB_f;
    RETURN( r1 ) ;
}


EVALUATE( ctr1__R )
{
    ARGDEF(0, r1 );
    ARGDEF(1, tWB );
    // Local variables
    double R;
    double tWB_f, b, c, d;

    tWB_f = T_BASE + tWB*T_FACT;
    b = a2 + a6*tWB_f;
    c = logK/2.0 + a1 -r1 + a4*tWB_f +a5*tWB_f*tWB_f;
    d = b*b -4.0*a3*c;
    
    if (d >= 0.0) {
        R = (-b+sqrt(d))/(2.0*a3*T_FACT);
    }
    else {
        std::ostringstream Msg;
        Msg << "Negative arg to sqrt in cooling tower ctr1_R." << std::endl
            << "   b  = " << b << std::endl
            << "   a3 = " << a3 << std::endl
            << "   c  = " << c << std::endl
            << std::ends;

        REQUEST__ABORT_SIMULATION( Msg.str() );
    }

    RETURN( R ) ;
}

