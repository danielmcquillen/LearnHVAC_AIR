/// \file  runcontrol.cc
/// \brief SPARK run control 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - CLASSTYPE SINK;
/// - PORT SPARKRUN
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// COMMIT = fn_commit1(SPARKRUN)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

CLASSTYPE SINK;


PORT SPARKRUN;


EQUATIONS {

}

FUNCTIONS {
	COMMIT = fn_commit1(SPARKRUN);
}  


#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
//#include <iostream.h>

//#include <stdexcept>


///////////////////////////////////////////////////////////
COMMIT (fn_commit1)
{
ARGDEF(0, SPARKRUN);


if (SPARKRUN ==0.0){
//cout<<"SPARKRUN="<<SPARKRUN<<endl;
REQUEST__ABORT_SIMULATION( "SPARK has been aborted" );
}

//if (SPARKRUN ==2)
//REQUEST__STOP_SIMULATION( "SPARK has been stopped" );

//if (SPARKRUN==3)
//REQUEST__RESTART_SIMULATION( "SPARK has been started" );



}
///////////////////////////////////////////////////////////























































































