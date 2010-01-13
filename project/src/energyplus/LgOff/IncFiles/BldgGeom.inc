!  BldgGeom.inc
!  Large Office
!  EnergyPlus Macro file
!                7 floors, 5 zones per floor
!

!------------------------------------------------------------------
!                    F I R S T   F L O O R
!------------------------------------------------------------------

ZONE,
    PERIM-1-NORTH,           !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Long_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    PERIM-1-EAST,            !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Width_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    PERIM-1-SOUTH,           !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Long_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    PERIM-1-WEST,            !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Width_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    CORE-1,                  !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Core_Area[] * C_Height[]],            !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm


##if #[Floors[] nes 2]

!------------------------------------------------------------------
!                   S E C O N D   F L O O R
!------------------------------------------------------------------

ZONEGROUP,
 Mid Floor,               !- Zone Group Name
 Mid Floor List,          !- Zone List Name
 Multplr[];                      !- Zone List Multiplier
 
ZONELIST,
 Mid Floor List,          !- Zone List Name
 PERIM-2-NORTH,           !- Zone Name 1
 PERIM-2-EAST,            !- Zone Name 2
 PERIM-2-SOUTH,           !- Zone Name 3
 PERIM-2-WEST,            !- Zone Name 4
 CORE-2;                  !- Zone Name 4

ZONE,
    PERIM-2-NORTH,           !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier  
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Long_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    PERIM-2-EAST,            !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier  
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Width_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    PERIM-2-SOUTH,           !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier  
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Long_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    PERIM-2-WEST,            !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier  
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Width_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    CORE-2,                  !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier  
    C_Height[],              !- Ceiling Height {m}
    #[Core_Area[] * C_Height[]],            !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

##endif

!------------------------------------------------------------------
!                      T H I R D   F L O O R
!------------------------------------------------------------------

ZONE,
    PERIM-3-NORTH,           !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Long_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    PERIM-3-EAST,            !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Width_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    PERIM-3-SOUTH,           !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Long_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    PERIM-3-WEST,                  !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Perim-Width_Area[] * C_Height[]],       !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm

ZONE,
    CORE-3,                  !- Zone Name
    0,                       !- Relative North (to building) {deg}
    0,                       !- X Origin {m}
    0,                       !- Y Origin {m}
    0,                       !- Z Origin {m}
    1,                       !- Type
    1,                       !- Multiplier
    C_Height[],              !- Ceiling Height {m}
    #[Core_Area[] * C_Height[]],            !- Volume {m3}
    detailed;                !- Zone Inside Convection Algorithm


!-   ===========  ALL OBJECTS IN CLASS: BuildingSurface:Detailed ===========

BuildingSurface:Detailed,
    Ext-Per1N-Nor,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-1-NORTH,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Per1N,                   !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    PERIM-1-NORTH,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    C_Height[],                  !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    C_Height[],                  !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per1N,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    Unheated - 4in Slab with Carpet_Ext-slab,   !- Construction Name of the Surface
    PERIM-1-NORTH,                  !- InsideFaceEnvironment
    Ground,               !- OutsideFaceEnvironment
    ,                   !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    0.000,                   !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    0.000;                   !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1N-SW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-NORTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-WEST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1N-Sou,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-NORTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-1,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1N-SE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-NORTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-EAST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ext-Per1E-Eas,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-1-EAST,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Per1E,                   !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    PERIM-1-EAST,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    C_Height[],                  !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    C_Height[],                  !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per1E,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    Unheated - 4in Slab with Carpet_Ext-slab,   !- Construction Name of the Surface
    PERIM-1-EAST,                  !- InsideFaceEnvironment
    Ground,               !- OutsideFaceEnvironment
    ,                   !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    0.000,                   !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    0.000;                   !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1E-NW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-EAST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-NORTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1E-Wes,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-EAST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-1,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1E-SW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-EAST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-SOUTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ext-Per1S-Sou,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-1-SOUTH,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Per1S,                   !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    PERIM-1-SOUTH,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    C_Height[],                  !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    C_Height[],                  !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per1S,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    Unheated - 4in Slab with Carpet_Ext-slab,   !- Construction Name of the Surface
    PERIM-1-SOUTH,                  !- InsideFaceEnvironment
    Ground,               !- OutsideFaceEnvironment
    ,                   !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    0.000,                   !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    0.000;                   !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1S-NE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-SOUTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-EAST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1S-Nor,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-SOUTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-1,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1S-NW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-SOUTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-WEST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ext-Per1W-Wes,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-1-WEST,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Per1W,                   !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    PERIM-1-WEST,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    C_Height[],                  !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    C_Height[],                  !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per1W,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    Unheated - 4in Slab with Carpet_Ext-slab,   !- Construction Name of the Surface
    PERIM-1-WEST,                  !- InsideFaceEnvironment
    Ground,               !- OutsideFaceEnvironment
    ,                   !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    0.000,                   !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    0.000;                   !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1W-SE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-WEST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-SOUTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1W-Eas,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-WEST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-1,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per1W-NE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-1-WEST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-NORTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Core1,                  !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    CORE-1,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,  
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    C_Height[],                  !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    C_Height[],                  !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Core1,                  !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    Unheated - 4in Slab with Carpet_Ext-slab,   !- Construction Name of the Surface
    CORE-1,                   !- InsideFaceEnvironment
    Ground,               !- OutsideFaceEnvironment
    ,                  !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    0.000,                   !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    0.000;                   !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core1-Sou,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-1,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-SOUTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[]0,                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core1-Wes,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-1,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-WEST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    C_Height[]000;               !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core1-Nor,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-1,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-NORTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core1-Eas,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-1,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-1-EAST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    C_Height[],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    0.000,                   !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    0.000,                   !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    C_Height[];                  !- Vertex 4 Z-coordinate {m}

##if #[Floors[] nes 2]

BuildingSurface:Detailed,
    Ext-Per2N-Nor,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-2-NORTH,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],     !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],      !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Per2N,                   !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    PERIM-2-NORTH,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],       !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];       !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per2N,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    PERIM-2-NORTH,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],      !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],      !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2N-SW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-NORTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-WEST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2N-Sou,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-NORTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-2,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],      !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2N-SE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-NORTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-EAST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];     !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ext-Per2E-Eas,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-2-EAST,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Per2E,                   !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    PERIM-2-EAST,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per2E,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    PERIM-2-EAST,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],      !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]];       !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2E-NW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-EAST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-NORTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2E-Wes,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-EAST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-2,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2E-SW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-EAST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-SOUTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2S-NE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-SOUTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-EAST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ext-Per2S-Sou,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-2-SOUTH,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Per2S,                   !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    PERIM-2-SOUTH,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],       !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per2S,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    PERIM-2-SOUTH,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]];       !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ext-Per2W-Wes,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-2-WEST,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Per2W,                   !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    PERIM-2-WEST,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per2W,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    PERIM-2-WEST,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]];       !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2S-NW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-SOUTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-WEST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2W-SE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-WEST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-SOUTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],      !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2W-Eas,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-WEST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-2,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];       !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2W-NE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-WEST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-NORTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ceiling-Core2,                  !- User Supplied Surface Name
    CEILING,                 !- Surface Type
    INT-FLOOR-UNDERSIDE,               !- Construction Name of the Surface
    CORE-2,                  !- InsideFaceEnvironment
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],     !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Core2,                  !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    CORE-2,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]];       !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per2S-Nor,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-2-SOUTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-2,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],      !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core2-Sou,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-2,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-SOUTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],      !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core2-Wes,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-2,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-WEST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];   !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core2-Nor,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-2,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-NORTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],     !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core2-Eas,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-2,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-2-EAST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]],      !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],      !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] - 1]]],       !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[0.5 * #[Floors[] + 1]]];      !- Vertex 4 Z-coordinate {m}


##endif

BuildingSurface:Detailed,
    Ext-Per3N-Nor,           !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-3-NORTH,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],        !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],      !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Roof-Per3N,              !- User Supplied Surface Name
    ROOF,                    !- Surface Type
    IEAD_R-15 ci_Roof,                  !- Construction Name of the Surface
    PERIM-3-NORTH,                   !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per3N,             !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    PERIM-3-NORTH,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]];              !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3N-SW,            !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-NORTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-WEST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3N-Sou,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-NORTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-3,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3N-SE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-NORTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-EAST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ext-Per3E-Eas,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-3-EAST,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Roof-Per3E,                  !- User Supplied Surface Name
    ROOF,                    !- Surface Type
    IEAD_R-15 ci_Roof,                  !- Construction Name of the Surface
    PERIM-3-EAST,                   !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per3E,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    PERIM-3-EAST,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]];              !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3E-NW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-EAST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-NORTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3E-Wes,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-EAST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-3,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3E-SW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-EAST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-SOUTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ext-Per3S-Sou,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-3-SOUTH,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],               !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Roof-Per3S,                  !- User Supplied Surface Name
    ROOF,                    !- Surface Type
    IEAD_R-15 ci_Roof,                  !- Construction Name of the Surface
    PERIM-3-SOUTH,                   !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per3S,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    PERIM-3-SOUTH,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]];              !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3S-NE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-SOUTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-EAST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3S-Nor,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-SOUTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-3,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3S-NW,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-SOUTH,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-WEST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Ext-Per3W-Wes,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Mass_R-5.7 ci_Ext-wall,                  !- Construction Name of the Surface
    PERIM-3-WEST,                  !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Roof-Per3W,                  !- User Supplied Surface Name
    ROOF,                    !- Surface Type
    IEAD_R-15 ci_Roof,                  !- Construction Name of the Surface
    PERIM-3-WEST,                   !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Per3W,                   !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    PERIM-3-WEST,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]];             !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3W-SE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-WEST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-SOUTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3W-Eas,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-WEST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    CORE-3,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Per3W-NE,                 !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    PERIM-3-WEST,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-NORTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Roof-Core3,                 !- User Supplied Surface Name
    ROOF,                    !- Surface Type
    IEAD_R-15 ci_Roof,                  !- Construction Name of the Surface
    CORE-3,                   !- Zone Name
    Outdoors,     !- OutsideFaceEnvironment
    ,                        !- OutsideFaceEnvironment Object
    SunExposed,              !- Sun Exposure
    WindExposed,             !- Wind Exposure
    0.00,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
   #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Floor-Core3,                  !- User Supplied Surface Name
    FLOOR,                   !- Surface Type
    INT-FLOOR-TOPSIDE,                 !- Construction Name of the Surface
    CORE-3,                  !- Zone Name
    Adiabatic,               !- OutsideFaceEnvironment
    ,
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]];             !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core3-Sou,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-3,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-SOUTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    P_Width[]0,                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],             !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core3-Wes,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-3,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-WEST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    P_Width[],                   !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    P_Width[],                   !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    P_Width[],                   !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    P_Width[],                   !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];               !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core3-Nor,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-3,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-NORTH,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    P_Width[],                   !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    P_Width[],                   !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}

BuildingSurface:Detailed,
    Int-Core3-Eas,                !- User Supplied Surface Name
    WALL,                    !- Surface Type
    Standard_Int-Wall,               !- Construction Name of the Surface
    CORE-3,                  !- InsideFaceEnvironment
    Zone,               !- OutsideFaceEnvironment
    PERIM-3-EAST,                 !- OutsideFaceEnvironment Object
    NoSun,                   !- Sun Exposure
    NoWind,                  !- Wind Exposure
    AutoCalculate,                    !- View Factor to Ground
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    #[Long_Len[]  - P_Width[]],                  !- Vertex 1 X-coordinate {m}
    P_Width[],                   !- Vertex 1 Y-coordinate {m}
    #[C_Height[] * Floors[]],                  !- Vertex 1 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 2 X-coordinate {m}
    P_Width[],                   !- Vertex 2 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 2 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 3 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 3 Y-coordinate {m}
    #[C_Height[] * #[Floors[] - 1 ]],              !- Vertex 3 Z-coordinate {m}
    #[Long_Len[]  - P_Width[]],                  !- Vertex 4 X-coordinate {m}
    #[Width_Len[]  - P_Width[]],                  !- Vertex 4 Y-coordinate {m}
    #[C_Height[] * Floors[]];                  !- Vertex 4 Z-coordinate {m}





!-   ===========  ALL OBJECTS IN CLASS: FenestrationSurface:Detailed ===========

FenestrationSurface:Detailed,
    Win-1-Nor,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per1N-Nor,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    W_Z_High[],                   !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    W_Z_Low[],                   !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    W_Z_Low[],                   !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    W_Z_High[];                   !- Vertex 4 Z-coordinate {m}

FenestrationSurface:Detailed,
    Win-1-Eas,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per1E-Eas,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    W_Z_High[],                   !- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    W_Z_Low[],                   !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    W_Z_Low[],                   !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    W_Z_High[];                   !- Vertex 4 Z-coordinate {m}

FenestrationSurface:Detailed,
    Win-1-Sou,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per1S-Sou,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    W_Z_High[],                   !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    W_Z_Low[],                   !- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    W_Z_Low[],                   !- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    W_Z_High[];                   !- Vertex 4 Z-coordinate {m}

FenestrationSurface:Detailed,
    Win-1-Wes,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per1W-Wes,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    W_Z_High[],                   !- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    W_Z_Low[],                   !- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    W_Z_Low[],                   !- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    W_Z_High[];                   !- Vertex 4 Z-coordinate {m}


##if #[Floors[] nes 2]

FenestrationSurface:Detailed,
    Win-2-Nor,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per2N-Nor,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]];!- Vertex 4 Z-coordinate {m}

FenestrationSurface:Detailed,
    Win-2-Eas,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per2E-Eas,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]];!- Vertex 4 Z-coordinate {m}

FenestrationSurface:Detailed,
    Win-2-Sou,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per2S-Sou,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]];!- Vertex 4 Z-coordinate {m}

FenestrationSurface:Detailed,
    Win-2-Wes,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per2W-Wes,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]],!- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[0.5 * #[Floors[] - 1]]]];!- Vertex 4 Z-coordinate {m}

##endif


FenestrationSurface:Detailed,
    Win-3-Nor,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per3N-Nor,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
!   CONTROL ON INCIDENT SOLAR, !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[Floors[] - 1]]];!- Vertex 4 Z-coordinate {m}

FenestrationSurface:Detailed,
    Win-3-Eas,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per3E-Eas,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    Long_Len[],                  !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 1 Z-coordinate {m}
    Long_Len[],                  !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    Width_Len[],                  !- Vertex 3 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    Width_Len[],                  !- Vertex 4 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[Floors[] - 1]]];!- Vertex 4 Z-coordinate {m}

FenestrationSurface:Detailed,
    Win-3-Sou,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per3S-Sou,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    0.000,                   !- Vertex 1 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    0.000,                   !- Vertex 2 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 2 Z-coordinate {m}
    Long_Len[],                  !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 3 Z-coordinate {m}
    Long_Len[],                  !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[Floors[] - 1]]];!- Vertex 4 Z-coordinate {m}

FenestrationSurface:Detailed,
    Win-3-Wes,                  !- User Supplied Surface Name
    WINDOW,                  !- Surface Type
##if #[Wind_Type[] eqs U_6.88_SHGC_0.34_VT_0.34]
    std_window_UValue_6.878_SHGC_0.34_VT_0.34,   !- Used for ESW windows
##elseif #[Wind_Type[] eqs U_6.88_SHGC_0.61_VT_0.61]
    std_window_UValue_6.878_SHGC_0.61_VT_0.61,   !- Used for N windows
##else #[Wind_Type[] eqs U_6.92_SHGC_0.61_VT_0.775]
    std_window_UValue_6.922_SHGC_0.61_VT_0.775,   !- Used for skylights 
##endif
    Ext-Per3W-Wes,                 !- Base Surface Name
    ,                        !- OutsideFaceEnvironment Object
    0.50,                    !- View Factor to Ground
    Wind_Shade[],            !- Name of shading control
    ,                        !- WindowFrameAndDivider Name
    1.00,                    !- Multiplier
    4,                       !- Number of Surface Vertex Groups -- Number of (X,Y,Z) groups in this surface
    0.000,                   !- Vertex 1 X-coordinate {m}
    Width_Len[],                  !- Vertex 1 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 1 Z-coordinate {m}
    0.000,                   !- Vertex 2 X-coordinate {m}
    Width_Len[],                  !- Vertex 2 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 2 Z-coordinate {m}
    0.000,                   !- Vertex 3 X-coordinate {m}
    0.000,                   !- Vertex 3 Y-coordinate {m}
    #[W_Z_Low[] + #[C_Height[] * #[Floors[] - 1]]],!- Vertex 3 Z-coordinate {m}
    0.000,                   !- Vertex 4 X-coordinate {m}
    0.000,                   !- Vertex 4 Y-coordinate {m}
    #[W_Z_High[] + #[C_Height[] * #[Floors[] - 1]]];!- Vertex 4 Z-coordinate {m}




!-   ===========  ALL OBJECTS IN CLASS: INTERNALMASS ===========

InternalMass,
    Internal-Per1N,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-1-NORTH,                  !- Interior Environment
    #[Perim-Long_Area[] * Furn_Sqm[]];         !- Surface area {m2}

InternalMass,
    Internal-Per1E,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-1-EAST,                  !- Interior Environment
    #[Perim-Width_Area[] * Furn_Sqm[]];        !- Surface area {m2}

InternalMass,
    Internal-Per1S,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-1-SOUTH,                  !- Interior Environment
    #[Perim-Long_Area[] * Furn_Sqm[]];     !- Surface area {m2}

InternalMass,
    Internal-Per1W,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-1-WEST,                  !- Interior Environment
    #[Perim-Width_Area[] * Furn_Sqm[]];    !- Surface area {m2}

InternalMass,
    Internal-Core1,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    CORE-1,                   !- Interior Environment
    #[Core_Area[] * Furn_Sqm[]];      !- Surface area {m2}


##if #[Floors[] nes 2]

InternalMass,
    Internal-Per2N,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-2-NORTH,                  !- Interior Environment
    #[Perim-Long_Area[] * Furn_Sqm[]];         !- Surface area {m2}

InternalMass,
    Internal-Per2E,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-2-EAST,                  !- Interior Environment
    #[Perim-Width_Area[] * Furn_Sqm[]];        !- Surface area {m2}

InternalMass,
    Internal-Per2S,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-2-SOUTH,                  !- Interior Environment
    #[Perim-Long_Area[] * Furn_Sqm[]];           !- Surface area {m2}

InternalMass,
    Internal-Per2W,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-2-WEST,                  !- Interior Environment
    #[Perim-Width_Area[] * Furn_Sqm[]];      !- Surface area {m2}

InternalMass,
    Internal-Core2,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    CORE-2,                   !- Interior Environment
    #[Core_Area[] * Furn_Sqm[]];      !- Surface area {m2}

##endif


InternalMass,
    Internal-Per3N,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-3-NORTH,                  !- Interior Environment
    #[Perim-Long_Area[] * Furn_Sqm[]];    !- Surface area {m2}

InternalMass,
    Internal-Per3E,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-3-EAST,                  !- Interior Environment
    #[Perim-Width_Area[] * Furn_Sqm[]];     !- Surface area {m2}

InternalMass,
    Internal-Per3S,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-3-SOUTH,                  !- Interior Environment
    #[Perim-Long_Area[] * Furn_Sqm[]];     !- Surface area {m2}

InternalMass,
    Internal-Per3W,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    PERIM-3-WEST,                  !- Interior Environment
    #[Perim-Width_Area[] * Furn_Sqm[]];         !- Surface area {m2}

InternalMass,
    Internal-Core3,            !- User Supplied Surface Name
    InteriorFurnishings,        !- Construction Name of the Surface
    CORE-3,                   !- Interior Environment
    #[Core_Area[] * Furn_Sqm[]];        !- Surface area {m2}