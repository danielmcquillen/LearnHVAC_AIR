! Location.inc
!

##if #[location[] eqs Albuquerque]  

Site:Location,
  albuquerque,     !- Location Name
      35.05,     !- Latitude {N+ S-}
    -106.62,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
    1619.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 8.738377,
 6.903116,
 6.756156,
 7.627078,
 11.12333,
 14.60328,
 17.62025,
 19.5314,
 19.69375,
 18.13936,
 15.19936,
 11.82611;
 
 !  WMO=723650 Time Zone=NAM: (GMT-07:00) Mountain Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
  RunPeriodControl:DaylightSavingTime,
    2nd Sunday in March,     !- Start Date
    1st Sunday in November;  !- End Date
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! albuquerque_NM_USA Extreme Annual Wind Speeds, 1%=12.6m/s, 2.5%=11.1m/s, 5%=9.3m/s
 ! albuquerque_NM_USA Extreme Annual Temperatures, Max Drybulb=37.8°C Min Drybulb=-12.9°C
  
 ! albuquerque_NM_USA Annual Heating Design Conditions Wind Speed=3.3m/s Wind Dir=0
 ! Coldest Month=JAN
 ! albuquerque_NM_USA Annual Heating 99.6%, MaxDB=-9°C
 SizingPeriod:DesignDay,
  albuquerque Ann Htg 99.6% Condns DB,     !- Name
         -9,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
         -9,      !- Humidity Indicating Condition at Max Dry-Bulb
     83328.,      !- Barometric Pressure {Pa}
        3.3,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 

 ! albuquerque Annual Cooling Design Conditions Wind Speed=4.4m/s Wind Dir=260
 ! Hottest Month=JUL
 ! albuquerque_NM_USA Annual Cooling (DB=>MWB) .4%, MaxDB=35.6°C MWB=15.7°C
 SizingPeriod:DesignDay,
  albuquerque Ann Clg .4% Condns DB=>MWB,     !- Name
       35.6,      !- Max Dry-Bulb {C}
       14.1,      !- Daily Temp Range {C}
       15.7,      !- Humidity Indicating Condition at Max Dry-Bulb
     83328.,      !- Barometric Pressure {Pa}
        4.4,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        260,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Baltimore] 
 
 Site:Location,
  baltimore,     !- Location Name
      39.18,     !- Latitude {N+ S-}
     -76.67,     !- Longitude {W- E+}
      -5.00,     !- Time Zone Relative to GMT {GMT+/-}
      47.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 7.875406,
 5.945236,
 5.790664,
 6.706633,
 10.38372,
 14.04366,
 17.21664,
 19.22667,
 19.39739,
 17.7626,
 14.67052,
 11.12285;
 
 !  WMO=724060 Time Zone=NAE: (GMT-05:00) Eastern Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! baltimore_MD_USA Extreme Annual Wind Speeds, 1%=10.3m/s, 2.5%=8.7m/s, 5%=7.9m/s
 ! baltimore_MD_USA Extreme Annual Temperatures, Max Drybulb=36.5°C Min Drybulb=-15.1°C
  
 ! baltimore_MD_USA Annual Heating Design Conditions Wind Speed=3.9m/s Wind Dir=270
 ! Coldest Month=JAN
 ! baltimore_MD_USA Annual Heating 99.6%, MaxDB=-11°C
 SizingPeriod:DesignDay,
  baltimore Ann Htg 99.6% Condns DB,     !- Name
        -11,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
        -11,      !- Humidity Indicating Condition at Max Dry-Bulb
    100762.,      !- Barometric Pressure {Pa}
        3.9,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        270,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! baltimore Annual Cooling Design Conditions Wind Speed=4.7m/s Wind Dir=280
 ! Hottest Month=JUL
 ! baltimore_MD_USA Annual Cooling (DB=>MWB) .4%, MaxDB=34.2°C MWB=23.9°C
 SizingPeriod:DesignDay,
  baltimore Ann Clg .4% Condns DB=>MWB,     !- Name
       34.2,      !- Max Dry-Bulb {C}
       10.4,      !- Daily Temp Range {C}
       23.9,      !- Humidity Indicating Condition at Max Dry-Bulb
    100762.,      !- Barometric Pressure {Pa}
        4.7,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        280,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Boise]  

 Site:Location,
  boise,     !- Location Name
      43.57,     !- Latitude {N+ S-}
    -116.22,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
     874.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 5.174768,
 3.102504,
 2.936556,
 3.919952,
 7.867726,
 11.79709,
 15.20367,
 17.36163,
 17.54498,
 15.78981,
 12.47014,
 8.661285;
 
 !  WMO=726810 Time Zone=NAM: (GMT-07:00) Mountain Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! boise_ID_USA Extreme Annual Wind Speeds, 1%=10m/s, 2.5%=8.6m/s, 5%=7.8m/s
 ! boise_ID_USA Extreme Annual Temperatures, Max Drybulb=39.5°C Min Drybulb=-19.1°C
  
 ! boise_ID_USA Annual Heating Design Conditions Wind Speed=2.4m/s Wind Dir=120
 ! Coldest Month=JAN
 ! boise_ID_USA Annual Heating 99.6%, MaxDB=-16.9°C
 SizingPeriod:DesignDay,
  boise Ann Htg 99.6% Condns DB,     !- Name
      -16.9,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
      -16.9,      !- Humidity Indicating Condition at Max Dry-Bulb
     91257.,      !- Barometric Pressure {Pa}
        2.4,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        120,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! boise Annual Cooling Design Conditions Wind Speed=4.4m/s Wind Dir=330
 ! Hottest Month=JUL
 ! boise_ID_USA Annual Cooling (DB=>MWB) .4%, MaxDB=36.1°C MWB=17.7°C
 SizingPeriod:DesignDay,
  boise Ann Clg .4% Condns DB=>MWB,     !- Name
       36.1,      !- Max Dry-Bulb {C}
       16.8,      !- Daily Temp Range {C}
       17.7,      !- Humidity Indicating Condition at Max Dry-Bulb
     91257.,      !- Barometric Pressure {Pa}
        4.4,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        330,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Burlington]  

 Site:Location,
  burlington,     !- Location Name
      44.47,     !- Latitude {N+ S-}
     -73.15,     !- Longitude {W- E+}
      -5.00,     !- Time Zone Relative to GMT {GMT+/-}
     104.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 1.806727,
 -0.3939653,
 -0.5702044,
 0.4741248,
 4.666582,
 8.839492,
 12.45718,
 14.74892,
 14.94362,
 13.07967,
 9.554231,
 5.509326;
 
 !  WMO=726170 Time Zone=NAE: (GMT-05:00) Eastern Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! burlington_VT_USA Extreme Annual Wind Speeds, 1%=10.5m/s, 2.5%=9m/s, 5%=8.2m/s
 ! burlington_VT_USA Extreme Annual Temperatures, Max Drybulb=34°C Min Drybulb=-27.7°C
  
 ! burlington_VT_USA Annual Heating Design Conditions Wind Speed=2.8m/s Wind Dir=70
 ! Coldest Month=JAN
 ! burlington_VT_USA Annual Heating 99.6%, MaxDB=-22.9°C
 SizingPeriod:DesignDay,
  burlington Ann Htg 99.6% Condns DB,     !- Name
      -22.9,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
      -22.9,      !- Humidity Indicating Condition at Max Dry-Bulb
    100082.,      !- Barometric Pressure {Pa}
        2.8,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
         70,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! burlington Annual Cooling Design Conditions Wind Speed=4.7m/s Wind Dir=180
 ! Hottest Month=JUL
 ! burlington_VT_USA Annual Cooling (DB=>MWB) .4%, MaxDB=31.2°C MWB=21.7°C
 SizingPeriod:DesignDay,
  burlington Ann Clg .4% Condns DB=>MWB,     !- Name
       31.2,      !- Max Dry-Bulb {C}
       10.9,      !- Daily Temp Range {C}
       21.7,      !- Humidity Indicating Condition at Max Dry-Bulb
    100082.,      !- Barometric Pressure {Pa}
        4.7,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        180,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Chicago] 

 Site:Location,
  chicago,     !- Location Name
      41.78,     !- Latitude {N+ S-}
     -87.75,     !- Longitude {W- E+}
      -6.00,     !- Time Zone Relative to GMT {GMT+/-}
     190.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 4.469574,
 2.317235,
 2.144879,
 3.166269,
 7.26658,
 11.34777,
 14.88598,
 17.12733,
 17.31772,
 15.49477,
 12.04682,
 8.090793;
 
 !  WMO=725300 Time Zone=NAC: (GMT-06:00) Central Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! chicago_IL_USA Extreme Annual Wind Speeds, 1%=11.2m/s, 2.5%=9.9m/s, 5%=8.7m/s
 ! chicago_IL_USA Extreme Annual Temperatures, Max Drybulb=35.7°C Min Drybulb=-24.2°C
  
 ! chicago_IL_USA Annual Heating Design Conditions Wind Speed=4.9m/s Wind Dir=270
 ! Coldest Month=JAN
 ! chicago_IL_USA Annual Heating 99.6%, MaxDB=-20.6°C
 SizingPeriod:DesignDay,
  chicago Ann Htg 99.6% Condns DB,     !- Name
      -20.6,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
      -20.6,      !- Humidity Indicating Condition at Max Dry-Bulb
     99063.,      !- Barometric Pressure {Pa}
        4.9,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        270,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! chicago Annual Cooling Design Conditions Wind Speed=5.3m/s Wind Dir=230
 ! Hottest Month=JUL
 ! chicago_IL_USA Annual Cooling (DB=>MWB) .4%, MaxDB=33.2°C MWB=23.8°C
 SizingPeriod:DesignDay,
  chicago Ann Clg .4% Condns DB=>MWB,     !- Name
       33.2,      !- Max Dry-Bulb {C}
       10.7,      !- Daily Temp Range {C}
       23.8,      !- Humidity Indicating Condition at Max Dry-Bulb
     99063.,      !- Barometric Pressure {Pa}
        5.3,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        230,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Duluth] 

 Site:Location,
  duluth,     !- Location Name
      46.83,     !- Latitude {N+ S-}
     -92.18,     !- Longitude {W- E+}
      -6.00,     !- Time Zone Relative to GMT {GMT+/-}
     432.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 -2.76442,
 -5.191451,
 -5.385814,
 -4.23408,
 0.3895572,
 4.991645,
 8.981415,
 11.50883,
 11.72357,
 9.667926,
 5.779898,
 1.318988;
 
 !  WMO=727450 Time Zone=NAC: (GMT-06:00) Central Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! duluth_MN_USA Extreme Annual Wind Speeds, 1%=11.1m/s, 2.5%=9.3m/s, 5%=8.5m/s
 ! duluth_MN_USA Extreme Annual Temperatures, Max Drybulb=32.1°C Min Drybulb=-32.9°C
  
 ! duluth_MN_USA Annual Heating Design Conditions Wind Speed=4.3m/s Wind Dir=310
 ! Coldest Month=JAN
 ! duluth_MN_USA Annual Heating 99.6%, MaxDB=-29°C
 SizingPeriod:DesignDay,
  duluth Ann Htg 99.6% Condns DB,     !- Name
        -29,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
        -29,      !- Humidity Indicating Condition at Max Dry-Bulb
     96242.,      !- Barometric Pressure {Pa}
        4.3,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        310,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 

 ! duluth Annual Cooling Design Conditions Wind Speed=5.2m/s Wind Dir=230
 ! Hottest Month=JUL
 ! duluth_MN_USA Annual Cooling (DB=>MWB) .4%, MaxDB=29°C MWB=20.6°C
 SizingPeriod:DesignDay,
  duluth Ann Clg .4% Condns DB=>MWB,     !- Name
         29,      !- Max Dry-Bulb {C}
       10.9,      !- Daily Temp Range {C}
       20.6,      !- Humidity Indicating Condition at Max Dry-Bulb
     96242.,      !- Barometric Pressure {Pa}
        5.2,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        230,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs ElPaso] 

 Site:Location,
  elpaso,     !- Location Name
      31.80,     !- Latitude {N+ S-}
    -106.40,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
    1194.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 13.79508,
 12.15794,
 12.02682,
 12.80373,
 15.92256,
 19.02688,
 21.71812,
 23.42297,
 23.56779,
 22.18121,
 19.55856,
 16.54949;

 !  WMO=722700 Time Zone=NAM: (GMT-07:00) Mountain Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! elpaso_TX_USA Extreme Annual Wind Speeds, 1%=11.2m/s, 2.5%=9.2m/s, 5%=8m/s
 ! elpaso_TX_USA Extreme Annual Temperatures, Max Drybulb=40.8°C Min Drybulb=-9.4°C
  
 ! elpaso_TX_USA Annual Heating Design Conditions Wind Speed=2.1m/s Wind Dir=20
 ! Coldest Month=JAN
 ! elpaso_TX_USA Annual Heating 99.6%, MaxDB=-5.5°C
 SizingPeriod:DesignDay,
  elpaso Ann Htg 99.6% Condns DB,     !- Name
       -5.5,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
       -5.5,      !- Humidity Indicating Condition at Max Dry-Bulb
     87780.,      !- Barometric Pressure {Pa}
        2.1,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
         20,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! elpaso Annual Cooling Design Conditions Wind Speed=3.8m/s Wind Dir=280
 ! Hottest Month=JUL
 ! elpaso_TX_USA Annual Cooling (DB=>MWB) .4%, MaxDB=38.6°C MWB=18.2°C
 SizingPeriod:DesignDay,
  elpaso Ann Clg .4% Condns DB=>MWB,     !- Name
       38.6,      !- Max Dry-Bulb {C}
       13.5,      !- Daily Temp Range {C}
       18.2,      !- Humidity Indicating Condition at Max Dry-Bulb
     87780.,      !- Barometric Pressure {Pa}
        3.8,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        280,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Fairbanks] 

 Site:Location,
  fairbanks,     !- Location Name
      64.82,     !- Latitude {N+ S-}
    -147.87,     !- Longitude {W- E+}
      -9.00,     !- Time Zone Relative to GMT {GMT+/-}
     138.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 -10.59151,
 -13.65636,
 -13.90178,
 -12.44737,
 -6.608672,
 -0.7971706,
 4.241082,
 7.432698,
 7.703846,
 5.108002,
 0.1982288,
 -5.434999;
 
 !  WMO=702610 Time Zone=NAK: (GMT-09:00) Alaska
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! fairbanks_AK_USA Extreme Annual Wind Speeds, 1%=8.1m/s, 2.5%=7.1m/s, 5%=5.8m/s
 ! fairbanks_AK_USA Extreme Annual Temperatures, Max Drybulb=30.5°C Min Drybulb=-43.1°C
  
 ! fairbanks_AK_USA Annual Heating Design Conditions Wind Speed=0.5m/s Wind Dir=10
 ! Coldest Month=JAN
 ! fairbanks_AK_USA Annual Heating 99.6%, MaxDB=-42.5°C
 SizingPeriod:DesignDay,
  fairbanks Ann Htg 99.6% Condns DB,     !- Name
      -42.5,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
      -42.5,      !- Humidity Indicating Condition at Max Dry-Bulb
     99678.,      !- Barometric Pressure {Pa}
        0.5,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
         10,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! fairbanks Annual Cooling Design Conditions Wind Speed=3.3m/s Wind Dir=180
 ! Hottest Month=JUL
 ! fairbanks_AK_USA Annual Cooling (DB=>MWB) .4%, MaxDB=27.2°C MWB=16.1°C
 SizingPeriod:DesignDay,
  fairbanks Ann Clg .4% Condns DB=>MWB,     !- Name
       27.2,      !- Max Dry-Bulb {C}
       10.3,      !- Daily Temp Range {C}
       16.1,      !- Humidity Indicating Condition at Max Dry-Bulb
     99678.,      !- Barometric Pressure {Pa}
        3.3,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        180,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Helena] 

 Site:Location,
  helena,     !- Location Name
      46.60,     !- Latitude {N+ S-}
    -112.00,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
    1188.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 1.626622,
 -0.4956567,
 -0.6656228,
 0.3415089,
 4.3846,
 8.408837,
 11.89763,
 14.10771,
 14.29546,
 12.49794,
 9.098111,
 5.197317;
 
 !  WMO=727720 Time Zone=NAM: (GMT-07:00) Mountain Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! helena_MT_USA Extreme Annual Wind Speeds, 1%=10.9m/s, 2.5%=9.2m/s, 5%=8.3m/s
 ! helena_MT_USA Extreme Annual Temperatures, Max Drybulb=35.9°C Min Drybulb=-30.6°C
  
 ! helena_MT_USA Annual Heating Design Conditions Wind Speed=1.7m/s Wind Dir=300
 ! Coldest Month=JAN
 ! helena_MT_USA Annual Heating 99.6%, MaxDB=-27.3°C
 SizingPeriod:DesignDay,
  helena Ann Htg 99.6% Condns DB,     !- Name
      -27.3,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
      -27.3,      !- Humidity Indicating Condition at Max Dry-Bulb
     87844.,      !- Barometric Pressure {Pa}
        1.7,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        300,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 

 ! helena Annual Cooling Design Conditions Wind Speed=4.9m/s Wind Dir=290
 ! Hottest Month=JUL
 ! helena_MT_USA Annual Cooling (DB=>MWB) .4%, MaxDB=32.8°C MWB=16.1°C
 SizingPeriod:DesignDay,
  helena Ann Clg .4% Condns DB=>MWB,     !- Name
       32.8,      !- Max Dry-Bulb {C}
       15.7,      !- Daily Temp Range {C}
       16.1,      !- Humidity Indicating Condition at Max Dry-Bulb
     87844.,      !- Barometric Pressure {Pa}
        4.9,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        290,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Houston]

 Site:Location,
  houston,     !- Location Name
      29.98,     !- Latitude {N+ S-}
     -95.37,     !- Longitude {W- E+}
      -6.00,     !- Time Zone Relative to GMT {GMT+/-}
      33.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 16.84378,
 15.53804,
 15.43346,
 16.05311,
 18.54063,
 21.01656,
 23.16306,
 24.52283,
 24.63835,
 23.53243,
 21.44065,
 19.04064;
 
 !  WMO=722430 Time Zone=NAC: (GMT-06:00) Central Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! houston_TX_USA Extreme Annual Wind Speeds, 1%=8.5m/s, 2.5%=7.8m/s, 5%=7.2m/s
 ! houston_TX_USA Extreme Annual Temperatures, Max Drybulb=37.6°C Min Drybulb=-5.3°C
  
 ! houston_TX_USA Annual Heating Design Conditions Wind Speed=2.7m/s Wind Dir=0
 ! Coldest Month=JAN
 ! houston_TX_USA Annual Heating 99.6%, MaxDB=-2.4°C
 SizingPeriod:DesignDay,
  houston Ann Htg 99.6% Condns DB,     !- Name
       -2.4,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
       -2.4,      !- Humidity Indicating Condition at Max Dry-Bulb
    100929.,      !- Barometric Pressure {Pa}
        2.7,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! houston Annual Cooling Design Conditions Wind Speed=3.7m/s Wind Dir=170
 ! Hottest Month=JUL
 ! houston_TX_USA Annual Cooling (DB=>MWB) .4%, MaxDB=36.1°C MWB=24.9°C
 SizingPeriod:DesignDay,
  houston Ann Clg .4% Condns DB=>MWB,     !- Name
       36.1,      !- Max Dry-Bulb {C}
       10.6,      !- Daily Temp Range {C}
       24.9,      !- Humidity Indicating Condition at Max Dry-Bulb
    100929.,      !- Barometric Pressure {Pa}
        3.7,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        170,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Memphis]

 Site:Location,
  memphis,     !- Location Name
      35.05,     !- Latitude {N+ S-}
     -89.98,     !- Longitude {W- E+}
      -6.00,     !- Time Zone Relative to GMT {GMT+/-}
      87.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 12.61147,
 10.94149,
 10.80776,
 11.60025,
 14.78164,
 17.94822,
 20.69348,
 22.43254,
 22.58028,
 21.16586,
 18.49058,
 15.42115;
 
 !  WMO=723340 Time Zone=NAC: (GMT-06:00) Central Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! memphis_TN_USA Extreme Annual Wind Speeds, 1%=9.2m/s, 2.5%=8.3m/s, 5%=7.6m/s
 ! memphis_TN_USA Extreme Annual Temperatures, Max Drybulb=37°C Min Drybulb=-11.9°C
  
 ! memphis_TN_USA Annual Heating Design Conditions Wind Speed=4.4m/s Wind Dir=350
 ! Coldest Month=JAN
 ! memphis_TN_USA Annual Heating 99.6%, MaxDB=-8.5°C
 SizingPeriod:DesignDay,
  memphis Ann Htg 99.6% Condns DB,     !- Name
       -8.5,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
       -8.5,      !- Humidity Indicating Condition at Max Dry-Bulb
    100284.,      !- Barometric Pressure {Pa}
        4.4,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        350,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! memphis Annual Cooling Design Conditions Wind Speed=3.9m/s Wind Dir=240
 ! Hottest Month=JUL
 ! memphis_TN_USA Annual Cooling (DB=>MWB) .4%, MaxDB=35.7°C MWB=25.3°C
 SizingPeriod:DesignDay,
  memphis Ann Clg .4% Condns DB=>MWB,     !- Name
       35.7,      !- Max Dry-Bulb {C}
        9.3,      !- Daily Temp Range {C}
       25.3,      !- Humidity Indicating Condition at Max Dry-Bulb
    100284.,      !- Barometric Pressure {Pa}
        3.9,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        240,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Miami]

 Site:Location,
  miami,     !- Location Name
      25.80,     !- Latitude {N+ S-}
     -80.27,     !- Longitude {W- E+}
      -5.00,     !- Time Zone Relative to GMT {GMT+/-}
       2.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 22.81832,
 22.20912,
 22.16032,
 22.44943,
 23.60998,
 24.76514,
 25.76659,
 26.40098,
 26.4549,
 25.93891,
 24.96299,
 23.84327;

 !  WMO=722020 Time Zone=NAE: (GMT-05:00) Eastern Time (US & Canada)
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! miami_FL_USA Extreme Annual Wind Speeds, 1%=9.4m/s, 2.5%=8.6m/s, 5%=8m/s
 ! miami_FL_USA Extreme Annual Temperatures, Max Drybulb=34.7°C Min Drybulb=4.4°C
  
 ! miami_FL_USA Annual Heating Design Conditions Wind Speed=4.4m/s Wind Dir=340
 ! Coldest Month=JAN
 ! miami_FL_USA Annual Heating 99.6%, MaxDB=8°C
 SizingPeriod:DesignDay,
  miami Ann Htg 99.6% Condns DB,     !- Name
          8,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
          8,      !- Humidity Indicating Condition at Max Dry-Bulb
    101301.,      !- Barometric Pressure {Pa}
        4.4,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        340,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! miami Annual Cooling Design Conditions Wind Speed=4.7m/s Wind Dir=140
 ! Hottest Month=JUL
 ! miami_FL_USA Annual Cooling (DB=>MWB) .4%, MaxDB=33.1°C MWB=25.3°C
 SizingPeriod:DesignDay,
  miami Ann Clg .4% Condns DB=>MWB,     !- Name
       33.1,      !- Max Dry-Bulb {C}
        6.7,      !- Daily Temp Range {C}
       25.3,      !- Humidity Indicating Condition at Max Dry-Bulb
    101301.,      !- Barometric Pressure {Pa}
        4.7,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        140,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Phoenix]

 Site:Location,
  phoenix,     !- Location Name
      33.43,     !- Latitude {N+ S-}
    -112.02,     !- Longitude {W- E+}
      -7.00,     !- Time Zone Relative to GMT {GMT+/-}
     339.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 18.40703,
 16.72836,
 16.59395,
 17.39056,
 20.58846,
 23.77152,
 26.53102,
 28.2791,
 28.42762,
 27.00584,
 24.3167,
 21.2313;
 
 !  WMO=722780 Time Zone=NAZ: (GMT-07:00) Arizona
 !  Data Source=ASHRAE 2005 Annual Design Conditions
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! phoenix_AZ_USA Extreme Annual Wind Speeds, 1%=8.3m/s, 2.5%=7.2m/s, 5%=5.9m/s
 ! phoenix_AZ_USA Extreme Annual Temperatures, Max Drybulb=45.8°C Min Drybulb=0.4°C
  
 ! phoenix_AZ_USA Annual Heating Design Conditions Wind Speed=2m/s Wind Dir=120
 ! Coldest Month=DEC
 ! phoenix_AZ_USA Annual Heating 99.6%, MaxDB=2.9°C
 SizingPeriod:DesignDay,
  phoenix Ann Htg 99.6% Condns DB,     !- Name
        2.9,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
        2.9,      !- Humidity Indicating Condition at Max Dry-Bulb
     97318.,      !- Barometric Pressure {Pa}
          2,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        120,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
         12,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! phoenix Annual Cooling Design Conditions Wind Speed=4.1m/s Wind Dir=270
 ! Hottest Month=JUL
 ! phoenix_AZ_USA Annual Cooling (DB=>MWB) .4%, MaxDB=43.4°C MWB=21.1°C
 SizingPeriod:DesignDay,
  phoenix Ann Clg .4% Condns DB=>MWB,     !- Name
       43.4,      !- Max Dry-Bulb {C}
       12.3,      !- Daily Temp Range {C}
       21.1,      !- Humidity Indicating Condition at Max Dry-Bulb
     97318.,      !- Barometric Pressure {Pa}
        4.1,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        270,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Salem]

 Site:Location,
  salem,     !- Location Name
      44.92,     !- Latitude {N+ S-}
    -123.02,     !- Longitude {W- E+}
      -8.00,     !- Time Zone Relative to GMT {GMT+/-}
      61.00;     !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 8.103254,
 6.917018,
 6.822023,
 7.384954,
 9.644817,
 11.89413,
 13.84421,
 15.07953,
 15.18447,
 14.17973,
 12.2794,
 10.09909;
 
 !  WMO=726940 Time Zone=NAP: (GMT-08:00) Pacific Time (US & Canada); Tijuana
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! salem_OR_USA Extreme Annual Wind Speeds, 1%=9.3m/s, 2.5%=8.2m/s, 5%=7.3m/s
 ! salem_OR_USA Extreme Annual Temperatures, Max Drybulb=37.4°C Min Drybulb=-9.4°C
  
 ! salem_OR_USA Annual Heating Design Conditions Wind Speed=2.4m/s Wind Dir=0
 ! Coldest Month=DEC
 ! salem_OR_USA Annual Heating 99.6%, MaxDB=-6.4°C
 SizingPeriod:DesignDay,
  salem Ann Htg 99.6% Condns DB,     !- Name
       -6.4,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
       -6.4,      !- Humidity Indicating Condition at Max Dry-Bulb
    100594.,      !- Barometric Pressure {Pa}
        2.4,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
         12,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 

 ! salem Annual Cooling Design Conditions Wind Speed=4.3m/s Wind Dir=0
 ! Hottest Month=JUL
 ! salem_OR_USA Annual Cooling (DB=>MWB) .4%, MaxDB=33.2°C MWB=19.5°C
 SizingPeriod:DesignDay,
  salem Ann Clg .4% Condns DB=>MWB,     !- Name
       33.2,      !- Max Dry-Bulb {C}
         15,      !- Daily Temp Range {C}
       19.5,      !- Humidity Indicating Condition at Max Dry-Bulb
    100594.,      !- Barometric Pressure {Pa}
        4.3,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          7,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs SanFrancisco]

 Site:Location,
      San Francisco,     !- Location Name
      37.62,             !- Latitude {N+ S-}
      -122.40,           !- Longitude {W- E+}
      -8.0,              !- Time Zone Relative to GMT {GMT+/-}
       2.0;              !- Elevation {m}

Site:GroundTemperature:BuildingSurface,
 11.58207,
 10.96887,
 10.91976,
 11.21074,
 12.37896,
 13.54168,
 14.54974,
 15.18831,
 15.24253,
 14.72318,
 13.74086,
 12.61377;
 
 !  WMO=724940 Time Zone=NAP: (GMT-08:00) Pacific Time (US & Canada); Tijuana
 !  Data Source=ASHRAE 2005 Annual Design Conditions
 RunPeriodControl:DaylightSavingTime,
   2nd Sunday in March,    !- StartDate
   1st Sunday in November;    !- EndDate
  
 ! Using Design Conditions from "Climate Design Data 2005 ASHRAE Handbook"
 ! sanfrancisco_CA_USA Extreme Annual Wind Speeds, 1%=12.7m/s, 2.5%=11.4m/s, 5%=10.5m/s
 ! sanfrancisco_CA_USA Extreme Annual Temperatures, Max Drybulb=34.7°C Min Drybulb=1.4°C
  
 ! sanfrancisco_CA_USA Annual Heating Design Conditions Wind Speed=2.4m/s Wind Dir=140
 ! Coldest Month=JAN
 ! sanfrancisco_CA_USA Annual Heating 99.6%, MaxDB=3.2°C
 SizingPeriod:DesignDay,
  sanfrancisco Ann Htg 99.6% Condns DB,     !- Name
        3.2,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
        3.2,      !- Humidity Indicating Condition at Max Dry-Bulb
    101265.,      !- Barometric Pressure {Pa}
        2.4,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
        140,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          1,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type
 
 
 ! sanfrancisco Annual Cooling Design Conditions Wind Speed=5.8m/s Wind Dir=310
 ! Hottest Month=SEP
 ! sanfrancisco_CA_USA Annual Cooling (DB=>MWB) .4%, MaxDB=28.3°C MWB=17.2°C
 SizingPeriod:DesignDay,
  sanfrancisco Ann Clg .4% Condns DB=>MWB,     !- Name
       28.3,      !- Max Dry-Bulb {C}
          9,      !- Daily Temp Range {C}
       17.2,      !- Humidity Indicating Condition at Max Dry-Bulb
    101265.,      !- Barometric Pressure {Pa}
        5.8,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
        310,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          9,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type


##elseif #[location[] eqs Seattle]

 Site:Location,
   seattle,  ! LocationName
   47.45,  ! Latitude
   -122.3,  ! Longitude
   -8.,  ! TimeZone
   122.0114;  ! Elevation

Site:GroundTemperature:BuildingSurface,
 8.349904,
 7.320257,
 7.237792,
 7.726413,
 9.687948,
 11.64036,
 13.33297,
 14.40522,
 14.4963,
 13.62421,
 11.97477,
 10.08225;

 SizingPeriod:DesignDay,
  seattle Ann Htg 99.6% Condns DB,     !- Name
       -4.5,      !- Max Dry-Bulb {C}
        0.0,      !- Daily Temp Range {C}
       -4.5,      !- Humidity Indicating Condition at Max Dry-Bulb
     99868.,      !- Barometric Pressure {Pa}
        4.2,      !- Wind Speed {m/s} design conditions vs. traditional 6.71 m/s (15 mph)
         20,      !- Wind Direction {Degrees; N=0, S=180}
       0.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
         12,      !- Month
  WinterDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type

 ! seattle Annual Cooling Design Conditions Wind Speed=4.3m/s Wind Dir=0
 ! Hottest Month=AUG
 ! seattle_WA_USA Annual Cooling (DB=>MWB) .4%, MaxDB=29.4°C MWB=18.4°C
 SizingPeriod:DesignDay,
  seattle Ann Clg .4% Condns DB=>MWB,     !- Name
       29.4,      !- Max Dry-Bulb {C}
       10.1,      !- Daily Temp Range {C}
       18.4,      !- Humidity Indicating Condition at Max Dry-Bulb
     99868.,      !- Barometric Pressure {Pa}
        4.3,      !- Wind Speed {m/s} design conditions vs. traditional 3.35 m/s (7mph)
          0,      !- Wind Direction {Degrees; N=0, S=180}
       1.00,      !- Clearness {0.0 to 1.1}
          0,      !- Rain {0-no,1-yes}
          0,      !- Snow on ground {0-no,1-yes}
         21,      !- Day of Month
          8,      !- Month
  SummerDesignDay,!- Day Type
          0,      !- Daylight Savings Time Indicator
   WetBulb;      !- Humidity Indicating Type

##endif
 




