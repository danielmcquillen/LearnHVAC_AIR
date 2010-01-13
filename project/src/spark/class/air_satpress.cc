/// \file  air_satpress.cc
/// \brief Computes saturation pressure of water vapor 
///        as a function of temperature (Hyland & Wexler).
/// 
/// This is the relationship between temperature and pressure at
/// saturaion using an emperical curve fit psat(T) due to Hyland &
/// Wexler, as given in the 1993 ASHRAE HOF,  Eq. 6.3 and 6.4.
///
/// \warning 173.16 deg_K <= T <= 473.15 deg_K
///
///////////////////////////////////////////////////////////////////////////////
/// \par Interface variables
/// 
/// - T               Water temperature at saturation          [deg_C]
/// - p               Water pressure at saturation             [Pa]
///
///////////////////////////////////////////////////////////////////////////////
/// \par Equations
///
/// The relation SPARK::hvactk2::psat0() to derive the saturated pressure from 
/// the temperature has no explicit inverse.  
///
/// Consequently, this object uses a residual equation when a problem needs T as
/// a function of p. The advantage of this object is accuracy.
///
/// The disadvantage of using this object is that problems requiring 
/// temperature from pressure will require an additional iteration variable.
/// the temperature is converted to Kelvin using the KELV_ZERO constant from
/// file consts.h.
///
///////////////////////////////////////////////////////////////////////////////
/// \par History
/// 
/// - 051211 Dimitri Curtil (LBNL)
///     - Reengineered to improve numerical robustness and reusability.
///     - Enforced naming convention. 
///     - Updated doxygen-compatible comments.
/// - 050720 Chadi Maalouf (LEPTAB)
///     - Initial implementation.
///
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER

PORT T  "Water temperature at saturation"  [deg_C]
        INIT = 20.0    
        MIN = -50.0    
        MAX = 95.0    
        INIT = 20    
        MATCH_LEVEL=4;
PORT p  "Water pressure at saturation" [Pa]
        INIT = 101325      
        MIN = 0    
        MAX = 110000     
        MATCH_LEVEL=6;


FUNCTIONS {
        p = air_satpress__explicit( T ) ;
        T = RESIDUAL air_satpress__residual( p, T ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include "hvactk2.h"

/// \namespace air_satpress
/// \brief Private namespace for functions used to implement the callbacks in the atomic class air_satpress.cc
namespace air_satpress {
    
    /// \brief  Computes the saturated pressure from saturated temperature (Hyland & Wexler) 
    inline double psat0(double t)
    {
        double p ;
        const double c1 = -5674.5359,     c2  = 6.3925247,
                     c3 = -0.9677843e-2,  c4  = 0.62215701e-6,
                     c5 = 0.20747825e-8,  c6  = -0.9484024e-12,
                     c7 = 4.1635019,      c8  = -5800.2206,
                     c9 = 1.3914993,      c10 = -0.048640239,
                     c11 = 0.41764768e-4, c12 = -0.14452093e-7,
                     c13 = 6.5459673;
        
        // Correlation is in Kelvin & Pascals
		double t_k = t + SPARK::hvactk2::KELV_ZERO; 
        
		// Over ice
		if (t_k < SPARK::hvactk2::KELV_ZERO) {
            p = exp(c1/t_k+c2+t_k*(c3+t_k*(c4+t_k*(c5+c6*t_k))) +c7*log(t_k));
		}
        // Over water
		else {
            p = exp(c8/t_k+c9+t_k*(c10+t_k*(c11+t_k*c12)) + c13*log(t_k));
		}
        
		return p ;
    }
}; // namespace air_satpress

    
/// \name Inverse for (pressure)
//@{
/// \brief  Evaluate callback for port p
EVALUATE( air_satpress__explicit )
{
    ARGUMENT(0, T );

    double p = air_satpress::psat0(T);
    RETURN( p ) ;
}
//@}

/// \name Inverse for (temperature)
//@{
/// \brief  Evaluate callback for port T
///
/// \note Residual form.
EVALUATE( air_satpress__residual )
{
    ARGUMENT(0, p );
    ARGUMENT(1, T );

    double Residual = air_satpress::psat0(T) - p;
    RETURN( Residual );
}
//@}

