/// \file  Fileread.cc
/// \brief SPARK object that read in inputs from a file 
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Interface variables
/// - // VARIABLE READ FROM .inp FILE TO FORCE EXECUTION AT END TIME-STEP
/// -   port inpdummy					;
/// - 
/// - // HEATCOOL SPLIT-RANGE CONTROL INPUTS  - Added BC-Feb22-08
/// -   port	HeatCoolbias					;
/// -   port	HeatCoolfr					noerr	;
/// -   port	HeatCoolKd					noerr	;
/// -   port	HeatCoolKi					;
/// -   port	HeatCoolKp					;
/// -   port	HeatCoolS1				;
/// -   port	HeatCoolS2				;
/// - // HEATING COIL INPUTS - PI controller removed BC-Feb22-08
/// - //  port	HCbias					;
/// - //  port	HCfr					noerr	;
/// - //  port	HCKd					noerr	;
/// - //  port	HCKi					;
/// - //  port	HCKp					;
/// -   port	HCUA					;
/// -   port	HCmLiqOpen				;
/// -   port	HCStatus				;
/// -   port	HCTLiqEnt				;
/// - // HEATING COIL FAULTS
/// -   port	HCBootLeakage			;
/// -   port	HCDriftedsensor			noerr	;
/// -   port	HCFouledCoil			;
/// -   port	HCLeakyValve			;
/// -   port	HCObstructedPipe		;
/// -   port	HCOversizedValve		;
/// -   port	HCSensorOffset			noerr	;
/// -   port	HCStuckValve			;
/// -   port	HCUndersizedCoil		;
/// - // COOLING COIL INPUTS - removed CCPI, BC-Feb22-08
/// - //  port	CCbias					;
/// - //  port	CCfr					noerr	;
/// - //  port	CCKd					noerr	;
/// - //  port	CCKi					;
/// - //  port	CCKp					;
/// -   port	CCmLiqOpen				;
/// -   port	CCStatus				;
/// -   port	CCTLiqEnt				;
/// -   port	CCUA					;
/// - // COOLING COIL FAULTS
/// -   port	CCBootLeakage			;
/// -   port	CCFouledCoil			;
/// -   port	CCLeakyValve			;
/// -   port	CCObstructedPipe		;
/// -   port	CCOversizedValve		;
/// -   port	CCStuckValve			;
/// -   port	CCUndersizedCoil		;
/// - // FAN INPUTS
/// -   port	Fanbias					;
/// -   port	Fanfr					noerr	;
/// -   port	FanKd					noerr	;
/// -   port	FanKi					;
/// -   port	FanKp					;
/// -   port	FanmAirLvg				;
/// -   port	FanmAirMax				;
/// -   port	FanpStat				;
/// - // FAN FAULTS
/// - //  port	FanBadFanRotationnDir	;
/// -   port	FanDeafVFDorIGV			noerr	;
/// - //  port	FanFailedFanSensor		noerr	;  // renamed
/// -   port	FanStatPresSensorOffset	noerr	; // new name
/// -   port	FanFanTooSmall			noerr	;
/// -   port	FanRangeErrorVFD		noerr	;
/// -   port	FanStuckFanSpeed		noerr	;
/// -   port	FanTotFanFailure		noerr	;
/// -   port	FanWrongFanType			noerr	;
/// - // MIXING BOX INPUTS   - removed MXPI, BC-Feb22-08
/// - //  port	MXbias					;
/// - //  port	MXfr					noerr	;
/// - //  port	MXKd					noerr	;
/// - //  port	MXKi					;
/// - //  port	MXKp					;
/// -   port	MXTRet					;
/// -   port	MXTwRet					;
/// - // MIXING BOX FAULTS
/// -   port	MXBadPosOADamper		noerr	;
/// -   port	MXBadSensor				noerr	;
/// -   port	MXDeafActuator			noerr	;
/// -   port	MXLeakOADamper			;
/// - //  port	MXLeakRetDamper			;  // renamed
/// -   port	MXLeakRADamper			; // new name
/// -   port	MXMismatchDampAct		noerr	;
/// -   port	MXReverseActionAct		noerr	;
/// -   port	MXStuckActuator			;
/// -   port	MXStuckOADamper			noerr	;
/// - // VAV BOX INPUTS
/// -   port	VAVbias					;
/// -   port	VAVDAMPbias				;
/// -   port	VAVDAMPfr				noerr	;
/// -   port	VAVDAMPKd				noerr	;
/// -   port	VAVDAMPKi				;
/// -   port	VAVDAMPKp				;
/// -   port	VAVfr					noerr	;
/// -   port	VAVHCmLiqOpen			;
/// -   port	VAVHCStatus				noerr	;
/// -   port	VAVHCTLiqEnt			;
/// -   port	VAVHCTs					noerr	;
/// -   port	VAVHCUA					;
/// -   port	VAVKd					noerr	;
/// -   port	VAVKi					;
/// -   port	VAVKp					;
/// -   port	VAVposMin				noerr	;
/// - // VAV BOX FAULTS
/// -   port	VAVBadDmprPosSignal		noerr	;
/// - //  port	VAVBadFlowerMeas		;  // renamed
/// -   port	VAVFlowSensorOffset		; // new name
/// -   port	VAVBadLoopTune			noerr	;
/// -   port	VAVBadMinPosDamper		noerr	;
/// -   port	VAVBadReheatCoil		noerr	;
/// - //  port	VAVBadZoneMeas			;
/// -   port	VAVBoxTooBig			noerr	;
/// -   port	VAVBoxTooSmall			noerr	;
/// - //  port	VAVDeafActuator			noerr	;  // rename
/// -   port	VAVFailedActuator			noerr	;  // new name
/// -   port	VAVHCBootLeakage		noerr	;
/// -   port	VAVHCDriftedsensor		noerr	;
/// -   port	VAVHCFouledCoil			noerr	;
/// -   port	VAVHCLeakyValve			;
/// -   port	VAVHCObstructedPipe		noerr	;
/// -   port	VAVHCOversizedValve		;
/// -   port	VAVHCStuckValve			;
/// -   port	VAVHCUndersizedCoil		noerr	;
/// -   port	VAVLeakyDamper			noerr	;
/// -   port	VAVStuckDamper			;
/// -   port	VAVTooHighInletAirSP	noerr	;
/// -   port	VAVTooLowInletAirSP		noerr	;
/// - // FILTER INPUTS
/// - // FILTER FAULTS
/// -   port	FltBadDPSensor			;
/// -   port	FltLeakyFilter			noerr	;
/// -   port	FltPartlyClogged		;
/// - // SYSTEM INPUTS
/// -   port	PAtm					;
/// -   port	RmQSENS					;
/// -   port	TAirOut					;
/// -   port	TRoomSP_Heat				;
/// -   port	TRoomSP_Cool				;
/// -   port	HeatCoolMode				;
/// -   port	TRoomSPDB				;
/// -   port	TSupS					;
/// -   port	TSupSensorOffset		;
/// -   port	TwAirOut				;
/// - // SYSTEM FAULTS
/// - // SIMULATION INPUTS
/// -   port	calcInterval			;
/// -   port	Pause					noerr	;
/// -   port	timeScale				;
/// - // RUN CONTROL
/// -   port    SPARKRUN				;
/// -   port 	MXminOAfrac				; // Added BC-Feb22-08
/// - 
/// - // Boiler, Chiller and Cooling Tower inputs, added BC-Jul10-08
/// -   port BOItset ;
/// -   port BOIcap ;
/// -   port CHLevapset ;
/// -   port CHLcondflow ;
/// -   port CHLcondin ;
/// -   port CHLcap ;
/// -   port CTWwaterflow ;
/// -   port CTWtin ;
/// -   port CTWmakeuptemp ;
/// - PORT  w    [-]    "set-point";
/// - PORT  y    [-]    "measured variable";
/// - PORT  iP   [-]    "previous value of integral term";
/// - PORT  Kp   [-]    "proportional gain";
/// - PORT  Ki   [1/s]  "integral gain";
/// - PORT  fr   [-]    "override (0), forward (+1) or reverse (-1) acting";
/// - PORT  bias [-]    "offset, output in open loop";
/// - PORT  dt   [s]    "time step";
/// - PORT  u   [-]     "control signal";
/// - PORT  i   [-]  	  "integral term";
///
///////////////////////////////////////////////////////////////////////////////
/// \par  Functions
///
/// \code
/// HeatCoolbias				   ,HeatCoolfr				   ,HeatCoolKd				   ,HeatCoolKi				   ,HeatCoolKp				,HeatCoolS1				,HeatCoolS2				   ,HCUA				   ,HCmLiqOpen			   ,HCStatus			   ,HCTLiqEnt			   ,HCBootLeakage			,HCDriftedsensor		,HCFouledCoil			,HCLeakyValve			,HCObstructedPipe		,HCOversizedValve		,HCSensorOffset			,HCStuckValve			,HCUndersizedCoil				,CCmLiqOpen				,CCStatus				,CCTLiqEnt				,CCUA					,CCBootLeakage			,CCFouledCoil			,CCLeakyValve			,CCObstructedPipe		,CCOversizedValve		,CCStuckValve			,CCUndersizedCoil		,Fanbias				,Fanfr					,FanKd					,FanKi					,FanKp					,FanmAirLvg				,FanmAirMax				,FanpStat				,FanDeafVFDorIGV		,FanStatPresSensorOffset,				FanFanTooSmall			,FanRangeErrorVFD		,FanStuckFanSpeed		,FanTotFanFailure		,FanWrongFanType		,MXTRet					,MXTwRet				,MXBadPosOADamper		,MXBadSensor			,MXDeafActuator			,MXLeakOADamper			,MXLeakRADamper		,MXMismatchDampAct		,MXReverseActionAct		,MXStuckActuator		,MXStuckOADamper		,VAVbias				,VAVDAMPbias			,VAVDAMPfr				,VAVDAMPKd				,VAVDAMPKi				,VAVDAMPKp				,VAVfr					,VAVHCmLiqOpen			,VAVHCStatus			,VAVHCTLiqEnt			,VAVHCTs				,VAVHCUA				,VAVKd					,VAVKi					,VAVKp					,VAVposMin				,VAVBadDmprPosSignal	,VAVFlowSensorOffset	,VAVBadLoopTune			,VAVBadMinPosDamper		,VAVBadReheatCoil		,VAVBoxTooBig			,VAVBoxTooSmall			,VAVFailedActuator		,VAVHCBootLeakage		,VAVHCDriftedsensor		,VAVHCFouledCoil		,VAVHCLeakyValve		,VAVHCObstructedPipe	,VAVHCOversizedValve	,VAVHCStuckValve		,VAVHCUndersizedCoil	,VAVLeakyDamper			,VAVStuckDamper			,VAVTooHighInletAirSP	,VAVTooLowInletAirSP	,FltBadDPSensor			,FltLeakyFilter			,FltPartlyClogged		,PAtm					,RmQSENS				,TAirOut				,TRoomSP_Heat				,TRoomSP_Cool				,HeatCoolMode				,TRoomSPDB				,TSupS					,TSupSensorOffset		,TwAirOut				,calcInterval			,Pause					,timeScale				,SPARKRUN				,MXminOAfrac ,BOItset ,BOIcap ,CHLevapset ,CHLcondflow ,CHLcondin ,CHLcap ,CTWwaterflow ,CTWtin ,CTWmakeuptemp = readin(inpdummy);
/// \endcode
///
///////////////////////////////////////////////////////////////////////////////
/// \par  History
/// 
///////////////////////////////////////////////////////////////////////////////


#ifdef SPARK_PARSER

// VARIABLE READ FROM .inp FILE TO FORCE EXECUTION AT END TIME-STEP
  port inpdummy					;

// HEATCOOL SPLIT-RANGE CONTROL INPUTS  - Added BC-Feb22-08
  port	HeatCoolbias					;
  port	HeatCoolfr					noerr	;
  port	HeatCoolKd					noerr	;
  port	HeatCoolKi					;
  port	HeatCoolKp					;
  port	HeatCoolS1				;
  port	HeatCoolS2				;
// HEATING COIL INPUTS - PI controller removed BC-Feb22-08
//  port	HCbias					;
//  port	HCfr					noerr	;
//  port	HCKd					noerr	;
//  port	HCKi					;
//  port	HCKp					;
  port	HCUA					;
  port	HCmLiqOpen				;
  port	HCStatus				;
  port	HCTLiqEnt				;
// HEATING COIL FAULTS
  port	HCBootLeakage			;
  port	HCDriftedsensor			noerr	;
  port	HCFouledCoil			;
  port	HCLeakyValve			;
  port	HCObstructedPipe		;
  port	HCOversizedValve		;
  port	HCSensorOffset			noerr	;
  port	HCStuckValve			;
  port	HCUndersizedCoil		;
// COOLING COIL INPUTS - removed CCPI, BC-Feb22-08
//  port	CCbias					;
//  port	CCfr					noerr	;
//  port	CCKd					noerr	;
//  port	CCKi					;
//  port	CCKp					;
  port	CCmLiqOpen				;
  port	CCStatus				;
  port	CCTLiqEnt				;
  port	CCUA					;
// COOLING COIL FAULTS
  port	CCBootLeakage			;
  port	CCFouledCoil			;
  port	CCLeakyValve			;
  port	CCObstructedPipe		;
  port	CCOversizedValve		;
  port	CCStuckValve			;
  port	CCUndersizedCoil		;
// FAN INPUTS
  port	Fanbias					;
  port	Fanfr					noerr	;
  port	FanKd					noerr	;
  port	FanKi					;
  port	FanKp					;
  port	FanmAirLvg				;
  port	FanmAirMax				;
  port	FanpStat				;
// FAN FAULTS
//  port	FanBadFanRotationnDir	;
  port	FanDeafVFDorIGV			noerr	;
//  port	FanFailedFanSensor		noerr	;  // renamed
  port	FanStatPresSensorOffset	noerr	; // new name
  port	FanFanTooSmall			noerr	;
  port	FanRangeErrorVFD		noerr	;
  port	FanStuckFanSpeed		noerr	;
  port	FanTotFanFailure		noerr	;
  port	FanWrongFanType			noerr	;
// MIXING BOX INPUTS   - removed MXPI, BC-Feb22-08
//  port	MXbias					;
//  port	MXfr					noerr	;
//  port	MXKd					noerr	;
//  port	MXKi					;
//  port	MXKp					;
  port	MXTRet					;
  port	MXTwRet					;
// MIXING BOX FAULTS
  port	MXBadPosOADamper		noerr	;
  port	MXBadSensor				noerr	;
  port	MXDeafActuator			noerr	;
  port	MXLeakOADamper			;
//  port	MXLeakRetDamper			;  // renamed
  port	MXLeakRADamper			; // new name
  port	MXMismatchDampAct		noerr	;
  port	MXReverseActionAct		noerr	;
  port	MXStuckActuator			;
  port	MXStuckOADamper			noerr	;
// VAV BOX INPUTS
  port	VAVbias					;
  port	VAVDAMPbias				;
  port	VAVDAMPfr				noerr	;
  port	VAVDAMPKd				noerr	;
  port	VAVDAMPKi				;
  port	VAVDAMPKp				;
  port	VAVfr					noerr	;
  port	VAVHCmLiqOpen			;
  port	VAVHCStatus				noerr	;
  port	VAVHCTLiqEnt			;
  port	VAVHCTs					noerr	;
  port	VAVHCUA					;
  port	VAVKd					noerr	;
  port	VAVKi					;
  port	VAVKp					;
  port	VAVposMin				noerr	;
// VAV BOX FAULTS
  port	VAVBadDmprPosSignal		noerr	;
//  port	VAVBadFlowerMeas		;  // renamed
  port	VAVFlowSensorOffset		; // new name
  port	VAVBadLoopTune			noerr	;
  port	VAVBadMinPosDamper		noerr	;
  port	VAVBadReheatCoil		noerr	;
//  port	VAVBadZoneMeas			;
  port	VAVBoxTooBig			noerr	;
  port	VAVBoxTooSmall			noerr	;
//  port	VAVDeafActuator			noerr	;  // rename
  port	VAVFailedActuator			noerr	;  // new name
  port	VAVHCBootLeakage		noerr	;
  port	VAVHCDriftedsensor		noerr	;
  port	VAVHCFouledCoil			noerr	;
  port	VAVHCLeakyValve			;
  port	VAVHCObstructedPipe		noerr	;
  port	VAVHCOversizedValve		;
  port	VAVHCStuckValve			;
  port	VAVHCUndersizedCoil		noerr	;
  port	VAVLeakyDamper			noerr	;
  port	VAVStuckDamper			;
  port	VAVTooHighInletAirSP	noerr	;
  port	VAVTooLowInletAirSP		noerr	;
// FILTER INPUTS
// FILTER FAULTS
  port	FltBadDPSensor			;
  port	FltLeakyFilter			noerr	;
  port	FltPartlyClogged		;
// SYSTEM INPUTS
  port	PAtm					;
  port	RmQSENS					;
  port	TAirOut					;
  port	TRoomSP_Heat			;
  port	TRoomSP_Cool			;
  port	HeatCoolMode			;
  port	TRoomSPDB				;
  port	TSupS					;
  port	TSupSensorOffset		;
  port	TwAirOut				;
// SYSTEM FAULTS
// SIMULATION INPUTS
  port	calcInterval			;
  port	Pause					noerr	;
  port	timeScale				;
// RUN CONTROL
  port    SPARKRUN				;
  port 	MXminOAfrac				; // Added BC-Feb22-08

// Boiler, Chiller and Cooling Tower inputs, added BC-Jul10-08
  port BOItset ;
  port BOIcap ;
  port CHLevapset ;
  port CHLcondflow ;
  port CHLcondin ;
  port CHLcap ;
  port CTWwaterflow ;
  port CTWtin ;
  port CTWmakeuptemp ;

  
  EQUATIONS {
	
  }

  FUNCTIONS {
HeatCoolbias				   ,HeatCoolfr				   ,HeatCoolKd				   ,HeatCoolKi				   ,HeatCoolKp				,HeatCoolS1				,HeatCoolS2				   ,HCUA				   ,HCmLiqOpen			   ,HCStatus			   ,HCTLiqEnt			   ,HCBootLeakage			,HCDriftedsensor		,HCFouledCoil			,HCLeakyValve			,HCObstructedPipe		,HCOversizedValve		,HCSensorOffset			,HCStuckValve			,HCUndersizedCoil				,CCmLiqOpen				,CCStatus				,CCTLiqEnt				,CCUA					,CCBootLeakage			,CCFouledCoil			,CCLeakyValve			,CCObstructedPipe		,CCOversizedValve		,CCStuckValve			,CCUndersizedCoil		,Fanbias				,Fanfr					,FanKd					,FanKi					,FanKp					,FanmAirLvg				,FanmAirMax				,FanpStat				,FanDeafVFDorIGV		,FanStatPresSensorOffset,				FanFanTooSmall			,FanRangeErrorVFD		,FanStuckFanSpeed		,FanTotFanFailure		,FanWrongFanType		,MXTRet					,MXTwRet				,MXBadPosOADamper		,MXBadSensor			,MXDeafActuator			,MXLeakOADamper			,MXLeakRADamper		,MXMismatchDampAct		,MXReverseActionAct		,MXStuckActuator		,MXStuckOADamper		,VAVbias				,VAVDAMPbias			,VAVDAMPfr				,VAVDAMPKd				,VAVDAMPKi				,VAVDAMPKp				,VAVfr					,VAVHCmLiqOpen			,VAVHCStatus			,VAVHCTLiqEnt			,VAVHCTs				,VAVHCUA				,VAVKd					,VAVKi					,VAVKp					,VAVposMin				,VAVBadDmprPosSignal	,VAVFlowSensorOffset	,VAVBadLoopTune			,VAVBadMinPosDamper		,VAVBadReheatCoil		,VAVBoxTooBig			,VAVBoxTooSmall			,VAVFailedActuator		,VAVHCBootLeakage		,VAVHCDriftedsensor		,VAVHCFouledCoil		,VAVHCLeakyValve		,VAVHCObstructedPipe	,VAVHCOversizedValve	,VAVHCStuckValve		,VAVHCUndersizedCoil	,VAVLeakyDamper			,VAVStuckDamper			,VAVTooHighInletAirSP	,VAVTooLowInletAirSP	,FltBadDPSensor			,FltLeakyFilter			,FltPartlyClogged		,PAtm					,RmQSENS				,TAirOut				,TRoomSP_Heat				,TRoomSP_Cool				,HeatCoolMode				,TRoomSPDB				,TSupS					,TSupSensorOffset		,TwAirOut				,calcInterval			,Pause					,timeScale				,SPARKRUN				,MXminOAfrac ,BOItset ,BOIcap ,CHLevapset ,CHLcondflow ,CHLcondin ,CHLcap ,CTWwaterflow ,CTWtin ,CTWmakeuptemp = readin(inpdummy);
  }  // Added MXminOAfrac and HeatCool Controller parameters, removed HCPI, MXPI, CCPI, BC-Feb22-08,  removed VAVBadZoneMeas, BC-May28-08, added Boiler, Chiller and Cooling Tower

  
#endif /* SPARK_PARSER */

#include "spark.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <string.h>
//#include <iostream.h>

///////////////////////////////////////////////////////////
EVALUATE (readin)
  {

  ARGDEF(0,inpdummy);

// HEATCOOL SPLIT-RANGE CONTROL INPUTS  - Added BC-Feb22-08
  double	HeatCoolbias					;
  double	HeatCoolfr						;
  double	HeatCoolKd						;
  double	HeatCoolKi					;
  double	HeatCoolKp					;  
  double	HeatCoolS1				;
  double	HeatCoolS2				;
// HEATING COIL INPUTS          - removed HCPI BC-Feb22-08
//  double	HCbias					;             
//  double	HCfr						;
//  double	HCKd						;         
//  double	HCKi					;
  double	HCKp					;
  double	HCUA					;
  double	HCmLiqOpen				;          
  double	HCStatus				;            
  double	HCTLiqEnt				;           
// HEATING COIL FAULTS          
  double	HCBootLeakage			;        
  double	HCDriftedsensor				;
  double	HCFouledCoil			;         
  double	HCLeakyValve			;         
  double	HCObstructedPipe		;      
  double	HCOversizedValve		;      
  double	HCSensorOffset				; 
  double	HCStuckValve			;         
  double	HCUndersizedCoil		;      
// COOLING COIL INPUTS    - removed CCPI, BC-Feb22=08
//  double	CCbias					;       
//  double	CCfr						;   
//  double	CCKd						;   
//  double	CCKi					;         
//  double	CCKp					;         
  double	CCmLiqOpen				;    
  double	CCStatus				;      
  double	CCTLiqEnt				;     
  double	CCUA					;         
// COOLING COIL FAULTS    
  double	CCBootLeakage			;  
  double	CCFouledCoil			;   
  double	CCLeakyValve			;   
  double	CCObstructedPipe		;
  double	CCOversizedValve		;
  double	CCStuckValve			;   
  double	CCUndersizedCoil		;
// FAN INPUTS             
  double	Fanbias					;      
  double	Fanfr						;
  double	FanKd						;  
  double	FanKi					;        
  double	FanKp					;        
  double	FanmAirLvg				;    
  double	FanmAirMax				;    
  double	FanpStat				;      
// FAN FAULTS                     
//  double	FanBadFanRotationnDir	;    
  double	FanDeafVFDorIGV			;        
//  double	FanFailedFanSensor		;     // renamed
  double	FanStatPresSensorOffset		; // new name     
  double	FanFanTooSmall			;         
  double	FanRangeErrorVFD		;        
  double	FanStuckFanSpeed			;  
  double	FanTotFanFailure		;        
  double	FanWrongFanType				;  
// MIXING BOX INPUTS              - removed MXPI, BC-Feb22-08
//  double	MXbias					;      
//  double	MXfr						;  
//  double	MXKd						;   
//  double	MXKi					;             
//  double	MXKp					;           
  double	MXTRet					;           
  double	MXTwRet					;              
// MIXING BOX FAULTS              
  double	MXBadPosOADamper			;  
  double	MXBadSensor					;     
  double	MXDeafActuator				;   
  double	MXLeakOADamper			;         
//  double	MXLeakRetDamper			;   // renamed 
  double	MXLeakRADamper			;   // new name     
  double	MXMismatchDampAct			; 
  double	MXReverseActionAct			;
  double	MXStuckActuator			;        
  double	MXStuckOADamper				;  
// VAV BOX INPUTS                  
  double	VAVbias					;         
  double	VAVDAMPbias				;            
  double	VAVDAMPfr					;        
  double	VAVDAMPKd					;        
  double	VAVDAMPKi				;              
  double	VAVDAMPKp				;              
  double	VAVfr						;     
  double	VAVHCmLiqOpen			;           
  double	VAVHCStatus				;            
  double	VAVHCTLiqEnt			;            
  double	VAVHCTs					;               
  double	VAVHCUA					;               
  double	VAVKd						;                 
  double	VAVKi					;                 
  double	VAVKp					;                 
  double	VAVposMin				;              
// VAV BOX FAULTS                  
  double	VAVBadDmprPosSignal			;
//  double	VAVBadFlowerMeas		;      // renamed   
  double	VAVFlowSensorOffset		;  // new name        
  double	VAVBadLoopTune				;    
  double	VAVBadMinPosDamper			; 
  double	VAVBadReheatCoil			;   
//  double	VAVBadZoneMeas			;          
  double	VAVBoxTooBig				;      
  double	VAVBoxTooSmall				;    
//  double	VAVDeafActuator				;   // renamed
  double	VAVFailedActuator				;   // new name
  double	VAVHCBootLeakage			;   
  double	VAVHCDriftedsensor			; 
  double	VAVHCFouledCoil				;   
  double	VAVHCLeakyValve			;         
  double	VAVHCObstructedPipe			;
  double	VAVHCOversizedValve		;      
  double	VAVHCStuckValve			;         
  double	VAVHCUndersizedCoil			;
  double	VAVLeakyDamper				;    
  double	VAVStuckDamper			;          
  double	VAVTooHighInletAirSP		;
  double	VAVTooLowInletAirSP			;
// FILTER INPUTS                   
// FILTER FAULTS                   
  double	FltBadDPSensor			;          
  double	FltLeakyFilter				;    
  double	FltPartlyClogged		;         
// SYSTEM INPUTS                   
  double	PAtm					;                  
  double	RmQSENS					;               
  double	TAirOut					;               
  double	TRoomSP_Heat			;               
  double	TRoomSP_Cool			;               
  double	HeatCoolMode			;               
  double	TRoomSPDB				;              
  double	TSupS					;                 
  double	TSupSensorOffset		;         
  double	TwAirOut				;               
// SYSTEM FAULTS                   
// SIMULATION INPUTS               
  double	calcInterval			;            
  double	Pause					;                 
  double	timeScale				;              
// RUN CONTROL                     
  double    SPARKRUN				;              
  double	MXminOAfrac				;  // Added BC-Feb22-08

// Boiler, Chiller and Cooling Tower inputs, added BC-Jul10-08
  double	BOItset ;
  double	BOIcap ;
  double	CHLevapset ;
  double	CHLcondflow ;
  double	CHLcondin ;
  double	CHLcap ;
  double	CTWwaterflow ;
  double	CTWtin ;
  double	CTWmakeuptemp ;  

  FILE *F1;
  F1 = fopen("input.txt", "r");

//  double Pause =0.0;

  while (!feof (F1)  )
  {

	char a[100];
	char line[100];
	
	double b = 0.0;
	fgets (line, sizeof(line), F1); 
	char * token =strtok(line, ":"); 
	if(token != NULL) 
		strcpy (a,token);
//cout<<"a="<<a<<endl;
	token = strtok(NULL, ":"); 
	if(token != NULL) 
        	b = atof(token); 
//cout<<"b="<<b<<endl;

// HEATCOOL SPLIT-RANGE CONTROL INPUTS  - Added BC-Feb22-08
  if      (strcmp (a, "CObias")==0)    
  HeatCoolbias =b; 
  else if (strcmp (a, "COfr")==0)    
  HeatCoolfr =b; 
  else if (strcmp (a, "COKd")==0)    
  HeatCoolKd =b; 
  else if (strcmp (a, "COki")==0)    
  HeatCoolKi =b; 
  else if (strcmp (a, "COKp")==0)    
  HeatCoolKp =b; 
  else if (strcmp (a, "COs1")==0)    
  HeatCoolS1 =b; 
  else if (strcmp (a, "COs2")==0)    
  HeatCoolS2 =b;   
// HEATING COIL INPUTS  - removed HCPI - BC-Feb22-08
//  if      (strcmp (a, "HCbias")==0)    
//  HCbias =b; 
//  else if (strcmp (a, "HCfr")==0)    
//  HCfr =b; 
//  else if (strcmp (a, "HCKd")==0)    
//  HCKd =b; 
//  else if (strcmp (a, "HCKi")==0)    
//  HCKi =b; 
//  else if (strcmp (a, "HCKp")==0)    
//  HCKp =b; 
  else if (strcmp (a, "HCUA")==0)    
  HCUA =b; 
  else if (strcmp (a, "HCmLiqOpen")==0)    
  HCmLiqOpen =b; 
  else if (strcmp (a, "HCStatus")==0)    
  HCStatus =b; 
  else if (strcmp (a, "HCTLiqEnt")==0)    
  HCTLiqEnt =b; 
// HEATING COIL FAULTS
  else if (strcmp (a, "HCBootLeakage")==0)    
  HCBootLeakage =b; 
  else if (strcmp (a, "HCDriftedsensor")==0)    
  HCDriftedsensor =b; 
  else if (strcmp (a, "HCFouledCoil")==0)   
  HCFouledCoil =b; 
  else if (strcmp (a, "HCLeakyValve")==0)    
  HCLeakyValve =b; 
  else if (strcmp (a, "HCObstructedPipe")==0)    
  HCObstructedPipe =b; 
  else if (strcmp (a, "HCOversizedValve")==0)    
  HCOversizedValve =b; 
  else if (strcmp (a, "HCSensorOffset")==0)    
  HCSensorOffset =b; 
  else if (strcmp (a, "HCStuckValve")==0)   
  HCStuckValve =b; 
  else if (strcmp (a, "HCUndersizedCoil")==0)    
  HCUndersizedCoil =b; 
// COOLING COIL INPUTS  - removed CCPI, BC-Feb22-08
//  else if (strcmp (a, "CCbias")==0)    
//  CCbias =b; 
//  else if (strcmp (a, "CCfr")==0)  
//  CCfr =b; 
//  else if (strcmp (a, "CCKd")==0)   
//  CCKd =b; 
//  else if (strcmp (a, "CCKi")==0)    
//  CCKi =b; 
//  else if (strcmp (a, "CCKp")==0)   
//  CCKp =b; 
  else if (strcmp (a, "CCmLiqOpen")==0)    
  CCmLiqOpen =b; 
  else if (strcmp (a, "CCStatus")==0)  
  CCStatus =b; 
  else if (strcmp (a, "CCTLiqEnt")==0)    
  CCTLiqEnt =b; 
  else if (strcmp (a, "CCUA")==0)  
  CCUA =b; 
// COOLING COIL FAULTS
  else if (strcmp (a, "CCBootLeakage")==0)   
  CCBootLeakage =b; 
  else if (strcmp (a, "CCFouledCoil")==0)  
  CCFouledCoil =b; 
  else if (strcmp (a, "CCLeakyValve")==0)   
  CCLeakyValve =b; 
  else if (strcmp (a, "CCObstructedPipe")==0)   
  CCObstructedPipe =b; 
  else if (strcmp (a, "CCOversizedValve")==0)   
  CCOversizedValve =b; 
  else if (strcmp (a, "CCStuckValve")==0) 
  CCStuckValve =b; 
  else if (strcmp (a, "CCUndersizedCoil")==0)  
  CCUndersizedCoil =b; 
// FAN INPUTS
  else if (strcmp (a, "Fanbias")==0)  
  Fanbias =b; 
  else if (strcmp (a, "Fanfr")==0)   
  Fanfr =b; 
  else if (strcmp (a, "FanKd")==0)   
  FanKd =b; 
  else if (strcmp (a, "FanKi")==0)  
  FanKi =b; 
  else if (strcmp (a, "FanKp")==0) 
  FanKp =b; 
  else if (strcmp (a, "FanmAirLvg")==0)  
  FanmAirLvg =b; 
  else if (strcmp (a, "FanmAirMax")==0)   
  FanmAirMax =b; 
  else if (strcmp (a, "FanpStat")==0)   
  FanpStat =b; 
// FAN FAULTS
//  else if (strcmp (a, "FanBadFanRotationnDir")==0)
//  FanBadFanRotationnDir =b; 
  else if (strcmp (a, "FanDeafVFDorIGV")==0)   
  FanDeafVFDorIGV =b; 
  else if (strcmp (a, "FanFailedFanSensor")==0)  
  FanStatPresSensorOffset =b; // new name
//  FanFailedFanSensor =b; // old name
  else if (strcmp (a, "FanFanTooSmall")==0)   
  FanFanTooSmall =b; 
  else if (strcmp (a, "FanRangeErrorVFD")==0)   
  FanRangeErrorVFD =b; 
  else if (strcmp (a, "FanStuckFanSpeed")==0)   
  FanStuckFanSpeed =b; 
  else if (strcmp (a, "FanTotFanFailure")==0)   
  FanTotFanFailure =b; 
  else if (strcmp (a, "FanWrongFanType")==0) 
  FanWrongFanType =b; 
// MIXING BOX INPUTS  - removed MXPI, BC-Feb22-08
//  else if (strcmp (a, "MXbias")==0)   
//  MXbias =b; 
//  else if (strcmp (a, "MXfr")==0)    
//  MXfr =b; 
//  else if (strcmp (a, "MXKd")==0)   
//  MXKd =b; 
//  else if (strcmp (a, "MXKi")==0)  
//  MXKi =b; 
//  else if (strcmp (a, "MXKp")==0)  
//  MXKp =b; 
  else if (strcmp (a, "MXTRet")==0)   
  MXTRet =b; 
  else if (strcmp (a, "MXTwRet")==0)    
  MXTwRet =b; 
// MIXING BOX FAULTS
  else if (strcmp (a, "MXBadPosOADamper")==0)   
  MXBadPosOADamper =b; 
  else if (strcmp (a, "MXBadSensor")==0)    
  MXBadSensor =b; 
  else if (strcmp (a, "MXDeafActuator")==0)   
  MXDeafActuator =b; 
  else if (strcmp (a, "MXLeakOADamper")==0)  
  MXLeakOADamper =b; 
  else if (strcmp (a, "MXLeakRetDamper")==0)   
  MXLeakRADamper =b; // new name
//  MXLeakRetDamper =b;          // renamed
  else if (strcmp (a, "MXMismatchDampAct")==0)    
  MXMismatchDampAct =b; 
  else if (strcmp (a, "MXReverseActionAct")==0)    
  MXReverseActionAct =b; 
  else if (strcmp (a, "MXStuckActuator")==0)    
  MXStuckActuator =b; 
  else if (strcmp (a, "MXStuckOADamper")==0)   
  MXStuckOADamper =b; 
// VAV BOX INPUTS
  else if (strcmp (a, "VAVbias")==0)  
  VAVbias =b; 
  else if (strcmp (a, "VAVDAMPbias")==0)    
  VAVDAMPbias =b; 
  else if (strcmp (a, "VAVDAMPfr")==0)    
  VAVDAMPfr =b; 
  else if (strcmp (a, "VAVDAMPKd")==0)   
  VAVDAMPKd =b; 
  else if (strcmp (a, "VAVDAMPKi")==0)   
  VAVDAMPKi =b; 
  else if (strcmp (a, "VAVDAMPKp")==0)  
  VAVDAMPKp =b; 
  else if (strcmp (a, "VAVHCmLiqOpen")==0)   
  VAVHCmLiqOpen =b; 
  else if (strcmp (a, "VAVfr")==0) 
  VAVfr =b; 
  else if (strcmp (a, "VAVHCStatus")==0)    
  VAVHCStatus =b; 
  else if (strcmp (a, "VAVHCTLiqEnt")==0)   
  VAVHCTLiqEnt =b; 
  else if (strcmp (a, "VAVHCTs")==0)   
  VAVHCTs =b; 
  else if (strcmp (a, "VAVHCUA")==0)  
  VAVHCUA =b; 
  else if (strcmp (a, "VAVKd")==0)   
  VAVKd =b; 
  else if (strcmp (a, "VAVKi")==0)   
  VAVKi =b; 
  else if (strcmp (a, "VAVKp")==0)    
  VAVKp =b; 
  else if (strcmp (a, "VAVposMin")==0)   
  VAVposMin =b; 
// VAV BOX FAULTS
  else if (strcmp (a, "VAVBadDmprPosSignal")==0)   
  VAVBadDmprPosSignal =b; 
  else if (strcmp (a, "VAVBadFlowerMeas")==0) 
  VAVFlowSensorOffset =b;   // new name
//  VAVBadFlowerMeas =b; // old name
  else if (strcmp (a, "VAVBadLoopTune")==0)  
  VAVBadLoopTune =b; 
  else if (strcmp (a, "VAVBadMinPosDamper")==0)  
  VAVBadMinPosDamper =b; 
  else if (strcmp (a, "VAVBadReheatCoil")==0)   
  VAVBadReheatCoil =b; 
//  else if (strcmp (a, "VAVBadZoneMeas")==0)  
//  VAVBadZoneMeas =b; 
  else if (strcmp (a, "VAVBoxTooBig")==0)    
  VAVBoxTooBig =b; 
  else if (strcmp (a, "VAVBoxTooSmall")==0)  
  VAVBoxTooSmall =b; 
  else if (strcmp (a, "VAVDeafActuator")==0) 
  VAVFailedActuator =b; // new name
//  VAVDeafActuator =b;  // old name
  else if (strcmp (a, "VAVHCBootLeakage")==0)  
  VAVHCBootLeakage =b; 
  else if (strcmp (a, "VAVHCDriftedsensor")==0)  
  VAVHCDriftedsensor =b; 
  else if (strcmp (a, "VAVHCFouledCoil")==0)   
  VAVHCFouledCoil =b; 
  else if (strcmp (a, "VAVHCLeakyValve")==0)  
  VAVHCLeakyValve =b; 
  else if (strcmp (a, "VAVHCObstructedPipe")==0)  
  VAVHCObstructedPipe =b; 
  else if (strcmp (a, "VAVHCOversizedValve")==0)  
  VAVHCOversizedValve =b; 
  else if (strcmp (a, "VAVHCStuckValve")==0)  
  VAVHCStuckValve =b; 
  else if (strcmp (a, "VAVHCUndersizedCoil")==0)   
  VAVHCUndersizedCoil =b; 
  else if (strcmp (a, "VAVLeakyDamper")==0)  
  VAVLeakyDamper =b; 
  else if (strcmp (a, "VAVStuckDamper")==0)  
  VAVStuckDamper =b; 
  else if (strcmp (a, "VAVTooHighInletAirSP")==0)  
  VAVTooHighInletAirSP =b; 
  else if (strcmp (a, "VAVTooLowInletAirSP")==0) 
  VAVTooLowInletAirSP =b; 
// FILTER INPUTS
// FILTER FAULTS
  else if (strcmp (a, "FltBadDPSensor")==0)  
  FltBadDPSensor =b; 
  else if (strcmp (a, "FltLeakyFilter")==0) 
  FltLeakyFilter =b; 
  else if (strcmp (a, "FltPartlyClogged")==0)  
  FltPartlyClogged =b; 
// SYSTEM INPUTS
  else if (strcmp (a, "PAtm")==0)    
  PAtm =b; 
  else if (strcmp (a, "RmQSENS")==0)    
  RmQSENS =b; 
  else if (strcmp (a, "TAirOut")==0)    
  TAirOut =b; 
  else if (strcmp (a, "TRoomSP_Heat")==0)  
  TRoomSP_Heat =b; 
  else if (strcmp (a, "TRoomSP_Cool")==0)  
  TRoomSP_Cool =b; 
  else if (strcmp (a, "HeatCoolMode")==0)  
  HeatCoolMode =b; 
  else if (strcmp (a, "TRoomSPDB")==0)  
  TRoomSPDB =b; 
  else if (strcmp (a, "TSupS")==0)  
  TSupS =b; 
  else if (strcmp (a, "TSupSensorOffset")==0)  
  TSupSensorOffset =b; 
  else if (strcmp (a,"TwAirOut")==0)
  TwAirOut = b;
// SYSTEM FAULTS
// SIMULATION INPUTS
  else if (strcmp (a,"calcInterval")==0)
  calcInterval = b;
  else if (strcmp (a, "Pause")==0)    
  Pause =b; 
  else if (strcmp (a, "timeScale")==0)   
  timeScale =b; 
// RUN CONTROL
  else if (strcmp (a, "SPARKRUN")==0)   
  SPARKRUN =b; 
// MXminOAfrac - Added BC-Feb22-08
  else if (strcmp (a, "MXminOAfrac")==0)   
  MXminOAfrac =b; 

// Boiler, Chiller and Cooling Tower inputs, added BC-Jul10-08
  else if (strcmp (a, "BOItset")==0) 
  BOItset =b;
  else if (strcmp (a, "BOIcap")==0) 
  BOIcap =b;
  else if (strcmp (a, "CHLevapset")==0) 
  CHLevapset =b;
  else if (strcmp (a, "CHLcondflow")==0) 
  CHLcondflow =b;
  else if (strcmp (a, "CHLcondin")==0) 
  CHLcondin =b;
  else if (strcmp (a, "CHLcap")==0) 
  CHLcap =b;
  else if (strcmp (a, "CTWwaterflow")==0) 
  CTWwaterflow =b;
  else if (strcmp (a, "CTWtin")==0) 
  CTWtin =b;
  else if (strcmp (a, "CTWmakeuptemp")==0) 
  CTWmakeuptemp =b;  

  
  }
 

  fclose(F1);


  if (Pause==1)
  {
  
  while (Pause ==1)
    {
          F1 = fopen("input.txt", "r");
  	char a[100];
  	char line[100];
  	
  	double b = 0.0;
  	fgets (line, sizeof(line), F1); 
  	char * token =strtok(line, ":"); 
  	if(token != NULL) 
  		strcpy (a,token);
  	token = strtok(NULL, ":"); 
  	if(token != NULL) 
        	b = atof(token); 
	if (strcmp (a,"Pause")==0)
		Pause=b;
	fclose(F1);
    }


  }
  
  BEGIN_RETURN
  	HeatCoolbias					,  // Added BC-Feb22-08             
  	HeatCoolfr						,             
  	HeatCoolKd						,             
  	HeatCoolKi					,                 
  	HeatCoolKp					,                 
	HeatCoolS1				,
	HeatCoolS2				,
	//  	HCbias					,           //    Removed BC-Feb22-08
//  	HCfr						,             
//  	HCKd						,             
//  	HCKi					,                 
//  	HCKp					,                 
  	HCUA					,                 
  	HCmLiqOpen				,            
  	HCStatus				,              
  	HCTLiqEnt				,             
  	HCBootLeakage			,          
  	HCDriftedsensor				,       
  	HCFouledCoil			,           
  	HCLeakyValve			,           
  	HCObstructedPipe		,        
  	HCOversizedValve		,        
  	HCSensorOffset				,        
  	HCStuckValve			,           
  	HCUndersizedCoil		,        
//  	CCbias					,        	//	Removed BC-Feb22-08         
//  	CCfr						,             
//  	CCKd						,             
//  	CCKi					,                 
//  	CCKp					,                 
  	CCmLiqOpen				,            
  	CCStatus				,              
  	CCTLiqEnt				,             
  	CCUA					,                 
  	CCBootLeakage			,          
  	CCFouledCoil			,           
  	CCLeakyValve			,           
  	CCObstructedPipe		,        
  	CCOversizedValve		,        
  	CCStuckValve			,           
  	CCUndersizedCoil		,        
  	Fanbias					,              
  	Fanfr						,            
  	FanKd						,            
  	FanKi					,                
  	FanKp					,                
  	FanmAirLvg				,            
  	FanmAirMax				,            
  	FanpStat				,              
//  	FanBadFanRotationnDir	,    
  	FanDeafVFDorIGV			,        
//  	FanFailedFanSensor		,      // renamed
  	FanStatPresSensorOffset		,   // new name   
  	FanFanTooSmall			,         
  	FanRangeErrorVFD		,        
  	FanStuckFanSpeed			,       
  	FanTotFanFailure		,        
  	FanWrongFanType				,       
//  	MXbias					,              	// Removed BC-Feb22-08 
//  	MXfr					,                 
//  	MXKd					,                 
//  	MXKi					,                 
//  	MXKp					,                 
  	MXTRet					,               
  	MXTwRet					,              
  	MXBadPosOADamper			,       
  	MXBadSensor					,          
  	MXDeafActuator				,        
  	MXLeakOADamper			,         
//  	MXLeakRetDamper			,        // renamed
  	MXLeakRADamper			,  // new name      
  	MXMismatchDampAct			,      
  	MXReverseActionAct			,     
  	MXStuckActuator			,        
  	MXStuckOADamper				,       
  	VAVbias					,              
  	VAVDAMPbias				,           
  	VAVDAMPfr					,             
  	VAVDAMPKd					,            
  	VAVDAMPKi				,             
  	VAVDAMPKp				,             
  	VAVfr						,             
  	VAVHCmLiqOpen			,          
  	VAVHCStatus				,           
  	VAVHCTLiqEnt			,           
  	VAVHCTs					,              
  	VAVHCUA					,              
  	VAVKd					,                
  	VAVKi					,                
  	VAVKp					,                
  	VAVposMin				,             
  	VAVBadDmprPosSignal			,    
  	VAVFlowSensorOffset		,   // new name     
  	VAVBadLoopTune				,        
  	VAVBadMinPosDamper			,     
  	VAVBadReheatCoil			,       
//  	VAVBadZoneMeas			,         
  	VAVBoxTooBig				,          
  	VAVBoxTooSmall				,        
  	VAVFailedActuator				,  // new name     
  	VAVHCBootLeakage			,       
  	VAVHCDriftedsensor			,     
  	VAVHCFouledCoil				,       
  	VAVHCLeakyValve			,        
  	VAVHCObstructedPipe			,    
  	VAVHCOversizedValve		,     
  	VAVHCStuckValve			,        
  	VAVHCUndersizedCoil			,    
  	VAVLeakyDamper				,        
  	VAVStuckDamper			,         
  	VAVTooHighInletAirSP		,    
  	VAVTooLowInletAirSP			,    
  	FltBadDPSensor			,         
  	FltLeakyFilter				,            
  	FltPartlyClogged		,            
  	PAtm					,                 
  	RmQSENS					,               
  	TAirOut					,               
  	TRoomSP_Heat			,                
  	TRoomSP_Cool			,                
  	HeatCoolMode			,                
  	TRoomSPDB				,      
  	TSupS					,                
  	TSupSensorOffset		,        
  	TwAirOut				,              
  	calcInterval			,           
  	Pause					,                
  	timeScale				,             
    SPARKRUN				,          
	MXminOAfrac				,
	BOItset 				,
	BOIcap 					,
	CHLevapset 				,
	CHLcondflow 			,
	CHLcondin 				,
	CHLcap 					,
	CTWwaterflow 			,
	CTWtin 					,
	CTWmakeuptemp 

	END_RETURN  
  
}                                    