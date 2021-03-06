! Schedule.inc

  ScheduleTypeLimits,
    Any Number;              !- Name

  ScheduleTypeLimits,
    Fraction,                !- Name
    0,                       !- Lower Limit Value
    1,                       !- Upper Limit Value
    CONTINUOUS;              !- Numeric Type

  ScheduleTypeLimits,
    Temperature,             !- Name
    -60,                       !- Lower Limit Value
    200,                       !- Upper Limit Value
    CONTINUOUS;              !- Numeric Type

  ScheduleTypeLimits,
    On/Off,                  !- Name
    0,                       !- Lower Limit Value
    1,                       !- Upper Limit Value
    DISCRETE;                !- Numeric Type

  ScheduleTypeLimits,
    Control Type,            !- Name
    0,                       !- Lower Limit Value
    4,                       !- Upper Limit Value
    DISCRETE;                !- Numeric Type

  ScheduleTypeLimits,
    Humidity,                !- Name
    10,                       !- Lower Limit Value
    90,                       !- Upper Limit Value
    CONTINUOUS;              !- Numeric Type

  ScheduleTypeLimits,
    Number;                  !- Name


! Schedule set    Schedule_Office_ASHRAE_90.1-1989_TypTstatSetback[]
! Hours: Weekly: 92, Yearly: 4797
! Schedule Office Lighting,  ASHRAE 90.1-1989, Section 13 w/addenda

  Schedule:Compact,
    BLDG_LIGHT_SCH,          !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays,           !- Field 2
    Until: 05:00,            !- Field 3
    0.05,                    !- Field 4
    Until: 07:00,            !- Field 5
    0.1,                     !- Field 6
    Until: 08:00,            !- Field 7
    0.3,                     !- Field 8
    Until: 17:00,            !- Field 9
    0.9,                     !- Field 10
    Until: 18:00,            !- Field 11
    0.5,                     !- Field 12
    Until: 20:00,            !- Field 13
    0.3,                     !- Field 14
    Until: 22:00,            !- Field 15
    0.2,                     !- Field 16
    Until: 23:00,            !- Field 17
    0.1,                     !- Field 18
    Until: 24:00,            !- Field 19
    0.05,                    !- Field 20
    For: SummerDesignDay,    !- Field 21
    Until: 24:00,            !- Field 22
    1.0,                     !- Field 23
    For: Saturday,           !- Field 24
    Until: 06:00,            !- Field 25
    0.05,                    !- Field 26
    Until: 08:00,            !- Field 27
    0.1,                     !- Field 28
    Until: 12:00,            !- Field 29
    0.3,                     !- Field 30
    Until: 17:00,            !- Field 31
    0.15,                    !- Field 32
    Until: 24:00,            !- Field 33
    0.05,                    !- Field 34
    For: WinterDesignDay,    !- Field 35
    Until: 24:00,            !- Field 36
    0.0,                     !- Field 37
    For: Sunday Holidays AllOtherDays,  !- Field 38
    Until: 24:00,            !- Field 39
    0.05;                    !- Field 40

! Schedule Office Receptacle,  ASHRAE 90.1-1989, Section 13
! MODIFIED for increased off-hours plug loads (to account for more IT equipment)
! Hours: Weekly: 86.15, Yearly: 4492

  Schedule:Compact,
    BLDG_EQUIP_SCH,          !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays,           !- Field 2
    Until: 08:00,            !- Field 3
    0.40,                    !- Field 4
    Until: 12:00,            !- Field 5
    0.90,                    !- Field 6
    Until: 13:00,            !- Field 7
    0.80,                    !- Field 8
    Until: 17:00,            !- Field 9
    0.90,                    !- Field 10
    Until: 18:00,            !- Field 11
    0.50,                    !- Field 12
    Until: 24:00,            !- Field 13
    0.40,                    !- Field 14
    For: SummerDesignDay,    !- Field 15
    Until: 24:00,            !- Field 16
    1.0,                     !- Field 17
    For: Saturday,           !- Field 18
    Until: 06:00,            !- Field 19
    0.30,                    !- Field 20
    Until: 08:00,            !- Field 21
    0.4,                     !- Field 22
    Until: 12:00,            !- Field 23
    0.5,                     !- Field 24
    Until: 17:00,            !- Field 25
    0.35,                    !- Field 26
    Until: 24:00,            !- Field 27
    0.30,                    !- Field 28
    For: WinterDesignDay,    !- Field 29
    Until: 24:00,            !- Field 30
    0.0,                     !- Field 31
    For: Sunday Holidays AllOtherDays,  !- Field 32
    Until: 24:00,            !- Field 33
    0.30;                    !- Field 34

! Schedule Office Occupancy,

  Schedule:Compact,
    BLDG_OCC_SCH,            !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays,           !- Field 2
    Until: 06:00,            !- Field 3
    0.0,                     !- Field 4
    Until: 07:00,            !- Field 5
    0.1,                     !- Field 6
    Until: 08:00,            !- Field 7
    0.2,                     !- Field 8
    Until: 12:00,            !- Field 9
    0.95,                    !- Field 10
    Until: 13:00,            !- Field 11
    0.5,                     !- Field 12
    Until: 17:00,            !- Field 13
    0.95,                    !- Field 14
    Until: 18:00,            !- Field 15
    0.3,                     !- Field 16
    Until: 20:00,            !- Field 17
    0.1,                     !- Field 18
    Until: 24:00,            !- Field 19
    0.05,                    !- Field 20
    For: SummerDesignDay,    !- Field 21
    Until: 06:00,            !- Field 22
    0.0,                     !- Field 23
    Until: 22:00,            !- Field 24
    1.0,                     !- Field 25
    Until: 24:00,            !- Field 26
    0.05,                    !- Field 27
    For: Saturday,           !- Field 28
    Until: 06:00,            !- Field 29
    0.0,                     !- Field 30
    Until: 08:00,            !- Field 31
    0.1,                     !- Field 32
    Until: 12:00,            !- Field 33
    0.3,                     !- Field 34
    Until: 17:00,            !- Field 35
    0.1,                     !- Field 36
    Until: 19:00,            !- Field 37
    0.0,                     !- Field 38
    Until: 24:00,            !- Field 39
    0.0,                     !- Field 40
    For: WinterDesignDay,    !- Field 41
    Until: 24:00,            !- Field 42
    0.0,                     !- Field 43
    For: Sunday Holidays AllOtherDays,  !- Field 44
    Until: 06:00,            !- Field 45
    0.0,                     !- Field 46
    Until: 18:00,            !- Field 47
    0.0,                     !- Field 48
    Until: 24:00,            !- Field 49
    0.0;                     !- Field 50

! Schedule Elevator

  Schedule:Compact,
    BLDG_ELEVATORS,          !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 07:00,            !- Field 3
    0.0,                     !- Field 4
    Until: 08:00,            !- Field 5
    0.35,                    !- Field 6
    Until: 09:00,            !- Field 7
    0.69,                    !- Field 8
    Until: 10:00,            !- Field 9
    0.43,                    !- Field 10
    Until: 11:00,            !- Field 11
    0.37,                    !- Field 12
    Until: 12:00,            !- Field 13
    0.43,                    !- Field 14
    Until: 13:00,            !- Field 15
    0.58,                    !- Field 16
    Until: 14:00,            !- Field 17
    0.48,                    !- Field 18
    Until: 15:00,            !- Field 19
    0.37,                    !- Field 20
    Until: 16:00,            !- Field 21
    0.37,                    !- Field 22
    Until: 17:00,            !- Field 23
    0.46,                    !- Field 24
    Until: 18:00,            !- Field 25
    0.62,                    !- Field 26
    Until: 19:00,            !- Field 27
    0.12,                    !- Field 28
    Until: 20:00,            !- Field 29
    0.04,                    !- Field 30
    Until: 21:00,            !- Field 31
    0.04,                    !- Field 32
    Until: 24:00,            !- Field 33
    0.00,                    !- Field 34
    For: Saturday WinterDesignDay,  !- Field 35
    Until: 07:00,            !- Field 36
    0.0,                     !- Field 37
    Until: 08:00,            !- Field 38
    0.16,                    !- Field 39
    Until: 09:00,            !- Field 40
    0.14,                    !- Field 41
    Until: 10:00,            !- Field 42
    0.21,                    !- Field 43
    Until: 11:00,            !- Field 44
    0.18,                    !- Field 45
    Until: 12:00,            !- Field 46
    0.25,                    !- Field 47
    Until: 13:00,            !- Field 48
    0.21,                    !- Field 49
    Until: 14:00,            !- Field 50
    0.13,                    !- Field 51
    Until: 15:00,            !- Field 52
    0.08,                    !- Field 53
    Until: 16:00,            !- Field 54
    0.04,                    !- Field 55
    Until: 17:00,            !- Field 56
    0.05,                    !- Field 57
    Until: 18:00,            !- Field 58
    0.06,                    !- Field 59
    Until: 24:00,            !- Field 60
    0.00,                    !- Field 61
    For: Sunday Holidays AllOtherDays,  !- Field 62
    Until: 24:00,            !- Field 63
    0.0;                     !- Field 64

  Schedule:Compact,
    INFIL_SCH,               !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 06:00,            !- Field 3
    1.0,                     !- Field 4
    Until: 22:00,            !- Field 5
    0.0,                     !- Field 6
    Until: 24:00,            !- Field 7
    1.0,                     !- Field 8
    For: Saturday WinterDesignDay,  !- Field 9
    Until: 06:00,            !- Field 10
    1.0,                     !- Field 11
    Until: 18:00,            !- Field 12
    0.0,                     !- Field 13
    Until: 24:00,            !- Field 14
    1.0,                     !- Field 15
    For: Sunday Holidays AllOtherDays,  !- Field 16
    Until: 24:00,            !- Field 17
    1.0;                     !- Field 18

  Schedule:Compact,
    INFIL_HALF_ON_SCH,       !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 06:00,            !- Field 3
    1.0,                     !- Field 4
    Until: 22:00,            !- Field 5
    0.5,                     !- Field 6
    Until: 24:00,            !- Field 7
    1.0,                     !- Field 8
    For: Saturday WinterDesignDay,  !- Field 9
    Until: 06:00,            !- Field 10
    1.0,                     !- Field 11
    Until: 18:00,            !- Field 12
    0.5,                     !- Field 13
    Until: 24:00,            !- Field 14
    1.0,                     !- Field 15
    For: Sunday Holidays AllOtherDays,  !- Field 16
    Until: 24:00,            !- Field 17
    1.0;                     !- Field 18

  Schedule:Compact,
    INFIL_QUARTER_ON_SCH,    !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 06:00,            !- Field 3
    1.0,                     !- Field 4
    Until: 22:00,            !- Field 5
    0.25,                    !- Field 6
    Until: 24:00,            !- Field 7
    1.0,                     !- Field 8
    For: Saturday WinterDesignDay,  !- Field 9
    Until: 06:00,            !- Field 10
    1.0,                     !- Field 11
    Until: 18:00,            !- Field 12
    0.25,                    !- Field 13
    Until: 24:00,            !- Field 14
    1.0,                     !- Field 15
    For: Sunday Holidays AllOtherDays,  !- Field 16
    Until: 24:00,            !- Field 17
    1.0;                     !- Field 18

! Schedule Office Service Water Heating, ASHRAE 90.1-1989, Section 13

  Schedule:Compact,
    BLDG_SWH_SCH,            !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 05:00,            !- Field 3
    0.05,                    !- Field 4
    Until: 06:00,            !- Field 5
    0.08,                    !- Field 6
    Until: 07:00,            !- Field 7
    0.07,                    !- Field 8
    Until: 08:00,            !- Field 9
    0.19,                    !- Field 10
    Until: 09:00,            !- Field 11
    0.35,                    !- Field 12
    Until: 10:00,            !- Field 13
    0.38,                    !- Field 14
    Until: 11:00,            !- Field 15
    0.39,                    !- Field 16
    Until: 12:00,            !- Field 17
    0.47,                    !- Field 18
    Until: 13:00,            !- Field 19
    0.57,                    !- Field 20
    Until: 14:00,            !- Field 21
    0.54,                    !- Field 22
    Until: 15:00,            !- Field 23
    0.34,                    !- Field 24
    Until: 16:00,            !- Field 25
    0.33,                    !- Field 26
    Until: 17:00,            !- Field 27
    0.44,                    !- Field 28
    Until: 18:00,            !- Field 29
    0.26,                    !- Field 30
    Until: 19:00,            !- Field 31
    0.21,                    !- Field 32
    Until: 20:00,            !- Field 33
    0.15,                    !- Field 34
    Until: 21:00,            !- Field 35
    0.17,                    !- Field 36
    Until: 22:00,            !- Field 37
    0.08,                    !- Field 38
    Until: 24:00,            !- Field 39
    0.05,                    !- Field 40
    For: Saturday WinterDesignDay,  !- Field 41
    Until: 05:00,            !- Field 42
    0.05,                    !- Field 43
    Until: 06:00,            !- Field 44
    0.08,                    !- Field 45
    Until: 07:00,            !- Field 46
    0.07,                    !- Field 47
    Until: 08:00,            !- Field 48
    0.11,                    !- Field 49
    Until: 09:00,            !- Field 50
    0.15,                    !- Field 51
    Until: 10:00,            !- Field 52
    0.21,                    !- Field 53
    Until: 11:00,            !- Field 54
    0.19,                    !- Field 55
    Until: 12:00,            !- Field 56
    0.23,                    !- Field 57
    Until: 13:00,            !- Field 58
    0.20,                    !- Field 59
    Until: 14:00,            !- Field 60
    0.19,                    !- Field 61
    Until: 15:00,            !- Field 62
    0.15,                    !- Field 63
    Until: 16:00,            !- Field 64
    0.13,                    !- Field 65
    Until: 17:00,            !- Field 66
    0.14,                    !- Field 67
    Until: 21:00,            !- Field 68
    0.07,                    !- Field 69
    Until: 22:00,            !- Field 70
    0.09,                    !- Field 71
    Until: 24:00,            !- Field 72
    0.05,                    !- Field 73
    For: Sunday Holidays AllOtherDays,  !- Field 74
    Until: 05:00,            !- Field 75
    0.04,                    !- Field 76
    Until: 06:00,            !- Field 77
    0.07,                    !- Field 78
    Until: 11:00,            !- Field 79
    0.04,                    !- Field 80
    Until: 13:00,            !- Field 81
    0.06,                    !- Field 82
    Until: 14:00,            !- Field 83
    0.09,                    !- Field 84
    Until: 15:00,            !- Field 85
    0.06,                    !- Field 86
    Until: 21:00,            !- Field 87
    0.04,                    !- Field 88
    Until: 22:00,            !- Field 89
    0.07,                    !- Field 90
    Until: 24:00,            !- Field 91
    0.04;                    !- Field 92

  Schedule:Compact,
    Hours_of_operation,      !- Name
    On/Off,                  !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 06:00,            !- Field 3
    0.0,                     !- Field 4
    Until: 22:00,            !- Field 5
    1.0,                     !- Field 6
    Until: 24:00,            !- Field 7
    0.0,                     !- Field 8
    For: Saturday WinterDesignDay,  !- Field 9
    Until: 06:00,            !- Field 10
    0.0,                     !- Field 11
    Until: 18:00,            !- Field 12
    1.0,                     !- Field 13
    Until: 24:00,            !- Field 14
    0.0,                     !- Field 15
    For: Sunday Holidays AllOtherDays,  !- Field 16
    Until: 24:00,            !- Field 17
    0.0;                     !- Field 18

  Schedule:Compact,
    ALWAYS_ON,               !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    1.0;                     !- Field 4

  Schedule:Compact,
    ALWAYS_OFF,              !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    0.0;                     !- Field 4

! Schedule Office HVAC Systems, ASHRAE 90.1-1989, Section 13
!  Equivalent Full-Load Hours: Weekdays 16, Saturday 12, Sunday/Holidays 0

  Schedule:Compact,
    HVACOperationSchd,       !- Name
    On/Off,                  !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 06:00,            !- Field 3
    0.0,                     !- Field 4
    Until: 22:00,            !- Field 5
    1.0,                     !- Field 6
    Until: 24:00,            !- Field 7
    0.0,                     !- Field 8
    For: Saturday WinterDesignDay,  !- Field 9
    Until: 06:00,            !- Field 10
    0.0,                     !- Field 11
    Until: 18:00,            !- Field 12
    1.0,                     !- Field 13
    Until: 24:00,            !- Field 14
    0.0,                     !- Field 15
    For: Sunday Holidays AllOtherDays,  !- Field 16
    Until: 24:00,            !- Field 17
    0.0;                     !- Field 18

  Schedule:Compact,
    PlantOnSched,            !- Name
    On/Off,                  !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    1.0;                     !- Field 4

  Schedule:Compact,
    FAN_SCH,                 !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    1.0;                     !- Field 4

  Schedule:Compact,
    ReheatCoilAvailSched,    !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    1.0;                     !- Field 4

  Schedule:Compact,
    CoolingCoilAvailSched,   !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    1.0;                     !- Field 4

  Schedule:Compact,
    HTGSETP_SCH,             !- Name
    Temperature,             !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays,  !- Field 2
    Until: 05:00,            !- Field 3
    Heat_SetBack[],                    !- Field 4
    Until: 19:00,            !- Field 5
    Heat_SetPoint[],                    !- Field 6
    Until: 24:00,            !- Field 7
    Heat_SetBack[],                     !- Field 8
    For SummerDesignDay,     !- Field 9
    Until: 24:00,            !- Field 10
    Heat_SetBack[],                    !- Field 11
    For: Saturday,           !- Field 12
    Until: 06:00,            !- Field 13
    Heat_SetBack[],                    !- Field 14
    Until: 17:00,            !- Field 15
    Heat_SetPoint[],                    !- Field 16
    Until: 24:00,            !- Field 17
    Heat_SetBack[],                    !- Field 18
    For: WinterDesignDay,    !- Field 19
    Until: 24:00,            !- Field 20
    Heat_SetPoint[],                    !- Field 21
    For: Sunday Holidays AllOtherDays,  !- Field 22
    Until: 24:00,            !- Field 23
    Heat_SetBack[];                    !- Field 24

  Schedule:Compact,
    CLGSETP_SCH,             !- Name
    Temperature,             !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 06:00,            !- Field 3
    Cool_SetUp[],                    !- Field 4
    Until: 22:00,            !- Field 5
    Cool_SetPoint[],                    !- Field 6
    Until: 24:00,            !- Field 7
    Cool_SetUp[],                    !- Field 8
    For: Saturday,           !- Field 9
    Until: 06:00,            !- Field 10
    Cool_SetUp[],                    !- Field 11
    Until: 18:00,            !- Field 12
    Cool_SetPoint[],                    !- Field 13
    Until: 24:00,            !- Field 14
    Cool_SetUp[],                    !- Field 15
    For WinterDesignDay,     !- Field 16
    Until: 24:00,            !- Field 17
    Cool_SetUp[],                    !- Field 18
    For: Sunday Holidays AllOtherDays,  !- Field 19
    Until: 24:00,            !- Field 20
    Cool_SetUp[];                    !- Field 21

  Schedule:Compact,
    Humidity Setpoint Schedule,  !- Name
    Humidity,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 24:00,            !- Field 3
    50,                      !- Field 4
    For: Saturday WinterDesignDay,  !- Field 5
    Until: 24:00,            !- Field 6
    50,                      !- Field 7
    For: Sunday Holidays AllOtherDays,  !- Field 8
    Until: 24:00,            !- Field 9
    50;                      !- Field 10

  Schedule:Compact,
    MinRelHumSetSch,  
    Humidity,                 
    Through: 12/31,        
    For: AllDays,           
    Until: 24:00,             
    30;                          
    
  Schedule:Compact,
    MaxRelHumSetSch,  
    Humidity,                 
    Through: 12/31,        
    For: AllDays,           
    Until: 24:00,             
    60;

  Schedule:Compact,
    MinOA_MotorizedDamper_Sched,  !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: Weekdays SummerDesignDay,  !- Field 2
    Until: 07:00,            !- Field 3
    0.0,                     !- Field 4
    Until: 22:00,            !- Field 5
    1.0,                     !- Field 6
    Until: 24:00,            !- Field 7
    0.0,                     !- Field 8
    For: Saturday WinterDesignDay,  !- Field 9
    Until: 07:00,            !- Field 10
    0.0,                     !- Field 11
    Until: 18:00,            !- Field 12
    1.0,                     !- Field 13
    Until: 24:00,            !- Field 14
    0.0,                     !- Field 15
    For: Sunday Holidays AllOtherDays,  !- Field 16
    Until: 24:00,            !- Field 17
    0.0;                     !- Field 18

  Schedule:Compact,
    MinOA_Sched,             !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    1.0;                     !- Field 4

  Schedule:Compact,
    Dual Zone Control Type Sched,  !- Name
    Control Type,            !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    4;                       !- Field 4

  Schedule:Compact,
    Seasonal-Reset-Supply-Air-Temp-Sch,  !- Name
    Temperature,             !- Schedule Type Limits Name
    Through: 3/31,           !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    zcdsat[],                    !- Field 4
    Through: 9/30,           !- Field 5
    For: AllDays,            !- Field 6
    Until: 24:00,            !- Field 7
    zcdsat[],                    !- Field 8
    Through: 12/31,          !- Field 9
    For: AllDays,            !- Field 10
    Until: 24:00,            !- Field 11
    zcdsat[];                    !- Field 12

  Schedule:Compact,
    CW-Loop-Temp-Schedule,   !- Name
    Temperature,             !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    6.7;                     !- Field 4

  Schedule:Compact,
    HW-Loop-Temp-Schedule,   !- Name
    Temperature,             !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    60.;                     !- Field 4

  Schedule:Compact,
    Heating-Supply-Air-Temp-Sch,  !- Name
    Temperature,             !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    16.0;                    !- Field 4

  Schedule:Compact,
    ACTIVITY_SCH,            !- Name
    Any Number,              !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    120.;                    !- Field 4

  Schedule:Compact,
    WORK_EFF_SCH,            !- Name
    Fraction,                !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    0.0;                     !- Field 4

  Schedule:Compact,
    AIR_VELO_SCH,            !- Name
    Any Number,              !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    0.2;                     !- Field 4

  Schedule:Compact,
    CLOTHING_SCH,            !- Name
    Any Number,              !- Schedule Type Limits Name
    Through: 04/30,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    1.0,                     !- Field 4
    Through: 09/30,          !- Field 5
    For: AllDays,            !- Field 6
    Until: 24:00,            !- Field 7
    0.5,                     !- Field 8
    Through: 12/31,          !- Field 9
    For: AllDays,            !- Field 10
    Until: 24:00,            !- Field 11
    1.0;                     !- Field 12

  Schedule:Compact,
    SHADING_SCH,             !- Name
    Any Number,              !- Schedule Type Limits Name
    Through: 12/31,          !- Field 1
    For: AllDays,            !- Field 2
    Until: 24:00,            !- Field 3
    0.0;                     !- Field 4
