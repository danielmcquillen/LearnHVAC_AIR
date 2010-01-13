/// \file  pause.cc
/// \brief 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT Lasttime	"time between two steps" ;
/// - PORT Currenttime	"current time between two steps" ;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// Currenttime = time_Currenttime(Lasttime)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER


PORT Lasttime	"time between two steps" ;
PORT Currenttime	"current time between two steps" ;

EQUATIONS {
	c = a + b ;
}

FUNCTIONS {
	Currenttime = time_Currenttime(Lasttime);
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include <time.h>
//#include <iostream.h>
#include <windows.h>
///////////////////////////////////////////////////////////
EVALUATE  (time_Currenttime)
{
    ARGDEF(0, Lasttime);

double result =0.0;

result = 1000/Lasttime;

//cout<<"Lasttime="<<Lasttime<<endl;
//cout<<"result="<<result<<endl;
Sleep (result);

RETURN(result);

}
///////////////////////////////////////////////////////////



















