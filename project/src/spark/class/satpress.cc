/// \file  satpress.cc
/// \brief Saturated pressure relationship for water.
/// 
/// Relationship between temperature and pressure at saturaion.
/// Uses an emperical curve fit pwsdb(t) given by G. Walton in
/// TARP.  SI units.
/// 
///////////////////////////////////////////////////////////////////////////////
/// \par Notes:           
///
/// The advantage of this object over satp_hw, which employes the
/// Hyland & Wexler empirical relationship, is that Walton also
/// gives an inverse correlation, dbpws(p),  allowing problem
/// solutions without introducing T as an iteration variable.
/// 
/// Acceptable input set:  
///     T = 20
/// 
///////////////////////////////////////////////////////////////////////////////
/// \par Equations:  
///
/// \code
/// P = pwsdb(T)
/// \endcode
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

PORT T    "Water temperature at saturation"    [deg_C]
                INIT = 20.0    MIN = -50.0    MAX = 95.0 ;
PORT P    "Water pressure at saturation"       [Pa]
                INIT = 101325    MIN = 0        MAX = 110000 ;

FUNCTIONS {
       P = satpress__P( T ) ;
       T = satpress__T( P ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk.h"

/*
 *                 Functions to support satpress.cc
 *     Abstract:  Employs the correlations from George Walton's
 *                TARP program.  See psat also.
 *     Interface:  P(t), T(P)
 *               t:  Saturation temperature (deg-C)
 *               p:  Saturation pressure (Pascals)
 *
 */
/* Helper functions: */
static double  PS ( short P_FLAG, double T ) ;
static short   PS_FLAG ( double TEMP ) ;
static double  TS ( short T_FLAG, double P ) ;
static short   TS_FLAG ( double PRES ) ;
/* Helper functions: END */

/*static const double    CONV1 = 2.952973e-4; /* Use these for IP units*/
/*static const double    CONV2 = 32.0;        /* Use these for IP units*/
/*static const double    CONV3 = 1.8;         /* Use these for IP units*/
static const double CONV1 = 1.0;           /* Use these for SI units*/
static const double CONV2 = 0.0;           /* Use these for SI units*/
static const double CONV3 = 1.0;           /* Use these for SI units*/


EVALUATE( satpress__T )
{
    ARGDEF( 0, P ) ;
    double PS, TS_POLY;
    short T_FLAG ;
    double T;

    if (P > SMALL) {
        PS = P / CONV1;
        T_FLAG = TS_FLAG(PS);
        TS_POLY = TS(T_FLAG, PS);
        T = CONV3 * TS_POLY + CONV2;
    }
    else
        T = -LARGE;

    RETURN(  T ) ;
}


EVALUATE( satpress__P )
{
    ARGDEF( 0, T ) ;
    double PS_POLY, TS;
    short P_FLAG ;
    double P;
    
    TS = (T - CONV2) / CONV3;
    P_FLAG = PS_FLAG(TS);
    if (P_FLAG == 10)
        TS = -70.0;
    if (P_FLAG == 11)
        TS = 100.0;
    PS_POLY = PS(P_FLAG, TS);
    P = CONV1 * PS_POLY;
    
    RETURN(  P ) ;
}  /* End of PSWDB */


short PS_FLAG ( double TEMP )
{
    /* Sets case number for a given temperature */
    /* Used by pwsdb */
    short Result ;
    
    if (TEMP < -70)   /* temperature is -70 degrees C */
        Result = 10;
    else if ( TEMP < -60)
        Result = 1;
    else if ( TEMP < -50)
        Result = 2;
    else if ( TEMP < -35)
        Result = 3;
    else if (TEMP < -20)
        Result = 4;
    else if ( TEMP < 0)
        Result = 5;
    else if (TEMP < 20)
        Result = 6;
    else if (TEMP < 40)
        Result = 7;
    else if (TEMP < 70)
        Result = 8;
    else if (TEMP < 100)
        Result = 9;
    else   /* temperature is 100 degrees C */
        Result = 11;
    
    return  Result ;
}


static double  PS ( short P_FLAG, double T )
{
    /* Evaluates by Ploynomial */
    /* Used by pwsdb */
    short J;
    double y;
    static double a[11][5] = {
        {187.72756,
        9.7388459,
        0.19227592,
        0.0017092958,
        5.7638449e-6},
        
        {304.327455,
        17.544515,
        0.38850839,
        0.0039049250,
        1.4989099e-5},
        
        {456.91552,
        30.071980,
        0.77543816,
        0.0092327737,
        4.2579887e-5},
        
        {578.24965,
        43.849126,
        1.3678040,
        0.020662996,
        0.00012607288},
        
        {611.12442,
        50.242069,
        1.8540594,
        0.037851608,
        0.00036358829},
        
        {617.57030,
        44.857183,
        1.4599520,
        0.024895806,
        0.00041888641},
        
        {674.80450,
        34.735044,
        2.1525746,
        0.0029183585,
        0.00069389647},
        
        {1882.1549,
        -75.905764,
        6.0054813,
        -0.057650288,
        0.0010572251},
        
        {10003.937,
        -537.34244,
        15.931817,
        -0.15349268,
        0.0014076596},
        
        {187.72756,
        9.7388459,
        0.19227592,
        0.0017092958,
        5.7638449e-6},
        
        {10003.937,
        -537.34244,
        15.931817,
        -0.15349268,
        0.0014076596}
    };
    y = 0.0;
    for (J = 4; J >= 0; J--)
        y = a[P_FLAG - 1][J] + T * y;
    
    return  y ;
}


static short  TS_FLAG ( double PRES )
{
    /* Sets case number for a given pressure */
    short Result;
    
    if (PRES < 1.08000)
        Result = 1;
    else if (PRES < 3.94000)
        Result = 2;
    else if (PRES < 22.3500)
        Result = 3;
    else if (PRES < 103.260)
        Result = 4;
    else if (PRES < 617.560)
        Result = 5;
    else if (PRES < 2364.90)
        Result = 6;
    else if (PRES < 7471.50)
        Result = 7;
    else if (PRES < 31605.7)
        Result = 8;
    else
        Result = 9;
    
    return  Result ;
}


static double  TS ( short T_FLAG, double P )
{
  short J;
  double y;
  static double a[9][7] = {
  {-80.481222,
  60.488509,
  -104.02603,
  116.27016,
  -70.240148,
  17.403927,
  0.0},
  {-71.907528,
  17.059641,
  -7.6219223,
  2.2337690,
  -0.35643002,
  0.023469826,
  0.0},
  {-62.643477,
  4.8931575,
  -0.58140203,
  0.047441082,
  -0.0023302718,
  6.2036235e-5,
  -6.8559241e-7},
  {-50.166219,
  1.0796773,
  -0.025433803,
  0.00041771901,
  -4.1788472e-6,
  2.28788e-8,
  -5.2415828e-11},
  {-36.261166,
  0.23970771,
  -0.0010835426,
  3.3697165e-6,
  -6.2986874e-9,
  6.3667218e-12,
  -2.6646050e-15},
  {-21.4716785,
  0.052658152,
  -3.8998869e-5,
  1.9227789e-8,
  -5.1661347e-12,
  5.7225294e-16,
  0.0},
  {-6.2548222,
  0.017442339,
  -3.7406571e-6,
  5.4267058e-10,
  -4.3379212e-14,
  1.4427502e-18,
  0.0},
  {9.3624054,
  0.0065309333,
  -4.6769042e-7,
  2.4048849e-11,
  -7.603404e-16,
  1.3232127e-20,
  -9.6773935e-26},
  {33.328934,
  0.0017898571,
  -2.7520024e-8,
  2.8970085e-13,
  -1.6828604e-18,
  4.0679479e-24,
  0.0}
  };
  y = 0.0;
  for (J = 6; J >= 0; J--)
    y = a[T_FLAG - 1][J] + P * y;

  return  y ;
}

