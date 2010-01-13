/// \file  boiler_parasitic.cc
/// \brief Calculates the parasitic electrical power (e.g. forced draft fan)
///

#ifdef SPARK_PARSER
 
PORT ParasiticElecLoad  [W]       "parasitic electric load (e.g. forced draft fan)";
PORT ParasiticElecPower [W]       "parasitic electrical power (e.g. forced draft fan)";
PORT PLR                [W/W]     "boiler part load ratio"; 


EQUATIONS {
    ParasiticElecPower = boiler_parasitic( ParasiticElecLoad, PLR ) ;
}

FUNCTIONS {
    ParasiticElecPower = boiler_parasitic__evaluate( ParasiticElecLoad, PLR ) ;
}

#endif /* SPARK_PARSER */


#include "spark.h"
using std::cout;
using std::endl;

EVALUATE( boiler_parasitic__evaluate )
{
    ARGUMENT( 0, ParasiticElecLoad);
    ARGUMENT( 1, PLR);

	//cout << "boiler parasitic says hi." << endl;
	
    double ParasiticElecPower = ParasiticElecLoad * PLR;

    RETURN( ParasiticElecPower );
}
