/// \file  time.cc
/// \brief 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT Lasttime	"time between two steps" ;
/// - PORT Currenttime	"current time between two steps" ;
/// - PORT timeScale "waiting time between two runs";
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// Currenttime = time_Currenttime(Lasttime, timeScale)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER


PORT Lasttime	"time between two steps" ;
PORT Currenttime	"current time between two steps" ;
PORT timeScale "waiting time between two runs";

EQUATIONS {
	
}

FUNCTIONS {
	Currenttime = time_Currenttime(Lasttime, timeScale);
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
    ARGDEF(1, timeScale);

/*
       time_t Currenttime;
   time( &Currenttime );

   double timespan =0.0;
   timespan = Currenttime-Lasttime;

   if (timespan >10000)
	timespan =timeScale;
//cout<<"timespan="<<timespan<<endl;
//cout<<"currenttime="<<Currenttime<<endl;
//cout<<"Lastime="<<Lasttime<<endl;
//cout<<"timeScale="<<timeScale<<endl;

while ((timespan<=timeScale ))
{
     double doubletime;
     doubletime =Currenttime-0.0;
     timespan = doubletime-Lasttime;
 //	printf( "Lasttime 1/1/02:\t%f\n", Lasttime );
 //	printf( "Currenttime 1/1/02:\t%f\n", doubletime );

     time( &Currenttime );

}

 // printf( "Time in seconds since UTC 1/1/02:\t%ld\n", Currenttime );
  
	double doubletime =Currenttime-0.0;
*/

//Sleep (timeScale*1000.0-50);
Sleep(1000);
RETURN (0.0);
//RETURN(doubletime) ;

}







