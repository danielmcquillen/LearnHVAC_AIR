/// \file  FileWrite.cc
/// \brief SPARK write object that write the simulation output to a file
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - CLASSTYPE SINK;
/// - 
/// - // HEATING COIL
/// - port	HCmAirEnt			;
/// - port	HCmAirLvg			;
/// - port    HCmLiqbypass 		;
/// - port	HCmLiqEnt			;
/// - port	HCmLiqEntValve		;
/// - port	HCmLiqLvg			;
/// - port	HCmLiqLvgValve		;
/// - port	HCpos				;
/// - port	HCposReal			;
/// - port	HCq					;
/// - port	HCTAirEnt			;
/// - port	HCTAirLvg			;
/// - port	HCTLiqbypass		;
/// - port	HCTLiqEntValve		;
/// - port	HCTLiqLvg			;
/// - port	HCTLiqLvgValve		;
/// - port	HCTp				;
/// - port	HCTs				;
/// - port	HCTwAirEnt			;
/// - port	HCTwAirLvg 			;
/// - port	HCwAirEnt			;
/// - port	HCwAirLvg			;
/// - // COOLING COIL
/// - port	CCmAirEnt			;
/// - port	CCmAirLvg			;
/// - port	CCmLiqbypass		;
/// - port	CCmLiqEnt			;
/// - port	CCmLiqEntValve		;
/// - port	CCmLiqLvg			;
/// - port	CCmLiqLvgValve		;
/// - port	CCpos				;
/// - port	CCposReal			;
/// - port	CCqLat				;
/// - port	CCqSen				;
/// - port	CCqTot				;
/// - port	CCTAirEnt			;
/// - port	CCTAirLvg			;
/// - port	CCTLiqbypass		;
/// - port	CCTLiqEntValve		;
/// - port	CCTLiqLvg			;
/// - port	CCTLiqLvgValve		;
/// - port	CCTp				;
/// - port	CCTs				;
/// - port	CCTwAirEnt			;
/// - port	CCTwAirLvg			;
/// - port	CCwAirEnt			;
/// - port	CCwAirLvg			;
/// - port	CCwTAirEnt			;
/// - // FAN 
/// - port	FaneffShaft			;
/// - port	FanmAirEnt			;
/// - port	FannCon				;
/// - port	FannReal			;
/// - port	Fanp				;
/// - port	FanpowerTot			;
/// - port	FanpStatMea			;
/// - port	FanpStatReal		;
/// - port	FanTAirEnt			;
/// - port	FanTAirLvg			;
/// - port	FanTp				;
/// - port	FanTwAirEnt			;
/// - port	FanTwAirLvg			;
/// - port	FanwAirEnt			;
/// - port	FanwAirLvg			;
/// - //MIXING BOX
/// - port	MXEAPosDamper		;
/// - port	MXEAPosDamperReal	;
/// - port	MXOAPosDamper		;
/// - port	MXOAPosDamperReal	;
/// - port	MXPos				;
/// - port	MXRAPosDamper		;
/// - port	MXRAPosDamperReal	;
/// - port	MXTmix				;
/// - port	MXTMixReal			;
/// - port	MXTOut				;
/// - port	MXTp				;
/// - port	MXTs				;
/// - port	MXTwmix				;
/// - port	MXTwOut				;
/// - // VAV BOX
/// - port	VAVCFMTp			;
/// - port	VAVDAMPos			;
/// - port	VAVDAMPTp			;
/// - port	VAVDAMPTr			;
/// - port	VAVDAMPTs			;
/// - port	VAVHCmAirEnt		;
/// - port	VAVHCmAirLvg		;
/// - port	VAVHCmLiqbypass		;
/// - port	VAVHCmLiqEnt		;
/// - port	VAVHCmLiqEntValve	;
/// - port	VAVHCmLiqLvg		;
/// - port	VAVHCmLiqLvgValve	;
/// - port	VAVHCpos			;
/// - port	VAVHCposReal 		;
/// - port	VAVHCq				;
/// - port	VAVHCTAirEnt		;
/// - port	VAVHCTAirLvg		;
/// - port	VAVHCTLiqbypass		;
/// - port	VAVHCTLiqEntValve	;
/// - port	VAVHCTLiqLvg		;
/// - port	VAVHCTLiqLvgValve	;
/// - port	VAVHCTp				;
/// - port	VAVHCTwAirEnt		;
/// - port	VAVHCTwAirLvg		;
/// - port	VAVHCwAirEnt		;
/// - port	VAVHCwAirLvg		;
/// - port	VAVm				;
/// - port	VAVPos				;
/// - port	VAVpre				;
/// - // FILTER
/// - port	FltmAirEnt			;
/// - port	FltmAirLvg			;
/// - port	FltpreDrop			;
/// - // SYSTEM
/// - port	MAirsup				;
/// - port	RmTRoomW			;
/// - port	TAirSup				;
/// - port	TRoom				;
/// - port	TsupMea				;
/// - port	TsupReal			;
/// - port	uCombined           ;
/// - // SIMULATION
/// - port	timestep			;
/// - port	Tstep				;
/// - // Boiler, Chiller, Cooling Tower, added BC-Jul10-08
/// - port	BOItin				;
/// - port	BOIwaterflow		;
/// - port	BOItout				;
/// - port	BOIfuel				;
/// - port	BOIqdot				;
/// - port	CHLevapout			;
/// - port	CHLevapin			;
/// - port	CHLevapflow			;
/// - port	CHLcondout			;
/// - port	CHLcomppow			;
/// - port	CHLpumppow			;
/// - port	CHLqdot				;
/// - port	CTWtout				;
/// - port	CTWmakeuprate		;
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// COMMIT = fn_commit(HCmAirEnt			,HCmAirLvg		,HCmLiqbypass		,HCmLiqEnt		,HCmLiqEntValve	,HCmLiqLvg			,HCmLiqLvgValve		,HCpos				,HCposReal			,HCq				,HCTAirEnt			,HCTAirLvg         ,HCTLiqbypass		,HCTLiqEntValve		,HCTLiqLvg			,HCTLiqLvgValve		,HCTp				,HCTs			,HCTwAirEnt			,HCTwAirLvg 		,HCwAirEnt			,HCwAirLvg			,CCmAirEnt			,CCmAirLvg		,CCmLiqbypass		,CCmLiqEnt			,CCmLiqEntValve		,CCmLiqLvg			,CCmLiqLvgValve		,CCpos			,CCposReal			,CCqLat				,CCqSen			 	,CCqTot				,CCTAirEnt			,CCTAirLvg		,CCTLiqbypass		,CCTLiqEntValve		,CCTLiqLvg			,CCTLiqLvgValve		,CCTp				,CCTs			,CCTwAirEnt			,CCTwAirLvg			,CCwAirEnt			,CCwAirLvg			,CCwTAirEnt			,FaneffShaft	,FanmAirEnt			,FannCon			,FannReal			,Fanp				,FanpowerTot		,FanpStatMea	,FanpStatReal		,FanTAirEnt			,FanTAirLvg			,FanTp				,FanTwAirEnt		,FanTwAirLvg	,FanwAirEnt			,FanwAirLvg			,MXEAPosDamper		,MXEAPosDamperReal	,MXOAPosDamper		,MXOAPosDamperReal	,MXPos				,MXRAPosDamper		,MXRAPosDamperReal	,MXTmix				,MXTMixReal			,MXTOut				,MXTp				,MXTs				,MXTwmix			,MXTwOut			,VAVCFMTp		,VAVDAMPos			,VAVDAMPTp			,VAVDAMPTr			,VAVDAMPTs			,VAVHCmAirEnt		,VAVHCmAirLvg	,VAVHCmLiqbypass	,VAVHCmLiqEnt		,VAVHCmLiqEntValve	,VAVHCmLiqLvg		,VAVHCmLiqLvgValve	,VAVHCpos		,VAVHCposReal 		,VAVHCq				,VAVHCTAirEnt		,VAVHCTAirLvg		,VAVHCTLiqbypass	,VAVHCTLiqEntValve	,VAVHCTLiqLvg		,VAVHCTLiqLvgValve	,VAVHCTp			,VAVHCTwAirEnt		,VAVHCTwAirLvg		,VAVHCwAirEnt		,VAVHCwAirLvg		,VAVm				,VAVPos				,VAVpre				,FltmAirEnt		,FltmAirLvg			,FltpreDrop			,MAirsup			,RmTRoomW			,TAirSup			,TRoom				,TsupMea			,TsupReal			,uCombined	        ,timestep			,Tstep , BOItin, BOIwaterflow, BOItout	,BOIfuel	,BOIqdot	,CHLevapout, CHLevapin, CHLevapflow	,CHLcondout	,CHLcomppow	,CHLpumppow	,CHLqdot		,CTWtout		,CTWmakeuprate )
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

CLASSTYPE SINK;

// HEATING COIL
port	HCmAirEnt			;
port	HCmAirLvg			;
port    HCmLiqbypass 		;
port	HCmLiqEnt			;
port	HCmLiqEntValve		;
port	HCmLiqLvg			;
port	HCmLiqLvgValve		;
port	HCpos				;
port	HCposReal			;
port	HCq					;
port	HCTAirEnt			;
port	HCTAirLvg			;
port	HCTLiqbypass		;
port	HCTLiqEntValve		;
port	HCTLiqLvg			;
port	HCTLiqLvgValve		;
port	HCTp				;
port	HCTs				;
port	HCTwAirEnt			;
port	HCTwAirLvg 			;
port	HCwAirEnt			;
port	HCwAirLvg			;
// COOLING COIL
port	CCmAirEnt			;
port	CCmAirLvg			;
port	CCmLiqbypass		;
port	CCmLiqEnt			;
port	CCmLiqEntValve		;
port	CCmLiqLvg			;
port	CCmLiqLvgValve		;
port	CCpos				;
port	CCposReal			;
port	CCqLat				;
port	CCqSen				;
port	CCqTot				;
port	CCTAirEnt			;
port	CCTAirLvg			;
port	CCTLiqbypass		;
port	CCTLiqEntValve		;
port	CCTLiqLvg			;
port	CCTLiqLvgValve		;
port	CCTp				;
port	CCTs				;
port	CCTwAirEnt			;
port	CCTwAirLvg			;
port	CCwAirEnt			;
port	CCwAirLvg			;
port	CCwTAirEnt			;
// FAN 
port	FaneffShaft			;
port	FanmAirEnt			;
port	FannCon				;
port	FannReal			;
port	Fanp				;
port	FanpowerTot			;
port	FanpStatMea			;
port	FanpStatReal		;
port	FanTAirEnt			;
port	FanTAirLvg			;
port	FanTp				;
port	FanTwAirEnt			;
port	FanTwAirLvg			;
port	FanwAirEnt			;
port	FanwAirLvg			;
//MIXING BOX
port	MXEAPosDamper		;
port	MXEAPosDamperReal	;
port	MXOAPosDamper		;
port	MXOAPosDamperReal	;
port	MXPos				;
port	MXRAPosDamper		;
port	MXRAPosDamperReal	;
port	MXTmix				;
port	MXTMixReal			;
port	MXTOut				;
port	MXTp				;
port	MXTs				;
port	MXTwmix				;
port	MXTwOut				;
// VAV BOX
port	VAVCFMTp			;
port	VAVDAMPos			;
port	VAVDAMPTp			;
port	VAVDAMPTr			;
port	VAVDAMPTs			;
port	VAVHCmAirEnt		;
port	VAVHCmAirLvg		;
port	VAVHCmLiqbypass		;
port	VAVHCmLiqEnt		;
port	VAVHCmLiqEntValve	;
port	VAVHCmLiqLvg		;
port	VAVHCmLiqLvgValve	;
port	VAVHCpos			;
port	VAVHCposReal 		;
port	VAVHCq				;
port	VAVHCTAirEnt		;
port	VAVHCTAirLvg		;
port	VAVHCTLiqbypass		;
port	VAVHCTLiqEntValve	;
port	VAVHCTLiqLvg		;
port	VAVHCTLiqLvgValve	;
port	VAVHCTp				;
port	VAVHCTwAirEnt		;
port	VAVHCTwAirLvg		;
port	VAVHCwAirEnt		;
port	VAVHCwAirLvg		;
port	VAVm				;
port	VAVPos				;
port	VAVpre				;
// FILTER
port	FltmAirEnt			;
port	FltmAirLvg			;
port	FltpreDrop			;
// SYSTEM
port	MAirsup				;
port	RmTRoomW			;
port	TAirSup				;
port	TRoom				;
port	TsupMea				;
port	TsupReal			;
port	uCombined           ;
// SIMULATION
port	timestep			;
port	Tstep				;
// Boiler, Chiller, Cooling Tower, added BC-Jul10-08
port	BOItin				;
port	BOIwaterflow		;
port	BOItout				;
port	BOIfuel				;
port	BOIqdot				;
port	CHLevapout			;
port	CHLevapin			;
port	CHLevapflow			;
port	CHLcondout			;
port	CHLcomppow			;
port	CHLpumppow			;
port	CHLqdot				;
port	CTWtout				;
port	CTWmakeuprate		;


EQUATIONS {

}

FUNCTIONS {
	COMMIT = fn_commit(HCmAirEnt			,HCmAirLvg		,HCmLiqbypass		,HCmLiqEnt		,HCmLiqEntValve	,HCmLiqLvg			,HCmLiqLvgValve		,HCpos				,HCposReal			,HCq				,HCTAirEnt			,HCTAirLvg         ,HCTLiqbypass		,HCTLiqEntValve		,HCTLiqLvg			,HCTLiqLvgValve		,HCTp				,HCTs			,HCTwAirEnt			,HCTwAirLvg 		,HCwAirEnt			,HCwAirLvg			,CCmAirEnt			,CCmAirLvg		,CCmLiqbypass		,CCmLiqEnt			,CCmLiqEntValve		,CCmLiqLvg			,CCmLiqLvgValve		,CCpos			,CCposReal			,CCqLat				,CCqSen			 	,CCqTot				,CCTAirEnt			,CCTAirLvg		,CCTLiqbypass		,CCTLiqEntValve		,CCTLiqLvg			,CCTLiqLvgValve		,CCTp				,CCTs			,CCTwAirEnt			,CCTwAirLvg			,CCwAirEnt			,CCwAirLvg			,CCwTAirEnt			,FaneffShaft	,FanmAirEnt			,FannCon			,FannReal			,Fanp				,FanpowerTot		,FanpStatMea	,FanpStatReal		,FanTAirEnt			,FanTAirLvg			,FanTp				,FanTwAirEnt		,FanTwAirLvg	,FanwAirEnt			,FanwAirLvg			,MXEAPosDamper		,MXEAPosDamperReal	,MXOAPosDamper		,MXOAPosDamperReal	,MXPos				,MXRAPosDamper		,MXRAPosDamperReal	,MXTmix				,MXTMixReal			,MXTOut				,MXTp				,MXTs				,MXTwmix			,MXTwOut			,VAVCFMTp		,VAVDAMPos			,VAVDAMPTp			,VAVDAMPTr			,VAVDAMPTs			,VAVHCmAirEnt		,VAVHCmAirLvg	,VAVHCmLiqbypass	,VAVHCmLiqEnt		,VAVHCmLiqEntValve	,VAVHCmLiqLvg		,VAVHCmLiqLvgValve	,VAVHCpos		,VAVHCposReal 		,VAVHCq				,VAVHCTAirEnt		,VAVHCTAirLvg		,VAVHCTLiqbypass	,VAVHCTLiqEntValve	,VAVHCTLiqLvg		,VAVHCTLiqLvgValve	,VAVHCTp			,VAVHCTwAirEnt		,VAVHCTwAirLvg		,VAVHCwAirEnt		,VAVHCwAirLvg		,VAVm				,VAVPos				,VAVpre				,FltmAirEnt		,FltmAirLvg			,FltpreDrop			,MAirsup			,RmTRoomW			,TAirSup			,TRoom				,TsupMea			,TsupReal			,uCombined	        ,timestep			,Tstep , BOItin, BOIwaterflow, BOItout	,BOIfuel	,BOIqdot	,CHLevapout, CHLevapin, CHLevapflow	,CHLcondout	,CHLcomppow	,CHLpumppow	,CHLqdot		,CTWtout		,CTWmakeuprate );
}  



#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>
//#include <stdexcept>


///////////////////////////////////////////////////////////
COMMIT (fn_commit)
{
ARGDEF(0,HCmAirEnt			);
ARGDEF(1,HCmAirLvg			);
ARGDEF(2,HCmLiqbypass 		);
ARGDEF(3,HCmLiqEnt			);
ARGDEF(4,HCmLiqEntValve		);
ARGDEF(5,HCmLiqLvg			);
ARGDEF(6,HCmLiqLvgValve		);
ARGDEF(7,HCpos				);
ARGDEF(8,HCposReal			);
ARGDEF(9,HCq				);
ARGDEF(10,HCTAirEnt			);
ARGDEF(11,HCTAirLvg			);
ARGDEF(12,HCTLiqbypass		);
ARGDEF(13,HCTLiqEntValve	);
ARGDEF(14,HCTLiqLvg			);
ARGDEF(15,HCTLiqLvgValve	);
ARGDEF(16,HCTp				);
ARGDEF(17,HCTs				);
ARGDEF(18,HCTwAirEnt		);
ARGDEF(19,HCTwAirLvg 		);
ARGDEF(20,HCwAirEnt			);
ARGDEF(21,HCwAirLvg			);
ARGDEF(22,CCmAirEnt			);
ARGDEF(23,CCmAirLvg			);
ARGDEF(24,CCmLiqbypass		);
ARGDEF(25,CCmLiqEnt			);
ARGDEF(26,CCmLiqEntValve	);
ARGDEF(27,CCmLiqLvg			);
ARGDEF(28,CCmLiqLvgValve	);
ARGDEF(29,CCpos				);
ARGDEF(30,CCposReal			);
ARGDEF(31,CCqLat			);
ARGDEF(32,CCqSen			);
ARGDEF(33,CCqTot			);
ARGDEF(34,CCTAirEnt			);
ARGDEF(35,CCTAirLvg			);
ARGDEF(36,CCTLiqbypass		);
ARGDEF(37,CCTLiqEntValve	);
ARGDEF(38,CCTLiqLvg			);
ARGDEF(39,CCTLiqLvgValve	);
ARGDEF(40,CCTp				);
ARGDEF(41,CCTs				);
ARGDEF(42,CCTwAirEnt		);
ARGDEF(43,CCTwAirLvg		);
ARGDEF(44,CCwAirEnt			);
ARGDEF(45,CCwAirLvg			);
ARGDEF(46,CCwTAirEnt		);
ARGDEF(47,FaneffShaft		);
ARGDEF(48,FanmAirEnt		);
ARGDEF(49,FannCon			);
ARGDEF(50,FannReal			);
ARGDEF(51,Fanp				);
ARGDEF(52,FanpowerTot		);
ARGDEF(53,FanpStatMea		);
ARGDEF(54,FanpStatReal		);
ARGDEF(55,FanTAirEnt		);
ARGDEF(56,FanTAirLvg		);
ARGDEF(57,FanTp			 	);
ARGDEF(58,FanTwAirEnt		);
ARGDEF(59,FanTwAirLvg		);
ARGDEF(60,FanwAirEnt		);
ARGDEF(61,FanwAirLvg		);
ARGDEF(62,MXEAPosDamper		);
ARGDEF(63,MXEAPosDamperReal	);
ARGDEF(64,MXOAPosDamper		);
ARGDEF(65,MXOAPosDamperReal	);
ARGDEF(66,MXPos				);
ARGDEF(67,MXRAPosDamper		);
ARGDEF(68,MXRAPosDamperReal	);
ARGDEF(69,MXTmix			);
ARGDEF(70,MXTMixReal		);
ARGDEF(71,MXTOut			);
ARGDEF(72,MXTp				);
ARGDEF(73,MXTs				);
ARGDEF(74,MXTwmix			);
ARGDEF(75,MXTwOut			);
ARGDEF(76,VAVCFMTp			);
ARGDEF(77,VAVDAMPos			);
ARGDEF(78,VAVDAMPTp			);
ARGDEF(79,VAVDAMPTr			);
ARGDEF(80,VAVDAMPTs			);
ARGDEF(81,VAVHCmAirEnt		);
ARGDEF(82,VAVHCmAirLvg		);
ARGDEF(83,VAVHCmLiqbypass	);
ARGDEF(84,VAVHCmLiqEnt		);
ARGDEF(85,VAVHCmLiqEntValve	);
ARGDEF(86,VAVHCmLiqLvg		);
ARGDEF(87,VAVHCmLiqLvgValve	);
ARGDEF(88,VAVHCpos			);
ARGDEF(89,VAVHCposReal 		);
ARGDEF(90,VAVHCq			);
ARGDEF(91,VAVHCTAirEnt		);
ARGDEF(92,VAVHCTAirLvg		);
ARGDEF(93,VAVHCTLiqbypass	);
ARGDEF(94,VAVHCTLiqEntValve	);
ARGDEF(95,VAVHCTLiqLvg		);
ARGDEF(96,VAVHCTLiqLvgValve	);
ARGDEF(97,VAVHCTp			);
ARGDEF(98,VAVHCTwAirEnt		);
ARGDEF(99,VAVHCTwAirLvg		);
ARGDEF(100,VAVHCwAirEnt		);
ARGDEF(101,VAVHCwAirLvg		);
ARGDEF(102,VAVm				);
ARGDEF(103,VAVPos			);
ARGDEF(104,VAVpre			);
ARGDEF(105,FltmAirEnt		);
ARGDEF(106,FltmAirLvg		);
ARGDEF(107,FltpreDrop		);
ARGDEF(108,MAirsup			);
ARGDEF(109,RmTRoomW			);
ARGDEF(110,TAirSup			);
ARGDEF(111,TRoom			);
ARGDEF(112,TsupMea			);		
ARGDEF(113,TsupReal			);	
ARGDEF(114,uCombined    	);	
ARGDEF(115,timestep			);	
ARGDEF(116,Tstep			);		  
// Boiler, Chiller, Cooling Tower, added BC-Jul10-08
ARGDEF(117,BOItin			);
ARGDEF(118,BOIwaterflow		);
ARGDEF(119,BOItout			);
ARGDEF(120,BOIfuel			);
ARGDEF(121,BOIqdot			);
ARGDEF(122,CHLevapout		);
ARGDEF(123,CHLevapin		);
ARGDEF(124,CHLevapflow		);
ARGDEF(125,CHLcondout		);
ARGDEF(126,CHLcomppow		);
ARGDEF(127,CHLpumppow		);
ARGDEF(128,CHLqdot			);
ARGDEF(129,CTWtout			);
ARGDEF(130,CTWmakeuprate	);


FILE *F2 = fopen("output.txt", "w");


//fprintf(F2, "%s", "Tstep:");  fprintf(F2, "%.2f\n", Tstep-0.0000);

fprintf(F2, "%s", "step:");  fprintf(F2, "%.2f\n", Tstep-0.0000);

fprintf(F2, "%s", "HCmAirEnt:");  fprintf(F2, "%.2f\n", HCmAirEnt-0.0000);
fprintf(F2, "%s", "HCmAirLvg:");  fprintf(F2, "%.2f\n", HCmAirLvg-0.0000);
fprintf(F2, "%s", "HCmLiqbypass:");  fprintf(F2, "%.2f\n", HCmLiqbypass-0.0000);
fprintf(F2, "%s", "HCmLiqEnt:");  fprintf(F2, "%.2f\n", HCmLiqEnt-0.0000);
fprintf(F2, "%s", "HCmLiqEntValve:");  fprintf(F2, "%.2f\n", HCmLiqEntValve-0.0000);
fprintf(F2, "%s", "HCmLiqLvg:");  fprintf(F2, "%.2f\n", HCmLiqLvg-0.0000);
fprintf(F2, "%s", "HCmLiqLvgValve:");  fprintf(F2, "%.2f\n", HCmLiqLvgValve-0.0000);
fprintf(F2, "%s", "HCpos:");  fprintf(F2, "%.2f\n", HCpos-0.0000);
fprintf(F2, "%s", "HCposReal:");  fprintf(F2, "%.2f\n", HCposReal-0.0000);
fprintf(F2, "%s", "HCq:");  fprintf(F2, "%.2f\n", HCq-0.0000);
fprintf(F2, "%s", "HCTAirEnt:");  fprintf(F2, "%.2f\n", HCTAirEnt-0.0000);
fprintf(F2, "%s", "HCTAirLvg:");  fprintf(F2, "%.2f\n", HCTAirLvg-0.0000);
fprintf(F2, "%s", "HCTLiqbypass:");  fprintf(F2, "%.2f\n", HCTLiqbypass-0.0000);
fprintf(F2, "%s", "HCTLiqEntValve:");  fprintf(F2, "%.2f\n", HCTLiqEntValve-0.0000);
fprintf(F2, "%s", "HCTLiqLvg:");  fprintf(F2, "%.2f\n", HCTLiqLvg-0.0000);
fprintf(F2, "%s", "HCTLiqLvgValve:");  fprintf(F2, "%.2f\n", HCTLiqLvgValve-0.0000);
fprintf(F2, "%s", "HCTp:");  fprintf(F2, "%.2f\n", HCTp-0.0000);
fprintf(F2, "%s", "HCTs:");  fprintf(F2, "%.2f\n", HCTs-0.0000);
fprintf(F2, "%s", "HCTwAirEnt:");  fprintf(F2, "%.2f\n", HCTwAirEnt-0.0000);
fprintf(F2, "%s", "HCTwAirLvg:");  fprintf(F2, "%.2f\n", HCTwAirLvg-0.0000);
fprintf(F2, "%s", "HCwAirEnt:");  fprintf(F2, "%.2f\n", HCwAirEnt-0.0000);
fprintf(F2, "%s", "HCwAirLvg:");  fprintf(F2, "%.2f\n", HCwAirLvg-0.0000);
fprintf(F2, "%s", "CCmAirEnt:");  fprintf(F2, "%.2f\n", CCmAirEnt-0.0000);
fprintf(F2, "%s", "CCmAirLvg:");  fprintf(F2, "%.2f\n", CCmAirLvg-0.0000);
fprintf(F2, "%s", "CCmLiqbypass:");  fprintf(F2, "%.2f\n", CCmLiqbypass-0.0000);
fprintf(F2, "%s", "CCmLiqEnt:");  fprintf(F2, "%.2f\n", CCmLiqEnt-0.0000);
fprintf(F2, "%s", "CCmLiqEntValve:");  fprintf(F2, "%.2f\n", CCmLiqEntValve-0.0000);
fprintf(F2, "%s", "CCmLiqLvg:");  fprintf(F2, "%.2f\n", CCmLiqLvg-0.0000);
fprintf(F2, "%s", "CCmLiqLvgValve:");  fprintf(F2, "%.2f\n", CCmLiqLvgValve-0.0000);
fprintf(F2, "%s", "CCpos:");  fprintf(F2, "%.2f\n", CCpos-0.0000);
fprintf(F2, "%s", "CCposReal:");  fprintf(F2, "%.2f\n", CCposReal-0.0000);
fprintf(F2, "%s", "CCqLat:");  fprintf(F2, "%.2f\n", CCqLat-0.0000);
fprintf(F2, "%s", "CCqSen:");  fprintf(F2, "%.2f\n", CCqSen-0.0000);
fprintf(F2, "%s", "CCqTot:");  fprintf(F2, "%.2f\n", CCqTot-0.0000);
fprintf(F2, "%s", "CCTAirEnt:");  fprintf(F2, "%.2f\n", CCTAirEnt-0.0000);
fprintf(F2, "%s", "CCTAirLvg:");  fprintf(F2, "%.2f\n", CCTAirLvg-0.0000);
fprintf(F2, "%s", "CCTLiqbypass:");  fprintf(F2, "%.2f\n", CCTLiqbypass-0.0000);
fprintf(F2, "%s", "CCTLiqEntValve:");  fprintf(F2, "%.2f\n", CCTLiqEntValve-0.0000);
fprintf(F2, "%s", "CCTLiqLvg:");  fprintf(F2, "%.2f\n", CCTLiqLvg-0.0000);
fprintf(F2, "%s", "CCTLiqLvgValve:");  fprintf(F2, "%.2f\n", CCTLiqLvgValve-0.0000);
fprintf(F2, "%s", "CCTp:");  fprintf(F2, "%.2f\n", CCTp-0.0000);
fprintf(F2, "%s", "CCTs:");  fprintf(F2, "%.2f\n", CCTs-0.0000);
fprintf(F2, "%s", "CCTwAirEnt:");  fprintf(F2, "%.2f\n", CCTwAirEnt-0.0000);
fprintf(F2, "%s", "CCTwAirLvg:");  fprintf(F2, "%.2f\n", CCTwAirLvg-0.0000);
fprintf(F2, "%s", "CCwAirEnt:");  fprintf(F2, "%.2f\n", CCwAirEnt-0.0000);
fprintf(F2, "%s", "CCwAirLvg:");  fprintf(F2, "%.2f\n", CCwAirLvg-0.0000);
fprintf(F2, "%s", "CCwTAirEnt:");  fprintf(F2, "%.2f\n", CCwTAirEnt-0.0000);
fprintf(F2, "%s", "FaneffShaft:");  fprintf(F2, "%.2f\n", FaneffShaft-0.0000);
fprintf(F2, "%s", "FanmAirEnt:");  fprintf(F2, "%.2f\n", FanmAirEnt-0.0000);
fprintf(F2, "%s", "FannCon:");  fprintf(F2, "%.2f\n", FannCon-0.0000);
fprintf(F2, "%s", "FannReal:");  fprintf(F2, "%.2f\n", FannReal-0.0000);
fprintf(F2, "%s", "Fanp:");  fprintf(F2, "%.2f\n", Fanp-0.0000);
fprintf(F2, "%s", "FanpowerTot:");  fprintf(F2, "%.2f\n", FanpowerTot-0.0000);
fprintf(F2, "%s", "FanpStatMea:");  fprintf(F2, "%.2f\n", FanpStatMea-0.0000);
fprintf(F2, "%s", "FanpStatReal:");  fprintf(F2, "%.2f\n", FanpStatReal-0.0000);
fprintf(F2, "%s", "FanTAirEnt:");  fprintf(F2, "%.2f\n", FanTAirEnt-0.0000);
fprintf(F2, "%s", "FanTAirLvg:");  fprintf(F2, "%.2f\n", FanTAirLvg-0.0000);
fprintf(F2, "%s", "FanTp:");  fprintf(F2, "%.2f\n", FanTp-0.0000);
fprintf(F2, "%s", "FanTwAirEnt:");  fprintf(F2, "%.2f\n", FanTwAirEnt-0.0000);
fprintf(F2, "%s", "FanTwAirLvg:");  fprintf(F2, "%.2f\n", FanTwAirLvg-0.0000);
fprintf(F2, "%s", "FanwAirEnt:");  fprintf(F2, "%.2f\n", FanwAirEnt-0.0000);
fprintf(F2, "%s", "FanwAirLvg:");  fprintf(F2, "%.2f\n", FanwAirLvg-0.0000);
fprintf(F2, "%s", "MXEAPosDamper:");  fprintf(F2, "%.2f\n", MXEAPosDamper-0.0000);
fprintf(F2, "%s", "MXEAPosDamperReal:");  fprintf(F2, "%.2f\n", MXEAPosDamperReal-0.0000);
fprintf(F2, "%s", "MXOAPosDamper:");  fprintf(F2, "%.2f\n", MXOAPosDamper-0.0000);
fprintf(F2, "%s", "MXOAPosDamperReal:");  fprintf(F2, "%.2f\n", MXOAPosDamperReal-0.0000);
fprintf(F2, "%s", "MXPos:");  fprintf(F2, "%.2f\n", MXPos-0.0000);
fprintf(F2, "%s", "MXRAPosDamper:");  fprintf(F2, "%.2f\n", MXRAPosDamper-0.0000);
fprintf(F2, "%s", "MXRAPosDamperReal:");  fprintf(F2, "%.2f\n", MXRAPosDamperReal-0.0000);
fprintf(F2, "%s", "MXTmix:");  fprintf(F2, "%.2f\n", MXTmix-0.0000);
fprintf(F2, "%s", "MXTMixReal:");  fprintf(F2, "%.2f\n", MXTMixReal-0.0000);
fprintf(F2, "%s", "MXTOut:");  fprintf(F2, "%.2f\n", MXTOut-0.0000);
fprintf(F2, "%s", "MXTp:");  fprintf(F2, "%.2f\n", MXTp-0.0000);
fprintf(F2, "%s", "MXTs:");  fprintf(F2, "%.2f\n", MXTs-0.0000);
fprintf(F2, "%s", "MXTwmix:");  fprintf(F2, "%.2f\n", MXTwmix-0.0000);
fprintf(F2, "%s", "MXTwOut:");  fprintf(F2, "%.2f\n", MXTwOut-0.0000);
fprintf(F2, "%s", "VAVCFMTp:");  fprintf(F2, "%.2f\n", VAVCFMTp-0.0000);
fprintf(F2, "%s", "VAVDAMPos:");  fprintf(F2, "%.2f\n", VAVDAMPos-0.0000);
fprintf(F2, "%s", "VAVDAMPTp:");  fprintf(F2, "%.2f\n", VAVDAMPTp-0.0000);
fprintf(F2, "%s", "VAVDAMPTr:");  fprintf(F2, "%.2f\n", VAVDAMPTr-0.0000);
fprintf(F2, "%s", "VAVDAMPTs:");  fprintf(F2, "%.2f\n", VAVDAMPTs-0.0000);
fprintf(F2, "%s", "VAVHCmAirEnt:");  fprintf(F2, "%.2f\n", VAVHCmAirEnt-0.0000);
fprintf(F2, "%s", "VAVHCmAirLvg:");  fprintf(F2, "%.2f\n", VAVHCmAirLvg-0.0000);
fprintf(F2, "%s", "VAVHCmLiqbypass:");  fprintf(F2, "%.2f\n", VAVHCmLiqbypass-0.0000);
fprintf(F2, "%s", "VAVHCmLiqEnt:");  fprintf(F2, "%.2f\n", VAVHCmLiqEnt-0.0000);
fprintf(F2, "%s", "VAVHCmLiqEntValve:");  fprintf(F2, "%.2f\n", VAVHCmLiqEntValve-0.0000);
fprintf(F2, "%s", "VAVHCmLiqLvg:");  fprintf(F2, "%.2f\n", VAVHCmLiqLvg-0.0000);
fprintf(F2, "%s", "VAVHCmLiqLvgValve:");  fprintf(F2, "%.2f\n", VAVHCmLiqLvgValve-0.0000);
fprintf(F2, "%s", "VAVHCpos:");  fprintf(F2, "%.2f\n", VAVHCpos-0.0000);
fprintf(F2, "%s", "VAVHCposReal:");  fprintf(F2, "%.2f\n", VAVHCposReal-0.0000);
fprintf(F2, "%s", "VAVHCq:");  fprintf(F2, "%.2f\n", VAVHCq-0.0000);
fprintf(F2, "%s", "VAVHCTAirEnt:");  fprintf(F2, "%.2f\n", VAVHCTAirEnt-0.0000);
fprintf(F2, "%s", "VAVHCTAirLvg:");  fprintf(F2, "%.2f\n", VAVHCTAirLvg-0.0000);
fprintf(F2, "%s", "VAVHCTLiqbypass:");  fprintf(F2, "%.2f\n", VAVHCTLiqbypass-0.0000);
fprintf(F2, "%s", "VAVHCTLiqEntValve:");  fprintf(F2, "%.2f\n", VAVHCTLiqEntValve-0.0000);
fprintf(F2, "%s", "VAVHCTLiqLvg:");  fprintf(F2, "%.2f\n", VAVHCTLiqLvg-0.0000);
fprintf(F2, "%s", "VAVHCTLiqLvgValve:");  fprintf(F2, "%.2f\n", VAVHCTLiqLvgValve-0.0000);
fprintf(F2, "%s", "VAVHCTp:");  fprintf(F2, "%.2f\n", VAVHCTp-0.0000);
fprintf(F2, "%s", "VAVHCTwAirEnt:");  fprintf(F2, "%.2f\n", VAVHCTwAirEnt-0.0000);
fprintf(F2, "%s", "VAVHCTwAirLvg:");  fprintf(F2, "%.2f\n", VAVHCTwAirLvg-0.0000);
fprintf(F2, "%s", "VAVHCwAirEnt:");  fprintf(F2, "%.2f\n", VAVHCwAirEnt-0.0000);
fprintf(F2, "%s", "VAVHCwAirLvg:");  fprintf(F2, "%.2f\n", VAVHCwAirLvg-0.0000);
fprintf(F2, "%s", "VAVm:");  fprintf(F2, "%.2f\n", VAVm-0.0000);
fprintf(F2, "%s", "VAVPos:");  fprintf(F2, "%.2f\n", VAVPos-0.0000);
fprintf(F2, "%s", "VAVpre:");  fprintf(F2, "%.2f\n", VAVpre-0.0000);
fprintf(F2, "%s", "FltmAirEnt:");  fprintf(F2, "%.2f\n", FltmAirEnt-0.0000);
fprintf(F2, "%s", "FltmAirLvg:");  fprintf(F2, "%.2f\n", FltmAirLvg-0.0000);
fprintf(F2, "%s", "FltpreDrop:");  fprintf(F2, "%.2f\n", FltpreDrop-0.0000);
fprintf(F2, "%s", "MAirsup:");  fprintf(F2, "%.2f\n", MAirsup-0.0000);
fprintf(F2, "%s", "RmTRoomW:");  fprintf(F2, "%.2f\n", RmTRoomW-0.0000);
fprintf(F2, "%s", "TAirSup:");  fprintf(F2, "%.2f\n", TAirSup-0.0000);
fprintf(F2, "%s", "TRoom:");  fprintf(F2, "%.2f\n", TRoom-0.0000);
fprintf(F2, "%s", "TsupMea:");  fprintf(F2, "%.2f\n", TsupMea-0.0000);
fprintf(F2, "%s", "TsupReal:");  fprintf(F2, "%.2f\n", TsupReal-0.0000);
fprintf(F2, "%s", "COu:");  fprintf(F2, "%.2f\n", uCombined-0.0000);
fprintf(F2, "%s", "timestep:");  fprintf(F2, "%.2f\n", timestep-0.0000);
// Boiler, Chiller, Cooling Tower, added BC-Jul10-08
fprintf(F2, "%s", "BOItin:");  fprintf(F2, "%.2f\n", BOItin-0.0000);
fprintf(F2, "%s", "BOIwaterflow:");  fprintf(F2, "%.2f\n", BOIwaterflow-0.0000);
fprintf(F2, "%s", "BOItout:");  fprintf(F2, "%.2f\n", BOItout-0.0000);
fprintf(F2, "%s", "BOIfuel:");  fprintf(F2, "%.2f\n", BOIfuel-0.0000);
fprintf(F2, "%s", "BOIqdot:");  fprintf(F2, "%.2f\n", BOIqdot-0.0000);
fprintf(F2, "%s", "CHLevapout:");  fprintf(F2, "%.2f\n", CHLevapout-0.0000);
fprintf(F2, "%s", "CHLevapin:");  fprintf(F2, "%.2f\n", CHLevapin-0.0000);
fprintf(F2, "%s", "CHLevapflow:");  fprintf(F2, "%.2f\n", CHLevapflow-0.0000);
fprintf(F2, "%s", "CHLcondout:");  fprintf(F2, "%.2f\n", CHLcondout-0.0000);
fprintf(F2, "%s", "CHLcomppow:");  fprintf(F2, "%.2f\n", CHLcomppow-0.0000);
fprintf(F2, "%s", "CHLpumppow:");  fprintf(F2, "%.2f\n", CHLpumppow-0.0000);
fprintf(F2, "%s", "CHLqdot:");  fprintf(F2, "%.2f\n", CHLqdot-0.0000);
fprintf(F2, "%s", "CTWtout:");  fprintf(F2, "%.2f\n", CTWtout-0.0000);
fprintf(F2, "%s", "CTWmakeuprate:");  fprintf(F2, "%.2f\n", CTWmakeuprate-0.0000);


fclose(F2);



}
///////////////////////////////////////////////////////////

