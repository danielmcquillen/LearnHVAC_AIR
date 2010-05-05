! Construction.inc
!
Construction,
    InteriorFurnishings,     !- Name
    Std Wood 6inch;          !- Outside Layer
 
  ComponentCost:LineItem,
    Interior Furnishings,    !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    InteriorFurnishings,     !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 
  Construction,
    INT-FLOOR-TOPSIDE,       !- Name
    Std MAT-CC05 4  MW CONCRETE,  !- Outside Layer
    Std CP02 CARPET PAD;     !- Layer 2
 
  Construction,
    INT-FLOOR-UNDERSIDE,     !- Name
    Std CP02 CARPET PAD,     !- Outside Layer
    Std MAT-CC05 4  MW CONCRETE;  !- Layer 2
 
  ComponentCost:LineItem,
    Interior Floor,          !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    INT-FLOOR-UNDERSIDE,     !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    15,                      !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 
  Construction,
    INT-FLOOR-SLAB,          !- Name
    Std MAT-CC05 4  MW CONCRETE;  !- Outside Layer
 
  ComponentCost:LineItem,
    Interior Floor Slab,     !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    INT-FLOOR-SLAB,          !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    35,                      !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 
  Construction,
    DropCeiling,             !- Name
    Std AC02;                !- Outside Layer
 
  ComponentCost:LineItem,
    Drop Ceiling,            !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    DropCeiling,             !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    10,                      !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 
  Construction,
    INT-CEILING_SIMPLE,  !- Name
    PW05_Plywood3/4_in;  !- Layer 1
  
  Construction,
    Raised-Floor-TopSide,    !- Name
    Std 1.5  MW CONCRETE,    !- Outside Layer
    Std CP02 CARPET PAD;     !- Layer 2
 
  Construction,
    Raised-Floor-UnderSide,  !- Name
    Std CP02 CARPET PAD,     !- Outside Layer
    Std 1.5  MW CONCRETE;    !- Layer 2
 
  Construction,
    TDD_Pipe,                !- Name
    Std Very High Reflectivity Surface;  !- Outside Layer
 
  Construction,
    TDD_Dome,                !- Name
    Std Clear Acrylic Plastic;  !- Outside Layer
 
  Construction,
    TDD_Diffuser,            !- Name
    Std Diffusing Acrylic Plastic;  !- Outside Layer
 
  Construction,
    Sloped_Metal_Roof,       !- Name
    Std Steel_Brown_Regular, !- Outside Layer
    Std PW05;                !- Layer 2
 
  ComponentCost:LineItem,
    Sloped Metal Roof,       !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    Sloped_Metal_Roof,       !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 
  Construction,
    Gable_Wall,              !- Name
    Std PW05;                !- Outside Layer
 
  ComponentCost:LineItem,
    Gable Wall,              !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    Gable_Wall,              !- Item Name
     ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 
  Construction,
    AIR-WALL,                !- Name
    MAT-AIR-WALL;            !- Outside Layer
 
  ComponentCost:LineItem,
    Air Wall,                !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    AIR-WALL,                !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 
  Construction,
    Std Swinging Door_con,   !- Name
    Std Opaque Door panel_con;  !- Outside Layer
 
  ComponentCost:LineItem,
    Swinging Door Conditioned,  !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    Std Swinging Door_con,   !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 
  Construction,
    Std Swinging Door_semi,  !- Name
    Std Opaque Door panel_semi;  !- Outside Layer
 
  ComponentCost:LineItem,
    Swinging Door Semi-conditioned,  !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    Std Swinging Door_semi,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 
  Construction,
    Std Overhead Door,       !- Name
    Std Overhead Door Panel; !- Outside Layer
 
  ComponentCost:LineItem,
    Overhead Door,           !- Name
    ,                        !- Type
    Construction,            !- Line Item Type
    Std Overhead Door,       !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
 

Construction,
  std_window_UValue_6.878_SHGC_0.34_VT_0.34,  !- Name
  Theoretical_Glass_ESW;  !- Layer 1

ComponentCost:LineItem,
  south:std_window_UValue_6.878_SHGC_0.34_VT_0.34,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  std_window_UValue_6.878_SHGC_0.34_VT_0.34,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    181.1070,                !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  std_window_UValue_6.878_SHGC_0.34_VT_0.34_east,  !- Name
  Theoretical_Glass_ESW;  !- Layer 1

ComponentCost:LineItem,
  east:std_window_UValue_6.878_SHGC_0.34_VT_0.34_east,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  std_window_UValue_6.878_SHGC_0.34_VT_0.34_east,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    181.1070,                !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  std_window_UValue_6.878_SHGC_0.61_VT_0.61,  !- Name
  Theoretical_Glass_N;  !- Layer 1

ComponentCost:LineItem,
  north:std_window_UValue_6.878_SHGC_0.61_VT_0.61,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  std_window_UValue_6.878_SHGC_0.61_VT_0.61,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    142.1560,                !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  std_window_UValue_6.878_SHGC_0.34_VT_0.34_west,  !- Name
  Theoretical_Glass_ESW;  !- Layer 1

ComponentCost:LineItem,
  west:std_window_UValue_6.878_SHGC_0.34_VT_0.34_west,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  std_window_UValue_6.878_SHGC_0.34_VT_0.34_west,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    181.1070,                !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  std_window_UValue_6.922_SHGC_0.61_VT_0.775,  !- Name
  Theoretical_Glass_Skylight;  !- Layer 1

ComponentCost:LineItem,
  SkylightConst:std_window_UValue_6.922_SHGC_0.61_VT_0.775,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  std_window_UValue_6.922_SHGC_0.61_VT_0.775,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    166.6890,                !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  IEAD_R-15 ci_Roof,  !- Name
  Roof Membrane,  !- Layer 1
  Roof Insulation,  !- Layer 2
  Metal Decking;  !- Layer 3

ComponentCost:LineItem,
  roofs:IEAD_R-15 ci_Roof,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  IEAD_R-15 ci_Roof,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    34.3904,                 !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  Standard_Int-Wall,  !- Name
  GP01 1/2 GYPSUM,  !- Layer 1
  GP01 1/2 GYPSUM;  !- Layer 2

ComponentCost:LineItem,
  int-walls:Standard_Int-Wall,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  Standard_Int-Wall,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  Mass_R-5.7 ci_Ext-wall,  !- Name
  1IN Stucco,  !- Layer 1
  8IN Concrete HW,  !- Layer 2
  Wall Insulation_4,  !- Layer 3
  1/2IN Gypsum;  !- Layer 4

ComponentCost:LineItem,
  ext-walls:Mass_R-5.7 ci_Ext-wall,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  Mass_R-5.7 ci_Ext-wall,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    41.1612,                 !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  Unheated - 4in Slab with Carpet_Ext-slab,  !- Name
  MAT-CC05 4 HW CONCRETE,  !- Layer 1
  CP02 CARPET PAD;  !- Layer 2

ComponentCost:LineItem,
  ext-slab:Unheated - 4in Slab with Carpet_Ext-slab,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  Unheated - 4in Slab with Carpet_Ext-slab,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    24.68,                   !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  Mass_R-6.3 ci_ExposedFloor,  !- Name
  Floor Insulation_1,  !- Layer 1
  MAT-CC05 8 HW CONCRETE,  !- Layer 2
  CP02 CARPET PAD;  !- Layer 3

ComponentCost:LineItem,
  exposed-floor:Mass_R-6.3 ci_ExposedFloor,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  Mass_R-6.3 ci_ExposedFloor,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    32.9966,                 !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  Swinging_NR_door,  !- Name
  METAL Door Medium 18Ga_1,  !- Layer 1
  AIR,  !- Layer 2
  METAL Door Medium 18Ga_2;  !- Layer 3

ComponentCost:LineItem,
  door:Swinging_NR_door,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  Swinging_NR_door,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future

Construction,
  Non-Swinging_NR_door,  !- Name
  METAL Door Medium 18Ga_1,  !- Layer 1
  AIR_1,  !- Layer 2
  METAL Door Medium 18Ga_2;  !- Layer 3

ComponentCost:LineItem,
  non-swinging-door:Non-Swinging_NR_door,  !- Name of Cost Estimate
  ,  !- Type  [Not Used]
  Construction,  !- Line Item Type
  Non-Swinging_NR_door,  !- Item Name
    ,                        !- Object End Use Key
    ,                        !- Cost per Each {$}
    1,                       !- Cost per Area {$/m2}
    ,                        !- Cost per Unit of Output Capacity {$/kW}
    ,                        !- Cost per Unit of Output Capacity per COP {$/kW}
    ,,,,,,,,,,;              !reserved for future
