/// \file  caprateDry.cc
/// \brief Dry air capacitance rate 
///         Includes simple anti-windup and limiting of the output to the range 0-1
///
/// Abstract:        
///       Calculates capacitance rate for moist air heat exchanger.
///
///  Notes:           
///       Used in airhx.ob.
///
///  Acceptable input set:  
///       mAir = 1, w = 0.01
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT mAir	"Dry air mass flow rate"		[kg_dryAir/s]
/// - 		INIT = 1	MIN = 0	MAX = 1000 ;
/// - PORT cap	"Capacitance rate"			[W/deg_C] ;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// cap = mAir * (CP_AIR + w * CP_VAP)
/// \endcode
///
/// \code
/// cap  = cap_ratedry__cap( mAir  )
/// \endcode
///
/// \code
/// mAir = cap_ratedry__mAir( cap )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

PORT mAir	"Dry air mass flow rate"		[kg_dryAir/s]
		INIT = 1	MIN = 0	MAX = 1000 ;
PORT cap	"Capacitance rate"			[W/deg_C] ;


EQUATIONS {
	cap = mAir * (CP_AIR + w * CP_VAP) ;
}

FUNCTIONS {
        cap  = cap_ratedry__cap( mAir  ) ;
        mAir = cap_ratedry__mAir( cap ) ;

}

#endif /* SPARK_PARSER */
#include "spark.h"

EVALUATE( cap_ratedry__cap )
{
	ARGDEF( 0, mAir );
	double w =0.0;
	double cap;

	cap = mAir * (CP_AIR + w * CP_VAP);
	RETURN(  cap ) ;
}

EVALUATE( cap_ratedry__mAir )
{
	ARGDEF( 0, cap );
	double w =0.0;
	double mAir;

	mAir = cap / (CP_AIR + w * CP_VAP);
	RETURN(  mAir ) ;
}


