/// \file  boiler_fuel.cc
/// \brief Calculates the fuel used using a second order polynomial fit
///        of performance data to obtain part load performance
///

#ifdef SPARK_PARSER
 
PORT FuelUsed           [W]       "fuel used";
PORT TheorFuelUsed      [W]       "theoretical (stoichiometric) fuel used";

PORT C1                           "first coefficient of the fuel use/part load curve";
PORT C2                           "second coefficient of the fuel use/part load curve";
PORT C3                           "third coefficient of the fuel use/part load curve";

PORT PLR                [W/W]     "boiler part load ratio"; 


EQUATIONS {
    FuelUsed = boiler_fuel( 
        TheorFuelUsed,
        C1, 
        C2, 
        C3, 
        PLR ) ;
}

FUNCTIONS {
    FuelUsed = boiler_fuel__evaluate( 
        TheorFuelUsed,
        C1, 
        C2, 
        C3, 
        PLR ) ;
}

#endif /* SPARK_PARSER */


#include "spark.h"
using std::cout;
using std::endl;

EVALUATE( boiler_fuel__evaluate )
{
    ARGUMENT( 0, TheorFuelUsed);
    ARGUMENT( 1, C1);
    ARGUMENT( 2, C2);
    ARGUMENT( 3, C3);
    ARGUMENT( 4, PLR);

	//cout << "boiler fuel says hi." << endl;
	
    double PLR_oper = PLR;
    double FuelUsed = TheorFuelUsed / ( C1 + C2*PLR_oper + C3*PLR_oper*PLR_oper );

    RETURN( FuelUsed );
}


