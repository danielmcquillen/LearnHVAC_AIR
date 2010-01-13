/////////////////////////////////////////////////////////////////////////////////////////
/// \file  hvactk.h 
/// \brief Declaration of constants used in the HVAC toolkit
///
/////////////////////////////////////////////////////////////////////////////////////////
///
/// \attention
/// PORTIONS COPYRIGHT (C) 2003 AYRES SOWELL ASSOCIATES, INC. \n
/// PORTIONS COPYRIGHT (C) 2003 THE REGENTS OF THE UNIVERSITY OF CALIFORNIA .
///   PENDING APPROVAL BY THE US DEPARTMENT OF ENERGY. ALL RIGHTS RESERVED.
///
/////////////////////////////////////////////////////////////////////////////////////////


#if !defined(__HVACTK_H__)
#define __HVACTK_H__


/////////////////////////////////////////////////////////////////////////////////////////
/// \name Mathematical constants
//@{
const double SMALL = 1.0e-23;                  ///< considered a very small number
const double LARGE = 1.0e+23;                  ///< considered a very large number
//@}
/////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////
/// \name Constants used to identify flow arrangement in heat exchangers
//@{
const unsigned COUNTER_FLOW            = 1; ///< counter flow
const unsigned PARALLEL_FLOW           = 2; ///< parallel flow
const unsigned CROSS_FLOW_BOTH_UNMIXED = 3; ///< cross flow, both unmixed
const unsigned CROSS_FLOW_BOTH_MIXED   = 4; ///< cross flow, both mixed
const unsigned CROSS_FLOW_1_UNMIXED    = 5; ///< cross flow, first stream unmixed
const unsigned CROSS_FLOW_2_UNMIXED    = 6; ///< cross flow, second stream unmixed
//@}
/////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////
/// \name Physical constants
//@{
const double ABS_ZERO    = -273.16;   ///< absolute zero temperature in [deg_C]
const double KELV_ZERO   = 273.16;    ///< 0 [deg_C] in [K]
const double BOLTZ       = 5.67E-8;   ///< Stefan-Boltzmann constant [W/(m^2*K^4)]
const double CP_AIR      = 1006.0;    ///< specific heat capacity of dry air [J/(kg*K)]
const double MW_AIR      = 28.9645;   ///< molar weight of dry air [g/mol]
const double CP_VAP      = 1805.0;    ///< specific heat capacity of water vapor [J/(kg*K)]
const double CP_WAT      = 4186.0;    ///< specific heat capacity of liquid water [J/(kg*K)]
const double MW_WATER    = 18.01528;  ///< molar weight of liquid water [g/mol]
const double MW_RATIO    = 0.62197;   ///< ratio of molar weights of liquid water over dry air [-]

const double HF_VAP      = 2.501E6;   ///< latent heat of vaporization of water [J/kg]
const double LAMBDA_AIR  = 0.0243;    ///< thermal conductivity of dry air [W/(m*K)]
const double LAMBDA_WAT  = 0.554;     ///< thermal conductivity of liquid water [W/(m*K)]

const double PRANDTL_AIR = 0.71;      ///< Prandtl number for dry air [-]
const double RHO_AIR     = 1.2;       ///< density of air [kg/m^3]
const double RHO_WAT     = 998.0;     ///< density of water [kg/m^3]
const double VISC_WAT    = 1.0E-3;    ///< dynamic viscosity for liquid water [kg/(m*s)]

const double R_AIR       = 287.053;   ///< specific gas constant for ideal air [J/(kg*K)]
const double R_0         = 8314.34;   ///< universal gas constant [kJ/(mol*K)]
const double P_ATM       = 101325.0;  ///< atmospheric pressure in [kg/(m*s^2)] or [Pa]
//@}
/////////////////////////////////////////////////////////////////////////////////////////

#endif //__HVACTK_H__



