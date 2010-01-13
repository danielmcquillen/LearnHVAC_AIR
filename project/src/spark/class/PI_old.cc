// Simple discrete-time PI controller - sampling interval = time-step(assumed fixed)  
// Includes simple anti-windup and limiting of the output to the range 0-1

// P Haves 11/11/07

#ifdef	spark_parser

PORT  w    [-]    "set-point";
PORT  y    [-]    "measured variable";
PORT  iP   [-]    "previous value of integral term";
PORT  Kp   [-]    "proportional gain";
PORT  Ki   [1/s]  "integral gain";
PORT  fr   [-]    "override (0), forward (+1) or reverse (-1) acting";
PORT  bias [-]    "offset, output in open loop";
PORT  dt   [s]    "time step";

// OUTPUT
PORT  u   [-]     "control signal";
PORT  i   [-]  	  "integral term";


FUNCTIONS {
	u,i = PI(w,y,iP,Kp,Ki,fr,bias,dt);
}

#endif /* SPARK_TEXT */
#include "spark.h"
//#include <iostream.h>

EVALUATE (PI)
{
 ARGDEF( 0,w);
 ARGDEF( 1,y);
 ARGDEF( 2,iP);
 ARGDEF( 3,Kp);
 ARGDEF( 4,Ki);
 ARGDEF( 5,fr);
 ARGDEF( 6,bias);
 ARGDEF( 7,dt);
 
 //outputs
   double u;
   double i;
//local variables
   double e;

   if (fr == 0.0 ) {
      // override PI control for open loop operation
      u = bias;
	  i = 0.0;
   } else {
      // normal operation
	  e = w-y          ;        // control error
	  i = iP+fr*Ki*e*dt     ;   // update integral term
      u = fr*Kp*e + i + bias;   // unclipped output
	  if (u > 1.0) {            // limit output to 0-1
	    u = 1.0;                
	  } else if (u < 0.0) {     
 	    u = 0.0;                
	  }
	  if (i > 1.0) {            // anti-windup
	    i = 1.0;                
	  } else if (i < 0.0) {    
 	    i = 0.0;                
	  }
   }
// cout<<"PI:fr="<<fr<<endl;
// cout<<"PI:bias="<<bias<<endl;
// cout<<"PI:w="<<w<<endl;
// cout<<"PI:y="<<y<<endl;
// cout<<"PI:e="<<e<<endl;
// cout<<"PI:i="<<i<<endl;
// cout<<"PI:iP="<<iP<<endl;
// cout<<"PI:u="<<u<<endl;
 
   BEGIN_RETURN
	u,    
	i 
   END_RETURN

}


