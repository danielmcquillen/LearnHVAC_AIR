/// \file  fan.cc
/// \brief fan model 
///
/// -  Abstract:        
/// -       The fan curve can be treated by simplified model:
/// -	pFan = pFan0 - CFan * m^2
/// -	where pFan0 is directly related to fan speed, where is
/// -	pFan = kFan * nFan^2
/// -       The resistance is:
/// -	pRes = pStat + (vAir/(2*area^2)+CRes )* m^2
/// -       Given a fan-resistance system
/// -	pFan = pRes, therefore
/// -	pFan0 = pStat + (vAir/(2*area^2)+ CFan + CRes) * m^2
/// -
/// -  Interface:       
/// - 	nFan:  	fan speed 					[rpm];
/// -	pStat: 	static pressure setpoint 			[Pa] ;
/// -	pFan:  	total pressure increase across fan		[Pa];
/// -	mAir:  	air flow rate through the fan      		[kg_dryAir/s];
/// -	CRes:  	resistance charactristic constant     		[];
/// -	CFan: 	fan curve constant			      	[];
/// -	kFan: 	pressure-fanspeed constant      			[];
/// -	CEff: 	fan effiency constant			      	[];
/// -	area: 	duct work crossing section area			[m2];
/// -	TAirEnt: Incoming air temperature 			[J/kg_dryAir] ;
/// -	wAirEnt: Incoming air humidity ratio			[kg/kg_dryAir];
/// -	TAirLvg: Outgoing air temperature 			[J/kg_dryAir] ;
/// -	wAirLvg: Incoming air humidity ratio			[kg/kg_dryAir];	
/// -	powerTot:Power consumption				[W] ;
/// -	effMot:	 Efficiency of fan motor				[] ;
/// -	motFrac: Fraction of motor heat loss in air stream[fraction] ;
/// -	effShaft: fan efficiency				[];
/// -	effShaftMax: fan maximum efficiency			[];
/// -	mAirMax: maximum air flow of the fan			[kg_dryAir/s];	
/// -	PAtm:	Atmospheric pressure				[Pa];
/// - PORT 	prevFanspeed [rpm] ;
/// -
/// -  Acceptable input set:  
/// -
/// - 	nFan: 		unknown 				[rpm];
/// -	pStat: 		20					[Pa] ;
/// -	pFan:  		unknown					[Pa];
/// -	mAir:  		5      					[kg_dryAir/s];
/// -	CRes: 		0.1      				[];
/// -	CFan: 		0.3			      		[];
/// -	kFan: 		1.25E-3     				[];
/// -	CEff: 		1e-4			      		[];
/// -	area: 		0.3					[m2];
/// -	TAirEnt: 	20	 				[J/kg_dryAir] ;
/// -	wAirEnt: 	0.08					[kg/kg_dryAir];
/// -	TAirLvg: 	unknown					[J/kg_dryAir] ;
/// -	wAirLvg: 	unknown					[kg/kg_dryAir];	
/// -	powerTot: 	unknown					[W] ;
/// -	effMot:		0.9					[] ;
/// -	motFrac: 	1	 ;
/// -	effShaft: 	unknown					[];
/// -	effShaftMax: 	0.9					[];
/// -	mAirMax: 	8					[kg_dryAir/s];	
/// -	PAtm: 		1e5					[Pa];
/// -
/// -  Recommended matches:  
/// -          None
/// -
/// -  Suggested breaks:  
/// -          None
/// -
/// -  Equations: 
/// -	kFan * nFan^2 = pStat + ((1/(2*density_air*area^2)) + CRes + CFan ) * mAir^2 ;
/// -	pFan = kFan* nFan^2 - CFan  * mAir^2;
/// -	effShaft = effShaftMax - CEff*((mAir-mAirMax)/nFan)^2;
/// -	powerShaft = mAir * PFan / effShaft *vAir;
/// -	powerTot = powerShaft / effMot;
/// -	qLoss = (powerShaft)+(powerTot-powerShaft)*motFrac;
/// -	(hAirLvg-hAirEnt)*mAir = qLoss;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///  Modified Brian Coffey, Feb8-09, to make the fan speed an actuated variable based on positive or negative control signal (added a previous fanspeed)
///
///////////////////////////////////////////////////////////////////////////////

#ifdef SPARK_PARSER


// inputs
port 	TAirEnt		"Incoming air temperature" 		[deg_C] ;
port 	wAirEnt		"Incoming air humidity ratio"	[kg_water/kg_dryAir];
//PORT	RangeErrorVFD;
//PORT	TotFanFailure;
//PORT	WrongFanType;
//PORT	FanTooSmall;
//PORT	StuckFanSpeed;
//PORT	DeafVFDorIGV;
PORT	FanStatPresSensorOffset;
//PORT	BadFanRotationnDir;
PORT	control_sig	"Fan speed control signal"			[-];
PORT	mAir	"air flow rate through the fan "    [kg_dryAir/s];
PORT    mAirMax  "maximum air flow rate of fan"     [kg_dryAir/s];
PORT 	prevFanspeed [rpm] ;
// outputs
PORT	pFan	"total pressure rise across fan"	[Pa];
port 	TAirLvg		"Outgoing air temperature" 		[deg_C] ;
port 	wAirLvg		"Incoming air humidity ratio"	[kg_water/kg_dryAir];	
port 	powerTot	"Power consumption."			[W] ;
PORT	pStat	"duct static pressure  "			[Pa] ;
port    pStatMea;
port    fanspeed [rpm] ;
port    effShaft ;


EQUATIONS {
}
FUNCTIONS {
pFan, TAirLvg, wAirLvg, powerTot, pStat, pStatMea, fanspeed, effShaft = fan(TAirEnt,wAirEnt,control_sig,mAir,mAirMax,FanStatPresSensorOffset,prevFanspeed);
}

#endif /* SPARK_PARSER */

#include "spark.h"
#include "hvactk.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>

///////////////////////////////////////////////////////////
EVALUATE (fan)
{

ARGDEF(0, TAirEnt	);
ARGDEF(1, wAirEnt	);
ARGDEF(2, control_sig	);
ARGDEF(3, mAir	);
ARGDEF(4, mAirMax	);
//ARGDEF(2, RangeErrorVFD	);
//ARGDEF(3, TotFanFailure	);
//ARGDEF(4, WrongFanType	);
//ARGDEF(5, FanTooSmall	);
//ARGDEF(6, StuckFanSpeed	);
//ARGDEF(7, DeafVFDorIGV	);
ARGDEF(5, FanStatPresSensorOffset	);
//ARGDEF(9, BadFanRotationnDir	);
ARGDEF(6, prevFanspeed	);

double pFan	;
double TAirLvg	;
double wAirLvg	;
double powerTot;
double pStat	;
double pStatMea;
double nReal 	;
double effShaft;

double CFan = 0.3;
double CRes = 0.3;
double kFan = 1.25e-3;
double CEff = 0.5;
double effShaftMax = 0.9;
double effMot = 0.9;
double motFrac = 1.0;

double qLoss = 0.0;
double powerShaft = 0.0;

//maximum fan speed is 1000;
double fanspeed;

fanspeed = prevFanspeed + (100*control_sig);
if (fanspeed > 1000) { fanspeed = 1000; }
if (fanspeed < 0) { fanspeed = 0; }

//if (StuckFanSpeed>=0.0)
//nFan1 =1000*StuckFanSpeed;

pFan = SPARK::max(0, (kFan * fanspeed*fanspeed - CFan  * mAir*mAir));

if (fanspeed==0.0)
{
effShaft=1.0;
}
else
{
effShaft = SPARK::max(0.1, (effShaftMax - (CEff*((mAir-mAirMax)/1)*((mAir-mAirMax)/1))));  // modified B Coffey, March 3, 2009, eliminated reference to control signal, was (mAir-mAirMax)/control_sig , seems like control_sig was out of place, and it was causing problems
}

powerShaft = (mAir/RHO_AIR) * pFan / effShaft ;
powerTot = powerShaft / effMot;
qLoss = (powerShaft)+(powerTot-powerShaft)*motFrac;
TAirLvg= TAirEnt + qLoss / (CP_AIR*mAir) ;
wAirLvg = wAirEnt;
pStat = SPARK::max(0, (pFan - CRes*mAir*mAir));

pStatMea = pFan;

if (FanStatPresSensorOffset >-999.0) 
  pStatMea = pFan + FanStatPresSensorOffset;

/*
cout<<"pFan1="<<pFan1<<endl;
cout<<"effShaft1="<<effShaft1<<endl;
cout<<"powerShaft="<<powerShaft<<endl;
cout<<"powerTot1="<<powerTot1<<endl;
cout<<"qLoss="<<qLoss<<endl;
cout<<"TAirLvg="<<TAirLvg<<endl;
cout<<"pStat="<<pStat<<endl;
*/

/*
if (TotFanFailure>-999.0)
{
pFan =0.0	;
TAirLvg=TAirEnt	;
wAirLvg	= wAirEnt;
powerTot =0.0;
pStat=0.0;
pStatMea =0.0;
nReal =0.0;
effShaft =1.0;
}
*/

BEGIN_RETURN
	pFan	,
	TAirLvg	,
	wAirLvg	,
	powerTot,
	pStat	,
	pStatMea,
	fanspeed 	,
	effShaft
END_RETURN

}

