

! ******************************************
! "Regular" inc file begins here 
! LH Configuration and/or fromSPARK 
! ******************************************
 

! following line gets replaced
! ##set1 Start_Day         UseWeatherFile

RunPeriod,  
    LH_startMonth[],  !- Begin Month 
    LH_startDay[],  !- Begin Day Of Month 
    LH_stopMonth[],  !- End Month 
    LH_stopDay[],  !- End Day Of Month 
    UseWeatherFile,  !- Day Of Week For Start Day 
    Yes,  !- Use WeatherFile Holidays/Special Days 
    Yes,  !- Use WeatherFile DaylightSavingPeriod 
    No,  !- Apply Weekend Holiday Rule 
    Yes,  !- Use WeatherFile Rain Indicators 
    Yes;  !- Use WeatherFile Snow Indicators 

!RunPeriod:Design, 
!    Summer including Extreme Summer days,  !- Name 
!    LH_SDD_startMonth[],                   !- Begin Month
!	LH_SDD_startDay[],                     !- Begin Day
!	LH_SDD_stopMonth[],                    !- End Month
!	LH_SDD_stopDay[],                      !- End Day 
!    LH_SDD_typeOfDD[],                     !- Day type 
!    No,                                    !- Use WeatherFile DaylightSavingPeriod 
!    No;                                    !- Use WeatherFile Rain/Snow Indicators 
 
!RunPeriod:Design, 
!    Winter including Extreme Winter days,  !- Name 
!    LH_WDD_startMonth[],                   !- Begin Month
!	LH_WDD_startDay[],                     !- Begin Day
!	LH_WDD_stopMonth[],                    !- End Month
!	LH_WDD_stopDay[],                      !- End Day 
!    LH_WDD_typeOfDD[],                     !- Day type 1
!    No,                                    !- Use WeatherFile DaylightSavingPeriod 
!    No;                                    !- Use WeatherFile Rain/Snow Indicators 


! -------------------------------------------
! Set 
!		region   <-- LH_region
!		location <-- LH_location
!		shell    <-- LH_shell
!
  ##set1 region     LH_region[]
  ##set1 location   LH_location[]
  ##set1 shell      LH_shell[] 

! -------------------------------------------

! -------------------------------------------
! Set Blg_Azimuth to value defined from Learn HVAC
!
  ##set1 Bldg_Azimuth     LH_Orientation[] 

!  ##set1 Bldg_Azimuth      0   NOTE: This is OLD line for Bldg_Azimuth 
! -------------------------------------------

! -------------------------------------------
! Set Aspect_Ratio to value defined from Learn HVAC
!
  ##set1 Aspect_Ratio     =     #[ LH_length[] / LH_width[] ]

! ##set1 Aspect_Ratio   =  1.5  NOTE: This is OLD line for Aspect_Ratio
! -------------------------------------------

! -------------------------------------------
! Set Floor_Area to value defined from Learn HVAC
! note - this is set directly in SI units from LearnHVAC, not I-P
!
  ##set1 Floor_Area    =  #[ #[LH_length[] * LH_width[] ] * LH_stories[] ]

! ##set1 Floor_Area_FT     460000  NOTE: This is OLD line for Floor_Area_FT
! -------------------------------------------

! -------------------------------------------
! Set Floors to value defined from Learn HVAC
!
  ##set1 Floors            LH_stories[] 

! ##set1 Floors            12    NOTE: This is OLD line for Floors
! -------------------------------------------


! Currently I am not understanding C_Height_ft vs B_Height_Ft (JJD)
! will do some sleuthing

! note - this is set directly in SI units from LearnHVAC, not I-P

! C_Height Defaults: SI = 3, I-P = 10 where SI = I-P / 3.28
! B_Height Defaults: SI = 2.44, I-P = 8 where SI = I-P / 3.28
  ##set1 C_Height           3			 
  ##set1 B_Height           2.44

! values in FT no longer used
! ##set1 C_Height_Ft       10
! ##set1 B_Height_Ft        8

! This appears to be width (or depth) of the perimeter zone (JJD)
! setting this in SI units as 4.6 m or about 15 ft
! P_Width Defaults: SI = 4.6 I-P = 15 where SI = I-P / 3.28

  ##set1 P_Width           4.6     

! old line of code in FT, no longer used
! ##set1 P_Width_Ft        15

! This appears to be WWR for entire building, all 4 orientations (JJD)
! -------------------------------------------
! Set WinFrac to value defined from Learn HVAC
! This appears to be WWR for entire building, all 4 orientations (JJD)
! Much easier to calculate this in ActionScript than in the macro language
! So am assuming it has been calculated and fed into E+
!
  ##set1 WinFrac             LH_WWR_Bldg[] 

! ##set1 WinFrac           0.4    NOTE: This is OLD line for WinFrac 
! -------------------------------------------

!
! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
! Set internal Loads here. Uniform for entire building for now, since 
! LgOfc prototype assumes uniform internal loads 12 Oct 08 JJD
! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
!

! Defaults: Furn_Sqm = 0.5 while Furn_Sqft = 0.0465 (Not set in LEarn HVAC)

  ##set1 Furn_Sqm          0.5 			! 0.0465 * 10.76
  
! ##set1 Furn_Sqft         0.0465

! ACH not set in LearnHVAC

  ##set1 ACH               0.1
!  ##set1 ACH_Base          2

! -------------------------------------------
! Set Equip_Sqft to value defined from Learn HVAC
! Defaults: Set LH_equipPeakLoad = 8.1 [SI] or 0.75 [I-P] 

  ##set1 Equip_Sqm         LH_equipPeakLoad[]

! ##set1 Equip_Sqft        0.75  NOTE: This is OLD line for Equip_Sqft
! -------------------------------------------

!  ##set1 Equip_Base          4.84

!
! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
! Current People names in LgOfc are missleading, Therefore
! RENAMING "People_Sqft" to "Sqft_perPerson"
! REMANING "People_Sqm" to "Sqm_perPerson"
! JJD 12 Octo 08

! Set Sqft_perPerson to value defined from Learn HVAC
! Should be in units of SqFt per Person
! However, 417 sqft/person seems large to JJD
! 200 or 250 seems more reasonable
! wonder where the 417 came from
! For now, setting LH_areaPerPerson Default = 225 Sqft_perPerson (I-P)
! 										   or 20.91 Sqm_perPerson
!

  ##set1 Sqm_perPerson       LH_areaPerPerson[]

! ##set1 Sqft_perPerson 417   NOTE: This is OLD line for Sqft_perPerson
! -------------------------------------------

! now set directly in SI units here and no longer converted in ParamCalc
!

  ##if #[shell[] eqs old]
	  ##set1 Lights_Sqm 16.14			! 1.5 * 10.76
  ##elseif    #[shell[] eqs recent]
	  ##set1 Lights_Sqm 13.99			! 1.3 * 10.76
  ##elseif    #[shell[] eqs new]
	  ##set1 Lights_Sqm 10.76			! 1.0 * 10.76
  ##else
       	Abort -- building shell shell[] undefined 
  ##endif


! Following section has been moved up from bottom of file

  ##set1 Roof_Abs_Thm      0.8
  ##set1 Roof_Abs_Slr      0.8
  ##set1 Roof_Abs_vsb      0.8
  ##set1 Wall_Abs_Thm       0.65
  ##set1 Wall_Abs_Slr      0.65
  ##set1 Wall_Abs_vsb      0.65
  ##set1 Slab_u            6inSlab_097
  ##set1 Wind_Type         U_6.88_SHGC_0.34_VT_0.34
  ##set1 Wind_Shade      ""
  ##set1 Outside_Air_cfm       15

  ##if    #[shell[] eqs old] 
    ##set1 HVAC_System    CAV
  ##elseif    #[shell[] eqs new] 
    ##set1 HVAC_System    VAV
  ##endif

  ##set1 Termbox_Type    "AirTerminal:SingleDuct:VAV:REHEAT"
  ##set1 Coil_Type    COIL:Heating:Water
  ##set1 Coil_Heat    Water
  ##set1 Coil_Gas_Eff    0.8
  ##set1 Economizer_Y_N   ECONOMIZER

! -------------------------------------------
! NOTE: next line is for "minimum system air flow ratio"
! It is used in "system.inc"
! But its value can be set here, since all "*.inc" files are concatenated
! and are effectively the same file.

  ##set1 Min_Air_Flow    MOD_VAVminpos[] 	

! ##set1 Min_Air_Flow    0.3	NOTE: This is the OLD line for Min Air Flow	
! Note: this is at least JJD's interpretation that this is what is intended by this variable.
! don't have access to the SPARK models.
! -------------------------------------------

  ##set1 Chiller_COP    3
  ##set1 Boiler_Eff    	0.8
  ##set1 fan_eff_tot    0.65
  ##set1 fan_eff_mtr    0.9
  ##set1 pump_eff_mtr   0.9

! -------------------------------------------
! Set the various setpoints to values defined from Learn HVAC
!
  ##set1 Cool_SetPoint    MOD_CRoomSP[]	 
  ##set1 Cool_SetUp    	  32.2			! 32.2 C = Roughly 90 F
  ##set1 Heat_SetPoint    MOD_HRoomSP[]		! From LearnHVAC in SI units
  ##set1 Heat_SetBack     12.78			! 12.78 C = Roughly 55 F  

! ##set1 Cool_SetPoint_F    75   NOTE: this is OLD line for Cool_SetPoint_F
! ##set1 Heat_SetPoint_F    70   NOTE: this is OLD line for Heat_SetPoint_F
! -------------------------------------------

  ##set1 Econo_Lockout     NO
  ##set1 Economizer_T      20			! 20 C = Roughly 68 F  
  
! ##set1 Econo_Lockout     NO
! ##set1 Economizer_T_F    68

! -------------------------------------------
! now all set directly in SI units from LearnHVAC

  ##set1 zhdsat      MOD_DHSupS[]
! ##set1 zhdsat      40.56				! 40.56 C = abvout 105 F
  ##set1 zcdsat      MOD_DCSupS[]
  ##set1 chdsat      MOD_DCSupS[]
  ##set1 ccdsat      MOD_DCSupS[]

! -------------------------------------------

  ##set1 Return_Fan    Yes
  ##set1 Cooling_Coil    Simple
  ##set1 fan_dp_inh2o    5.5
  ##set1 pump_psi    26

! end of the moved section



! --------------------------------------------------
! Following is long IF-THEN sequence to set envelope 
! construction and insulation values by region 
! and age of bldg probably based on 
! ASHRAE 90.1 envelope requirements
! --------------------------------------------------

##if    #[region[] eqs Northeast]

	##if    #[shell[] eqs old]

		##if #[location[] eqs Baltimore]
			##set1 wall_r 6.5
     			##set1 roof_r 7.01
     			##set1 bwall_f 1.940
     			##set1 window_r 1.79
     			##set1 window_sc 1.0 

 		##elseif #[location[] eqs Burlington]
			##set1 wall_r 6.5
     			##set1 roof_r 11.78
     			##set1 bwall_f 1.940
     			##set1 window_r 1.79
     			##set1 window_sc 1.0 
	
		##elseif #[location[] eqs Chicago]
			##set1 wall_r 6.5
     			##set1 roof_r 9.00
     			##set1 bwall_f 1.940
     			##set1 window_r 1.79
     			##set1 window_sc 1.0

		##elseif #[location[] eqs Duluth]
			##set1 wall_r 6.5
     			##set1 roof_r 11.78
     			##set1 bwall_f 1.940
     			##set1 window_r 1.79
     			##set1 window_sc 1.0 
 
		##elseif #[location[] eqs Fairbanks]
			##set1 wall_r 6.5
     			##set1 roof_r 15.52
     			##set1 bwall_f 1.940
     			##set1 window_r 1.79
     			##set1 window_sc 1.0 

		##endif

	##elseif    #[shell[] eqs recent]

		##if #[location[] eqs Baltimore]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45

		##elseif #[location[] eqs Burlington]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45 
	
		##elseif #[location[] eqs Chicago]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45

		##elseif #[location[] eqs Duluth]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 0.770
     			##set1 window_r 1.75
     			##set1 window_sc 0.57
 
		##elseif #[location[] eqs Fairbanks]
    			##set1 wall_r 13
     			##set1 roof_r 20
     			##set1 bwall_f 0.770
     			##set1 window_r 2.22
     			##set1 window_sc 0.0001 
	
		##endif	

	##elseif    #[shell[] eqs new]

		##if #[location[] eqs Baltimore]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45

 		##elseif #[location[] eqs Burlington]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45 
	
		##elseif #[location[] eqs Chicago]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45

		##elseif #[location[] eqs Duluth]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 0.770
     			##set1 window_r 1.75
     			##set1 window_sc 0.57
 
		##elseif #[location[] eqs Fairbanks]
    			##set1 wall_r 13
     			##set1 roof_r 20
     			##set1 bwall_f 0.770
     			##set1 window_r 2.17
     			##set1 window_sc 0.0001

		##endif
	##endif


##elseif    #[region[] eqs South]

	##if    #[shell[] eqs old]

		##if #[location[] eqs Miami]
			##set1 wall_r 6.5
     			##set1 roof_r 5.11
     			##set1 bwall_f 1.940
     			##set1 window_r 0.91
     			##set1 window_sc 1.0

		##elseif #[location[] eqs Houston]
			##set1 wall_r 6.5
     			##set1 roof_r 5.11
     			##set1 bwall_f 1.940		
     			##set1 window_r 0.91
     			##set1 window_sc 1.0

		##elseif #[location[] eqs Memphis]
			##set1 wall_r 6.5
     			##set1 roof_r 5.31
     			##set1 bwall_f 1.940
     			##set1 window_r 0.91
     			##set1 window_sc 1.0  

		##elseif #[location[] eqs ElPaso]
			##set1 wall_r 6.5
     			##set1 roof_r 5.11
     			##set1 bwall_f 1.940
     			##set1 window_r 0.91
     			##set1 window_sc 1.0

		##elseif #[location[] eqs Albuquerque]
			##set1 wall_r 6.5
     			##set1 roof_r 6.47
     			##set1 bwall_f 1.940
     			##set1 window_r 1.79
     			##set1 window_sc 1.0  

		##endif

	##elseif    #[shell[] eqs recent]

		##if #[location[] eqs Miami]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 0.82
     			##set1 window_sc 0.29 

		##elseif #[location[] eqs Houston]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 0.82
     			##set1 window_sc 0.29 

		##elseif #[location[] eqs Memphis]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45 

		##elseif #[location[] eqs ElPaso]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.29

		##elseif #[location[] eqs Albuquerque]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45
 
		##endif

	##elseif    #[shell[] eqs new]

		##if #[location[] eqs Miami]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 0.82
     			##set1 window_sc 0.29

		##elseif #[location[] eqs Houston]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 0.82
     			##set1 window_sc 0.29

		##elseif #[location[] eqs Memphis]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.29

		##elseif #[location[] eqs ElPaso]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.29

		##elseif #[location[] eqs Albuquerque]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45

		##endif
	##endif


##elseif    #[region[] eqs Pacific]

	##if    #[shell[] eqs old]

		##if #[location[] eqs LosAngeles]
			##set1 wall_r 6.5
     			##set1 roof_r 5.11
     			##set1 bwall_f 1.940
     			##set1 window_r 0.91
     			##set1 window_sc 1.0 

		##elseif #[location[] eqs Phoenix]
			##set1 wall_r 6.5
     			##set1 roof_r 5.11
     			##set1 bwall_f 1.940
     			##set1 window_r 0.91
     			##set1 window_sc 1.0 

		##elseif #[location[] eqs SanFrancisco]
			##set1 wall_r 6.5
     			##set1 roof_r 5.11
     			##set1 bwall_f 1.940
     			##set1 window_r 0.91
     			##set1 window_sc 1.0 

		##elseif #[location[] eqs Salem]
			##set1 wall_r 6.5
     			##set1 roof_r 7.01
     			##set1 bwall_f 1.940
     			##set1 window_r 1.79
     			##set1 window_sc 1.0 

		##elseif #[location[] eqs Boise]
			##set1 wall_r 6.5
     			##set1 roof_r 7.93
     			##set1 bwall_f 1.940
     			##set1 window_r 1.79
     			##set1 window_sc 1.0 

		##elseif #[location[] eqs Helena]
			##set1 wall_r 6.5
     			##set1 roof_r 11.24
     			##set1 bwall_f 1.940
     			##set1 window_r 1.79
     			##set1 window_sc 1.0 

		##endif 

	##elseif    #[shell[] eqs recent]

		##if #[location[] eqs LosAngeles]
    			##set1 wall_r 13
     			##set1 roof_r 10
     			##set1 bwall_f 1.940
     			##set1 window_r 0.82
     			##set1 window_sc 0.51

		##elseif #[location[] eqs Phoenix]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 0.82
     			##set1 window_sc 0.29 

		##elseif #[location[] eqs SanFrancisco]
    			##set1 wall_r 13
     			##set1 roof_r 10
     			##set1 bwall_f 1.940
     			##set1 window_r 0.82
     			##set1 window_sc 0.45 

		##elseif #[location[] eqs Salem]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45 

		##elseif #[location[] eqs Boise]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45

		##elseif #[location[] eqs Helena]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45 

		##endif

 
	##elseif    #[shell[] eqs new]

		##if #[location[] eqs LosAngeles]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.29
 
		##elseif #[location[] eqs Phoenix]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 0.82
     			##set1 window_sc 0.29

		##elseif #[location[] eqs SanFrancisco]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.29

		##elseif #[location[] eqs Salem]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45
	
		##elseif #[location[] eqs Boise]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45

 		##elseif #[location[] eqs Helena]
    			##set1 wall_r 13
     			##set1 roof_r 15
     			##set1 bwall_f 1.940
     			##set1 window_r 1.75
     			##set1 window_sc 0.45 


		##endif
	##endif
 

##endif


