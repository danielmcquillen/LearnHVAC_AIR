! Space Condition
! Large Office


PEOPLE,
    PERIM-1-NORTH People 1,  !- Name
    PERIM-1-NORTH,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Long_Area[] / Sqm_perPerson[]],!- Number of People
    ,  !- People per Zone Area
    ,  !- Zone Area per Person
    0.3000,  !- Fraction Radiant
    AUTOCALCULATE,  !- User Specified Sensible Fraction
    ACTIVITY_SCH,  !- Activity Level Schedule Name
    No,  !- Enable ASHRAE 55 Comfort Warnings
    ZoneAveraged,  !- MRT Calculation
    ,  !- Surface Name
    WORK_EFF_SCH,  !- Work Efficiency Schedule Name
    CLOTHING_SCH,  !- Clothing Schedule Name
    AIR_VELO_SCH,  !- Air Velocity Schedule Name
    FANGER;  !- Thermal Comfort Report

PEOPLE,
    PERIM-1-EAST People 1,   !- Name
    PERIM-1-EAST,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
   #[Perim-Width_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    PERIM-1-SOUTH People 1,  !- Name
    PERIM-1-SOUTH,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Long_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    PERIM-1-WEST People 1,   !- Name
    PERIM-1-WEST,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Width_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    CORE-1 People 1,         !- Name
    CORE-1,                   !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Core_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report

##if #[Floors[] nes 2]

PEOPLE,
    PERIM-2-NORTH People 1,  !- Name
    PERIM-2-NORTH,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Long_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    PERIM-2-EAST People 1,   !- Name
    PERIM-2-EAST,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Width_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    PERIM-2-SOUTH People 1,  !- Name
    PERIM-2-SOUTH,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Long_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    PERIM-2-WEST People 1,   !- Name
    PERIM-2-WEST,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Width_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    CORE-2 People 1,         !- Name
    CORE-2,                   !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Core_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
##endif

PEOPLE,
    PERIM-3-NORTH People 1,  !- Name
    PERIM-3-NORTH,                       !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Long_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    PERIM-3-EAST People 1,   !- Name
    PERIM-3-EAST,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Width_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    PERIM-3-SOUTH People 1,  !- Name
    PERIM-3-SOUTH,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Long_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    PERIM-3-WEST People 1,   !- Name
    PERIM-3-WEST,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Perim-Width_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report
  
PEOPLE,
    CORE-3 People 1,         !- Name
    CORE-3,                  !- Zone Name
    BLDG_OCC_SCH,  !- Schedule Name
    People,  !- Number of People Calculation Method
    #[Core_Area[] / Sqm_perPerson[]],!- Number of People
  ,  !- People per Zone Area
  ,  !- Zone Area per Person
  0.3000,  !- Fraction Radiant
  AUTOCALCULATE,  !- User Specified Sensible Fraction
  ACTIVITY_SCH,  !- Activity Level Schedule Name
  No,  !- Enable ASHRAE 55 Comfort Warnings
  ZoneAveraged,  !- MRT Calculation
  ,  !- Surface Name
  WORK_EFF_SCH,  !- Work Efficiency Schedule Name
  CLOTHING_SCH,  !- Clothing Schedule Name
  AIR_VELO_SCH,  !- Air Velocity Schedule Name
  FANGER;  !- Thermal Comfort Report


LIGHTS,
    PERIM-1-NORTH Lights 1,  !- Name
    PERIM-1-NORTH,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    PERIM-1-EAST Lights 1,   !- Name
    PERIM-1-EAST,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    PERIM-1-SOUTH Lights 1,  !- Name
    PERIM-1-SOUTH,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    PERIM-1-WEST Lights 1,   !- Name
    PERIM-1-WEST,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    CORE-1 Lights 1,         !- Name
    CORE-1,                   !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Core_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey


##if #[Floors[] nes 2]

LIGHTS,
    PERIM-2-NORTH Lights 1,  !- Name
    PERIM-2-NORTH,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    PERIM-2-EAST Lights 1,   !- Name
    PERIM-2-EAST,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    PERIM-2-SOUTH Lights 1,  !- Name
    PERIM-2-SOUTH,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    PERIM-2-WEST Lights 1,   !- Name
    PERIM-2-WEST,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    CORE-2 Lights 1,         !- Name
    CORE-2,                   !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Core_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

##endif

LIGHTS,
    PERIM-3-NORTH Lights 1,  !- Name
    PERIM-3-NORTH,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    PERIM-3-EAST Lights 1,   !- Name
    PERIM-3-EAST,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    PERIM-3-SOUTH Lights 1,  !- Name
    PERIM-3-SOUTH,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    PERIM-3-WEST Lights 1,   !- Name
    PERIM-3-WEST,                  !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey

LIGHTS,
    CORE-3 Lights 1,         !- Name
    CORE-3,                   !- Zone Name
    BLDG_LIGHT_SCH,               !- SCHEDULE Name
    LightingLevel,  !- Design Level Calculation Method
    #[Core_Area[] * Lights_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Return Air Fraction
    0.7000,  !- Fraction Radiant
    0.2000,  !- Fraction Visible
    1.0000,  !- Fraction Replaceable
    GeneralLights, !- End-Use Subcategory
    No;  !- Return Air Fraction is Calculated from Plenum Temperature           !- LightsEndUseKey



ElectricEquipment,
    PERIM-1-NORTH ElecEq 1,  !- Name
    PERIM-1-NORTH,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    PERIM-1-EAST ElecEq 1,   !- Name
    PERIM-1-EAST,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    PERIM-1-SOUTH ElecEq 1,  !- Name
    PERIM-1-SOUTH,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    PERIM-1-WEST ElecEq 1,   !- Name
    PERIM-1-WEST,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    CORE-1 ElecEq 1,         !- Name
    CORE-1,                   !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Core_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory


##if #[Floors[] nes 2]

ElectricEquipment,
    PERIM-2-NORTH ElecEq 1,  !- Name
    PERIM-2-NORTH,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    PERIM-2-EAST ElecEq 1,   !- Name
    PERIM-2-EAST,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    PERIM-2-SOUTH ElecEq 1,  !- Name
    PERIM-2-SOUTH,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    PERIM-2-WEST ElecEq 1,   !- Name
    PERIM-2-WEST,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    CORE-2 ElecEq 1,         !- Name
    CORE-2,                   !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Core_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

##endif

ElectricEquipment,
    PERIM-3-NORTH ElecEq 1,  !- Name
    PERIM-3-NORTH,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    PERIM-3-EAST ElecEq 1,   !- Name
    PERIM-3-EAST,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    PERIM-3-SOUTH ElecEq 1,  !- Name
    PERIM-3-SOUTH,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Long_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    PERIM-3-WEST ElecEq 1,   !- Name
    PERIM-3-WEST,                  !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Perim-Width_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory

ElectricEquipment,
    CORE-3 ElecEq 1,         !- Name
    CORE-3,                   !- Zone Name
    BLDG_EQUIP_SCH,               !- SCHEDULE Name
    EquipmentLevel,  !- Design Level Calculation Method
    #[Core_Area[] * Equip_Sqm[]],!- Design Level {W}
    ,  !- Watts per Zone Floor Area {W/m2}
    ,  !- Watts per Person {W/person}
    0.0000,  !- Fraction Latent
    0.5000,  !- Fraction Radiant
    0.0000,  !- Fraction Lost
    General;  !- End-Use Subcategory


ZoneInfiltration:DesignFlowRate,
    PERIM-1-NORTH Infil 1,   !- Name
    PERIM-1-NORTH,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Long_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient

ZoneInfiltration:DesignFlowRate,
    PERIM-1-EAST Infil 1,    !- Name
    PERIM-1-EAST,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Width_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    PERIM-1-SOUTH Infil 1,   !- Name
    PERIM-1-SOUTH,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Long_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    PERIM-1-WEST Infil 1,    !- Name
    PERIM-1-WEST,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Width_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    CORE-1 Infil 1,          !- Name
    CORE-1,                   !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Core_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    

##if #[Floors[] nes 2]

ZoneInfiltration:DesignFlowRate,
    PERIM-2-NORTH Infil 1,   !- Name
    PERIM-2-NORTH,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Long_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    PERIM-2-EAST Infil 1,    !- Name
    PERIM-2-EAST,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Width_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    PERIM-2-SOUTH Infil 1,   !- Name
    PERIM-2-SOUTH,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Long_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    PERIM-2-WEST Infil 1,    !- Name
    PERIM-2-WEST,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Width_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    CORE-2 Infil 1,          !- Name
    CORE-2,                   !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Core_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
##endif

ZoneInfiltration:DesignFlowRate,
    PERIM-3-NORTH Infil 1,   !- Name
    PERIM-3-NORTH,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Long_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    PERIM-3-EAST Infil 1,    !- Name
    PERIM-3-EAST,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Width_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    PERIM-3-SOUTH Infil 1,   !- Name
    PERIM-3-SOUTH,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Long_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    PERIM-3-WEST Infil 1,    !- Name
    PERIM-3-WEST,                  !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Perim-Width_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    
ZoneInfiltration:DesignFlowRate,
    CORE-3 Infil 1,          !- Name
    CORE-3,                   !- Zone Name
    INFIL_QUARTER_ON_SCH,               !- SCHEDULE Name
    Flow/Zone,  !- Design Volume Flow Rate Calculation Method
    #[ACH[] * #[#[Core_Area[] * C_Height[]] / 3600]], !- Design Volume Flow Rate {m3/s}
    ,  !- Flow per Zone Area {m3/s/m2}
    ,  !- Flow per Exterior Surface Area {m3/s/m2}
    ,  !- Air Changes Per Hour {ACH}
    1.0000,  !- Constant Term Coefficient
    0.0000,  !- Temperature Term Coefficient
    0.0000,  !- Velocity Term Coefficient
    0.0000;  !- Velocity Squared Term Coefficient
    