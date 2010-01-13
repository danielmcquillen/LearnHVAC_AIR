/// \file  read.cc
/// \brief SPARK read object  
///
///  Abstract:        
///       read an voltage value to A/D board
///  Acceptable input set:  
///       chan=0
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT Ainput	"analog input" ;
/// - PORT chan   "channel number";
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// Ainput = read_read( chan )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER



PORT Ainput	"analog input" ;
PORT chan   "channel number";


EQUATIONS {
	AInput= f(chan);
}

FUNCTIONS {
	Ainput = read_read( chan ) ;
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include "cbw.h"
#include <stdio.h>
#include <conio.h>
#include <windows.h>



///////////////////////////////////////////////////////////
EVALUATE(read_read ) 
{
    ARGDEF(0, Chan);
    double AInput;


	int BoardNum = 1;
    int UDStat = 0;
    int Gain = BIP10VOLTS;
    WORD DataValue = 0;
    float    EngUnits;
    float    RevLevel = (float)CURRENTREVNUM;

  /* Declare UL Revision Level */
	UDStat = cbDeclareRevision(&RevLevel);

    /* Initiate error handling
        Parameters:
            PRINTALL :all warnings and errors encountered will be printed
            STOPALL  :if any error is encountered, the program will stop */
    cbErrHandling (PRINTALL, STOPALL);

	UDStat = cbAIn (BoardNum, Chan, Gain, &DataValue);
    UDStat = cbToEngUnits (BoardNum, Gain, DataValue, &EngUnits);
	
	AInput = (double)EngUnits;	

    RETURN(AInput);
}
///////////////////////////////////////////////////////////











