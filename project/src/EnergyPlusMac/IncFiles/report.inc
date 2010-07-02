!==== file: report.inc ====Start====

! Temperatures, etc

  Output:Variable,
    *,                       !- Key_Value
    Outdoor Dry Bulb,        !- Variable_Name
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       	!- Key_Value
    Outdoor Relative Humidity,  !- Variable_Name
    hourly;                  	!- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Outdoor Wet Bulb,        !- Variable_Name
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Zone People Total Heat Gain,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Zone Lights Total Heat Gain,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Zone Electric Equipment Total Heat Gain	,
    hourly;                  !- Reporting_Frequency
	
  Output:Variable,
    *,                       !- Key_Value
    Zone Mean Air Temperature,        !- Variable_Name
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Zone Lights Electric Power, 
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Zone Electric Equipment Electric Power,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
	Zone/Sys Sensible Heating Rate,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
	Zone/Sys Sensible Cooling Rate,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    REHEAT COIL ZONE 1,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 2,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    REHEAT COIL ZONE 3,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 4,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 5,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 6,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 7,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
   
  Output:Variable,
    REHEAT COIL ZONE 8,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 9,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 10,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
       		
  Output:Variable,
    *,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
  	Total Water Cooling Coil Rate,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
	Fan Electric Power,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Chiller Electric Power, 
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Chiller COP ,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Boiler Gas Consumption Rate, 
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Boiler Parasitic Electric Consumption Rate, 
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Pump Electric Power, 
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Tower Fan Electric Power, 
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Total Building Electric Demand,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Total HVAC Electric Demand,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    *,                       !- Key_Value
    Total Electric Demand,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    COR1 INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    PER1WES INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    PER1EAS INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    PER1NOR INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    PER1SOU INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    COR3 INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    PER3WES INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    PER3EAS INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    PER3NOR INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    PER3SOU INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    MIXED AIR NODE 1,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    COOLING COIL AIR OUTLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

  Output:Variable,
    HEATING COIL AIR OUTLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    CoolSys1 Inlet Node,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    CoolSys1 Outlet Node,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    COOLING COIL WATER INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    COOLING COIL WATER OUTLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    Condenser Loop Supply Inlet Node,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    CONDENSER TOWER INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    CONDENSER TOWER OUTLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    CoolSys1 CONDENSER WATER INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    CoolSys1 CONDENSER WATER OUTLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    BOILER INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    BOILER OUTLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    HEATING COIL WATER INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	Output:Variable,
    HEATING COIL WATER OUTLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency

	
  Output:Variable,
    MIXED AIR NODE 1,
	System Node Setpoint Temp,
	hourly;

  Output:Variable,
    AIR LOOP OUTLET NODE 1,
	System Node Setpoint Temp,
	hourly;

  Output:Variable,
    COOLING COIL AIR OUTLET NODE,
	System Node Setpoint Temp,
	hourly;

  Output:Variable,
    HEATING COIL AIR OUTLET NODE,
	System Node Setpoint Temp,
	hourly;

  Output:Variable,
    COR1 NODE,
	System Node Setpoint Temp,
	hourly;
	
  Output:Variable,
    PER1WES NODE,
	System Node Setpoint Temp,
	hourly;
	
  Output:Variable,
    PER1EAS NODE,
	System Node Setpoint Temp,
	hourly;
	
	Output:Variable,
    PER1NOR NODE,
	System Node Setpoint Temp,
	hourly;
	
  Output:Variable,
    PER1SOU NODE,
	System Node Setpoint Temp,
	hourly;
	
  Output:Variable,
    COR3 NODE,
	System Node Setpoint Temp,
	hourly;
	
	Output:Variable,
    PER3WES NODE,
	System Node Setpoint Temp,
	hourly;
	
  Output:Variable,
    PER3EAS NODE,
	System Node Setpoint Temp,
	hourly;
	
	Output:Variable,
    PER3NOR NODE,
	System Node Setpoint Temp,
	hourly;
	
  Output:Variable,
    PER3SOU NODE,
	System Node Setpoint Temp,
	hourly;
	
	##if #[Floors[] nes 2]
  Output:Variable,
    COR2 NODE,
	System Node Setpoint Temp,
	hourly;
	
	Output:Variable,
    PER2WES NODE,
	System Node Setpoint Temp,
	hourly;
	
  Output:Variable,
    PER2EAS NODE,
	System Node Setpoint Temp,
	hourly;
	
	Output:Variable,
    PER2NOR NODE,
	System Node Setpoint Temp,
	hourly;
	
  Output:Variable,
    PER2SOU NODE,
	System Node Setpoint Temp,
	hourly;
	
	Output:Variable,
    COR2 INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
	Output:Variable,
    PER2WES INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
	Output:Variable,
    PER2EAS INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
	Output:Variable,
    PER2NOR INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
	Output:Variable,
    PER2SOU INLET NODE,
    System Node Temp,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 11,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 12,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 13,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 14,                      !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
  Output:Variable,
    REHEAT COIL ZONE 15,                       !- Key_Value
	Total Water Heating Coil Rate,
    hourly;                  !- Reporting_Frequency
    
	##endif

! Deru and Torcellini 2007
! Source Energy and Emission Factors for Energy Use in Buildings
! NREL/TP-550-38617
! source factor and Higher Heating Values from Table 5
! post-combustion emission factors for boiler from Table 9 (with factor of 1000 correction for natural gas)
 
  FuelFactors,
    NaturalGas,              !- Existing Fuel Resource Name
    m3,                      !- Units of Measure
    37631000,                !- Energy per Unit Factor
    1.092,                   !- Source Energy Factor {J/J}
    ,                        !- Source Energy Schedule Name
    5.21E+01,                !- CO2 Emission Factor {g/MJ}
    ,                        !- CO2 Emission Factor Schedule Name
    3.99E-02,                !- CO Emission Factor {g/MJ}
    ,                        !- CO Emission Factor Schedule Name
    1.06E-03,                !- CH4 Emission Factor {g/MJ}
    ,                        !- CH4 Emission Factor Schedule Name
    4.73E-02,                !- NOx Emission Factor {g/MJ}
    ,                        !- NOx Emission Factor Schedule Name
    1.06E-03,                !- N2O Emission Factor {g/MJ}
    ,                        !- N2O Emission Factor Schedule Name
    2.68E-04,                !- SO2 Emission Factor {g/MJ}
    ,                        !- SO2 Emission Factor Schedule Name
    0.0,                     !- PM Emission Factor {g/MJ}
    ,                        !- PM Emission Factor Schedule Name
    3.59E-03,                !- PM10 Emission Factor {g/MJ}
    ,                        !- PM10 Emission Factor Schedule Name
    0.0,                     !- PM2.5 Emission Factor {g/MJ}
    ,                        !- PM2.5 Emission Factor Schedule Name
    0,                       !- NH3 Emission Factor {g/MJ}
    ,                        !- NH3 Emission Factor Schedule Name
    2.61E-03,                !- NMVOC Emission Factor {g/MJ}
    ,                        !- NMVOC Emission Factor Schedule Name
    1.11E-07,                !- Hg Emission Factor {g/MJ}
    ,                        !- Hg Emission Factor Schedule Name
    2.13E-07,                !- Pb Emission Factor {g/MJ}
    ,                        !- Pb Emission Factor Schedule Name
    0,                       !- Water Emission Factor {L/MJ}
    ,                        !- Water Emission Factor Schedule Name
    0,                       !- Nuclear High Level Emission Factor {g/MJ}
    ,                        !- Nuclear High Level Emission Factor Schedule Name
    0;                       !- Nuclear Low Level Emission Factor {m3/MJ}
 
    !
 
  FuelFactors,
    FuelOil#1,               !- Existing Fuel Resource Name
    m3,                      !- Units of Measure
    38.656E+09,              !- Energy per Unit Factor
    1.158,                   !- Source Energy Factor {J/J}
    ,                        !- Source Energy Schedule Name
    7.06E+01,                !- CO2 Emission Factor {g/MJ}
    ,                        !- CO2 Emission Factor Schedule Name
    1.68E-02,                !- CO Emission Factor {g/MJ}
    ,                        !- CO Emission Factor Schedule Name
    7.19E-04,                !- CH4 Emission Factor {g/MJ}
    ,                        !- CH4 Emission Factor Schedule Name
    6.67E-02,                !- NOx Emission Factor {g/MJ}
    ,                        !- NOx Emission Factor Schedule Name
    3.70E-04,                !- N2O Emission Factor {g/MJ}
    ,                        !- N2O Emission Factor Schedule Name
    1.06E-01,                !- SO2 Emission Factor {g/MJ}
    ,                        !- SO2 Emission Factor Schedule Name
    0.0,                     !- PM Emission Factor {g/MJ}
    ,                        !- PM Emission Factor Schedule Name
    5.82E-03,                !- PM10 Emission Factor {g/MJ}
    ,                        !- PM10 Emission Factor Schedule Name
    0.0,                     !- PM2.5 Emission Factor {g/MJ}
    ,                        !- PM2.5 Emission Factor Schedule Name
    0,                       !- NH3 Emission Factor {g/MJ}
    ,                        !- NH3 Emission Factor Schedule Name
    1.14E-03,                !- NMVOC Emission Factor {g/MJ}
    ,                        !- NMVOC Emission Factor Schedule Name
    0.0,                     !- Hg Emission Factor {g/MJ}
    ,                        !- Hg Emission Factor Schedule Name
    0.0,                     !- Pb Emission Factor {g/MJ}
    ,                        !- Pb Emission Factor Schedule Name
    0,                       !- Water Emission Factor {L/MJ}
    ,                        !- Water Emission Factor Schedule Name
    0,                       !- Nuclear High Level Emission Factor {g/MJ}
    ,                        !- Nuclear High Level Emission Factor Schedule Name
    0;                       !- Nuclear Low Level Emission Factor {m3/MJ}
 
  FuelFactors,
    Propane,                 !- Existing Fuel Resource Name
    m3,                      !- Units of Measure
    25.362E+09,              !- Energy per Unit Factor
    1.151,                   !- Source Energy Factor {J/J}
    ,                        !- Source Energy Schedule Name
    6.27E+01,                !- CO2 Emission Factor {g/MJ}
    ,                        !- CO2 Emission Factor Schedule Name
    1.03E-02,                !- CO Emission Factor {g/MJ}
    ,                        !- CO Emission Factor Schedule Name
    1.03E-03,                !- CH4 Emission Factor {g/MJ}
    ,                        !- CH4 Emission Factor Schedule Name
    7.41E-02,                !- NOx Emission Factor {g/MJ}
    ,                        !- NOx Emission Factor Schedule Name
    4.61E-03,                !- N2O Emission Factor {g/MJ}
    ,                        !- N2O Emission Factor Schedule Name
    0.0,                     !- SO2 Emission Factor {g/MJ}
    ,                        !- SO2 Emission Factor Schedule Name
    0.0,                     !- PM Emission Factor {g/MJ}
    ,                        !- PM Emission Factor Schedule Name
    2.31E-03,                !- PM10 Emission Factor {g/MJ}
    ,                        !- PM10 Emission Factor Schedule Name
    0.0,                     !- PM2.5 Emission Factor {g/MJ}
    ,                        !- PM2.5 Emission Factor Schedule Name
    0.0,                     !- NH3 Emission Factor {g/MJ}
    ,                        !- NH3 Emission Factor Schedule Name
    1.79E-03,                !- NMVOC Emission Factor {g/MJ}
    ,                        !- NMVOC Emission Factor Schedule Name
    0.0,                     !- Hg Emission Factor {g/MJ}
    ,                        !- Hg Emission Factor Schedule Name
    0.0,                     !- Pb Emission Factor {g/MJ}
    ,                        !- Pb Emission Factor Schedule Name
    0,                       !- Water Emission Factor {L/MJ}
    ,                        !- Water Emission Factor Schedule Name
    0,                       !- Nuclear High Level Emission Factor {g/MJ}
    ,                        !- Nuclear High Level Emission Factor Schedule Name
    0;                       !- Nuclear Low Level Emission Factor {m3/MJ}
  
  Output:Surfaces:Drawing,   DXF;  
    
  Output:VariableDictionary, IDF, Unsorted;
    
  Output:Constructions,Constructions;  

  Output:Surfaces:List, Details; 
 
  OutputControl:Table:Style,
    HTML;                    !- Column Separator
 
  Output:Table:SummaryReports,
    AnnualBuildingUtilityPerformanceSummary,  !- Report 1 Name
    InputVerificationandResultsSummary,  !- Report 2 Name
    ClimaticDataSummary,  !- Report 3 Name
    EnvelopeSummary,         !- Report 4 Name
    EquipmentSummary,        !- Report 5 Name
    ComponentSizingSummary,         !- Report 6 Name
    HVACSizingSummary,         !- Report 7 Name
    SystemSummary;         !- Report 8 Name
 
  Output:Table:Monthly,
    Occupant Comfort Data Summary,  !- Name
    3,                       !- Digits After Decimal
    Zone People Number of Occupants,  !- Variable or Meter 1 Name
    HoursNonZero,            !- Aggregation Type for Variable or Meter 1
    Zone/Sys Air Temperature,!- Variable or Meter 2 Name
    SumOrAverageDuringHoursShown,  !- Aggregation Type for Variable or Meter 2
    Zone Air Relative Humidity,  !- Variable or Meter 3 Name
    SumOrAverageDuringHoursShown,  !- Aggregation Type for Variable or Meter 3
    ThermalComfortMRT,       !- Variable or Meter 4 Name
    SumOrAverageDuringHoursShown,  !- Aggregation Type for Variable or Meter 4
    Time Not Comfortable Summer Or Winter Clothes,  !- Variable or Meter 5 Name
    SumOrAverageDuringHoursShown,  !- Aggregation Type for Variable or Meter 5
    FANGERPMV,               !- Variable or Meter 6 Name
    SumOrAverageDuringHoursShown;  !- Aggregation Type for Variable or Meter 6
 
  Output:EnvironmentalImpactFactors,
    Monthly;                 !- Reporting Frequency
 
  EnvironmentalImpactFactors,
    0.663,                   !- District Heating Efficiency 
    4.18,                    !- District Cooling COP        
    0.585,                   !- Steam Conversion Efficiency 
    80.7272,                 !- Total Carbon Equivalent Emission Factor From NOx {kg/kg}
    6.2727,                  !- Total Carbon Equivalent Emission Factor From CH4 {kg/kg}
    0.2727;                  !- Total Carbon Equivalent Emission Factor From CO2 {kg/kg}
 
  Output:Table:Monthly,
    Emissions Data Summary,  !- Name
    4,                       !- Digits After Decimal
    CO2:Facility,            !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    NOx:Facility,            !- Variable or Meter 2 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 2
    SO2:Facility,            !- Variable or Meter 3 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 3
    PM:Facility,             !- Variable or Meter 4 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 4
    Hg:Facility,             !- Variable or Meter 5 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 5
    WaterEnvironmentalFactors:Facility,  !- Variable or Meter 6 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 6
    Carbon Equivalent:Facility,  !- Variable or Meter 7 Name
    SumOrAverage;            !- Aggregation Type for Variable or Meter 7
 
  Output:Table:Monthly,
    Outdoor Air Summary,     !- Name
    3,                       !- Digits After Decimal
    Zone People Number of Occupants,  !- Variable or Meter 1 Name
    HoursNonZero,            !- Aggregation Type for Variable or Meter 1
    Zone People Number Of Occupants,  !- Variable or Meter 2 Name
    SumOrAverageDuringHoursShown,  !- Aggregation Type for Variable or Meter 2
    Zone Mechanical Ventilation Air Change Rate,  !- Variable or Meter 3 Name
    SumOrAverageDuringHoursShown,  !- Aggregation Type for Variable or Meter 3
    Zone Infiltration Air Change Rate,  !- Variable or Meter 4 Name
    SumOrAverageDuringHoursShown;  !- Aggregation Type for Variable or Meter 4
 
  Output:Table:Monthly,
    Ventilation Load Components,  !- Name
    3,                       !- Digits After Decimal
    Zone Mechanical Ventilation No Load Heat Removal,  !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    Zone Mechanical Ventilation Cooling Load Increase,  !- Variable or Meter 2 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 2
    Zone Mech Ventilation Cooling Load Increase: OverHeating,  !- Variable or Meter 3 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 3
    Zone Mechanical Ventilation Cooling Load Decrease,  !- Variable or Meter 4 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 4
    Zone Mechanical Ventilation No Load Heat Addition,  !- Variable or Meter 5 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 5
    Zone Mechanical Ventilation Heating Load Increase,  !- Variable or Meter 6 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 6
    Zone Mech Ventilation Heating Load Increase: OverCooling,  !- Variable or Meter 7 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 7
    Zone Mechanical Ventilation Heating Load Decrease,  !- Variable or Meter 8 Name
    SumOrAverage;            !- Aggregation Type for Variable or Meter 8
 
  Output:Table:Monthly,
    Overall HVAC Air System Loads,  !- Name
    3,                       !- Digits After Decimal
    Air Loop Total Heating Energy,  !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    Air Loop Total Cooling Energy,  !- Variable or Meter 2 Name
    SumOrAverage;            !- Aggregation Type for Variable or Meter 2
 
  Output:Table:Monthly,
    Overall HVAC System Energy,  !- Name
    3,                       !- Digits After Decimal
    Electricity:HVAC,        !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    Heating:Gas,             !- Variable or Meter 2 Name
    SumOrAverage;            !- Aggregation Type for Variable or Meter 2
 
  Output:Table:Monthly,
    Components of Peak Electrical Demand,  !- Name
    3,                       !- Digits After Decimal
    Electricity:Facility,    !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    Electricity:Facility,    !- Variable or Meter 2 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 2
    InteriorLights:Electricity,  !- Variable or Meter 3 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 3
    InteriorEquipment:Electricity,  !- Variable or Meter 4 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 4
    Fans:Electricity,        !- Variable or Meter 5 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 5
    Heating:Electricity,     !- Variable or Meter 6 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 6
    Cooling:Electricity,     !- Variable or Meter 7 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 7
    ExteriorLights:Electricity,  !- Variable or Meter 8 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 8
    Pumps:Electricity,       !- Variable or Meter 9 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 9
    HeatRejection:Electricity,  !- Variable or Meter 10 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 10
    ExteriorEquipment:Electricity,  !- Variable or Meter 11 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 11
    Humidification:Electricity,  !- Variable or Meter 12 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 12
    HeatRecovery:Electricity,!- Variable or Meter 13 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 13
    WaterSystems:Electricity,!- Variable or Meter 14 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 14
    Refrigeration:Electricity,  !- Variable or Meter 15 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 15
    Generators:Electricity,  !- Variable or Meter 16 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 16
    ElectricityProduced:Facility,  !- Variable or Meter 17 Name
    ValueWhenMaximumOrMinimum;  !- Aggregation Type for Variable or Meter 17
 
  Output:Table:Monthly,
    Components of Peak Net Electrical Demand,  !- Name
    3,                       !- Digits After Decimal
    ElectricityNet:Facility, !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    ElectricityNet:Facility, !- Variable or Meter 2 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 2
    InteriorLights:Electricity,  !- Variable or Meter 3 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 3
    InteriorEquipment:Electricity,  !- Variable or Meter 4 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 4
    Fans:Electricity,        !- Variable or Meter 5 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 5
    Heating:Electricity,     !- Variable or Meter 6 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 6
    Cooling:Electricity,     !- Variable or Meter 7 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 7
    ExteriorLights:Electricity,  !- Variable or Meter 8 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 8
    Pumps:Electricity,       !- Variable or Meter 9 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 9
    HeatRejection:Electricity,  !- Variable or Meter 10 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 10
    ExteriorEquipment:Electricity,  !- Variable or Meter 11 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 11
    Humidification:Electricity,  !- Variable or Meter 12 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 12
    HeatRecovery:Electricity,!- Variable or Meter 13 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 13
    WaterSystems:Electricity,!- Variable or Meter 14 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 14
    Refrigeration:Electricity,  !- Variable or Meter 15 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 15
    Generators:Electricity,  !- Variable or Meter 16 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 16
    ElectricityProduced:Facility,  !- Variable or Meter 17 Name
    ValueWhenMaximumOrMinimum;  !- Aggregation Type for Variable or Meter 17
 
  Output:Table:Monthly,
    Setpoints Not Met With Temperatures,  !- Name
    2,                       !- Digits After Decimal
    Time Heating Setpoint Not Met,  !- Variable or Meter 1 Name
    HoursNonZero,            !- Aggregation Type for Variable or Meter 1
    Zone Mean Air Temperature,  !- Variable or Meter 2 Name
    SumOrAverageDuringHoursShown,  !- Aggregation Type for Variable or Meter 2
    Time Heating Setpoint Not Met While Occupied,  !- Variable or Meter 3 Name
    HoursNonZero,            !- Aggregation Type for Variable or Meter 3
    Zone Mean Air Temperature,  !- Variable or Meter 4 Name
    SumOrAverageDuringHoursShown,  !- Aggregation Type for Variable or Meter 4
    Time Cooling Setpoint Not Met,  !- Variable or Meter 5 Name
    HoursNonZero,            !- Aggregation Type for Variable or Meter 5
    Zone Mean Air Temperature,  !- Variable or Meter 6 Name
    SumOrAverageDuringHoursShown,  !- Aggregation Type for Variable or Meter 6
    Time Cooling Setpoint Not Met While Occupied,  !- Variable or Meter 7 Name
    HoursNonZero,            !- Aggregation Type for Variable or Meter 7
    Zone Mean Air Temperature,  !- Variable or Meter 8 Name
    SumOrAverageDuringHoursShown;  !- Aggregation Type for Variable or Meter 8
 
  Output:Table:Monthly,
    Building Loads - Cooling,!- Name
    2,                       !- Digits After Decimal
    Zone/Sys Sensible Cooling Energy,  !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    Zone/Sys Sensible Cooling Rate,  !- Variable or Meter 2 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 2
    Outdoor Dry Bulb,        !- Variable or Meter 3 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 3
    Outdoor Wet Bulb,        !- Variable or Meter 4 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 4
    Zone Total Internal Latent Gain,  !- Variable or Meter 5 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 5
    Zone Total Internal Latent Gain,  !- Variable or Meter 6 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 6
    Outdoor Dry Bulb,        !- Variable or Meter 7 Name
    ValueWhenMaximumOrMinimum,  !- Aggregation Type for Variable or Meter 7
    Outdoor Wet Bulb,        !- Variable or Meter 8 Name
    ValueWhenMaximumOrMinimum;  !- Aggregation Type for Variable or Meter 8
 
  Output:Table:Monthly,
    Building Loads - Heating,!- Name
    2,                       !- Digits After Decimal
    Zone/Sys Sensible Heating Energy,  !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    Zone/Sys Sensible Heating Rate,  !- Variable or Meter 2 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 2
    Outdoor Dry Bulb,        !- Variable or Meter 3 Name
    ValueWhenMaximumOrMinimum;  !- Aggregation Type for Variable or Meter 3
 
  Output:Table:Monthly,
    Building Loads - Electric,  !- Name
    2,                       !- Digits After Decimal
    Zone Lights Electric Consumption,  !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    Zone Lights Electric Consumption,  !- Variable or Meter 2 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 2
    Zone Electric Equipment Electric Consumption,  !- Variable or Meter 3 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 3
    Zone Electric Equipment Electric Consumption,  !- Variable or Meter 4 Name
    Maximum;                 !- Aggregation Type for Variable or Meter 4
 
  Output:Table:Monthly,
    Space Loads,             !- Name
    2,                       !- Digits After Decimal
    Zone People Total Heat Gain,  !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    Zone Lights Total Heat Gain,  !- Variable or Meter 2 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 2
    Zone Electric Equipment Total Heat Gain,  !- Variable or Meter 3 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 3
    Zone Infiltration Sensible Heat Gain,  !- Variable or Meter 4 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 4
    Zone Infiltration Sensible Heat Loss,  !- Variable or Meter 5 Name
    SumOrAverage;            !- Aggregation Type for Variable or Meter 5
 
  Output:Table:Monthly,
    Energy Consumption - Electricity & Natural Gas,  !- Name
    2,                       !- Digits After Decimal
    Electricity:Building,    !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    Electricity:Building,    !- Variable or Meter 2 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 2
    Gas:Building,            !- Variable or Meter 3 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 3
    Gas:Building,            !- Variable or Meter 4 Name
    Maximum;                 !- Aggregation Type for Variable or Meter 4
 
  Output:Table:Monthly,
    Building Energy Performance - Electricity,  !- Name
    2,                       !- Digits After Decimal
    InteriorLights:Electricity,  !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    TaskLights:InteriorLights:Electricity,  !- Variable or Meter 2 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 2
    ExteriorLights:Electricity,  !- Variable or Meter 3 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 3
    General:InteriorEquipment:Electricity,  !- Variable or Meter 4 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 4
    ExteriorEquipment:Electricity,  !- Variable or Meter 5 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 5
    Fans:Electricity,        !- Variable or Meter 6 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 6
    Pumps:Electricity,       !- Variable or Meter 7 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 7
    Heating:Electricity,     !- Variable or Meter 8 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 8
    Cooling:Electricity,     !- Variable or Meter 9 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 9
    HeatRejection:Electricity,  !- Variable or Meter 10 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 10
    Humidifier:Electricity,  !- Variable or Meter 11 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 11
    HeatRecovery:Electricity,!- Variable or Meter 12 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 12
    WaterSystems:Electricity,!- Variable or Meter 13 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 13
    Cogeneration:Electricity,!- Variable or Meter 14 Name
    SumOrAverage;            !- Aggregation Type for Variable or Meter 14
 
  Output:Table:Monthly,
    Building Energy Performance - Natural Gas,  !- Name
    2,                       !- Digits After Decimal
    InteriorEquipment:Gas,   !- Variable or Meter 1 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 1
    ExteriorEquipment:Gas,   !- Variable or Meter 2 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 2
    Heating:Gas,             !- Variable or Meter 3 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 3
    Cooling:Gas,             !- Variable or Meter 4 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 4
    WaterSystems:Gas,        !- Variable or Meter 5 Name
    SumOrAverage,            !- Aggregation Type for Variable or Meter 5
    Cogeneration:Gas,        !- Variable or Meter 6 Name
    SumOrAverage;            !- Aggregation Type for Variable or Meter 6
 
  Output:Table:Monthly,
    Peak Energy End-Use - Electricity Part 1,  !- Name
    2,                       !- Digits After Decimal
    InteriorLights:Electricity,  !- Variable or Meter 1 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 1
    TaskLights:InteriorLights:Electricity,  !- Variable or Meter 2 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 2
    ExteriorLights:Electricity,  !- Variable or Meter 3 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 3
    General:InteriorEquipment:Electricity,  !- Variable or Meter 4 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 4
    ExteriorEquipment:Electricity,  !- Variable or Meter 5 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 5
    Fans:Electricity,        !- Variable or Meter 6 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 6
    Pumps:Electricity,       !- Variable or Meter 7 Name
    Maximum,                 !- Aggregation Type for Variable or Meter 7
    Heating:Electricity,     !- Variable or Meter 8 Name
    Maximum;                 !- Aggregation Type for Variable or Meter 8
 
  Output:Meter,
    Electricity:Facility,    !- Name
    hourly;                  !- Reporting Frequency
 
  Output:Meter,
    Electricity:Building,    !- Name
    hourly;                  !- Reporting Frequency
 
  Output:Meter,
    ElectricityNet:Facility, !- Name
    hourly;                  !- Reporting Frequency
 
  Output:Meter,
    Electricity:HVAC,        !- Name
    hourly;                  !- Reporting Frequency
 
  Output:Meter,
    Gas:Facility,            !- Name
    hourly;                  !- Reporting Frequency

 
!		Report Meters

  Output:Meter:MeterFileOnly,
    InteriorLights:Electricity,  !- Meter_Name
    hourly;                 !- Reporting_Frequency
  Output:Meter:MeterFileOnly,
    InteriorEquipment:Electricity,  !- Meter_Name
    hourly;                 !- Reporting_Frequency
  Output:Meter:MeterFileOnly,
    Fans:Electricity,        !- Meter_Name
    hourly;                 !- Reporting_Frequency
  Output:Meter:MeterFileOnly,
    Pumps:Electricity,        !- Meter_Name
    hourly;                 !- Reporting_Frequency
  Output:Meter:MeterFileOnly,
    Heating:Electricity,     !- Meter_Name
    hourly;                 !- Reporting_Frequency
  Output:Meter:MeterFileOnly,
    Cooling:Electricity,     !- Meter_Name
    hourly;                 !- Reporting_Frequency
  Output:Meter:MeterFileOnly,
    Heating:Gas,            !- Meter_Name
    hourly;                 !- Reporting_Frequency


