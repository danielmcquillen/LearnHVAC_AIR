/// \file    hvactk2.h
/// \brief Functions that are needed for %SPARK hvactk2 class implementation.
///


#if !defined(__HVACTK2_H__)
#define __HVACTK2_H__

#include <cmath>


/// \namespace SPARK::hvactk2
/// \brief Definition of functions and constants used throughout the library.
namespace SPARK { namespace hvactk2 {


    /////////////////////////////////////////////////////////////////////////////////////////
    /// \name Mathematical constants
    //@{
    /// \brief Considered a very small number internally.
    const double SMALL = 1.0e-15;
    /// \brief Considered a very large number internally.
    const double LARGE = 1.0e+15;
    //@}
    /////////////////////////////////////////////////////////////////////////////////////////


    /////////////////////////////////////////////////////////////////////////////////////////
    /// \name Constants used to identify mode of operation
    //@{
    const unsigned MODE_OFF            = 0; ///< off mode
    const unsigned MODE_WET            = 1; ///< wet mode
    const unsigned MODE_DRYWET         = 2; ///< partially dry, partially wet mode
    const unsigned MODE_DRY            = 3; ///< dry mode
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

    
    /////////////////////////////////////////////////////////////////////////////////////////
    /// \name Helper functions for efficiency calculation
    //@{
    /// \brief Formula for efficiency when cRatio is small
    inline double eff_inf(double ntu)
    {
        return 1.0-exp(-ntu);
    }
    /// \brief  Formula (4-9) 
    inline double effcMinUnmixed(double ntu, double cRatio)
    {
        return (1.0-exp(-cRatio*(1.0-exp(-ntu))))/cRatio;
    }
    /// \brief  Formula (4-10)
    inline double effcMaxUnmixed(double ntu, double cRatio)
    {
        return 1.0-exp(-(1.0-exp(-ntu*cRatio))/cRatio);
    }
    /// \brief Formula for efficiency calculation for counterflow configuration.
    inline double eff_ctr(double ntu, double cRatio)
    {
        double eff;
        if (fabs(cRatio - 1.0) <= SMALL)
            eff = ntu/(ntu+1.0);
        else 
            eff = (1.0-exp(-ntu*(1.0 - cRatio))) /
                  (1.0-cRatio*exp(-ntu*(1.0 - cRatio)));
        return eff;
    }
    /// \brief Formula efficiency for parallel flow configuration.
    inline double eff_prl(double ntu, double cRatio)
    {
        double eta = (1.0+cRatio);
        return (1.0 - exp(-ntu*eta)) / eta;
    }
    /// \brief Formula efficiency for counterflow, both streams unmixed configuration.
    inline double eff_cbu(double ntu, double cRatio)
    {
        double eta = pow(ntu,-0.22);
        return 1.0 - exp((exp(-ntu*cRatio*eta)-1)/(cRatio*eta));
    }
    /// \brief Formula efficiency for counterflow, both streams mixed configuration.
    inline double eff_cbm(double ntu, double cRatio)
    {
        return 1.0/((1.0/(1.0-exp(-ntu)))+ (cRatio/(1.0-exp(-ntu*cRatio)))- (1.0/(ntu)));
    }
    //@}
    /////////////////////////////////////////////////////////////////////////////////////////
    
    
    /////////////////////////////////////////////////////////////////////////////////////////
    /// \name Helper functions for moist air enthalpy calculation
    /// 
    /// See p. 7-7 in ASHRAE HVACTK 2.
    ///
    //@{
   /// \brief Formula for enthalpy as a function of dry bulb temperature and humidity ratio
    inline double enth(double TDb, double w)
    {
        return (CP_AIR*TDb + (HF_VAP + CP_VAP*TDb)*w);
    }
    /// \brief Formula for dry bulb temperature as a function of enthalpy and humidity ratio
    inline double drybulb(double w, double h)
    {
        return (h - HF_VAP*w)/(CP_AIR + CP_VAP*w);
    }
    
    /// \brief Formula for humidity ratio as a function of enthalpy and dry bulb temperature
    inline double humth(double TDb, double h)
    {
        return (h - CP_AIR*TDb)/(HF_VAP + CP_VAP*TDb);
    }
    //@}
    /////////////////////////////////////////////////////////////////////////////////////////


}; };  // namespace SPARK::hvactk2

#endif //__HVACTK2_H__

