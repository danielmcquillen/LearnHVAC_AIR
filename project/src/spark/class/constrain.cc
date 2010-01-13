/// \file  constrain.cc
/// \brief constrain an input to range (min,max) 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - PORT	in   "input"   [scalar];
/// - PORT	out  "output"  [scalar];
/// - PORT	output_min  "lower bound" [scalar];
/// - PORT    output_max  "upper bound" [scalar];
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// out = constrain(in,output_min,output_max)
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef	spark_parser

PORT	in   "input"   [scalar];
PORT	out  "output"  [scalar];
PORT	output_min  "lower bound" [scalar];
PORT    output_max  "upper bound" [scalar];

FUNCTIONS {
	out = constrain(in,output_min,output_max);
}

#endif /* SPARK_TEXT */
#include "spark.h"

EVALUATE( constrain)
{

ARGDEF(0, in); 
ARGDEF(1, output_min); 
ARGDEF(2, output_max); 

   double result;

   if (in < output_min)
      result = output_min;
   else if (in > output_max)
      result = output_max;
   else
      result = in;

   RETURN (result);
}



