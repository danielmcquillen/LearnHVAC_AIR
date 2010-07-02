##if #[Location[] eqs Albuquerque]
 
Site:Location,
  Albuquerque Intl Arpt  Isis_NM_USA Design_Conditions,     !- Location Name
      35.04,     !- Latitude {N+ S-}
    -106.62,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
    1619.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     8.62,     !- January Ground Temperature {C}
     8.27,     !- February Ground Temperature {C}
     9.24,     !- March Ground Temperature {C}
     10.65,     !- April Ground Temperature {C}
     14.20,     !- May Ground Temperature {C}
     16.86,     !- June Ground Temperature {C}
     18.58,     !- July Ground Temperature {C}
     19.00,     !- August Ground Temperature {C}
     17.93,     !- September Ground Temperature {C}
     15.74,    !- October Ground Temperature {C}
     12.91,    !- November Ground Temperature {C}
     10.36;    !- December Ground Temperature {C}
 
 ! Albuquerque Intl Arpt  Isis_NM_USA Annual Heating 99.6%, MaxDB=-7.9°C
SizingPeriod:DesignDay,
  Albuquerque Intl Arpt  Isis Ann Htg 99.6% Condns DB,     !- Name
       -7.9,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
       -7.9,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     83328.,      !- Barometric Pressure {Pa}
        3.2,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
         12,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Albuquerque Intl Arpt  Isis Annual Cooling Design Conditions Wind Speed=4.4m/s Wind Dir=220
 ! Hottest Month=JUL
 ! Albuquerque Intl Arpt  Isis_NM_USA Annual Cooling (DB=>MWB) .4%, MaxDB=35.1°C MWB=15.7°C
SizingPeriod:DesignDay,
  Albuquerque Intl Arpt  Isis Ann Clg .4% Condns DB=>MWB,     !- Name
       35.1,      !- Maximum Dry-Bulb Temperature {C}
       13.5,      !- Daily Temp Range {C}
       15.7,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     83328.,      !- Barometric Pressure {Pa}
        4.4,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        220,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Baltimore]
 
Site:Location,
  Baltimore Blt Washngtn IntL_MD_USA Design_Conditions,     !- Location Name
      39.17,     !- Latitude {N+ S-}
     -76.68,     !- Longitude {W- E+}
      -5.00,     !- Time Zone Relative to GMT {GMT+/-}
      45.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     9.57,     !- January Ground Temperature {C}
     7.66,     !- February Ground Temperature {C}
     7.24,     !- March Ground Temperature {C}
     7.82,     !- April Ground Temperature {C}
     10.69,     !- May Ground Temperature {C}
     13.78,     !- June Ground Temperature {C}
     16.62,     !- July Ground Temperature {C}
     18.59,     !- August Ground Temperature {C}
     19.05,     !- September Ground Temperature {C}
     17.94,    !- October Ground Temperature {C}
     15.48,    !- November Ground Temperature {C}
     12.47;    !- December Ground Temperature {C}
 
 ! Baltimore Blt Washngtn IntL_MD_USA Annual Heating 99.6%, MaxDB=-10.6°C
SizingPeriod:DesignDay,
  Baltimore Blt Washngtn IntL Ann Htg 99.6% Condns DB,     !- Name
      -10.6,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
      -10.6,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100786.,      !- Barometric Pressure {Pa}
        3.9,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        290,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Baltimore Blt Washngtn IntL Annual Cooling Design Conditions Wind Speed=4.6m/s Wind Dir=280
 ! Hottest Month=JUL
 ! Baltimore Blt Washngtn IntL_MD_USA Annual Cooling (DB=>MWB) .4%, MaxDB=34.4°C MWB=23.9°C
SizingPeriod:DesignDay,
  Baltimore Blt Washngtn IntL Ann Clg .4% Condns DB=>MWB,     !- Name
       34.4,      !- Maximum Dry-Bulb Temperature {C}
       10.4,      !- Daily Temp Range {C}
       23.9,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100786.,      !- Barometric Pressure {Pa}
        4.6,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        280,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Boise]
 
Site:Location,
  Boise Air Terminal  Uo_ID_USA Design_Conditions,     !- Location Name
      43.62,     !- Latitude {N+ S-}
    -116.21,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
     701.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     7.51,     !- January Ground Temperature {C}
     5.58,     !- February Ground Temperature {C}
     5.15,     !- March Ground Temperature {C}
     5.74,     !- April Ground Temperature {C}
     8.65,     !- May Ground Temperature {C}
     11.79,     !- June Ground Temperature {C}
     14.66,     !- July Ground Temperature {C}
     16.66,     !- August Ground Temperature {C}
     17.13,     !- September Ground Temperature {C}
     16.00,    !- October Ground Temperature {C}
     13.50,    !- November Ground Temperature {C}
     10.46;    !- December Ground Temperature {C}
 
 ! Boise Air Terminal  Uo_ID_USA Annual Heating 99.6%, MaxDB=-16.3°C
SizingPeriod:DesignDay,
  Boise Air Terminal  Uo Ann Htg 99.6% Condns DB,     !- Name
      -16.3,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
      -16.3,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     93182.,      !- Barometric Pressure {Pa}
        2.3,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        120,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
         12,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Boise Air Terminal  Uo Annual Cooling Design Conditions Wind Speed=4.2m/s Wind Dir=330
 ! Hottest Month=JUL
 ! Boise Air Terminal  Uo_ID_USA Annual Cooling (DB=>MWB) .4%, MaxDB=36.7°C MWB=17.9°C
SizingPeriod:DesignDay,
  Boise Air Terminal  Uo Ann Clg .4% Condns DB=>MWB,     !- Name
       36.7,      !- Maximum Dry-Bulb Temperature {C}
       16.7,      !- Daily Temp Range {C}
       17.9,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     93182.,      !- Barometric Pressure {Pa}
        4.2,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        330,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Burlington]
 
Site:Location,
  Burlington International Ap_VT_USA Design_Conditions,     !- Location Name
      44.47,     !- Latitude {N+ S-}
     -73.15,     !- Longitude {W- E+}
      -5.00,     !- Time Zone Relative to GMT {GMT+/-}
     101.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     3.87,     !- January Ground Temperature {C}
     1.78,     !- February Ground Temperature {C}
     1.33,     !- March Ground Temperature {C}
     1.96,     !- April Ground Temperature {C}
     5.10,     !- May Ground Temperature {C}
     8.48,     !- June Ground Temperature {C}
     11.58,     !- July Ground Temperature {C}
     13.74,     !- August Ground Temperature {C}
     14.24,     !- September Ground Temperature {C}
     13.02,    !- October Ground Temperature {C}
     10.33,    !- November Ground Temperature {C}
     7.05;    !- December Ground Temperature {C}
 
 ! Burlington International Ap_VT_USA Annual Heating 99.6%, MaxDB=-22.4°C
SizingPeriod:DesignDay,
  Burlington International Ap Ann Htg 99.6% Condns DB,     !- Name
      -22.4,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
      -22.4,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100118.,      !- Barometric Pressure {Pa}
          3,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
         60,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Burlington International Ap Annual Cooling Design Conditions Wind Speed=4.5m/s Wind Dir=170
 ! Hottest Month=JUL
 ! Burlington International Ap_VT_USA Annual Cooling (DB=>MWB) .4%, MaxDB=31.3°C MWB=21.7°C
SizingPeriod:DesignDay,
  Burlington International Ap Ann Clg .4% Condns DB=>MWB,     !- Name
       31.3,      !- Maximum Dry-Bulb Temperature {C}
       10.7,      !- Daily Temp Range {C}
       21.7,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100118.,      !- Barometric Pressure {Pa}
        4.5,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        170,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Chicago]
 
Site:Location,
  Chicago Midway Ap_IL_USA Design_Conditions,     !- Location Name
      41.78,     !- Latitude {N+ S-}
     -87.75,     !- Longitude {W- E+}
      -6.00,     !- Time Zone Relative to GMT {GMT+/-}
     186.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     10.51,     !- January Ground Temperature {C}
     7.04,     !- February Ground Temperature {C}
     4.91,     !- March Ground Temperature {C}
     4.25,     !- April Ground Temperature {C}
     5.51,     !- May Ground Temperature {C}
     8.38,     !- June Ground Temperature {C}
     11.95,     !- July Ground Temperature {C}
     15.46,     !- August Ground Temperature {C}
     17.82,     !- September Ground Temperature {C}
     18.38,    !- October Ground Temperature {C}
     17.03,    !- November Ground Temperature {C}
     14.21;    !- December Ground Temperature {C}
 
 ! Chicago Midway Ap_IL_USA Annual Heating 99.6%, MaxDB=-18.7°C
SizingPeriod:DesignDay,
  Chicago Midway Ap Ann Htg 99.6% Condns DB,     !- Name
      -18.7,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
      -18.7,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     99110.,      !- Barometric Pressure {Pa}
        5.3,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        300,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Chicago Midway Ap Annual Cooling Design Conditions Wind Speed=5.6m/s Wind Dir=220
 ! Hottest Month=JUL
 ! Chicago Midway Ap_IL_USA Annual Cooling (DB=>MWB) .4%, MaxDB=33.4°C MWB=23.8°C
SizingPeriod:DesignDay,
  Chicago Midway Ap Ann Clg .4% Condns DB=>MWB,     !- Name
       33.4,      !- Maximum Dry-Bulb Temperature {C}
        8.8,      !- Daily Temp Range {C}
       23.8,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     99110.,      !- Barometric Pressure {Pa}
        5.6,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        220,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Duluth]
 
Site:Location,
  Duluth International Arpt_MN_USA Design_Conditions,     !- Location Name
      46.83,     !- Latitude {N+ S-}
     -92.22,     !- Longitude {W- E+}
      -6.00,     !- Time Zone Relative to GMT {GMT+/-}
     433.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     -0.33,     !- January Ground Temperature {C}
     -2.60,     !- February Ground Temperature {C}
     -3.10,     !- March Ground Temperature {C}
     -2.41,     !- April Ground Temperature {C}
     1.02,     !- May Ground Temperature {C}
     4.71,     !- June Ground Temperature {C}
     8.09,     !- July Ground Temperature {C}
     10.44,     !- August Ground Temperature {C}
     11.00,     !- September Ground Temperature {C}
     9.66,    !- October Ground Temperature {C}
     6.73,    !- November Ground Temperature {C}
     3.14;    !- December Ground Temperature {C}
 
 ! Duluth International Arpt_MN_USA Annual Heating 99.6%, MaxDB=-28.6°C
SizingPeriod:DesignDay,
  Duluth International Arpt Ann Htg 99.6% Condns DB,     !- Name
      -28.6,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
      -28.6,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     96230.,      !- Barometric Pressure {Pa}
        4.6,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        310,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Duluth International Arpt Annual Cooling Design Conditions Wind Speed=5.2m/s Wind Dir=220
 ! Hottest Month=JUL
 ! Duluth International Arpt_MN_USA Annual Cooling (DB=>MWB) .4%, MaxDB=29.2°C MWB=21°C
SizingPeriod:DesignDay,
  Duluth International Arpt Ann Clg .4% Condns DB=>MWB,     !- Name
       29.2,      !- Maximum Dry-Bulb Temperature {C}
       10.9,      !- Daily Temp Range {C}
         21,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     96230.,      !- Barometric Pressure {Pa}
        5.2,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        220,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs ElPaso]
 
Site:Location,
  El Paso International Ap  Ut_TX_USA Design_Conditions,     !- Location Name
      31.77,     !- Latitude {N+ S-}
    -106.50,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
    1186.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     17.39,     !- January Ground Temperature {C}
     15.02,     !- February Ground Temperature {C}
     13.57,     !- March Ground Temperature {C}
     13.12,     !- April Ground Temperature {C}
     13.98,     !- May Ground Temperature {C}
     15.94,     !- June Ground Temperature {C}
     18.38,     !- July Ground Temperature {C}
     20.77,     !- August Ground Temperature {C}
     22.38,     !- September Ground Temperature {C}
     22.76,    !- October Ground Temperature {C}
     21.84,    !- November Ground Temperature {C}
     19.92;    !- December Ground Temperature {C}
 
 ! El Paso International Ap  Ut_TX_USA Annual Heating 99.6%, MaxDB=-5.2°C
SizingPeriod:DesignDay,
  El Paso International Ap  Ut Ann Htg 99.6% Condns DB,     !- Name
       -5.2,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
       -5.2,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     87865.,      !- Barometric Pressure {Pa}
        2.2,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
         20,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
         12,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! El Paso International Ap  Ut Annual Cooling Design Conditions Wind Speed=3.9m/s Wind Dir=280
 ! Hottest Month=JUL
 ! El Paso International Ap  Ut_TX_USA Annual Cooling (DB=>MWB) .4%, MaxDB=38.1°C MWB=18.1°C
SizingPeriod:DesignDay,
  El Paso International Ap  Ut Ann Clg .4% Condns DB=>MWB,     !- Name
       38.1,      !- Maximum Dry-Bulb Temperature {C}
         13,      !- Daily Temp Range {C}
       18.1,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     87865.,      !- Barometric Pressure {Pa}
        3.9,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        280,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Fairbanks]
 
Site:Location,
  Fairbanks Intl Arpt_AK_USA Design_Conditions,     !- Location Name
      64.82,     !- Latitude {N+ S-}
    -147.85,     !- Longitude {W- E+}
      -9.00,     !- Time Zone Relative to GMT {GMT+/-}
     133.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     -6.53,     !- January Ground Temperature {C}
     -9.19,     !- February Ground Temperature {C}
     -9.78,     !- March Ground Temperature {C}
     -8.97,     !- April Ground Temperature {C}
     -4.96,     !- May Ground Temperature {C}
     -0.64,     !- June Ground Temperature {C}
     3.32,     !- July Ground Temperature {C}
     6.08,     !- August Ground Temperature {C}
     6.72,     !- September Ground Temperature {C}
     5.16,    !- October Ground Temperature {C}
     1.73,    !- November Ground Temperature {C}
     -2.47;    !- December Ground Temperature {C}
 
 ! Fairbanks Intl Arpt_AK_USA Annual Heating 99.6%, MaxDB=-41.9°C
SizingPeriod:DesignDay,
  Fairbanks Intl Arpt Ann Htg 99.6% Condns DB,     !- Name
      -41.9,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
      -41.9,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     99737.,      !- Barometric Pressure {Pa}
        0.3,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
         20,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Fairbanks Intl Arpt Annual Cooling Design Conditions Wind Speed=3.1m/s Wind Dir=180
 ! Hottest Month=JUL
 ! Fairbanks Intl Arpt_AK_USA Annual Cooling (DB=>MWB) .4%, MaxDB=27.4°C MWB=16.1°C
SizingPeriod:DesignDay,
  Fairbanks Intl Arpt Ann Clg .4% Condns DB=>MWB,     !- Name
       27.4,      !- Maximum Dry-Bulb Temperature {C}
       10.2,      !- Daily Temp Range {C}
       16.1,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     99737.,      !- Barometric Pressure {Pa}
        3.1,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        180,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Helena]
 
Site:Location,
  Helena Regional Airport_MT_USA Design_Conditions,     !- Location Name
      46.60,     !- Latitude {N+ S-}
    -111.97,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
    1167.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     3.56,     !- January Ground Temperature {C}
     1.67,     !- February Ground Temperature {C}
     1.26,     !- March Ground Temperature {C}
     1.83,     !- April Ground Temperature {C}
     4.67,     !- May Ground Temperature {C}
     7.73,     !- June Ground Temperature {C}
     10.53,     !- July Ground Temperature {C}
     12.48,     !- August Ground Temperature {C}
     12.93,     !- September Ground Temperature {C}
     11.83,    !- October Ground Temperature {C}
     9.40,    !- November Ground Temperature {C}
     6.43;    !- December Ground Temperature {C}
 
 ! Helena Regional Airport_MT_USA Annual Heating 99.6%, MaxDB=-26.3°C
SizingPeriod:DesignDay,
  Helena Regional Airport Ann Htg 99.6% Condns DB,     !- Name
      -26.3,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
      -26.3,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     88069.,      !- Barometric Pressure {Pa}
        1.6,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        300,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
         12,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Helena Regional Airport Annual Cooling Design Conditions Wind Speed=4.9m/s Wind Dir=290
 ! Hottest Month=JUL
 ! Helena Regional Airport_MT_USA Annual Cooling (DB=>MWB) .4%, MaxDB=33.7°C MWB=16.4°C
SizingPeriod:DesignDay,
  Helena Regional Airport Ann Clg .4% Condns DB=>MWB,     !- Name
       33.7,      !- Maximum Dry-Bulb Temperature {C}
       16.1,      !- Daily Temp Range {C}
       16.4,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     88069.,      !- Barometric Pressure {Pa}
        4.9,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        290,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Houston]
 
Site:Location,
  Houston Bush Intercontinental_TX_USA Design_Conditions,     !- Location Name
      30.00,     !- Latitude {N+ S-}
     -95.37,     !- Longitude {W- E+}
      -6.00,     !- Time Zone Relative to GMT {GMT+/-}
      29.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     19.86,     !- January Ground Temperature {C}
     17.86,     !- February Ground Temperature {C}
     16.63,     !- March Ground Temperature {C}
     16.25,     !- April Ground Temperature {C}
     16.98,     !- May Ground Temperature {C}
     18.63,     !- June Ground Temperature {C}
     20.69,     !- July Ground Temperature {C}
     22.70,     !- August Ground Temperature {C}
     24.06,     !- September Ground Temperature {C}
     24.38,    !- October Ground Temperature {C}
     23.61,    !- November Ground Temperature {C}
     21.98;    !- December Ground Temperature {C}
 
 ! Houston Bush Intercontinental_TX_USA Annual Heating 99.6%, MaxDB=-1.6°C
SizingPeriod:DesignDay,
  Houston Bush Intercontinental Ann Htg 99.6% Condns DB,     !- Name
       -1.6,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
       -1.6,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100977.,      !- Barometric Pressure {Pa}
        2.8,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Houston Bush Intercontinental Annual Cooling Design Conditions Wind Speed=3.5m/s Wind Dir=170
 ! Hottest Month=JUL
 ! Houston Bush Intercontinental_TX_USA Annual Cooling (DB=>MWB) .4%, MaxDB=36°C MWB=24.8°C
SizingPeriod:DesignDay,
  Houston Bush Intercontinental Ann Clg .4% Condns DB=>MWB,     !- Name
         36,      !- Maximum Dry-Bulb Temperature {C}
       10.1,      !- Daily Temp Range {C}
       24.8,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100977.,      !- Barometric Pressure {Pa}
        3.5,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        170,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs LosAngeles]
 
Site:Location,
  Los Angeles Intl Arpt_CA_USA Design_Conditions,     !- Location Name
      33.93,     !- Latitude {N+ S-}
    -118.40,     !- Longitude {W- E+}
      -8.00,     !- Time Zone Relative to GMT {GMT+/-}
      30.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     15.95,     !- January Ground Temperature {C}
     15.48,     !- February Ground Temperature {C}
     15.38,     !- March Ground Temperature {C}
     15.52,     !- April Ground Temperature {C}
     16.22,     !- May Ground Temperature {C}
     16.98,     !- June Ground Temperature {C}
     17.67,     !- July Ground Temperature {C}
     18.15,     !- August Ground Temperature {C}
     18.26,     !- September Ground Temperature {C}
     17.99,    !- October Ground Temperature {C}
     17.39,    !- November Ground Temperature {C}
     16.66;    !- December Ground Temperature {C}
 
 ! Los Angeles Intl Arpt_CA_USA Annual Heating 99.6%, MaxDB=6.9°C
SizingPeriod:DesignDay,
  Los Angeles Intl Arpt Ann Htg 99.6% Condns DB,     !- Name
        6.9,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
        6.9,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100965.,      !- Barometric Pressure {Pa}
        2.4,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
         90,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Los Angeles Intl Arpt Annual Cooling Design Conditions Wind Speed=4.1m/s Wind Dir=250
 ! Hottest Month=AUG
 ! Los Angeles Intl Arpt_CA_USA Annual Cooling (DB=>MWB) .4%, MaxDB=28.7°C MWB=17.9°C
SizingPeriod:DesignDay,
  Los Angeles Intl Arpt Ann Clg .4% Condns DB=>MWB,     !- Name
       28.7,      !- Maximum Dry-Bulb Temperature {C}
          6,      !- Daily Temp Range {C}
       17.9,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100965.,      !- Barometric Pressure {Pa}
        4.1,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        250,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          8,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Memphis]
 
Site:Location,
  Memphis International Ap_TN_USA Design_Conditions,     !- Location Name
      35.07,     !- Latitude {N+ S-}
     -89.98,     !- Longitude {W- E+}
      -6.00,     !- Time Zone Relative to GMT {GMT+/-}
      81.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     13.63,     !- January Ground Temperature {C}
     11.84,     !- February Ground Temperature {C}
     11.45,     !- March Ground Temperature {C}
     11.99,     !- April Ground Temperature {C}
     14.68,     !- May Ground Temperature {C}
     17.57,     !- June Ground Temperature {C}
     20.23,     !- July Ground Temperature {C}
     22.07,     !- August Ground Temperature {C}
     22.51,     !- September Ground Temperature {C}
     21.46,    !- October Ground Temperature {C}
     19.16,    !- November Ground Temperature {C}
     16.35;    !- December Ground Temperature {C}
 
 ! Memphis International Ap_TN_USA Annual Heating 99.6%, MaxDB=-8.3°C
SizingPeriod:DesignDay,
  Memphis International Ap Ann Htg 99.6% Condns DB,     !- Name
       -8.3,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
       -8.3,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100356.,      !- Barometric Pressure {Pa}
        4.1,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Memphis International Ap Annual Cooling Design Conditions Wind Speed=3.8m/s Wind Dir=240
 ! Hottest Month=JUL
 ! Memphis International Ap_TN_USA Annual Cooling (DB=>MWB) .4%, MaxDB=35.6°C MWB=25.2°C
SizingPeriod:DesignDay,
  Memphis International Ap Ann Clg .4% Condns DB=>MWB,     !- Name
       35.6,      !- Maximum Dry-Bulb Temperature {C}
        9.2,      !- Daily Temp Range {C}
       25.2,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100356.,      !- Barometric Pressure {Pa}
        3.8,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        240,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Miami]
 
Site:Location,
  Miami Kendall Tamia_FL_USA Design_Conditions,     !- Location Name
      25.65,     !- Latitude {N+ S-}
     -80.43,     !- Longitude {W- E+}
      -5.00,     !- Time Zone Relative to GMT {GMT+/-}
       3.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     21.28,     !- January Ground Temperature {C}
     21.15,     !- February Ground Temperature {C}
     21.52,     !- March Ground Temperature {C}
     22.06,     !- April Ground Temperature {C}
     23.41,     !- May Ground Temperature {C}
     24.42,     !- June Ground Temperature {C}
     25.08,     !- July Ground Temperature {C}
     25.24,     !- August Ground Temperature {C}
     24.83,     !- September Ground Temperature {C}
     24.00,    !- October Ground Temperature {C}
     22.92,    !- November Ground Temperature {C}
     21.95;    !- December Ground Temperature {C}
 
 ! Miami Kendall Tamia_FL_USA Annual Heating 99.6%, MaxDB=7.4°C
SizingPeriod:DesignDay,
  Miami Kendall Tamia Ann Htg 99.6% Condns DB,     !- Name
        7.4,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
        7.4,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    101289.,      !- Barometric Pressure {Pa}
        3.2,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        350,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Miami Kendall Tamia Annual Cooling Design Conditions Wind Speed=4.7m/s Wind Dir=120
 ! Hottest Month=AUG
 ! Miami Kendall Tamia_FL_USA Annual Cooling (DB=>MWB) .4%, MaxDB=33.6°C MWB=25.4°C
SizingPeriod:DesignDay,
  Miami Kendall Tamia Ann Clg .4% Condns DB=>MWB,     !- Name
       33.6,      !- Maximum Dry-Bulb Temperature {C}
        8.4,      !- Daily Temp Range {C}
       25.4,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    101289.,      !- Barometric Pressure {Pa}
        4.7,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        120,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          8,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Phoenix]
 
Site:Location,
  Deer Valley Phoenix_AZ_USA Design_Conditions,     !- Location Name
      33.68,     !- Latitude {N+ S-}
    -112.08,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
     450.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     19.82,     !- January Ground Temperature {C}
     18.27,     !- February Ground Temperature {C}
     17.93,     !- March Ground Temperature {C}
     18.40,     !- April Ground Temperature {C}
     20.73,     !- May Ground Temperature {C}
     23.23,     !- June Ground Temperature {C}
     25.53,     !- July Ground Temperature {C}
     27.13,     !- August Ground Temperature {C}
     27.50,     !- September Ground Temperature {C}
     26.60,    !- October Ground Temperature {C}
     24.61,    !- November Ground Temperature {C}
     22.17;    !- December Ground Temperature {C}
 
 
 
 
 
 
##elseif #[Location[] eqs Salem]
 
Site:Location,
  Salem Mcnary Field_OR_USA Design_Conditions,     !- Location Name
      44.90,     !- Latitude {N+ S-}
    -123.00,     !- Longitude {W- E+}
      -8.00,     !- Time Zone Relative to GMT {GMT+/-}
      60.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     8.38,     !- January Ground Temperature {C}
     8.15,     !- February Ground Temperature {C}
     8.79,     !- March Ground Temperature {C}
     9.72,     !- April Ground Temperature {C}
     12.07,     !- May Ground Temperature {C}
     13.83,     !- June Ground Temperature {C}
     14.97,     !- July Ground Temperature {C}
     15.24,     !- August Ground Temperature {C}
     14.53,     !- September Ground Temperature {C}
     13.09,    !- October Ground Temperature {C}
     11.22,    !- November Ground Temperature {C}
     9.53;    !- December Ground Temperature {C}
 
 ! Salem Mcnary Field_OR_USA Annual Heating 99.6%, MaxDB=-5.6°C
SizingPeriod:DesignDay,
  Salem Mcnary Field Ann Htg 99.6% Condns DB,     !- Name
       -5.6,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
       -5.6,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100606.,      !- Barometric Pressure {Pa}
        2.1,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
         12,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Salem Mcnary Field Annual Cooling Design Conditions Wind Speed=4.3m/s Wind Dir=0
 ! Hottest Month=AUG
 ! Salem Mcnary Field_OR_USA Annual Cooling (DB=>MWB) .4%, MaxDB=33.3°C MWB=19.4°C
SizingPeriod:DesignDay,
  Salem Mcnary Field Ann Clg .4% Condns DB=>MWB,     !- Name
       33.3,      !- Maximum Dry-Bulb Temperature {C}
       15.4,      !- Daily Temp Range {C}
       19.4,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    100606.,      !- Barometric Pressure {Pa}
        4.3,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          8,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs SanFrancisco]
 
Site:Location,
  San Francisco Intl Ap_CA_USA Design_Conditions,     !- Location Name
      37.62,     !- Latitude {N+ S-}
    -122.40,     !- Longitude {W- E+}
      -8.00,     !- Time Zone Relative to GMT {GMT+/-}
       2.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     12.79,     !- January Ground Temperature {C}
     12.27,     !- February Ground Temperature {C}
     12.15,     !- March Ground Temperature {C}
     12.31,     !- April Ground Temperature {C}
     13.10,     !- May Ground Temperature {C}
     13.96,     !- June Ground Temperature {C}
     14.74,     !- July Ground Temperature {C}
     15.28,     !- August Ground Temperature {C}
     15.41,     !- September Ground Temperature {C}
     15.10,    !- October Ground Temperature {C}
     14.42,    !- November Ground Temperature {C}
     13.60;    !- December Ground Temperature {C}
 
 ! San Francisco Intl Ap_CA_USA Annual Heating 99.6%, MaxDB=3.8°C
SizingPeriod:DesignDay,
  San Francisco Intl Ap Ann Htg 99.6% Condns DB,     !- Name
        3.8,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
        3.8,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    101301.,      !- Barometric Pressure {Pa}
        2.2,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        150,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! San Francisco Intl Ap Annual Cooling Design Conditions Wind Speed=5.9m/s Wind Dir=310
 ! Hottest Month=AUG
 ! San Francisco Intl Ap_CA_USA Annual Cooling (DB=>MWB) .4%, MaxDB=28.3°C MWB=17.2°C
SizingPeriod:DesignDay,
  San Francisco Intl Ap Ann Clg .4% Condns DB=>MWB,     !- Name
       28.3,      !- Maximum Dry-Bulb Temperature {C}
        8.5,      !- Daily Temp Range {C}
       17.2,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
    101301.,      !- Barometric Pressure {Pa}
        5.9,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        310,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          8,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##elseif #[Location[] eqs Seattle]
 
Site:Location,
  Seattle Seattle Tacoma Intl A_WA_USA Design_Conditions,     !- Location Name
      47.47,     !- Latitude {N+ S-}
    -122.32,     !- Longitude {W- E+}
      -8.00,     !- Time Zone Relative to GMT {GMT+/-}
     122.00;     !- Elevation {m}
 
 
!- 4m depth undisturbed ground temperatures
Site:GroundTemperature:BuildingSurface,
     10.83,     !- January Ground Temperature {C}
     9.23,     !- February Ground Temperature {C}
     8.24,     !- March Ground Temperature {C}
     7.93,     !- April Ground Temperature {C}
     8.52,     !- May Ground Temperature {C}
     9.85,     !- June Ground Temperature {C}
     11.50,     !- July Ground Temperature {C}
     13.13,     !- August Ground Temperature {C}
     14.22,     !- September Ground Temperature {C}
     14.48,    !- October Ground Temperature {C}
     13.85,    !- November Ground Temperature {C}
     12.55;    !- December Ground Temperature {C}
 
 ! Seattle Seattle Tacoma Intl A_WA_USA Annual Heating 99.6%, MaxDB=-4.2°C
SizingPeriod:DesignDay,
  Seattle Seattle Tacoma Intl A Ann Htg 99.6% Condns DB,     !- Name
       -4.2,      !- Maximum Dry-Bulb Temperature {C}
        0.0,      !- Daily Temp Range {C}
       -4.2,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     99868.,      !- Barometric Pressure {Pa}
        4.3,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
         20,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
         12,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 ! Seattle Seattle Tacoma Intl A Annual Cooling Design Conditions Wind Speed=4.2m/s Wind Dir=350
 ! Hottest Month=AUG
 ! Seattle Seattle Tacoma Intl A_WA_USA Annual Cooling (DB=>MWB) .4%, MaxDB=29.4°C MWB=18.3°C
SizingPeriod:DesignDay,
  Seattle Seattle Tacoma Intl A Ann Clg .4% Condns DB=>MWB,     !- Name
       29.4,      !- Maximum Dry-Bulb Temperature {C}
       10.4,      !- Daily Temp Range {C}
       18.3,      !- Humidity Indicating Conditions at Maximum Dry-Bulb
     99868.,      !- Barometric Pressure {Pa}
        4.2,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        350,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          8,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
WetBulb;
 
 
 
 
##endif
