!  System.inc
!  Large Office
!
!                chiller/cooling tower/boiler
!             w/ single duct VAV reheat
!             or single duct const volume reheat
!

!-   ===========  ALL OBJECTS IN CLASS: ZONE SIZING ===========

Sizing:Zone,
    PERIM-3-NORTH,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-3-EAST,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-3-SOUTH,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-3-WEST,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    CORE-3,                   !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-1-NORTH,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-1-EAST,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-1-SOUTH,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-1-WEST,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    CORE-1,                   !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction


##if #[Floors[] nes 2]

Sizing:Zone,
    PERIM-2-NORTH,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-2-EAST,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-2-SOUTH,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    PERIM-2-WEST,                  !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

Sizing:Zone,
    CORE-2,                   !- Name of a zone
! ---------------------------------------------------------------
!   13,                      !- Zone cooling design supply air temperature {C}
    zcdsat[],                !- Zone cooling design supply air temperature {C}
! ---------------------------------------------------------------
!   40.55,                   !- Zone heating design supply air temperature {C}
    zhdsat[],                !- Zone heating design supply air temperature {C}
    0.0085,                   !- Zone cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,                   !- Zone heating design supply air humidity ratio {kg-H2O/kg-air}
    flow/person,             !- outside air method
    Outside_Air[],           !- outside air flow per person {m3/s}
    0.0,                     !- outside air flow per zone area {m3/s-m2}
    0.0,                     !- outside air flow per zone {m3/s}
    ,                     !- zone sizing factor
    DesignDayWithLimit,              !- cooling design air flow method
    0,                       !- cooling design air flow rate {m3/s}
    ,                        !- cooling min air flow per zone area {m3/s-m2}
    0,                        !- cooling min air flow {m3/s}
    0,                        !- cooling min air flow fraction
    DesignDay,              !- heating design air flow method
    0,                       !- heating design air flow rate {m3/s}
    ,                        !- heating max air flow per zone area {m3/s-m2}
    ,                        !- heating max air flow {m3/s}
    ;                        !- heating max air flow fraction

##endif


!***** Air Loop: VAV_5 *****

AirLoopHVAC,
##if #[HVAC_System[] eqs VAV]
  VAV_5,  !- Name
  VAV_5_Controllers,  !- Controller List Name
  VAV_5 Availability Manager List,  !- Availability Manager List Name
  AUTOSIZE,  !- Design Supply Air Flow Rate {m3/s}
  VAV_5 Air Loop Branches,  !- Branch List Name
  ,  !- Connector List Name
  VAV_5 Supply Equipment Inlet Node,  !- Supply Side Inlet Node Name
  VAV_5 Zone Equipment Outlet Node,  !- Demand Side Outlet Node Name
  VAV_5 Zone Equipment Inlet Node,  !- Demand Side Inlet Node Names
  Air Loop Outlet Node 1;  !- Supply Side Outlet Node Names
##elseif #[HVAC_System[] eqs CAV]
  CAV_5,  !- Name
  CAV_5_Controllers,  !- Controller List Name
  VAV_5 Availability Manager List,  !- Availability Manager List Name
  AUTOSIZE,  !- Design Supply Air Flow Rate {m3/s}
  VAV_5 Air Loop Branches,  !- Branch List Name
  ,  !- Connector List Name
  VAV_5 Supply Equipment Inlet Node,  !- Supply Side Inlet Node Name
  VAV_5 Zone Equipment Outlet Node,  !- Demand Side Outlet Node Name
  VAV_5 Zone Equipment Inlet Node,  !- Demand Side Inlet Node Names
  Air Loop Outlet Node 1;  !- Supply Side Outlet Node Names
##endif

AirLoopHVAC:ControllerList,
##if #[HVAC_System[] eqs VAV]
  VAV_5_Controllers,  !- Name
##elseif #[HVAC_System[] eqs CAV]
  CAV_5_Controllers,  !- Name
##endif
  Controller:WaterCoil,  !- Controller 1 Object Type
  VAV_5_CoolC_Controller,  !- Controller 1 Name
  Controller:WaterCoil,  !- Controller 2 Object Type
  VAV_5_HeatC_Controller;  !- Controller 2 Name

Controller:WaterCoil,
  VAV_5_CoolC_Controller,  !- Name
  Temperature,  !- Control Variable {Temperature | HumidityRatio | TemperatureAndHumidityRatio | Flow}
  Reverse,  !- Action {Normal | Reverse}
  Flow,  !- Actuator Variable {Flow}
  Cooling Coil Air Outlet Node,  !- Sensor Node Name
  Cooling Coil Water Inlet Node,  !- Actuator Node Name
  ,  !- Controller Convergence Tolerance {delta C} [Delta temp from setpoint]
  AUTOSIZE,  !- Maximum Actuated Flow {m3/s}
  0.0;  !- Minimum Actuated Flow {m3/s}

Controller:WaterCoil,
  VAV_5_HeatC_Controller,  !- Name
  Temperature,  !- Control Variable {Temperature | HumidityRatio | TemperatureAndHumidityRatio | Flow}
  Normal,  !- Action {Normal | Reverse}
  Flow,  !- Actuator Variable {FLOW}
  Heating Coil Air Outlet Node,  !- Sensor Node Name
  Heating Coil Water Inlet Node,  !- Actuator Node Name
  0.0001,  !- Controller Convergence Tolerance {delta C} [Delta temp from setpoint]
  AUTOSIZE,  !- Maximum Actuated Flow {m3/s}
  0.0;  !- Minimum Actuated Flow {m3/s}

SetpointManager:Scheduled,
  VAV_5 SAT setpoint,  !- Name
  Temperature,  !- Control Variable {Temperature| others }
  Seasonal-Reset-Supply-Air-Temp-Sch,  !- Schedule Name
  Air Loop Outlet Node 1;  !- Setpoint Node or NodeList Name

SetpointManager:MixedAir,
  VAV_5_CoolC SAT Manager,  !- Name
  Temperature,  !- Control Variable {Temperature}
  Air Loop Outlet Node 1,  !- Reference Setpoint Node Name
  Heating Coil Air Outlet Node,  !- Fan Inlet Node Name
  Air Loop Outlet Node 1,  !- Fan Outlet Node Name
  Cooling Coil Air Outlet Node;  !- Setpoint Node or NodeList Name

SetpointManager:MixedAir,
  VAV_5_HeatC SAT Manager,  !- Name
  Temperature,  !- Control Variable {Temperature}
  Air Loop Outlet Node 1,  !- Reference Setpoint Node Name
  Heating Coil Air Outlet Node,  !- Fan Inlet Node Name
  Air Loop Outlet Node 1,  !- Fan Outlet Node Name
  Heating Coil Air Outlet Node;  !- Setpoint Node or NodeList Name

Sizing:System,
  ##if #[HVAC_System[] eqs VAV]
    VAV_5,               !- name of an AIR PRIMARY LOOP object
  ##elseif #[HVAC_System[] eqs CAV]
    CAV_5,               !- name of an AIR PRIMARY LOOP object
  ##endif VAV_5,
    sensible,              !- type of load to size on
    autosize,              !- Design (minimum) outside air volumetric flow rate {m3/s}
    min_air_flow[],        !- minimum system air flow ratio
    7.0,                   !- Preheat design set temperature {C}
    0.008,                 !- Preheat design humidity ratio {kg-H2O/kg-air}
! ---------------------------------------------------------------
!   13,                    !- Central cooling design supply air temperature {C}
    ccdsat[],              !- Central cooling design supply air temperature {C}
! ---------------------------------------------------------------	
    0.008,                 !- Precool design humidity ratio {kg-H2O/kg-air}
! ---------------------------------------------------------------
!   16,                    !- Central heating design supply air temperature {C}
    ccdsat[],                  !- Central cooling design supply air temperature {C}
    chdsat[],              !- Central heating design supply air temperature {C}
! ---------------------------------------------------------------	
    noncoincident,         !- Sizing Option
    no,                    !- Cooling 100% Outside Air
    no,                    !- Heating 100% Outside Air
    0.008,   !- Central cooling design supply air humidity ratio {kg-H2O/kg-air}
    0.008,   !- Central heating design supply air humidity ratio {kg-H2O/kg-air}
    DesignDay,              !- cooling design air flow method
    0.0,                     !- cooling design air flow rate {m3/s}
    DesignDay,              !- heating design air flow method
    0.0;                     !- heating design air flow rate {m3/s}

AvailabilityManagerAssignmentList,
  VAV_5 Availability Manager List,  !- Name
  AvailabilityManager:NightCycle,  !- Availability Manager 1 Object Type
  VAV_5 Availability Manager;  !- Availability Manager 1 Name

AvailabilityManager:NightCycle,
  VAV_5 Availability Manager,  !- Name  [*****Also must set MinOA schedule to 0 at night]
  ALWAYS_ON,  !- Availability Schedule Name
  HVACOperationSchd,  !- Fan Schedule Name
  CycleOnAny,  !- Control Type {CycleOnAny | CycleOnControlZone | CycleOnAnyZoneFansOnly}
  1.0,  !- Thermostat Tolerance {delta C}
  1800;  !- Cycling Run Time {s}

BranchList,
  VAV_5 Air Loop Branches,  !- Name
  VAV_5 Air Loop Main Branch;  !- Branch 1 Name

Branch,
##if #[HVAC_System[] eqs VAV]
  VAV_5 Air Loop Main Branch,         !- Branch Name
  autosize,                      !- Maximum Branch Flow Rate {m3/s}
  ##if #[Return_Fan[] eqs Yes]
    FAN:VariableVolume,     !- Comp1 Type
    VAV_Return_Fan,                  !- Comp1 Name
    VAV_5 Supply Equipment Inlet Node,         !- Comp1 Inlet Node Name
    VAV_5 OA_Sys_Inlet Node,      !- Comp1 Outlet Node Name
    ACTIVE,                        !- Comp1 Branch Control Type
    AirLoopHVAC:OutdoorAirSystem,  !- Component 1 Object Type
    VAV_5_OA,  !- Component 1 Name
    VAV_5 OA_Sys_Inlet Node,  !- Component 1 Inlet Node Name
    Mixed Air Node 1,  !- Component 1 Outlet Node Name
    Passive,  !- Component 1 Branch Control Type { Active | Passive | SeriesActive | Bypass }
  ##elseif #[Return_Fan[] eqs No]
    AirLoopHVAC:OutdoorAirSystem,  !- Component 1 Object Type
    VAV_5_OA,  !- Component 1 Name
    VAV_5 Supply Equipment Inlet Node,  !- Component 1 Inlet Node Name
    Mixed Air Node 1,  !- Component 1 Outlet Node Name
    Passive,  !- Component 1 Branch Control Type { Active | Passive | SeriesActive | Bypass }
  ##endif
  Coil:Cooling:Water,  !- Component 2 Object Type
  Main Cooling Coil 1,  !- Component 2 Name
  Mixed Air Node 1,  !- Component 2 Inlet Node Name
  Cooling Coil Air Outlet Node,  !- Component 2 Outlet Node Name
  Passive,  !- Component 2 Branch Control Type { Active | Passive | SeriesActive | Bypass }
  Coil:Heating:Water,  !- Component 3 Object Type
  Main Heating Coil 1,  !- Component 3 Name
  Cooling Coil Air Outlet Node,  !- Component 3 Inlet Node Name
  Heating Coil Air Outlet Node,  !- Component 3 Outlet Node Name
  Passive,  !- Component 3 Branch Control Type { Active | Passive | SeriesActive | Bypass }
  Fan:VariableVolume,  !- Component 4 Object Type
  VAV_Supply_Fan,  !- Component 4 Name
  Heating Coil Air Outlet Node,  !- Component 4 Inlet Node Name
  Air Loop Outlet Node 1,  !- Component 4 Outlet Node Name
  Active;  !- Component 4 Branch Control Type { Active | Passive | SeriesActive | Bypass }
  
##elseif #[HVAC_System[] eqs CAV]
  CAV_5 Air Loop Main Branch,         !- Branch Name
  autosize,                      !- Maximum Branch Flow Rate {m3/s}
  ##if #[Return_Fan[] eqs Yes]
    FAN:ConstantVolume,     !- Comp1 Type
    CAV_Return_Fan,                  !- Comp1 Name
    VAV_5 Supply Equipment Inlet Node,         !- Comp1 Inlet Node Name
    VAV_5 OA_Sys_Inlet Node,      !- Comp1 Outlet Node Name
    ACTIVE,                        !- Comp1 Branch Control Type
    AirLoopHVAC:OutdoorAirSystem,  !- Component 1 Object Type
    VAV_5_OA,  !- Component 1 Name
    VAV_5 OA_Sys_Inlet Node,  !- Component 1 Inlet Node Name
    Mixed Air Node 1,  !- Component 1 Outlet Node Name
    Passive,  !- Component 1 Branch Control Type { Active | Passive | SeriesActive | Bypass }
  ##elseif #[Return_Fan[] eqs No]
    AirLoopHVAC:OutdoorAirSystem,  !- Component 1 Object Type
    VAV_5_OA,  !- Component 1 Name
    VAV_5 Supply Equipment Inlet Node,  !- Component 1 Inlet Node Name
    Mixed Air Node 1,  !- Component 1 Outlet Node Name
    Passive,  !- Component 1 Branch Control Type { Active | Passive | SeriesActive | Bypass }
  ##endif
  Coil:Cooling:Water,  !- Component 2 Object Type
  Main Cooling Coil 1,  !- Component 2 Name
  Mixed Air Node 1,  !- Component 2 Inlet Node Name
  Cooling Coil Air Outlet Node,  !- Component 2 Outlet Node Name
  Passive,  !- Component 2 Branch Control Type { Active | Passive | SeriesActive | Bypass }
  Coil:Heating:Water,  !- Component 3 Object Type
  Main Heating Coil 1,  !- Component 3 Name
  Cooling Coil Air Outlet Node,  !- Component 3 Inlet Node Name
  Heating Coil Air Outlet Node,  !- Component 3 Outlet Node Name
  Passive,  !- Component 3 Branch Control Type { Active | Passive | SeriesActive | Bypass }
  Fan:ConstantVolume,  !- Component 4 Object Type
  CAV_Supply_Fan,  !- Component 4 Name
  Heating Coil Air Outlet Node,  !- Component 4 Inlet Node Name
  Air Loop Outlet Node 1,  !- Component 4 Outlet Node Name
  Active;  !- Component 4 Branch Control Type { Active | Passive | SeriesActive | Bypass }
##endif

AirLoopHVAC:ControllerList,
  VAV_5_OA_Controllers,  !- Name
  Controller:OutdoorAir,  !- Controller Object Type
  VAV_5_OA_Controller;  !- controller Name

AirLoopHVAC:OutdoorAirSystem:EquipmentList,
  VAV_5_OA_Equipment,  !- Name
  OutdoorAir:Mixer,  !- Component 1 Object Type
  VAV_5_OAMixing Box;  !- Component 1 Name

AirLoopHVAC:OutdoorAirSystem,
  VAV_5_OA,  !- Name
  VAV_5_OA_Controllers,  !- Controller List Name
  VAV_5_OA_Equipment,  !- Outdoor Air Equipment List Name
  VAV_5 Availability Manager List;  !- Availability Manager List Name

OutdoorAir:NodeList,
  VAV_5_OANode List;  !- Node or NodeList Name 1

NodeList,
  VAV_5_OANode List,  !- Name
  VAV_5_OAInlet Node;  !- Node 1 Name

OutdoorAir:Mixer,
  VAV_5_OAMixing Box,  !- Name
  Mixed Air Node 1,  !- Mixed Air Node Name
  VAV_5_OAInlet Node,  !- Outdoor Air Stream Node Name
  VAV_5_OARelief Node,  !- Relief Air Stream Node Name
  VAV_5 Supply Equipment Inlet Node;  !- Return Air Stream Node Name

SetpointManager:MixedAir,
  VAV_5_OAMixed Air Temp Manager,  !- Name
  Temperature,  !- Control Variable
  Air Loop Outlet Node 1,  !- Reference Setpoint Node Name
  Heating Coil Air Outlet Node,  !- Fan Inlet Node Name
  Air Loop Outlet Node 1,  !- Fan Outlet Node Name
  Mixed Air Node 1;  !- Setpoint Node or NodeList Name

Controller:OutdoorAir,
  VAV_5_OA_Controller,  !- Name
  VAV_5_OARelief Node,  !- Relief Air Outlet Node Name
  VAV_5 Supply Equipment Inlet Node,  !- Return Air Node Name
  Mixed Air Node 1,  !- Mixed Air Node Name
  VAV_5_OAInlet Node,  !- Actuator Node Name
##if #[HVAC_System[] eqs VAV]
    autosize,               !- minimum outside air flow rate {m3/s}
##elseif #[HVAC_System[] eqs CAV]
    0,                      !- minimum outside air flow rate {m3/s}
##endif
  AUTOSIZE,  !- Maximum Outdoor Air Flow Rate {m3/s}
  FixedDryBulb,  !- Economizer Control Type
  ModulateFlow,  !- Economizer Control Action Type
  Economizer_T[],  !- Economizer Maximum Limit Dry-Bulb Temperature {C}
  ,  !- Economizer Maximum Limit Enthalpy {J/kg}
  ,  !- Economizer Maximum Limit Dew-Point Temperature
  ,  !- Electronic Enthalpy Limit Curve Name
  0.0,  !- Economizer Minimum Limit Dry-Bulb Temperature {C}
##if #[Econo_Lockout[] eqs NO]
    NOLOCKOUT,                    !- Lockout
##elseif #[Econo_Lockout[] eqs COMP]
    LOCKOUTWITHCOMPRESSOR,       !- Lockout
##elseif #[Econo_Lockout[] eqs HEAT]
    LOCKOUTWITHHEATING,          !- Lockout
##endif
  FixedMinimum,  !- Minimum Limit Type
  MinOA_Sched,  !- Minimum Outdoor Air Schedule Name
  ,  !- Minimum Fraction of Outdoor Air Schedule Name
  ;  !- Maximum Fraction of Outdoor Air Schedule Name

Coil:Cooling:Water,
  Main Cooling Coil 1,  !- Name
  ALWAYS_ON,  !- Availability Schedule Name
  AUTOSIZE,  !- Design Water Flow Rate {m3/s}
  AUTOSIZE,  !- Design Air Flow Rate {m3/s}
  AUTOSIZE,  !- Design Inlet Water Temperature {C}
  AUTOSIZE,  !- Design Inlet Air Temperature {C}
  AUTOSIZE,  !- Design Outlet Air Temperature {C}
  AUTOSIZE,  !- Design Inlet Humidity Ratio {kg-H2O/kg-air}
  AUTOSIZE,  !- Design Outlet Humidity Ratio {kg-H2O/kg-air}
  Cooling Coil Water Inlet Node,  !- Water Inlet Node Name
  Cooling Coil Water Outlet Node,  !- Water Outlet Node Name
  Mixed Air Node 1,  !- Air Inlet Node Name
  Cooling Coil Air Outlet Node,  !- Air Outlet Node Name
  SimpleAnalysis,  !- Type of Analysise {*******}
  CrossFlow;  !- Heat Exchanger Configuration {*********}

Coil:Heating:Water,
  Main Heating Coil 1,  !- Name
  ALWAYS_ON,  !- Availablility Schedule Name
  AUTOSIZE,  !- U-Factor Times Area Value {W/K}
  AUTOSIZE,  !- Maximum Water Flow Rate {m3/s}
  Heating Coil Water Inlet Node,  !- Water Inlet Node Name
  Heating Coil Water Outlet Node,  !- Water Outlet Node Name
  Cooling Coil Air Outlet Node,  !- Air Inlet Node Name
  Heating Coil Air Outlet Node,  !- Air Outlet Node Name
  UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
  AUTOSIZE,  !- Nominal Capacity
  82.2,  !- Design Inlet Water Temperature
  16.6,  !- Design Inlet Air Temperature
  71.1,  !- Design Outlet Water Temperature
  32.2;  !- Design Outlet Air Temperature

##if #[HVAC_System[] eqs VAV]
Fan:VariableVolume,
  VAV_Supply_Fan,  !- Name
  HVACOperationSchd,  !- Availability Schedule Name
  fan_eff_tot[],  !- Fan Efficiency {}
  fan_dp[],  !- Pressure Rise {Pa}
  AUTOSIZE,  !- Maximum Flow Rate {m3/s}
  AUTOSIZE,  !- Minimum Flow Rate {m3/s}
  fan_eff_mtr[],  !- Motor Efficiency {}
  1.0,  !- Motor In Airstream Fraction {}
  0.0407598940,  !- Fan Coefficient 1
  0.08804497,  !- Fan Coefficient 2
  -0.072926120,  !- Fan Coefficient 3
  0.9437398230,  !- Fan Coefficient 4
  0,  !- Fan Coefficient 5
  Heating Coil Air Outlet Node,  !- Air Inlet Node Name
  Air Loop Outlet Node 1,  !- Air Outlet Node Name
  Fan Energy;  !- End-Use Subcategory

Fan:VariableVolume,
  VAV_Return_Fan,  !- Name
  HVACOperationSchd,  !- Availability Schedule Name
  fan_eff_tot[],  !- Fan Efficiency {}
  #eval[ fan_dp[] / 4 ],  !- Pressure Rise {Pa}
  AUTOSIZE,  !- Maximum Flow Rate {m3/s}
  AUTOSIZE,  !- Minimum Flow Rate {m3/s}
  fan_eff_mtr[],  !- Motor Efficiency {}
  1.0,  !- Motor In Airstream Fraction {}
  0.0278279,                  !- FanCoefficient 1
  0.0265832,                  !- FanCoefficient 2
  -0.0870687,                 !- FanCoefficient 3
  1.030920,                   !- FanCoefficient 4
  0,                          !- FanCoefficient 5
  VAV_5 Supply Equipment Inlet Node,         !- Comp1 Inlet Node Name
  VAV_5 OA_Sys_Inlet Node,      !- Comp1 Outlet Node Name
  Fan Energy;  !- End-Use Subcategory
  
##elseif #[HVAC_System[] eqs CAV]  
Fan:ConstantVolume,
  CAV_Supply_Fan,  !- Name
  HVACOperationSchd,  !- Availability Schedule Name
  fan_eff_tot[],  !- Fan Efficiency {}
  fan_dp[],  !- Pressure Rise {Pa}
  AUTOSIZE,  !- Maximum Flow Rate {m3/s}
  fan_eff_mtr[],  !- Motor Efficiency {}
  1.0,  !- Motor In Airstream Fraction {}
  Heating Coil Air Outlet Node,  !- Air Inlet Node Name
  Air Loop Outlet Node 1,  !- Air Outlet Node Name
  Fan Energy;  !- End-Use Subcategory
  
Fan:ConstantVolume,
  CAV_Return_Fan,  !- Name
  HVACOperationSchd,  !- Availability Schedule Name
  fan_eff_tot[],  !- Fan Efficiency {}
  #eval[ fan_dp[] / 4 ],  !- Pressure Rise {Pa}
  AUTOSIZE,  !- Maximum Flow Rate {m3/s}
  fan_eff_mtr[],  !- Motor Efficiency {}
  1.0,  !- Motor In Airstream Fraction {}
  VAV_5 Supply Equipment Inlet Node,         !- Comp1 Inlet Node Name
  VAV_5 OA_Sys_Inlet Node,      !- Comp1 Outlet Node Name
  Fan Energy;  !- End-Use Subcategory  
##endif

AirLoopHVAC:SupplyPath,
  VAV_5,  !- Name
  VAV_5 Zone Equipment Inlet Node,  !- Supply Air Path Inlet Node Name
  AirLoopHVAC:ZoneSplitter,  !- Component 1 Object Type
  VAV_5 Supply Air Splitter;  !- Component 1 Name

AirLoopHVAC:ZoneSplitter,
  VAV_5 Supply Air Splitter,  !- Name
  VAV_5 Zone Equipment Inlet Node,  !- Inlet Node Name
##if #[HVAC_System[] eqs CAV]
    Zone 1 Reheat Air Inlet Node,   !- Outlet_Node_1
    Zone 2 Reheat Air Inlet Node,   !- Outlet_Node_2
    Zone 3 Reheat Air Inlet Node,   !- Outlet_Node_3
    Zone 4 Reheat Air Inlet Node,   !- Outlet_Node_4
    Zone 5 Reheat Air Inlet Node,   !- Outlet_Node_5
    Zone 6 Reheat Air Inlet Node,   !- Outlet_Node_6
    Zone 7 Reheat Air Inlet Node,   !- Outlet_Node_7
    Zone 8 Reheat Air Inlet Node,   !- Outlet_Node_8
    Zone 9 Reheat Air Inlet Node,   !- Outlet_Node_9
##if #[Floors[] nes 2]
    Zone 10 Reheat Air Inlet Node,  !- Outlet_Node_10
    Zone 11 Reheat Air Inlet Node,  !- Outlet_Node_11
    Zone 12 Reheat Air Inlet Node,  !- Outlet_Node_12
    Zone 13 Reheat Air Inlet Node,  !- Outlet_Node_13
    Zone 14 Reheat Air Inlet Node,  !- Outlet_Node_14
    Zone 15 Reheat Air Inlet Node;  !- Outlet_Node_15
##endif
##elseif #[HVAC_System[] eqs VAV]
    Zone 1 Damper Inlet Node,   !- Outlet_Node_1
    Zone 2 Damper Inlet Node,   !- Outlet_Node_2
    Zone 3 Damper Inlet Node,   !- Outlet_Node_3
    Zone 4 Damper Inlet Node,   !- Outlet_Node_4
    Zone 5 Damper Inlet Node,   !- Outlet_Node_5
    Zone 6 Damper Inlet Node,   !- Outlet_Node_6
    Zone 7 Damper Inlet Node,   !- Outlet_Node_7
    Zone 8 Damper Inlet Node,   !- Outlet_Node_8
    Zone 9 Damper Inlet Node,   !- Outlet_Node_9
##if #[Floors[] nes 2]
    Zone 10 Damper Inlet Node,  !- Outlet_Node_10
    Zone 11 Damper Inlet Node,  !- Outlet_Node_11
    Zone 12 Damper Inlet Node,  !- Outlet_Node_12
    Zone 13 Damper Inlet Node,  !- Outlet_Node_13
    Zone 14 Damper Inlet Node,  !- Outlet_Node_14
    Zone 15 Damper Inlet Node;  !- Outlet_Node_15
##else
    Zone 10 Damper Inlet Node;  !- Outlet_Node_10
##endif
##endif

AirLoopHVAC:ReturnPath,
  VAV_5 Return Air Path,  !- Name
  VAV_5 Zone Equipment Outlet Node,  !- Return Air Path Outlet Node Name
  AirLoopHVAC:ZoneMixer,  !- Component 1 Object Type
  VAV_5 Return Air Mixer;  !- Component 1 Name

AirLoopHVAC:ZoneMixer,
  VAV_5 Return Air Mixer,  !- Name
  VAV_5 Zone Equipment Outlet Node,  !- Outlet Node Name
    PER1NOR Outlet Node,            !- Inlet_Node_6
    PER1EAS Outlet Node,            !- Inlet_Node_7
    PER1SOU Outlet Node,            !- Inlet_Node_8
    PER1WES Outlet Node,            !- Inlet_Node_9
    COR1 Outlet Node,               !- Inlet_Node_10
##if #[Floors[] nes 2]
    PER2NOR Outlet Node,            !- Inlet_Node_11
    PER2EAS Outlet Node,            !- Inlet_Node_12
    PER2SOU Outlet Node,            !- Inlet_Node_13
    PER2WES Outlet Node,            !- Inlet_Node_14
    COR2 Outlet Node,               !- Inlet_Node_15
##endif
    PER3NOR Outlet Node,            !- Inlet_Node_1
    PER3EAS Outlet Node,            !- Inlet_Node_2
    PER3SOU Outlet Node,            !- Inlet_Node_3
    PER3WES Outlet Node,            !- Inlet_Node_4
    COR3 Outlet Node;               !- Inlet_Node_5

  
!***** Plant Loop: HeatSys1 *****

PlantLoop,
  HeatSys1,  !- Name
  Water,  !- Fluid Type {WATER}
  HeatSys1 Loop Operation Scheme List,  !- Loop Equipment Operation Scheme Name
  HeatSys1 Supply Outlet Node,  !- Loop Temperature Setpoint Node Name
  100.0,  !- Maximum Loop Temperature {C}
  10.0,  !- Minimum Loop Temperature {C}
  AUTOSIZE,  !- Maximum Loop Flow Rate {m3/s}
  0.0,  !- Minimum Loop Flow Rate {m3/s}
  AUTOSIZE,  !- Loop Volume {m3}
  HeatSys1 Supply Inlet Node,  !- Supply Side Inlet Node
  HeatSys1 Supply Outlet Node,  !- Supply Side Outlet Node
  HeatSys1 Supply Branches,  !- Supply Side Branch List Name
  HeatSys1 Supply Connectors,  !- Supply Side Connector List Name
  HeatSys1 Demand Inlet Node,  !- Demand Side Inlet Node
  HeatSys1 Demand Outlet Node,  !- Demand Side Outlet Node
  HeatSys1 Demand Branches,  !- Demand Side Branch List Name
  HeatSys1 Demand Connectors,  !- Demand Side Connector List Name
  Optimal;  !- Load Distribution Scheme {OPTIMAL | SEQUENTIAL}

Sizing:Plant,
  HeatSys1,  !- Loop Name
  Heating,  !- Loop Type {COOLING | HEATING}
  82.0,  !- Design Loop Exit Temperature {C}
  11.0;  !- Design Loop Temperature Difference {C}

SetpointManager:Scheduled,
  HeatSys1 Loop Setpoint Manager,  !- Name
  Temperature,  !- Control Variable {TEMP}
  HW-Loop-Temp-Schedule,  !- Schedule Name
  HeatSys1 Supply Outlet Node;  !- Setpoint Node Name

PlantEquipmentOperationSchemes,
  HeatSys1 Loop Operation Scheme List,  !- Name
  PlantEquipmentOperation:HeatingLoad,  !- Control Scheme 1 Object Type {*******}
  HeatSys1 Operation Scheme,  !- Control Scheme 1 Name
  PlantOnSched;  !- Control Scheme 1 Schedule Name

PlantEquipmentOperation:HeatingLoad,
  HeatSys1 Operation Scheme,  !- Name
  0.0,  !- Load Range 1 Lower Limit {W}
  1000000000000000,  !- Load Range 1 Upper Limit {W}
  HeatSys1 Equipment List;  !- Priority Control 1 Equipment List Name

PlantEquipmentList,
  HeatSys1 Equipment List,  !- Name
  Boiler:HotWater,  !- Equipment 2 Object Type
  HeatSys1 Boiler;  !- Equipment 2 Name

BranchList,
  HeatSys1 Supply Branches,  !- Name
  HeatSys1 Supply Inlet Branch,  !- Branch 1 Name
  HeatSys1 Supply Equipment Branch,  !- Branch 2 Name
  HeatSys1 Supply Equipment Bypass Branch,  !- Branch 3 Name
  HeatSys1 Supply Outlet Branch;  !- Branch 4 Name

ConnectorList,
  HeatSys1 Supply Connectors,  !- Name
  Connector:Splitter,  !- Connector 1 Object Type
  HeatSys1 Supply Splitter,  !- Connector 1 Name
  Connector:Mixer,  !- Connector 2 Object Type
  HeatSys1 Supply Mixer;  !- Connector 2 Name

Connector:Splitter,
  HeatSys1 Supply Splitter,  !- Name
  HeatSys1 Supply Inlet Branch,  !- Inlet Branch Name
  HeatSys1 Supply Equipment Branch,  !- Outlet Branch 1 Name
  HeatSys1 Supply Equipment Bypass Branch;  !- Outlet Branch 2 Name

Connector:Mixer,
  HeatSys1 Supply Mixer,  !- Name
  HeatSys1 Supply Outlet Branch,  !- Outlet Branch Name
  HeatSys1 Supply Equipment Branch,  !- Inlet Branch 1 Name
  HeatSys1 Supply Equipment Bypass Branch;  !- Inlet Branch 2 Name

Branch,
  HeatSys1 Supply Inlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pump:VariableSpeed,  !- Component 1 Object Type
  HeatSys1 Pump,  !- Component 1 Name
  HeatSys1 Supply Inlet Node,  !- Component 1 Inlet Node Name
  Boiler Inlet NodeviaConnector,  !- Component 1 Outlet Node Name
  Active;  !- Component 1 Branch Control Type {Active | Passive}

Branch,
  HeatSys1 Supply Equipment Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Boiler:HotWater,  !- Component 2 Object Type
  HeatSys1 Boiler,  !- Component 2 Name
  Boiler Inlet Node,  !- Component 2 Inlet Node Name
  Boiler Outlet Node,  !- Component 2 Outlet Node Name
  Active;  !- Component 2 Branch Control Type

Pump:VariableSpeed,
  HeatSys1 Pump,  !- Name
  HeatSys1 Supply Inlet Node,  !- Inlet Node Name
  Boiler Inlet NodeviaConnector,  !- Outlet Node Name
  AUTOSIZE,  !- Rated Flow Rate {m3/s}
  pump_head[],  !- Rated Pump Head {Pa} [179352 Pa = 60 ft]
  AUTOSIZE,  !- Rated Power Consumption {W}
  pump_eff_mtr[],  !- Motor Efficiency {}
  0.0,  !- Fraction of Motor Inefficiencies to Fluid Stream {}
  0,  !- Coefficient 1 of the Part Load Performance Curve
  1,  !- Coefficient 2 of the Part Load Performance Curve
  0,  !- Coefficient 3 of the Part Load Performance Curve
  0,  !- Coefficient 4 of the Part Load Performance Curve
  0.0,  !- Minimum Flow Rate {m3/s}
  Intermittent,  !- Pump Control Type {Continuous | Intermittent}
  ;  !- Pump Flow Rate Schedule Name

Boiler:HotWater,
  HeatSys1 Boiler,  !- Name
  NATURALGAS,  !- Fuel Type
  AUTOSIZE,  !- Nominal Capacity {W}
  Boiler_Eff[],  !- Nominal Thermal Efficiency
  ,  !- Normalized Boiler Efficiency Curve Name
  81.0000,  !- Design Water Outlet Temperature {C}
  AUTOSIZE,  !- Design Water Flow Rate {m3/s}
  0.0,  !- Minimum Part Load Ratio
  1.2,  !- Maximum Part Load Ratio
  1.0,  !- Optimum Part Load Ratio
  Boiler Inlet Node,  !- Boiler Water Inlet Node Name
  Boiler Outlet Node,  !- Boiler Water Outlet Node Name
  95.0,  !- Water Outlet Upper Temperature Limit {C}
  VariableFlow,  !- Boiler Flow Mode
  0.0000,  !- Parasitic Electric Load
  1.0000;  !- Sizing Factor

Branch,
  HeatSys1 Supply Equipment Bypass Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  HeatSys1 Supply Equipment Bypass Pipe,  !- Component 1 Name
  HeatSys1 Supply Equip Bypass Inlet Node,  !- Component 1 Inlet Node Name
  HeatSys1 Supply Equip Bypass Outlet Node,  !- Component 1 Outlet Node Name
  Bypass;  !- Component 1 Control Type {ACTIVE | PASSIVE | BYPASS}

Pipe:Adiabatic,
  HeatSys1 Supply Equipment Bypass Pipe,  !- Name
  HeatSys1 Supply Equip Bypass Inlet Node,  !- Inlet Node Name
  HeatSys1 Supply Equip Bypass Outlet Node;  !- Outlet Node Name

Branch,
  HeatSys1 Supply Outlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  HeatSys1 Supply Outlet Pipe,  !- Component 1 Name
  HeatSys1 Supply Mixer-HeatSys1 Supply Outlet Pipe,  !- Component 1 Inlet Node Name
  HeatSys1 Supply Outlet Node,  !- Component 1 Outlet Node Name
  Passive;  !- Component 1 Control Type

Pipe:Adiabatic,
  HeatSys1 Supply Outlet Pipe,  !- Name
  HeatSys1 Supply Mixer-HeatSys1 Supply Outlet Pipe,  !- Inlet Node Name
  HeatSys1 Supply Outlet Node;  !- Outlet Node Name

BranchList,
  HeatSys1 Demand Branches,  !- Name
  HeatSys1 Demand Inlet Branch,  !- Branch 1 Name
  Zone 1 Reheat Branch,    !- Branch Name 2
    Zone 2 Reheat Branch,    !- Branch Name 3
    Zone 3 Reheat Branch,    !- Branch Name 4
    Zone 4 Reheat Branch,    !- Branch Name 5
    Zone 5 Reheat Branch,    !- Branch Name 6
    Zone 6 Reheat Branch,    !- Branch Name 7
    Zone 7 Reheat Branch,    !- Branch Name 8
    Zone 8 Reheat Branch,    !- Branch Name 9
    Zone 9 Reheat Branch,    !- Branch Name 10
    Zone 10 Reheat Branch,   !- Branch Name 11
##if #[Floors[] nes 2]
    Zone 11 Reheat Branch,   !- Branch Name 12
    Zone 12 Reheat Branch,   !- Branch Name 13
    Zone 13 Reheat Branch,   !- Branch Name 14
    Zone 14 Reheat Branch,   !- Branch Name 15
    Zone 15 Reheat Branch,   !- Branch Name 16
##endif
  Main Heat Coil Branch,
  HeatSys1 Demand Bypass Branch,  !- Name 22 Name
  HeatSys1 Demand Outlet Branch;  !- Name 23 Name

ConnectorList,
  HeatSys1 Demand Connectors,  !- Name
  Connector:Splitter,  !- Connector 1 Object Type
  HeatSys1 Demand Splitter,  !- Connector 1 Name
  Connector:Mixer,  !- Connector 2 Object Type
  HeatSys1 Demand Mixer;  !- Connector 2 Name

Connector:Splitter,
  HeatSys1 Demand Splitter,  !- Name
  HeatSys1 Demand Inlet Branch,  !- Inlet Branch Name
  Zone 1 Reheat Branch,    !- Branch Name 2
    Zone 2 Reheat Branch,    !- Branch Name 3
    Zone 3 Reheat Branch,    !- Branch Name 4
    Zone 4 Reheat Branch,    !- Branch Name 5
    Zone 5 Reheat Branch,    !- Branch Name 6
    Zone 6 Reheat Branch,    !- Branch Name 7
    Zone 7 Reheat Branch,    !- Branch Name 8
    Zone 8 Reheat Branch,    !- Branch Name 9
    Zone 9 Reheat Branch,    !- Branch Name 10
    Zone 10 Reheat Branch,   !- Branch Name 11
##if #[Floors[] nes 2]
    Zone 11 Reheat Branch,   !- Branch Name 12
    Zone 12 Reheat Branch,   !- Branch Name 13
    Zone 13 Reheat Branch,   !- Branch Name 14
    Zone 14 Reheat Branch,   !- Branch Name 15
    Zone 15 Reheat Branch,   !- Branch Name 16
##endif
  Main Heat Coil Branch,
  HeatSys1 Demand Bypass Branch;  !- Outlet Branch 21 Name

Connector:Mixer,
  HeatSys1 Demand Mixer,  !- Name
  HeatSys1 Demand Outlet Branch,  !- Outlet Branch Name
  Zone 1 Reheat Branch,    !- Branch Name 2
    Zone 2 Reheat Branch,    !- Branch Name 3
    Zone 3 Reheat Branch,    !- Branch Name 4
    Zone 4 Reheat Branch,    !- Branch Name 5
    Zone 5 Reheat Branch,    !- Branch Name 6
    Zone 6 Reheat Branch,    !- Branch Name 7
    Zone 7 Reheat Branch,    !- Branch Name 8
    Zone 8 Reheat Branch,    !- Branch Name 9
    Zone 9 Reheat Branch,    !- Branch Name 10
    Zone 10 Reheat Branch,   !- Branch Name 11
##if #[Floors[] nes 2]
    Zone 11 Reheat Branch,   !- Branch Name 12
    Zone 12 Reheat Branch,   !- Branch Name 13
    Zone 13 Reheat Branch,   !- Branch Name 14
    Zone 14 Reheat Branch,   !- Branch Name 15
    Zone 15 Reheat Branch,   !- Branch Name 16
##endif
  Main Heat Coil Branch,
  HeatSys1 Demand Bypass Branch;  !- Inlet Branch 21 Name

Branch,
  HeatSys1 Demand Inlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  HeatSys1 Demand Inlet Pipe,  !- Component 1 Name
  HeatSys1 Demand Inlet Node,  !- Component 1 Inlet Node Name
  HeatSys1 Demand Inlet Pipe-HeatSys1 Demand Mixer,  !- Component 1 Outlet Node Name
  Passive;  !- Component 1 Control Type

Pipe:Adiabatic,
  HeatSys1 Demand Inlet Pipe,  !- Name
  HeatSys1 Demand Inlet Node,  !- Inlet Node Name
  HeatSys1 Demand Inlet Pipe-HeatSys1 Demand Mixer;  !- Outlet Node Name

BRANCH,
    Zone 1 Reheat Branch,    !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 1,      !- Comp1 Name
    Zone 1 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 1 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 2 Reheat Branch,    !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 2,      !- Comp1 Name
    Zone 2 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 2 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 3 Reheat Branch,    !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 3,      !- Comp1 Name
    Zone 3 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 3 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 4 Reheat Branch,    !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 4,      !- Comp1 Name
    Zone 4 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 4 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 5 Reheat Branch,    !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 5,      !- Comp1 Name
    Zone 5 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 5 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 6 Reheat Branch,    !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 6,      !- Comp1 Name
    Zone 6 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 6 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 7 Reheat Branch,    !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 7,      !- Comp1 Name
    Zone 7 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 7 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 8 Reheat Branch,    !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 8,      !- Comp1 Name
    Zone 8 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 8 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 9 Reheat Branch,    !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 9,      !- Comp1 Name
    Zone 9 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 9 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 10 Reheat Branch,   !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 10,     !- Comp1 Name
    Zone 10 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 10 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

##if #[Floors[] nes 2]

BRANCH,
    Zone 11 Reheat Branch,   !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 11,     !- Comp1 Name
    Zone 11 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 11 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 12 Reheat Branch,   !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 12,     !- Comp1 Name
    Zone 12 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 12 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 13 Reheat Branch,   !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 13,     !- Comp1 Name
    Zone 13 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 13 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 14 Reheat Branch,   !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 14,     !- Comp1 Name
    Zone 14 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 14 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

BRANCH,
    Zone 15 Reheat Branch,   !- Branch Name
    0,                       !- Maximum Branch Flow Rate {m3/s}
    coil_type[],        !- Comp1 Type
    Reheat Coil Zone 15,     !- Comp1 Name
    Zone 15 Reheat Water Inlet Node,  !- Comp1 Inlet Node Name
    Zone 15 Reheat Water Outlet Node,  !- Comp1 Outlet Node Name
    ACTIVE;                  !- Comp1 Branch Control Type

##endif

Branch,
  Main Heat Coil Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Coil:Heating:Water,  !- Component 16 Object Type
  Main Heating Coil 1,  !- Component 17 Name
  Heating Coil Water Inlet Node,  !- Component 17 Inlet Node Name
  Heating Coil Water Outlet Node,  !- Component 17 Outlet Node Name
  Active;  !- Component 17 Control Type

Branch,
  HeatSys1 Demand Bypass Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  HeatSys1 Demand Bypass Pipe,  !- Component 1 Name
  HeatSys1 Demand Bypass Pipe Inlet Node,  !- Component 1 Inlet Node Name
  HeatSys1 Demand Bypass Pipe Outlet Node,  !- Component 1 Outlet Node Name
  Bypass;  !- Component 1 Control Type {ACTIVE | PASSIVE| BYPASS}

Pipe:Adiabatic,
  HeatSys1 Demand Bypass Pipe,  !- Name
  HeatSys1 Demand Bypass Pipe Inlet Node,  !- Inlet Node Name
  HeatSys1 Demand Bypass Pipe Outlet Node;  !- Outlet Node Name

Branch,
  HeatSys1 Demand Outlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  HeatSys1 Demand Outlet Pipe,  !- Component 1 Name
  HeatSys1 Demand Mixer-HeatSys1 Demand Outlet Pipe,  !- Component 1 Inlet Node Name
  HeatSys1 Demand Outlet Node,  !- Component 1 Outlet Node Name
  Passive;  !- Component 1 Control Type

Pipe:Adiabatic,
  HeatSys1 Demand Outlet Pipe,  !- Name
  HeatSys1 Demand Mixer-HeatSys1 Demand Outlet Pipe,  !- Inlet Node Name
  HeatSys1 Demand Outlet Node;  !- Outlet Node Name

!***** Plant Loop: CoolSys1 *****

PlantLoop,
  CoolSys1,  !- Name
  Water,  !- Fluid Type {WATER}
  CoolSys1 Loop Operation Scheme List,  !- Loop Equipment Operation Scheme Name
  CoolSys1 Supply Outlet Node,  !- Loop Temperature Setpoint Node Name
  98.0,  !- Maximum Loop Temperature {C}
  1.0,  !- Minimum Loop Temperature {C}
  AUTOSIZE,  !- Maximum Loop Flow Rate {m3/s}
  0.0,  !- Minimum Loop Flow Rate {m3/s}
  AUTOSIZE,  !- Loop Volume {m3}
  CoolSys1 Supply Inlet Node,  !- Supply Side Inlet Node
  CoolSys1 Supply Outlet Node,  !- Supply Side Outlet Node
  CoolSys1 Supply Branches,  !- Supply Side Branch List Name
  CoolSys1 Supply Connectors,  !- Supply Side Connector List Name
  CoolSys1 Demand Inlet Node,  !- Demand Side Inlet Node
  CoolSys1 Demand Outlet Node,  !- Demand Side Outlet Node
  CoolSys1 Demand Branches,  !- Demand Side Branch List Name
  CoolSys1 Demand Connectors,  !- Demand Side Connector List Name
  Optimal;  !- Load Distribution Scheme {OPTIMAL | SEQUENTIAL}

Sizing:Plant,
  CoolSys1,  !- Loop Name
  Cooling,  !- Loop Type {COOLING | HEATING}
  7.22,  !- Design Loop Exit Temperature {C}
  6.67;  !- Design Loop Temperature Difference {C}

SetpointManager:Scheduled,
  CoolSys1 Loop Setpoint Manager,  !- Name
  Temperature,  !- Control Variable {TEMP}
  CW-Loop-Temp-Schedule,  !- Schedule Name
  CoolSys1 Supply Outlet Node;  !- Setpoint Node Name

PlantEquipmentOperationSchemes,
  CoolSys1 Loop Operation Scheme List,  !- Name
  PlantEquipmentOperation:CoolingLoad,  !- Control Scheme 1 Object Type {*******}
  CoolSys1 Operation Scheme,  !- Control Scheme 1 Name
  PlantOnSched;  !- Control Scheme 1 Schedule Name

PlantEquipmentOperation:CoolingLoad,
  CoolSys1 Operation Scheme,  !- Name
  0.0,  !- Load Range 1 Lower Limit {W}
  100000000000000,  !- Load Range 1 Upper Limit {W}
  CoolSys1 Equipment List;  !- Priority Control 1 Equipment List Name

PlantEquipmentList,
  CoolSys1 Equipment List,  !- Name
  Chiller:Electric:EIR,  !- Equipment 2 Object Type
  CoolSys1 Chiller;  !- Equipment 2 Name

BranchList,
  CoolSys1 Supply Branches,  !- Name
  CoolSys1 Supply Inlet Branch,  !- Branch 1 Name
  CoolSys1 Supply Equipment Branch,  !- Branch 2 Name
  CoolSys1 Supply Equipment Bypass Branch,  !- Branch 3 Name
  CoolSys1 Supply Outlet Branch;  !- Branch 4 Name

ConnectorList,
  CoolSys1 Supply Connectors,  !- Name
  Connector:Splitter,  !- Connector 1 Object Type
  CoolSys1 Supply Splitter,  !- Connector 1 Name
  Connector:Mixer,  !- Connector 2 Object Type
  CoolSys1 Supply Mixer;  !- Connector 2 Name

Connector:Splitter,
  CoolSys1 Supply Splitter,  !- Name
  CoolSys1 Supply Inlet Branch,  !- Inlet Branch Name
  CoolSys1 Supply Equipment Branch,  !- Outlet Branch 1 Name
  CoolSys1 Supply Equipment Bypass Branch;  !- Outlet Branch 2 Name

Connector:Mixer,
  CoolSys1 Supply Mixer,  !- Name
  CoolSys1 Supply Outlet Branch,  !- Outlet Branch Name
  CoolSys1 Supply Equipment Branch,  !- Inlet Branch 1 Name
  CoolSys1 Supply Equipment Bypass Branch;  !- Inlet Branch 2 Name

Branch,
  CoolSys1 Supply Inlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pump:VariableSpeed,  !- Component 1 Object Type
  CoolSys1 Pump,  !- Component 1 Name
  CoolSys1 Supply Inlet Node,  !- Component 1 Inlet Node Name
  CoolSys1 Inlet NodeviaConnector,  !- Component 1 Outlet Node Name
  Active;  !- Component 1 Branch Control Type {Active | Passive}

Branch,
  CoolSys1 Supply Equipment Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Chiller:Electric:EIR,  !- Component 2 Object Type
  CoolSys1 Chiller,  !- Component 2 Name
  CoolSys1 Inlet Node,  !- Component 2 Inlet Node Name
  CoolSys1 Outlet Node,  !- Component 2 Outlet Node Name
  Active;  !- Component 2 Branch Control Type

Pump:VariableSpeed,
  CoolSys1 Pump,  !- Name
  CoolSys1 Supply Inlet Node,  !- Inlet Node Name
  CoolSys1 Inlet NodeviaConnector,  !- Outlet Node Name
  AUTOSIZE,  !- Rated Flow Rate {m3/s}
  pump_head[],  !- Rated Pump Head {Pa} [179352 Pa = 60 ft]
  AUTOSIZE,  !- Rated Power Consumption {W}
  pump_eff_mtr[],  !- Motor Efficiency {}
  0.0,  !- Fraction of Motor Inefficiencies to Fluid Stream {}
  0,  !- Coefficient 1 of the Part Load Performance Curve
  1,  !- Coefficient 2 of the Part Load Performance Curve
  0,  !- Coefficient 3 of the Part Load Performance Curve
  0,  !- Coefficient 4 of the Part Load Performance Curve
  0.0,  !- Minimum Flow Rate {m3/s}
  Intermittent,  !- Pump Control Type {Continuous | Intermittent}
  ;  !- Pump Flow Rate Schedule Name

Chiller:Electric:EIR,
  CoolSys1 Chiller,  !- Name
  AUTOSIZE,  !- Reference Capacity {W}
  Chiller_COP[],  !- Reference COP { }
  6.6700,  !- Reference Leaving Chilled Water Temperature {C}
  29.4000,  !- Reference Entering Condenser Fluid Temperature {C}
  AutoSize,  !- Reference Chilled Water Flow Rate {m3/s}
  AutoSize,  !- Reference Condenser Water Flow Rate {m3/s}
  TraneChillerClgCapFuncTemp,  !- Cooling Capacity Function of Temperature Curve Name
  TraneChillerEIRFuncTemp,  !- Electric Input to Cooling Output Ratio Function of Temperature Curve Name
  TraneChillerEIRFuncPLR,  !- Electric Input to Cooling Output Ratio Function of Part Load Ratio Curve Name
  0.1500,  !- Minimum Part Load Ratio
  1.0000,  !- Maximum Part Load Ratio
  0.8000,  !- Optimum Part Load Ratio
  0.1500,  !- Minimum Unloading Ratio
  CoolSys1 Inlet Node,  !- Chilled Water Inlet Node Name
  CoolSys1 Outlet Node,  !- Chilled Water Outlet Node Name
  CoolSys1 Condenser Water Inlet Node,  !- Condenser Inlet Node Name
  CoolSys1 Condenser Water Outlet Node,  !- Condenser Outlet Node Name
  WaterCooled,  !- Condenser Type
  0.0000,  !- Condenser Fan Power Ratio {W/W}
  ,  !- Compressor Motor Efficiency
  2.0000,  !- Leaving Chilled Water Lower Temperature Limit {C}
  VariableFlow,  !- Chiller Flow Mode
  0.0000,  !- Design Heat Recovery Water Flow Rate {m3/s}
  ,  !- Heat Recovery Inlet Node Name
  ,  !- Heat Recovery Outlet Node Name
  1.0000;  !- Sizing Factor
!***** Following curve from Trane *****

Curve:Biquadratic,
  TraneChillerClgCapFuncTemp,  !- Name
  1.0700,  !- Coefficient1 Const
  0.0429,  !- Coefficient2 x
  0.0004,  !- Coefficient3 x**2
  -0.0081,  !- Coefficient4 y
  0.0000,  !- Coefficient5 y**2
  -0.0004,  !- Coefficient6 x*y
  5.0000,  !- Minimum Value of x
  10.0000,  !- Maximum Value of x
  24.0000,  !- Minimum Value of y
  35.0000;  !- Maximum Value of y
!***** Following curve from Trane *****

Curve:Biquadratic,
  TraneChillerEIRFuncTemp,  !- Name
  0.4680,  !- Coefficient1 Const
  -0.0138,  !- Coefficient2 x
  0.0007,  !- Coefficient3 x**2
  0.0109,  !- Coefficient4 y
  0.0005,  !- Coefficient5 y**2
  -0.0007,  !- Coefficient6 x*y
  5.0000,  !- Minimum Value of x
  10.0000,  !- Maximum Value of x
  24.0000,  !- Minimum Value of y
  35.0000;  !- Maximum Value of y
!***** Following curve from Trane *****

Curve:Quadratic,
  TraneChillerEIRFuncPLR,  !- Name
  0.1410,  !- Coefficient1 Const
  0.6550,  !- Coefficient2 x
  0.2030,  !- Coefficient3 x**2
  0.0000,  !- Minimum Value of x
  1.0000;  !- Maximum Value of x

Branch,
  CoolSys1 Supply Equipment Bypass Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  CoolSys1 Supply Equipment Bypass Pipe,  !- Component 1 Name
  CoolSys1 Supply Equip Bypass Inlet Node,  !- Component 1 Inlet Node Name
  CoolSys1 Supply Equip Bypass Outlet Node,  !- Component 1 Outlet Node Name
  Bypass;  !- Component 1 Control Type {ACTIVE | PASSIVE | BYPASS}

Pipe:Adiabatic,
  CoolSys1 Supply Equipment Bypass Pipe,  !- Name
  CoolSys1 Supply Equip Bypass Inlet Node,  !- Inlet Node Name
  CoolSys1 Supply Equip Bypass Outlet Node;  !- Outlet Node Name

Branch,
  CoolSys1 Supply Outlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  CoolSys1 Supply Outlet Pipe,  !- Component 1 Name
  CoolSys1 Supply Mixer-CoolSys1 Supply Outlet Pipe,  !- Component 1 Inlet Node Name
  CoolSys1 Supply Outlet Node,  !- Component 1 Outlet Node Name
  Passive;  !- Component 1 Control Type

Pipe:Adiabatic,
  CoolSys1 Supply Outlet Pipe,  !- Name
  CoolSys1 Supply Mixer-CoolSys1 Supply Outlet Pipe,  !- Inlet Node Name
  CoolSys1 Supply Outlet Node;  !- Outlet Node Name

BranchList,
  CoolSys1 Demand Branches,  !- Name
  CoolSys1 Demand Inlet Branch,  !- Branch 1 Name
  CoolSys1 Demand Load Branch 1,  !- Name 2 Name
  CoolSys1 Demand Bypass Branch,  !- Name 6 Name
  CoolSys1 Demand Outlet Branch;  !- Name 7 Name

ConnectorList,
  CoolSys1 Demand Connectors,  !- Name
  Connector:Splitter,  !- Connector 1 Object Type
  CoolSys1 Demand Splitter,  !- Connector 1 Name
  Connector:Mixer,  !- Connector 2 Object Type
  CoolSys1 Demand Mixer;  !- Connector 2 Name

Connector:Splitter,
  CoolSys1 Demand Splitter,  !- Name
  CoolSys1 Demand Inlet Branch,  !- Inlet Branch Name
  CoolSys1 Demand Load Branch 1,  !- Outlet Branch 1 Name
  CoolSys1 Demand Bypass Branch;  !- Outlet Branch 5 Name

Connector:Mixer,
  CoolSys1 Demand Mixer,  !- Name
  CoolSys1 Demand Outlet Branch,  !- Outlet Branch Name
  CoolSys1 Demand Load Branch 1,  !- Inlet Branch 1 Name
  CoolSys1 Demand Bypass Branch;  !- Inlet Branch 5 Name

Branch,
  CoolSys1 Demand Inlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  CoolSys1 Demand Inlet Pipe,  !- Component 1 Name
  CoolSys1 Demand Inlet Node,  !- Component 1 Inlet Node Name
  CoolSys1 Demand Inlet Pipe-CoolSys1 Demand Mixer,  !- Component 1 Outlet Node Name
  Passive;  !- Component 1 Control Type

Pipe:Adiabatic,
  CoolSys1 Demand Inlet Pipe,  !- Name
  CoolSys1 Demand Inlet Node,  !- Inlet Node Name
  CoolSys1 Demand Inlet Pipe-CoolSys1 Demand Mixer;  !- Outlet Node Name

Branch,
  CoolSys1 Demand Load Branch 1,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Coil:Cooling:Water,  !- Component 1 Object Type
  Main Cooling Coil 1,  !- Component 1 Name
  Cooling Coil Water Inlet Node,  !- Component 1 Inlet Node Name
  Cooling Coil Water Outlet Node,  !- Component 1 Outlet Node Name
  Active;  !- Component 1 Control Type

Branch,
  CoolSys1 Demand Bypass Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  CoolSys1 Demand Bypass Pipe,  !- Component 1 Name
  CoolSys1 Demand Bypass Pipe Inlet Node,  !- Component 1 Inlet Node Name
  CoolSys1 Demand Bypass Pipe Outlet Node,  !- Component 1 Outlet Node Name
  Bypass;  !- Component 1 Control Type {ACTIVE | PASSIVE| BYPASS}

Pipe:Adiabatic,
  CoolSys1 Demand Bypass Pipe,  !- Name
  CoolSys1 Demand Bypass Pipe Inlet Node,  !- Inlet Node Name
  CoolSys1 Demand Bypass Pipe Outlet Node;  !- Outlet Node Name

Branch,
  CoolSys1 Demand Outlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  CoolSys1 Demand Outlet Pipe,  !- Component 1 Name
  CoolSys1 Demand Mixer-CoolSys1 Demand Outlet Pipe,  !- Component 1 Inlet Node Name
  CoolSys1 Demand Outlet Node,  !- Component 1 Outlet Node Name
  Passive;  !- Component 1 Control Type

Pipe:Adiabatic,
  CoolSys1 Demand Outlet Pipe,  !- Name
  CoolSys1 Demand Mixer-CoolSys1 Demand Outlet Pipe,  !- Inlet Node Name
  CoolSys1 Demand Outlet Node;  !- Outlet Node Name
  
!***** Condenser Loop: TowerWaterSys *****

CondenserLoop,
  TowerWaterSys,  !- Name
  Water,  !- Fluid Type {WATER}
  TowerWaterSys Loop Operation Scheme List,  !- Loop Equipment Operation Scheme Name
  AIR,  !- Loop Temperature Setpoint Node Name
  80.0,  !- Maximum Loop Temperature {C}
  5.0,  !- Minimum Loop Temperature {C}
  AUTOSIZE,  !- Maximum Loop Flow Rate {m3/s}
  0.0,  !- Minimum Loop Flow Rate {m3/s}
  AUTOSIZE,  !- Loop Volume {m3}
  Condenser Loop Supply Inlet Node,  !- Supply Side Inlet Node
  TowerWaterSys Supply Outlet Node,  !- Supply Side Outlet Node
  TowerWaterSys Supply Branches,  !- Supply Side Branch List Name
  TowerWaterSys Supply Connectors,  !- Supply Side Connector List Name
  TowerWaterSys Demand Inlet Node,  !- Demand Side Inlet Node
  TowerWaterSys Demand Outlet Node,  !- Demand Side Outlet Node
  TowerWaterSys Demand Branches,  !- Demand Side Branch List Name
  TowerWaterSys Demand Connectors,  !- Demand Side Connector List Name
  Sequential;  !- Load Distribution Scheme {OPTIMAL | SEQUENTIAL}

Sizing:Plant,
  TowerWaterSys,  !- Loop Name
  CONDENSER,  !- Loop Type {COOLING | HEATING | CONDENSER}
  29.4,  !- Design Loop Exit Temperature {C}
  5.6;  !- Design Loop Temperature Difference {C}

CondenserEquipmentOperationSchemes,
  TowerWaterSys Loop Operation Scheme List,  !- Name
  PlantEquipmentOperation:CoolingLoad,  !- Control Scheme 1 Object Type {*******}
  TowerWaterSys Operation Scheme,  !- Control Scheme 1 Name
  PlantOnSched;  !- Control Scheme 1 Schedule Name

PlantEquipmentOperation:CoolingLoad,
  TowerWaterSys Operation Scheme,  !- Name
  0.0,  !- Load Range 1 Lower Limit {W}
  1000000000000,  !- Load Range 1 Upper Limit {W}
  TowerWaterSys Equipment List;  !- Priority Control 1 Equipment List Name

CondenserEquipmentList,
  TowerWaterSys Equipment List,  !- Name
  CoolingTower:SingleSpeed,  !- Equipment 2 Object Type
  TowerWaterSys CoolTower;  !- Equipment 2 Name

BranchList,
  TowerWaterSys Supply Branches,  !- Name
  TowerWaterSys Supply Inlet Branch,  !- Branch 1 Name
  TowerWaterSys Supply Equipment Branch,  !- Branch 2 Name
  TowerWaterSys Supply Equipment Bypass Branch,  !- Branch 3 Name
  TowerWaterSys Supply Outlet Branch;  !- Branch 4 Name

ConnectorList,
  TowerWaterSys Supply Connectors,  !- Name
  Connector:Splitter,  !- Connector 1 Object Type
  TowerWaterSys Supply Splitter,  !- Connector 1 Name
  Connector:Mixer,  !- Connector 2 Object Type
  TowerWaterSys Supply Mixer;  !- Connector 2 Name

Connector:Splitter,
  TowerWaterSys Supply Splitter,  !- Name
  TowerWaterSys Supply Inlet Branch,  !- Inlet Branch Name
  TowerWaterSys Supply Equipment Branch,  !- Outlet Branch 1 Name
  TowerWaterSys Supply Equipment Bypass Branch;  !- Outlet Branch 2 Name

Connector:Mixer,
  TowerWaterSys Supply Mixer,  !- Name
  TowerWaterSys Supply Outlet Branch,  !- Outlet Branch Name
  TowerWaterSys Supply Equipment Branch,  !- Inlet Branch 1 Name
  TowerWaterSys Supply Equipment Bypass Branch;  !- Inlet Branch 2 Name

Branch,
  TowerWaterSys Supply Inlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pump:ConstantSpeed,  !- Component 1 Object Type
  TowerWaterSys Pump,  !- Component 1 Name
  Condenser Loop Supply Inlet Node,  !- Component 1 Inlet Node Name
  Condenser Tower Inlet NodeviaConnector,  !- Component 1 Outlet Node Name
  Active;  !- Component 1 Branch Control Type {Active | Passive}

Branch,
  TowerWaterSys Supply Equipment Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  CoolingTower:SingleSpeed,  !- Component 2 Object Type
  TowerWaterSys CoolTower,  !- Component 2 Name
  Condenser Tower Inlet Node,  !- Component 2 Inlet Node Name
  Condenser Tower Outlet Node,  !- Component 2 Outlet Node Name
  Active;  !- Component 2 Branch Control Type

Pump:ConstantSpeed,
  TowerWaterSys Pump,  !- Name
  Condenser Loop Supply Inlet Node,  !- Inlet Node Name
  Condenser Tower Inlet NodeviaConnector,  !- Outlet Node Name
  AUTOSIZE,  !- Rated Flow Rate {m3/s}
  pump_head[],  !- Rated Pump Head {Pa} [179352 Pa = 60 ft]
  AUTOSIZE,  !- Rated Power Consumption {W}
  pump_eff_mtr[],  !- Motor Efficiency {}
  0.0,  !- Fraction of Motor Inefficiencies to Fluid Stream {}
  Intermittent,  !- Pump Control Type {Continuous | Intermittent}
  ;  !- Pump Flow Rate Schedule Name

CoolingTower:SingleSpeed,
  TowerWaterSys CoolTower,  !- Name
  Condenser Tower Inlet Node,  !- Water Inlet Node Name
  Condenser Tower Outlet Node,  !- Water Outlet Node Name
  AUTOSIZE,  !- Design Water Flow Rate {m3/s}
  AUTOSIZE,  !- Design Air Flow Rate {m3/s}
  AUTOSIZE,  !- Fan Power At Design Air Flow Rate {W}
  AUTOSIZE,  !- U-Factor Times Area Value at Design Air Flow Rate {W/K}
  AUTOSIZE,  !- Air Flow Rate In Free Convection Regime {m3/s}
  AUTOSIZE,  !- U-Factor Times Area Value at Free Convection Air Flow Rate {W/K}
  UFactorTimesAreaAndDesignWaterFlowRate,  !- Performance Input Method {NominalCapacity | UFactorTimesAreaAndDesignWaterFlowRate}
  ,  !- Nominal Capacity {W}
  ,  !- Free Convection Capacity {W}
  SaturatedExit,  !- Evaporation Loss Mode { LossFactor | SaturatedExit }
  ,  !- Evaporation Loss Factor
  0.0080,  !- Drift Loss Percent
  ConcentrationRatio,  !- Blowdown Calculation Mode { ConcentrationRatio | ScheduledRate }
  3.0000,  !- Blowdown Concentration Ratio
  ,  !- Blowdown Makeup Water Usage Schedule Name
  ,  !- Supply Water Storage Tank Name
  TowerWaterSys CoolTower OA ref Node,  !- Outdoor Air Inlet Node Name
  FanCycling,  !- Capacity Control  { FanCycling |  FluidBypass }
  1.0000;  !- Sizing Factor

OutdoorAir:Node,
  TowerWaterSys CoolTower OA ref Node;  !- Name

Branch,
  TowerWaterSys Supply Equipment Bypass Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  TowerWaterSys Supply Equipment Bypass Pipe,  !- Component 1 Name
  TowerWaterSys Supply Equip Bypass Inlet Node,  !- Component 1 Inlet Node Name
  TowerWaterSys Supply Equip Bypass Outlet Node,  !- Component 1 Outlet Node Name
  Bypass;  !- Component 1 Control Type {ACTIVE | PASSIVE | BYPASS}

Pipe:Adiabatic,
  TowerWaterSys Supply Equipment Bypass Pipe,  !- Name
  TowerWaterSys Supply Equip Bypass Inlet Node,  !- Inlet Node Name
  TowerWaterSys Supply Equip Bypass Outlet Node;  !- Outlet Node Name

Branch,
  TowerWaterSys Supply Outlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  TowerWaterSys Supply Outlet Pipe,  !- Component 1 Name
  TowerWaterSys Supply Mixer-TowerWaterSys Supply Outlet Pipe,  !- Component 1 Inlet Node Name
  TowerWaterSys Supply Outlet Node,  !- Component 1 Outlet Node Name
  Passive;  !- Component 1 Control Type

Pipe:Adiabatic,
  TowerWaterSys Supply Outlet Pipe,  !- Name
  TowerWaterSys Supply Mixer-TowerWaterSys Supply Outlet Pipe,  !- Inlet Node Name
  TowerWaterSys Supply Outlet Node;  !- Outlet Node Name

BranchList,
  TowerWaterSys Demand Branches,  !- Name
  TowerWaterSys Demand Inlet Branch,  !- Branch 1 Name
  TowerWaterSys Demand Load Branch 1,  !- Name 2 Name
  TowerWaterSys Demand Bypass Branch,  !- Name 3 Name
  TowerWaterSys Demand Outlet Branch;  !- Name 4 Name

ConnectorList,
  TowerWaterSys Demand Connectors,  !- Name
  Connector:Splitter,  !- Connector 1 Object Type
  TowerWaterSys Demand Splitter,  !- Connector 1 Name
  Connector:Mixer,  !- Connector 2 Object Type
  TowerWaterSys Demand Mixer;  !- Connector 2 Name

Connector:Splitter,
  TowerWaterSys Demand Splitter,  !- Name
  TowerWaterSys Demand Inlet Branch,  !- Inlet Branch Name
  TowerWaterSys Demand Load Branch 1,  !- Outlet Branch 1 Name
  TowerWaterSys Demand Bypass Branch;  !- Outlet Branch 2 Name

Connector:Mixer,
  TowerWaterSys Demand Mixer,  !- Name
  TowerWaterSys Demand Outlet Branch,  !- Outlet Branch Name
  TowerWaterSys Demand Load Branch 1,  !- Inlet Branch 1 Name
  TowerWaterSys Demand Bypass Branch;  !- Inlet Branch 2 Name

Branch,
  TowerWaterSys Demand Inlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  TowerWaterSys Demand Inlet Pipe,  !- Component 1 Name
  TowerWaterSys Demand Inlet Node,  !- Component 1 Inlet Node Name
  TowerWaterSys Demand Inlet Pipe-TowerWaterSys Demand Mixer,  !- Component 1 Outlet Node Name
  Passive;  !- Component 1 Control Type

Pipe:Adiabatic,
  TowerWaterSys Demand Inlet Pipe,  !- Name
  TowerWaterSys Demand Inlet Node,  !- Inlet Node Name
  TowerWaterSys Demand Inlet Pipe-TowerWaterSys Demand Mixer;  !- Outlet Node Name

Branch,
  TowerWaterSys Demand Load Branch 1,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Chiller:Electric:EIR,  !- Component 1 Object Type
  CoolSys1 Chiller,  !- Component 1 Name
  CoolSys1 Condenser Water Inlet Node,  !- Component 1 Inlet Node Name
  CoolSys1 Condenser Water Outlet Node,  !- Component 1 Outlet Node Name
  Active;  !- Component 1 Control Type

Branch,
  TowerWaterSys Demand Bypass Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  TowerWaterSys Demand Bypass Pipe,  !- Component 1 Name
  TowerWaterSys Demand Bypass Pipe Inlet Node,  !- Component 1 Inlet Node Name
  TowerWaterSys Demand Bypass Pipe Outlet Node,  !- Component 1 Outlet Node Name
  Bypass;  !- Component 1 Control Type {ACTIVE | PASSIVE| BYPASS}

Pipe:Adiabatic,
  TowerWaterSys Demand Bypass Pipe,  !- Name
  TowerWaterSys Demand Bypass Pipe Inlet Node,  !- Inlet Node Name
  TowerWaterSys Demand Bypass Pipe Outlet Node;  !- Outlet Node Name

Branch,
  TowerWaterSys Demand Outlet Branch,  !- Name
  ,  !- Maximum Flow Rate {m3/s}
  Pipe:Adiabatic,  !- Component 1 Object Type
  TowerWaterSys Demand Outlet Pipe,  !- Component 1 Name
  TowerWaterSys Demand Mixer-TowerWaterSys Demand Outlet Pipe,  !- Component 1 Inlet Node Name
  TowerWaterSys Demand Outlet Node,  !- Component 1 Outlet Node Name
  Passive;  !- Component 1 Control Type

Pipe:Adiabatic,
  TowerWaterSys Demand Outlet Pipe,  !- Name
  TowerWaterSys Demand Mixer-TowerWaterSys Demand Outlet Pipe,  !- Inlet Node Name
  TowerWaterSys Demand Outlet Node;  !- Outlet Node Name
  
##if #[Coil_heat[] eqs Gas ] 

!-   ===========  ALL OBJECTS IN CLASS: COIL:Heating:Gas =========== 

COIL:Heating:Gas,
    Reheat Coil Zone 1,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 1 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER3NOR Inlet Node;                !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 2,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 2 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER3EAS Inlet Node;                !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 3,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 3 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER3SOU Inlet Node;                !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 4,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 4 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER3WES Inlet Node;                !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 5,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 5 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    COR3 Inlet Node;                !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 6,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 6 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER1NOR Inlet Node;                !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 7,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 7 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER1EAS Inlet Node;                !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 8,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 8 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER1SOU Inlet Node;                !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 9,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 9 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER1WES Inlet Node;                !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 10,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 10 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    COR1 Inlet Node;                 !- Reheat_Air_Outlet_Node

##if #[Floors[] nes 2]

COIL:Heating:Gas,
    Reheat Coil Zone 11,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 11 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER2NOR Inlet Node;                 !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 12,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 12 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER2EAS Inlet Node;                 !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 13,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 13 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER2SOU Inlet Node;                 !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 14,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 14 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    PER2WES Inlet Node;                 !- Reheat_Air_Outlet_Node

COIL:Heating:Gas,
    Reheat Coil Zone 15,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    Coil_gas_eff[],          !-Gas Burner Efficiency of the Coil
    autosize,                !-Nominal Capacity of the Coil
    Zone 15 Reheat Air Inlet Node,  !- Reheat_Air_Inlet_Node
    COR2 Inlet Node;                 !- Reheat_Air_Outlet_Node

##endif

##elseif #[Coil_heat[] eqs Water ]

!-   ===========  ALL OBJECTS IN CLASS: COIL:Heating:Water ===========

COIL:Heating:Water,
    Reheat Coil Zone 1,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 1 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 1 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 1 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER3NOR Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;          

COIL:Heating:Water,
    Reheat Coil Zone 2,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 2 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 2 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 2 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER3EAS Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 3,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 3 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 3 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 3 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER3SOU Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 4,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 4 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 4 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 4 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER3WES Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 5,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 5 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 5 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 5 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    COR3 Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 6,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 6 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 6 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 6 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER1NOR Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 7,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 7 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 7 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 7 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER1EAS Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 8,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 8 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 8 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 8 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER1SOU Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 9,      !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 9 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 9 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 9 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER1WES Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 10,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 10 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 10 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 10 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    COR1 Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

##if #[Floors[] nes 2]

COIL:Heating:Water,
    Reheat Coil Zone 11,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 11 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 11 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 11 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER2NOR Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 12,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 12 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 12 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 12 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER2EAS Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 13,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 13 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 13 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 13 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER2SOU Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 14,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 14 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 14 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 14 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    PER2WES Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

COIL:Heating:Water,
    Reheat Coil Zone 15,     !- Coil Name
    ALWAYS_ON,       !- Available Schedule
    autosize,                !- UA of the Coil {W/K}
    autosize,                !- Max Water Flow Rate of Coil {m3/s}
    Zone 15 Reheat Water Inlet Node,  !- Coil_Water_Inlet_Node
    Zone 15 Reheat Water Outlet Node,  !- Coil_Water_Outlet_Node
    Zone 15 Reheat Air Inlet Node,  !- Coil_Air_Inlet_Node
    COR2 Inlet Node,     !- Coil_Air_Outlet_Node
    UFactorTimesAreaAndDesignWaterFlowRate,  !- Coil Peformance input method
    AUTOSIZE,  !- Nominal Capacity
    82.2,  !- Design Inlet Water Temperature
    16.6,  !- Design Inlet Air Temperature
    71.1,  !- Design Outlet Water Temperature
    32.2;  !- Design Outlet Air Temperature;         

##endif

##endif

!-   ===========  ALL OBJECTS IN CLASS: Exterior:Lights ===========

  Exterior:Lights,
    Exterior Facade Lighting,  !- Name
    ALWAYS_ON,  !- Schedule Name
    3997.5006,  !- Design Level
    AstronomicalClock,  !- Control Option
    Exterior Facade Lighting;  !- End-Use Subcategory

!-   ===========  ALL OBJECTS IN CLASS: NODE LIST ===========

NodeList,
    PER3NORInlet,                !- NodeList Name
    PER3NOR Inlet Node;          !- Node_ID_1

NodeList,
    PER3EASInlet,                !- NodeList Name
    PER3EAS Inlet Node;          !- Node_ID_1

NodeList,
    PER3SOUInlet,                !- NodeList Name
    PER3SOU Inlet Node;          !- Node_ID_1

NodeList,
    PER3WESInlet,                !- NodeList Name
    PER3WES Inlet Node;          !- Node_ID_1

NodeList,
    COR3Inlet,                !- NodeList Name
    COR3 Inlet Node;          !- Node_ID_1

NodeList,
    PER1NORInlet,                !- NodeList Name
    PER1NOR Inlet Node;          !- Node_ID_1

NodeList,
    PER1EASInlet,                !- NodeList Name
    PER1EAS Inlet Node;          !- Node_ID_1

NodeList,
    PER1SOUInlet,                !- NodeList Name
    PER1SOU Inlet Node;          !- Node_ID_1

NodeList,
    PER1WESInlet,                !- NodeList Name
    PER1WES Inlet Node;          !- Node_ID_1

NodeList,
    COR1Inlet,                !- NodeList Name
    COR1 Inlet Node;          !- Node_ID_1

NodeList,
    PER2NORInlet,                !- NodeList Name
    PER2NOR Inlet Node;          !- Node_ID_1

NodeList,
    PER2EASInlet,                !- NodeList Name
    PER2EAS Inlet Node;          !- Node_ID_1

NodeList,
    PER2SOUInlet,                !- NodeList Name
    PER2SOU Inlet Node;          !- Node_ID_1

NodeList,
    PER2WESInlet,                !- NodeList Name
    PER2WES Inlet Node;          !- Node_ID_1

NodeList,
    COR2Inlet,                !- NodeList Name
    COR2 Inlet Node;          !- Node_ID_1

NodeList,
    Mixed OA Node 1,         !- NodeList Name
    Mixed Air Node 1;        !- Node_ID_1

NodeList,
    OA Inlet Node 1,         !- NodeList Name
    Outside Air Inlet Node 1;!- Node_ID_1

NodeList,
    Supply Air Temp Node,    !- NodeList Name
    Air Loop Outlet Node 1;  !- Node_ID_1

NodeList,
    CW Temp Node List,       !- NodeList Name
    CW Supply Outlet Node;   !- Node_ID_1

NodeList,
    HW Temp Node List,       !- NodeList Name
    HW Supply Outlet Node;   !- Node_ID_1

NodeList,
    CondW Temp Node List,           !- NodeList Name
    Condenser Supply Outlet Node;   !- Node_ID_1

!-   ===========  ALL OBJECTS IN CLASS: ZoneHVAC:EquipmentConnections ===========

ZoneHVAC:EquipmentConnections,
    PERIM-3-NORTH,                  !- Zone Name
    PER3NOREquipment,            !- List Name: Zone Equipment
    PER3NORInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER3NOR Node,                !- Zone Air Node Name
    PER3NOR Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-3-EAST,                  !- Zone Name
    PER3EASEquipment,            !- List Name: Zone Equipment
    PER3EASInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER3EAS Node,                !- Zone Air Node Name
    PER3EAS Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-3-SOUTH,                  !- Zone Name
    PER3SOUEquipment,            !- List Name: Zone Equipment
    PER3SOUInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER3SOU Node,                !- Zone Air Node Name
    PER3SOU Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-3-WEST,                  !- Zone Name
    PER3WESEquipment,            !- List Name: Zone Equipment
    PER3WESInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER3WES Node,                !- Zone Air Node Name
    PER3WES Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    CORE-3,                   !- Zone Name
    COR3Equipment,            !- List Name: Zone Equipment
    COR3Inlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    COR3 Node,                !- Zone Air Node Name
    COR3 Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-1-NORTH,                  !- Zone Name
    PER1NOREquipment,            !- List Name: Zone Equipment
    PER1NORInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER1NOR Node,                !- Zone Air Node Name
    PER1NOR Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-1-EAST,                  !- Zone Name
    PER1EASEquipment,            !- List Name: Zone Equipment
    PER1EASInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER1EAS Node,                !- Zone Air Node Name
    PER1EAS Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-1-SOUTH,                  !- Zone Name
    PER1SOUEquipment,            !- List Name: Zone Equipment
    PER1SOUInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER1SOU Node,                !- Zone Air Node Name
    PER1SOU Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-1-WEST,                  !- Zone Name
    PER1WESEquipment,            !- List Name: Zone Equipment
    PER1WESInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER1WES Node,                !- Zone Air Node Name
    PER1WES Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    CORE-1,                   !- Zone Name
    COR1Equipment,            !- List Name: Zone Equipment
    COR1Inlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    COR1 Node,                !- Zone Air Node Name
    COR1 Outlet Node;         !- Zone Return Air Node Name


##if #[Floors[] nes 2]

ZoneHVAC:EquipmentConnections,
    PERIM-2-NORTH,                  !- Zone Name
    PER2NOREquipment,            !- List Name: Zone Equipment
    PER2NORInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER2NOR Node,                !- Zone Air Node Name
    PER2NOR Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-2-EAST,                  !- Zone Name
    PER2EASEquipment,            !- List Name: Zone Equipment
    PER2EASInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER2EAS Node,                !- Zone Air Node Name
    PER2EAS Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-2-SOUTH,                  !- Zone Name
    PER2SOUEquipment,            !- List Name: Zone Equipment
    PER2SOUInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER2SOU Node,                !- Zone Air Node Name
    PER2SOU Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    PERIM-2-WEST,                  !- Zone Name
    PER2WESEquipment,            !- List Name: Zone Equipment
    PER2WESInlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    PER2WES Node,                !- Zone Air Node Name
    PER2WES Outlet Node;         !- Zone Return Air Node Name

ZoneHVAC:EquipmentConnections,
    CORE-2,                   !- Zone Name
    COR2Equipment,            !- List Name: Zone Equipment
    COR2Inlet,                !- List Name: Zone Air Inlet Nodes
    ,                        !- List Name: Zone Air Exhaust Nodes
    COR2 Node,                !- Zone Air Node Name
    COR2 Outlet Node;         !- Zone Return Air Node Name

##endif

!-   ===========  ALL OBJECTS IN CLASS: ZoneHVAC:EquipmentList ===========

ZoneHVAC:EquipmentList,
    PER3NOREquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER3NOR AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER3EASEquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER3EAS AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER3SOUEquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER3SOU AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER3WESEquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER3WES AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    COR3Equipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    COR3 AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER1NOREquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER1NOR AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER1EASEquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER1EAS AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER1SOUEquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER1SOU AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER1WESEquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER1WES AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    COR1Equipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    COR1 AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

##if #[Floors[] nes 2]

ZoneHVAC:EquipmentList,
    PER2NOREquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER2NOR AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER2EASEquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER2EAS AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER2SOUEquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER2SOU AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    PER2WESEquipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    PER2WES AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

ZoneHVAC:EquipmentList,
    COR2Equipment,            !- Name
    ZoneHVAC:AirDistributionUnit,   !- KEY--Zone Equipment Type 1
    COR2 AHU,                 !- Type Name 1
    1,                       !- Cooling Priority
    1;                       !- Heating Priority

##endif



!-   ===========  ALL OBJECTS IN CLASS: ZoneHVAC:AirDistributionUnit ===========

ZoneHVAC:AirDistributionUnit,
    PER3NOR AHU,                  !- ZoneHVAC:AirDistributionUnit Name
    PER3NOR Inlet Node,           !- Air Dist Unit Outlet Node Name
    termbox_type[],           !- KEY--System Component Type 1
    PER3NOR HVAC_System[] system; !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER3EAS AHU,                  !- ZoneHVAC:AirDistributionUnit Name
    PER3EAS Inlet Node,           !- Air Dist Unit Outlet Node Name
    termbox_type[],           !- KEY--System Component Type 1
    PER3EAS HVAC_System[] system; !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER3SOU AHU,                  !- ZoneHVAC:AirDistributionUnit Name
    PER3SOU Inlet Node,           !- Air Dist Unit Outlet Node Name
    termbox_type[],           !- KEY--System Component Type 1
    PER3SOU HVAC_System[] system; !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER3WES AHU,                  !- ZoneHVAC:AirDistributionUnit Name
    PER3WES Inlet Node,           !- Air Dist Unit Outlet Node Name
    termbox_type[],           !- KEY--System Component Type 1
    PER3WES HVAC_System[] system; !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    COR3 AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    COR3 Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    COR3 HVAC_System[] system;          !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER1NOR AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    PER1NOR Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    PER1NOR HVAC_System[] system;          !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER1EAS AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    PER1EAS Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    PER1EAS HVAC_System[] system;          !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER1SOU AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    PER1SOU Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    PER1SOU HVAC_System[] system;          !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER1WES AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    PER1WES Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    PER1WES HVAC_System[] system;          !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    COR1 AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    COR1 Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    COR1 HVAC_System[] system;          !- Component Name 1


##if #[Floors[] nes 2]

ZoneHVAC:AirDistributionUnit,
    PER2NOR AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    PER2NOR Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    PER2NOR HVAC_System[] system;          !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER2EAS AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    PER2EAS Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    PER2EAS HVAC_System[] system;          !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER2SOU AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    PER2SOU Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    PER2SOU HVAC_System[] system;          !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    PER2WES AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    PER2WES Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    PER2WES HVAC_System[] system;          !- Component Name 1

ZoneHVAC:AirDistributionUnit,
    COR2 AHU,                 !- ZoneHVAC:AirDistributionUnit Name
    COR2 Inlet Node,          !- Air Dist Unit Outlet Node Name
    termbox_type[],  !- KEY--System Component Type 1
    COR2 HVAC_System[] system;          !- Component Name 1

##endif


!-   ===========  ALL OBJECTS IN CLASS: ZoneControl:Thermostat, ===========

ZoneControl:Thermostat,
    PER3NOR Thermostat,          !- Thermostat Name
    PERIM-3-NORTH,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    PER3EAS Thermostat,          !- Thermostat Name
    PERIM-3-EAST,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    PER3SOU Thermostat,          !- Thermostat Name
    PERIM-3-SOUTH,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name
    
ZoneControl:Thermostat,
    PER3WES Thermostat,          !- Thermostat Name
    PERIM-3-WEST,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    COR3 Thermostat,          !- Thermostat Name
    CORE-3,                   !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    PER1NOR Thermostat,          !- Thermostat Name
    PERIM-1-NORTH,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    PER1EAS Thermostat,          !- Thermostat Name
    PERIM-1-EAST,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    PER1SOU Thermostat,          !- Thermostat Name
    PERIM-1-SOUTH,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    PER1WES Thermostat,          !- Thermostat Name
    PERIM-1-WEST,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    COR1 Thermostat,          !- Thermostat Name
    CORE-1,                   !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name


##if #[Floors[] nes 2]

ZoneControl:Thermostat,
    PER2NOR Thermostat,          !- Thermostat Name
    PERIM-2-NORTH,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    PER2EAS Thermostat,          !- Thermostat Name
    PERIM-2-EAST,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    PER2SOU Thermostat,          !- Thermostat Name
    PERIM-2-SOUTH,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    PER2WES Thermostat,          !- Thermostat Name
    PERIM-2-WEST,                  !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

ZoneControl:Thermostat,
    COR2 Thermostat,          !- Thermostat Name
    CORE-2,                   !- Zone Name
    Dual Zone Control Type Sched,            !- Control Type SCHEDULE Name
    ThermostatSetpoint:DualSetpoint,
    DualSetPoint;  !- Control 1 Name

##endif


!-   ===========  ALL OBJECTS IN CLASS: ThermostatSetpoint:DualSetpoint ===========

ThermostatSetpoint:DualSetpoint,
    DualSetPoint,            !- Name
  HTGSETP_SCH,  !- Heating Setpoint Temperature Schedule Name
  CLGSETP_SCH;  !- Cooling Setpoint Temperature Schedule Name

##if #[HVAC_System[] eqs CAV ]

!-   ===========  ALL OBJECTS IN CLASS: SINGLE DUCT:CONST VOLUME:REHEAT ===========

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER3NOR CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER3NOR Inlet Node,          !- Unit Air Outlet Node
    Zone 1 Reheat Air Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 1 Reheat Water Inlet Node,  !-Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 1,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER3EAS CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER3EAS Inlet Node,          !- Unit Air Outlet Node
    Zone 2 Reheat Air Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 2 Reheat Water Inlet Node,       !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 2,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER3SOU CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER3SOU Inlet Node,          !- Unit Air Outlet Node
    Zone 3 Reheat Air Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 3 Reheat Water Inlet Node,          !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 3,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00         ,           !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER3WES CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER3WES Inlet Node,          !- Unit Air Outlet Node
    Zone 4 Reheat Air Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 4 Reheat Water Inlet Node,        !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 4,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    COR3 CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    COR3 Inlet Node,          !- Unit Air Outlet Node
    Zone 5 Reheat Air Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 5 Reheat Water Inlet Node,          !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 5,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER1NOR CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER1NOR Inlet Node,          !- Unit Air Outlet Node
    Zone 6 Reheat Air Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 6 Reheat Water Inlet Node,        !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 6,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER1EAS CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER1EAS Inlet Node,          !- Unit Air Outlet Node
    Zone 7 Reheat Air Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 7 Reheat Water Inlet Node,      !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 7,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER1SOU CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER1SOU Inlet Node,          !- Unit Air Outlet Node
    Zone 8 Reheat Air Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 8 Reheat Water Inlet Node,        !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 8,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER1WES CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER1WES Inlet Node,          !- Unit Air Outlet Node
    Zone 9 Reheat Air Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 9 Reheat Water Inlet Node,        !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 9,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    COR1 CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    COR1 Inlet Node,          !- Unit Air Outlet Node
    Zone 10 Reheat Air Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 10 Reheat Water Inlet Node,      !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 10,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

##if #[Floors[] nes 2]

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER2NOR CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER2NOR Inlet Node,          !- Unit Air Outlet Node
    Zone 11 Reheat Air Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 11 Reheat Water Inlet Node,         !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 11,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER2EAS CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER2EAS Inlet Node,          !- Unit Air Outlet Node
    Zone 12 Reheat Air Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 12 Reheat Water Inlet Node,       !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 12,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER2SOU CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER2SOU Inlet Node,          !- Unit Air Outlet Node
    Zone 13 Reheat Air Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 13 Reheat Water Inlet Node,      !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 13,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    PER2WES CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    PER2WES Inlet Node,          !- Unit Air Outlet Node
    Zone 14 Reheat Air Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 14 Reheat Water Inlet Node,        !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 14,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance

AirTerminal:SingleDuct:ConstantVolume:Reheat,
    COR2 CAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    COR2 Inlet Node,          !- DAMPER Air Outlet Node
    Zone 15 Reheat Air Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Zone 15 Reheat Water Inlet Node,        !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 15,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    0.001;                   !- Convergence Tolerance
##endif

##elseif #[HVAC_System[] eqs VAV ]

!-   ===========  ALL OBJECTS IN CLASS: AirTerminal:SingleDuct:VAV:Reheat ===========

AirTerminal:SingleDuct:VAV:Reheat,
    PER3NOR VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 1 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 1 Damper Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 1 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 1,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER3NOR Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER3EAS VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 2 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 2 Damper Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 2 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 2,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER3EAS Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER3SOU VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 3 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 3 Damper Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 3 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 3,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER3SOU Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER3WES VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 4 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 4 Damper Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 4 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 4,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER3WES Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    COR3 VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 5 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 5 Damper Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 5 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 5,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    COR3 Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER1NOR VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 6 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 6 Damper Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 6 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 6,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER1NOR Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER1EAS VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 7 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 7 Damper Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 7 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 7,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER1EAS Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER1SOU VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 8 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 8 Damper Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 8 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 8,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER1SOU Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER1WES VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 9 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 9 Damper Inlet Node,!- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 9 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 9,      !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER1WES Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    COR1 VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 10 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 10 Damper Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 10 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 10,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    COR1 Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

##if #[Floors[] nes 2]

AirTerminal:SingleDuct:VAV:Reheat,
    PER2NOR VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 11 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 11 Damper Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 11 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 11,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER2NOR Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER2EAS VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 12 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 12 Damper Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 12 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 12,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER2EAS Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER2SOU VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 13 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 13 Damper Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 13 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 13,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER2SOU Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    PER2WES VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 14 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 14 Damper Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 14 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 14,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    PER2WES Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

AirTerminal:SingleDuct:VAV:Reheat,
    COR2 VAV system,          !- Name of System
    ALWAYS_ON,        !- System Availability schedule
    Zone 15 Reheat Air Inlet Node,  !- DAMPER Air Outlet Node
    Zone 15 Damper Inlet Node,  !- UNIT Air Inlet Node
    autosize,                !- Maximum air flow rate {m3/s}
    Constant,  !- Zone Minimum Air Flow Input Method
    min_air_flow[],          !- Zone Minimum Air Flow Fraction
    ,
    Zone 15 Reheat Water Inlet Node,  !- Control node
    coil_type[],             !- Reheat Component Object
    Reheat Coil Zone 15,     !- Name of Reheat Component
    autosize,                !- Max Reheat Water Flow {m3/s}
    0.00,                    !- Min Reheat Water Flow {m3/s}
    COR2 Inlet Node,          !- UNIT Air Outlet Node
    0.001,                 !- Convergence Tolerance
    Normal;          !- Damper Heating Action

##endif

##endif



