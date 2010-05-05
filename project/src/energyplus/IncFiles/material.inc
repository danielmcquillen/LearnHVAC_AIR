! material.inc
! Large Office

WindowMaterial:Glazing,
  Theoretical_Glass_ESW,  !- Name
  SpectralAverage,  !- Optical Data Type
  ,  !- Window Glass Spectral Data Set Name
  0.0030,  !- Thickness
  0.3267,  !- Solar Transmittance at Normal Incidence
  0.6233,  !- Front Side Solar Reflectance at Normal Incidence
  0.6233,  !- Back Side Solar Reflectance at Normal Incidence
  0.3408,  !- Visible Transmittance at Normal Incidence
  0.6092,  !- Front Side Visible Reflectance at Normal Incidence
  0.6092,  !- Back Side Visible Reflectance at Normal Incidence
  0.0000,  !- Infrared Transmittance at Normal Incidence
  0.9990,  !- Front Side Infrared Hemispherical Emissivity
  0.9990,  !- Back Side Infrared Hemispherical Emissivity
  3.3687,  !- Conductivity
  1.0000,  !- Dirt Correction Factor for Solar and Visible Transmittance
  No;  !- Solar Diffusing

WindowMaterial:Glazing,
  Theoretical_Glass_N,  !- Name
  SpectralAverage,  !- Optical Data Type
  ,  !- Window Glass Spectral Data Set Name
  0.0030,  !- Thickness
  0.5952,  !- Solar Transmittance at Normal Incidence
  0.3548,  !- Front Side Solar Reflectance at Normal Incidence
  0.3548,  !- Back Side Solar Reflectance at Normal Incidence
  0.6092,  !- Visible Transmittance at Normal Incidence
  0.3408,  !- Front Side Visible Reflectance at Normal Incidence
  0.3408,  !- Back Side Visible Reflectance at Normal Incidence
  0.0000,  !- Infrared Transmittance at Normal Incidence
  0.9990,  !- Front Side Infrared Hemispherical Emissivity
  0.9990,  !- Back Side Infrared Hemispherical Emissivity
  3.3687,  !- Conductivity
  1.0000,  !- Dirt Correction Factor for Solar and Visible Transmittance
  No;  !- Solar Diffusing

WindowMaterial:Glazing,
  Theoretical_Glass_Skylight,  !- Name
  SpectralAverage,  !- Optical Data Type
  ,  !- Window Glass Spectral Data Set Name
  0.0030,  !- Thickness
  0.5960,  !- Solar Transmittance at Normal Incidence
  0.3540,  !- Front Side Solar Reflectance at Normal Incidence
  0.3540,  !- Back Side Solar Reflectance at Normal Incidence
  0.7750,  !- Visible Transmittance at Normal Incidence
  0.1750,  !- Front Side Visible Reflectance at Normal Incidence
  0.1750,  !- Back Side Visible Reflectance at Normal Incidence
  0.0000,  !- Infrared Transmittance at Normal Incidence
  0.9990,  !- Front Side Infrared Hemispherical Emissivity
  0.9990,  !- Back Side Infrared Hemispherical Emissivity
  299.3830,  !- Conductivity
  1.0000,  !- Dirt Correction Factor for Solar and Visible Transmittance
  No;  !- Solar Diffusing

Material,
  Roof Membrane,  !- Name
  VeryRough,  !- Roughness
  0.0095,  !- Thickness
  0.1600,  !- Conductivity
  1121.2900,  !- Density
  1460.0000,  !- Specific Heat
    Roof_Abs_Thm[],          !- Absorptance:Thermal
    Roof_Abs_Slr[],          !- Absorptance:Solar
    Roof_Abs_Vsb[];          !- Absorptance:Visible

Material:NoMass,
  Roof Insulation,  !- Name
  MediumRough,  !- Roughness
  #[roof_r[] * 0.1761],  !- Thermal Resistance {(m2-K)/W}
  0.9000,  !- Thermal Absorptance
  0.75000,  !- Solar Absorptance
  0.75000;  !- Visible Absorptance

Material,
  Metal Decking,  !- Name
  MediumSmooth,  !- Roughness
  0.0015,  !- Thickness
  45.0060,  !- Conductivity
  7680.0000,  !- Density
  418.4000,  !- Specific Heat
  0.9000,  !- Thermal Absorptance
  0.7000,  !- Solar Absorptance
  0.3000;  !- Visible Absorptance

Material,
  GP01 1/2 GYPSUM,  !- Name
  Smooth,  !- Roughness
  0.0127,  !- Thickness
  0.1600,  !- Conductivity
  800.0000,  !- Density
  1090.0000,  !- Specific Heat
  0.9000,  !- Thermal Absorptance
  0.7000,  !- Solar Absorptance
  0.5000;  !- Visible Absorptance

Material,
  1IN Stucco,  !- Name
  Smooth,  !- Roughness
  0.0253,  !- Thickness
  0.6918,  !- Conductivity
  1858.0000,  !- Density
  837.0000,  !- Specific Heat
    Wall_Abs_Thm[],          !- Absorptance:Thermal
    Wall_Abs_Slr[],          !- Absorptance:Solar
    Wall_Abs_Vsb[];          !- Absorptance:Visible

Material,
  8IN Concrete HW,  !- Name
  MediumRough,  !- Roughness
  0.2033,  !- Thickness
  1.7296,  !- Conductivity
  2243.0000,  !- Density
  837.0000,  !- Specific Heat
  0.9000,  !- Thermal Absorptance
  0.6500,  !- Solar Absorptance
  0.6500;  !- Visible Absorptance

Material:NoMass,
  Wall Insulation_4,  !- Name
  MediumRough,  !- Roughness
  #[wall_r[] * 0.1761],  !- Thermal Resistance {(m2-K)/W}
  0.9000,  !- Thermal Absorptance
  0.75000,  !- Solar Absorptance
  0.75000;  !- Visible Absorptance

Material,
  1/2IN Gypsum,  !- Name
  Smooth,  !- Roughness
  0.0127,  !- Thickness
  0.1600,  !- Conductivity
  784.9000,  !- Density
  830.0000,  !- Specific Heat
  0.9000,  !- Thermal Absorptance
  0.9200,  !- Solar Absorptance
  0.9200;  !- Visible Absorptance

Material,
  MAT-CC05 4 HW CONCRETE,  !- Name
  Rough,  !- Roughness
  0.1016,  !- Thickness
  1.3110,  !- Conductivity
  2240.0000,  !- Density
  836.8000,  !- Specific Heat
  0.9000,  !- Thermal Absorptance
  0.7000,  !- Solar Absorptance
  0.7000;  !- Visible Absorptance

Material:NoMass,
  CP02 CARPET PAD,  !- Name
  VeryRough,  !- Roughness
  0.2165,  !- Thermal Resistance {(m2-K)/W}
  0.9000,  !- Thermal Absorptance
  0.7000,  !- Solar Absorptance
  0.8000;  !- Visible Absorptance

Material,
  Floor Insulation_1,  !- Name
  MediumRough,  !- Roughness
  0.0464,  !- Thickness
  0.0450,  !- Conductivity
  265.0000,  !- Density
  836.8000,  !- Specific Heat
  0.9000,  !- Thermal Absorptance
  0.7000,  !- Solar Absorptance
  0.7000;  !- Visible Absorptance

Material,
  MAT-CC05 8 HW CONCRETE,  !- Name
  Rough,  !- Roughness
  0.2032,  !- Thickness
  1.3110,  !- Conductivity
  2240.0000,  !- Density
  836.8000,  !- Specific Heat
  0.9000,  !- Thermal Absorptance
  0.7000,  !- Solar Absorptance
  0.7000;  !- Visible Absorptance

Material,
  METAL Door Medium 18Ga_1,  !- Name
  Smooth,  !- Roughness
  0.0013,  !- Thickness
  45.3149,  !- Conductivity
  7833.0300,  !- Density
  502.0800,  !- Specific Heat
  0.8000,  !- Thermal Absorptance
  0.5000,  !- Solar Absorptance
  0.5000;  !- Visible Absorptance

Material:NoMass,
  AIR,  !- Name
  Smooth,  !- Roughness
  0.2515,  !- Thermal Resistance {(m2-K)/W}
  0.8000,  !- Thermal Absorptance
  0.5000,  !- Solar Absorptance
  0.5000;  !- Visible Absorptance

Material,
  METAL Door Medium 18Ga_2,  !- Name
  Smooth,  !- Roughness
  0.0013,  !- Thickness
  45.3149,  !- Conductivity
  7833.0300,  !- Density
  502.0800,  !- Specific Heat
  0.8000,  !- Thermal Absorptance
  0.5000,  !- Solar Absorptance
  0.5000;  !- Visible Absorptance

Material:NoMass,
  AIR_1,  !- Name
  Smooth,  !- Roughness
  0.1214,  !- Thermal Resistance {(m2-K)/W}
  0.8000,  !- Thermal Absorptance
  0.5000,  !- Solar Absorptance
  0.5000;  !- Visible Absorptance

 
 
  Material,
    Std Wood 6inch,          !- Name
    MediumSmooth,            !- Roughness
    0.15,                    !- Thickness {m}
    0.12,                    !- Conductivity {W/m-K}
    540.0000,                !- Density {kg/m3}
    1210,                    !- Specific Heat {J/kg-K}
    0.9000000,               !- Thermal Absorptance
    0.7000000,               !- Solar Absorptance
    0.7000000;               !- Visible Absorptance
 
  Material,
    Std 1.5  MW CONCRETE,    !- Name
    Rough,                   !- Roughness
    0.038,                   !- Thickness {m}
    0.858,                   !- Conductivity {W/m-K}
    1968,                    !- Density {kg/m3}
    836.8,                   !- Specific Heat {J/kg-K}
    0.9,                     !- Thermal Absorptance
    0.7,                     !- Solar Absorptance
    0.7;                     !- Visible Absorptance
 
  Material,
    Std AC02,                !- Name
    MediumSmooth,            !- Roughness
    1.2700000E-02,           !- Thickness {m}
    5.7000000E-02,           !- Conductivity {W/m-K}
    288.0000,                !- Density {kg/m3}
    1339.000,                !- Specific Heat {J/kg-K}
    0.9000000,               !- Thermal Absorptance
    0.7000000,               !- Solar Absorptance
    0.2000000;               !- Visible Absorptance
 
  Material:NoMass,
    Std CP02 CARPET PAD,     !- Name
    VeryRough,               !- Roughness
    0.21648,                 !- Thermal Resistance {m2-K/W}
    0.9,                     !- Thermal Absorptance
    0.7,                     !- Solar Absorptance
    0.8;                     !- Visible Absorptance
 
  Material,
    Std MAT-CC05 4  MW CONCRETE,  !- Name
    Rough,                   !- Roughness
    0.1000,                  !- Thickness {m}
    0.858,                   !- Conductivity {W/m-K}
    1968,                    !- Density {kg/m3}
    836.8,                   !- Specific Heat {J/kg-K}
    0.9,                     !- Thermal Absorptance
    0.7,                     !- Solar Absorptance
    0.2;                     !- Visible Absorptance
 
  Material,
    Std Very High Reflectivity Surface,  !- Name
    Smooth,                  !- Roughness
    0.0005,                  !- Thickness {m}
    237,                     !- Conductivity {W/m-K}
    2702,                    !- Density {kg/m3}
    903,                     !- Specific Heat {J/kg-K}
    0.90,                    !- Thermal Absorptance
    0.05,                    !- Solar Absorptance
    0.05;                    !- Visible Absorptance
 
  WindowMaterial:Glazing,
    Std Clear Acrylic Plastic,  !- Name
    SpectralAverage,         !- Optical Data Type
    ,                        !- Window Glass Spectral Data Set Name
    0.003,                   !- Thickness {m}
    0.92,                    !- Solar Transmittance at Normal Incidence
    0.05,                    !- Front Side Solar Reflectance at Normal Incidence
    0.05,                    !- Back Side Solar Reflectance at Normal Incidence
    0.92,                    !- Visible Transmittance at Normal Incidence
    0.05,                    !- Front Side Visible Reflectance at Normal Incidence
    0.05,                    !- Back Side Visible Reflectance at Normal Incidence
    0.00,                    !- Infrared Transmittance at Normal Incidence
    0.90,                    !- Front Side Infrared Hemispherical Emissivity
    0.90,                    !- Back Side Infrared Hemispherical Emissivity
    0.90;                    !- Conductivity {W/m-K}
 
  WindowMaterial:Glazing,
    Std Diffusing Acrylic Plastic,  !- Name
    SpectralAverage,         !- Optical Data Type
    ,                        !- Window Glass Spectral Data Set Name
    0.0022,                  !- Thickness {m}
    0.90,                    !- Solar Transmittance at Normal Incidence
    0.08,                    !- Front Side Solar Reflectance at Normal Incidence
    0.08,                    !- Back Side Solar Reflectance at Normal Incidence
    0.90,                    !- Visible Transmittance at Normal Incidence
    0.08,                    !- Front Side Visible Reflectance at Normal Incidence
    0.08,                    !- Back Side Visible Reflectance at Normal Incidence
    0.00,                    !- Infrared Transmittance at Normal Incidence
    0.90,                    !- Front Side Infrared Hemispherical Emissivity
    0.90,                    !- Back Side Infrared Hemispherical Emissivity
    0.90;                    !- Conductivity {W/m-K}
 
  Material,
    Std PW05,                !- Name
    MediumSmooth,            !- Roughness
    1.9099999E-02,           !- Thickness {m}
    0.1150000,               !- Conductivity {W/m-K}
    545.0000,                !- Density {kg/m3}
    1213.000,                !- Specific Heat {J/kg-K}
    0.9000000,               !- Thermal Absorptance
    0.7800000,               !- Solar Absorptance
    0.7800000;               !- Visible Absorptance
 
  Material,
    Std Steel_Brown_Regular, !- Name
    Smooth,                  !- Roughness
    1.5000000E-03,           !- Thickness {m}
    44.96960,                !- Conductivity {W/m-K}
    7689.000,                !- Density {kg/m3}
    418.0000,                !- Specific Heat {J/kg-K}
    0.9000000,               !- Thermal Absorptance
    0.9200000,               !- Solar Absorptance
    0.92000000;              !- Visible Absorptance
 
  Material,
    Std Steel_Brown_Cool,    !- Name
    Smooth,                  !- Roughness
    1.5000000E-03,           !- Thickness {m}
    44.96960,                !- Conductivity {W/m-K}
    7689.000,                !- Density {kg/m3}
    418.0000,                !- Specific Heat {J/kg-K}
    0.9000000,               !- Thermal Absorptance
    0.7300000,               !- Solar Absorptance
    0.73000000;              !- Visible Absorptance
    
  Material,
    PW05_Plywood3/4_in,  !- Name
    MediumSmooth,  !- Roughness
    0.0191,  !- Thickness
    0.1150,  !- Conductivity
    545.0000,  !- Density
    1213.0000,  !- Specific Heat
    0.9000,  !- Thermal Absorptance
    0.7000,  !- Solar Absorptance
    0.7800;  !- Visible Absorptance   
 
  Material:NoMass,
    MAT-AIR-WALL,            !- Name
    Rough,                   !- Roughness
    0.2079491,               !- Thermal Resistance {m2-K/W}
    0.9,                     !- Thermal Absorptance
    0.7;                     !- Solar Absorptance
 
  Material:NoMass,
    Std Opaque Door panel_con,  !- Name
    MediumRough,             !- Roughness
    0.12327,                 !- Thermal Resistance {m2-K/W}
    0.9,                     !- Thermal Absorptance
    0.7,                     !- Solar Absorptance
    0.7;                     !- Visible Absorptance
 
  Material:NoMass,
    Std Opaque Door panel_semi,  !- Name
    MediumRough,             !- Roughness
    0.12327,                 !- Thermal Resistance {m2-K/W}
    0.9,                     !- Thermal Absorptance
    0.7,                     !- Solar Absorptance
    0.7;                     !- Visible Absorptance
 
  Material:NoMass,
    Std Overhead Door Panel, !- Name
    MediumRough,             !- Roughness
    0.255345,                !- Thermal Resistance {m2-K/W}
    0.9,                     !- Thermal Absorptance
    0.7,                     !- Solar Absorptance
    0.7;                     !- Visible Absorptance