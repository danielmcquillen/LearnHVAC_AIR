/// \file  write.cc
/// \brief SPARK write object  
///
///  Abstract:        
///       write an voltage value to D/A board
///  Acceptable input set:  
///       a=2, chan=0
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT a		"value to write to board" ;
/// - PORT Output	"return value of what was wrote" ;
/// - PORT chan   "channel number";
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// Output=a
/// \endcode
///
/// \code
/// Output = write_write( a, chan )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER


PORT a		"value to write to board" ;
PORT Output	"return value of what was wrote" ;
PORT chan   "channel number";


EQUATIONS {
	Output=a;
}

FUNCTIONS {
	Output = write_write( a, chan ) ;
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include "cbw.h"
#include <stdio.h>
#include <conio.h>
#include <windows.h>


///////////////////////////////////////////////////////////
EVALUATE(write_write) 
{
    ARGDEF(0, a);
    ARGDEF(1, chan0);

    int BoardNum = 1;
    int ULStat = 0;
    int Gain = UNI5VOLTS;
    int Chan, ExitFlag;
    WORD DataValue;
    float EngUnits;
    float    RevLevel = (float)CURRENTREVNUM;

  /* Declare UL Revision Level */
   ULStat = cbDeclareRevision(&RevLevel);

    /* Initiate error handling
        Parameters:
            PRINTALL :all warnings and errors encountered will be printed
            DONTSTOP :program will continue even if error occurs.
                     Note that STOPALL and STOPFATAL are only effective in 
                     Windows applications, not Console applications. 
   */
    cbErrHandling (PRINTALL, DONTSTOP);

	EngUnits = a;
    ExitFlag = FALSE;
    Chan = chan0;
    ULStat = cbFromEngUnits(BoardNum, Gain, EngUnits, &DataValue);
    ULStat = cbAOut (BoardNum, Chan, Gain, DataValue);
	DataValue = a;
	double Output = DataValue;

    RETURN(Output);
}
///////////////////////////////////////////////////////////





