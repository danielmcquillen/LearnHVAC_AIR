/// \file  AirCFM.cc
/// \brief  
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT q		"heat transfer rate" ;
/// - PORT TRoom		"room air temperature" ;
/// - PORT TSup		"Supply air temperature" ;
/// - PORT mAirDes	"Desired mair" ;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// mAirDes = q/(T1 - T2)*Cp
/// \endcode
///
/// \code
/// mAirDes = mAirDes( q, TRoom, TSup )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

PORT q		"heat transfer rate" ;
PORT TRoom		"room air temperature" ;
PORT TSup		"Supply air temperature" ;
PORT mAirDes	"Desired mair" ;

EQUATIONS {
	mAirDes = q/(T1 - T2)*Cp ;
}

FUNCTIONS {
	mAirDes = mAirDes( q, TRoom, TSup ) ;
}

#endif /* SPARK_PARSER */
#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>

EVALUATE( mAirDes )
{
    ARGDEF(0, q ) ;
    ARGDEF(1, TRoom ) ;
    ARGDEF(2, TSup ) ;
        double mAirDes;

        mAirDes = q/ ((TRoom-TSup)*1000.0);
       

	//cout<<"QmAirDes="<<mAirDes<<endl;
	//cout<<"Qq="<<q<<endl;
	//cout<<"QTRoom="<<TRoom<<endl;
	//cout<<"QTSup="<<TSup<<endl;

	 RETURN(  mAirDes ) ;
}
