! ParamCalc.inc

! Large Office calculated Parameters  

! Next line no longer needed. Input directly in SI from LearnHVAC. See Param_LgOff 
!  ##set1 Floor_Area     =  #[Floor_Area_FT[] / 10.76]

! New length and width calcs using SI inputs from LearnHVAC
!
  ##set1 Long_Len       =  #[SQRT OF #[Aspect_Ratio[] * #[Floor_Area[] / Floors[]]]]
  ##set1 Width_Len      =  #[Long_Len[] / Aspect_Ratio[]]

! Old code for I-P units, no longer used
!  ##set1 Long_Len_FT    =  #[SQRT OF #[Aspect_Ratio[] * #[Floor_Area_FT[] / Floors[]]]]
!  ##set1 Long_Len       =  #[Long_Len_FT[]   /  3.28]
!  ##set1 Width_Len_FT   =  #[Long_Len_FT[] / Aspect_Ratio[]]
!  ##set1 Width_Len      =  #[Width_Len_FT[]  /  3.28]
!  ##set1 P_Width        =  #[P_Width_FT[]    /  3.28]

! Old code for I-P units, no longer used. See Param_LgOff 
!
!  ##set1 C_Height       =  #[C_Height_FT[]   /  3.28]
!  ##set1 B_Height       =  #[B_Height_FT[]   /  3.28]

 ##set1 Multplr      =     #[Floors[] - 2]

  ##set1 W_W_Ratio[]  =     WinFrac[]

  ##set1 W_Height     =     #[C_Height[] * W_W_Ratio[]]
  ##set1 Wall_Por     =     #[C_Height[] - W_Height[]]
  ##set1 W_Z_Low      =     #[Wall_Por[] / 2]
  ##set1 W_Z_High     =     #[W_Z_Low[] + W_Height[]]


! This is in units of SqFt per Person, converted to SqM per person (JJD)
! no longer used - set to Sqm_perPerson in Param_LGPfc.inc
!  ##set1 People_Sqm   =     #[People_Sqft[] / 10.76]

!These are in units of X per SqFt converted to X per SqM (JJD) 
! no longer used.  See Param_LgOff

!  ##set1 Lights_Sqm   =     #[Lights_Sqft[] * 10.76]
!  ##set1 Equip_Sqm    =     #[Equip_Sqft[]  * 10.76]
!  ##set1 Equip_Base   =     #[Equip_Base_Sqft[]  * 10.76]
!  ##set1 Furn_Sqm     =     #[Furn_Sqft[]   * 10.76]


!  ##set1 Cool_SetPoint   =  #[#[Cool_SetPoint_F[] - 32] / 1.8]

!  ##set1 Cool_SetUp      =  #[#[Cool_SetUp_F[]    - 32] / 1.8]

!  ##set1 Heat_SetPoint   =  #[#[Heat_SetPoint_F[] - 32] / 1.8]

!  ##set1 Heat_SetBack    =  #[#[Heat_SetBack_F[]  - 32] / 1.8]

  ##set1 Outside_Air    =  #[#[#[#[Outside_Air_cfm[] / 60] / 3.28] / 3.28] / 3.28]


!  ##set1 Economizer_T     =  #[#[Economizer_T_F[] - 32] / 1.8]

! ------------------------------------------------------
!  ##set1 zhdsat           =  #[#[zhdsat_F[] - 32] / 1.8]
!  ##set1 zcdsat           =  #[#[zcdsat_F[] - 32] / 1.8]
!  ##set1 chdsat           =  #[#[chdsat_F[] - 32] / 1.8]
!  ##set1 ccdsat           =  #[#[ccdsat_F[] - 32] / 1.8]
!  ##set1 MOD_TRoomSP      =  #[#[MOD_TRoomSP_F[] - 32] / 1.8]
!  ##set1 MOD_CRoomSP      =  #[#[MOD_CRoomSP_F[] - 32] / 1.8]
!  ##set1 MOD_HRoomSP      =  #[#[MOD_HRoomSP_F[] - 32] / 1.8]
! ------------------------------------------------------

  ##set1 fan_dp           =  #[fan_dp_inh2o[]  * 249]

  ##set1 pump_head         = #[pump_psi[]  / 0.000145]

  ##set1 2P_Width       =    #[P_Width[] * 2]
  ##set1 P2_Width       =    #[P_Width[] / 2]
  ##set1 Core_Width     =    #[Width_Len[] - 2P_Width[]]
  ##set1 Core_Long      =    #[Long_Len[]  - 2P_Width[]]

  ##set1 Base_Area      =    #[Long_Len[] * Width_Len[]]

!for north and south perimeter zones
  ##set1 Perim-Long_Area     =    #[P_Width[] * #[Long_Len[]  - P_Width[]]]

!for east and west perimeter zones
  ##set1 Perim-Width_Area    =    #[P_Width[] * #[Width_Len[] - P_Width[]]]

  ##set1 Core_Area           =    #[Core_Width[] * Core_Long[]]


##! ---------------------------------------------------------------------------$
##!  B A S E M E N T  C O N S T R U C T I O N  C A L C U L A T I O N 
##! ---------------------------------------------------------------------------$

##!  For basement walls Reff = (basement height)/bwall_f and is the same for all walls
##!  FicLayer-Soil- 8" concrete

##! ##set1 Rsoil = 1.0 
##! ##set1 Rlin = 0.05
##! ##set1 Rcon = 0.32   8" heavy concrete --for basement walls
##! ##set1 Rfilm = 0.68  for vertical surfaces

 ##set1 Reff = #[ #[B_Height[] * 3.28] / bwall_f[]]
##! ##set1 Rfic = # [Reff[] - #[Rsoil[] + #[Rcon[] + Rfilm[]]]
 ##set1 Rfic = # [Reff[] - #[1.0 + #[0.64 + 0.68]]]
