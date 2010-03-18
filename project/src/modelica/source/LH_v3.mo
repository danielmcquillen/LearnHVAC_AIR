within ;
package LH_v3 "this version gets the input variables from Flex."
  model Room "Model of thermal zone"
  replaceable package MediumA = Buildings.Media.IdealGases.SimpleAir;
      // Port definitions
    parameter Integer nPorts=0 "Number of ports" 
      annotation(Evaluate=true, Dialog(__Dymola_connectorSizing=true, tab="General",group="Ports"));
    parameter Modelica.SIunits.Volume VRoo = 2000 "Room volume";
    parameter Modelica.SIunits.ThermalConductance UA=100 "UA value of room";

    Buildings.Fluid.MixingVolumes.MixingVolume vol(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      use_HeatTransfer=true,
      redeclare model HeatTransfer = 
          Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
      redeclare package Medium = MediumA,
      V=VRoo,
      nPorts=nPorts,
      p_start=100000,
      T_start=293.15) "Room volume" 
      annotation (Placement(transformation(extent={{-14,24},{6,44}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G=UA)
      "Wall heat conduction" 
      annotation (Placement(transformation(extent={{38,10},{58,30}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut
      "Outside air temperature" 
      annotation (Placement(transformation(extent={{92,10},{72,30}})));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}),
                           graphics), Icon(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Rectangle(
            extent={{-60,60},{60,-80}},
            lineColor={135,135,135},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid), Text(
            extent={{-64,100},{72,66}},
            lineColor={0,0,255},
            textString="%name")}));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSen
      "Air temperature sensor" 
      annotation (Placement(transformation(extent={{22,42},{42,62}})));
    Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[
                             nPorts](redeclare each package Medium = MediumA)
      "Fluid inlets and outlets" 
      annotation (Placement(transformation(extent={{-40,-10},{40,10}},
        origin={0,-100})));
    Modelica.Blocks.Interfaces.RealOutput TRoo "Room air temperature" 
      annotation (Placement(transformation(extent={{100,42},{120,62}})));
    Modelica.Blocks.Interfaces.RealInput TAmb(start=273.15)
      "Outside air temperature" 
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow Qsen(Q_flow=Q_sen_d)
      "internal sensible heat gain" 
      annotation (Placement(transformation(extent={{-66,48},{-46,68}})));
    inner Modelica.Fluid.System system 
      annotation (Placement(transformation(extent={{-96,-96},{-76,-76}})));
    parameter Modelica.SIunits.HeatFlowRate Q_sen_d=4000
      "Fixed heat flow rate at port";
  equation

    connect(TOut.port, theCon.port_b) annotation (Line(
        points={{72,20},{58,20}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(theCon.port_a, vol.heatPort) annotation (Line(
        points={{38,20},{-14,20},{-14,34}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(temSen.port, vol.heatPort) annotation (Line(
        points={{22,52},{-14,52},{-14,34}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(temSen.T, TRoo) annotation (Line(
        points={{42,52},{110,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(TOut.T, TAmb) annotation (Line(
        points={{94,20},{100,20},{100,0},{-120,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(vol.ports, ports) annotation (Line(
        points={{-4,24},{-4,-100},{0,-100}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Qsen.port, vol.heatPort) annotation (Line(
        points={{-46,58},{-30,58},{-30,34},{-14,34}},
        color={191,0,0},
        smooth=Smooth.None));
  end Room;
  annotation (uses(Modelica(version="3.1"), Buildings(version="0.8.0")));
  model HVAC_v3

    inner Modelica.Fluid.System system 
      annotation (Placement(transformation(extent={{-88,-90},{-68,-70}})));
    //replaceable package MediumA = Buildings.Media.IdealGases.SimpleAir;
    replaceable package MediumA = Buildings.Media.GasesPTDecoupled.SimpleAir;
    //replaceable package MediumA = Buildings.Media.GasesPTDecoupled.MoistAir;
    replaceable package MediumB = Buildings.Media.ConstantPropertyLiquidWater;
    parameter Modelica.SIunits.Volume VRoo=800 "Room volume";
    parameter Modelica.SIunits.ThermalConductance UA=200 "UA value of room" annotation(Evaluate=false);
    parameter Modelica.SIunits.HeatFlowRate Q_sen_d=8000
      "Fixed heat flow rate at port" annotation(Evaluate=false);
    Buildings.Fluid.Actuators.Dampers.VAVBoxExponential VAV(redeclare package
        Medium = MediumA,
      use_v_nominal=true,
      dp_nominal=P_vd,
      A=0.5556,
      allowFlowReversal=false,
      m_flow_nominal=m_a_cc_d,
      v_nominal=3.6) "VAV box serving the single zone" 
      annotation (Placement(transformation(extent={{378,156},{398,176}})));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{600,400}}),
                           graphics), Icon(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{600,400}})));
    parameter Modelica.SIunits.Pressure P_vd = 3;
    parameter Modelica.SIunits.SpecificHeatCapacity cp_a=1005;
    parameter Modelica.SIunits.SpecificHeatCapacity cp_w=4200;
    Buildings.Fluid.Movers.FlowMachine_y SupF(
      redeclare package Medium = MediumA,
      use_y_in=true,
      V=0.5,
      redeclare function flowCharacteristic = 
          Buildings.Fluid.Movers.BaseClasses.Characteristics.quadraticFlow (
            V_flow_nominal={0.8*V_fan_d,V_fan_d,1.2*V_fan_d}, dp_nominal={1.173
              *dp_fan_d,460.8,0.838*dp_fan_d}),
      redeclare function efficiencyCharacteristic = 
          Buildings.Fluid.Movers.BaseClasses.Characteristics.constantEfficiency
          (eta_nominal=0.65)) "Supply air fan" 
      annotation (Placement(transformation(extent={{296,155},{310,169}})));

    Modelica.Fluid.Sources.MassFlowSource_T Boi(
      redeclare package Medium = MediumB,
      use_m_flow_in=true,
      T=T_ew_hc_d,
      nPorts=1) "Boiler" 
      annotation (Placement(transformation(extent={{-9,-9.5},{9,9.5}},
          rotation=90,
          origin={221,129.5})));

    OAMixingBoxMinimumDamper Econ(                                  redeclare
        package Medium = MediumA,
      allowFlowReversal=false,
      m0OutMin_flow=0.1*m_a_cc_d,
      m0Out_flow=m_a_cc_d,
      m0Rec_flow=m_a_cc_d,
      m0Exh_flow=m_a_cc_d,
      dpOutMin_nominal(displayUnit="Pa") = 42,
      dpOut_nominal(displayUnit="Pa") = 42,
      dpRec_nominal(displayUnit="Pa") = 42,
      dpExh_nominal(displayUnit="Pa") = 42,
      AOutMin=0.03,
      AOut=0.33,
      AExh=0.33,
      ARec=0.33) "AHU economizer" 
      annotation (Placement(transformation(extent={{90,148},{116,176}})));
    Buildings.Fluid.Sources.Boundary_pT Amb(
      redeclare package Medium = MediumA,
      nPorts=3,
      use_p_in=false,
      use_T_in=true) "ambient condition" 
      annotation (Placement(transformation(extent={{36,150},{58,172}})));
    Buildings.Fluid.FixedResistances.FixedResistanceDpM filter(redeclare
        package Medium = 
                 MediumA,
      dp_nominal=dp_fil_d,
      allowFlowReversal=false,
      m_flow_nominal=m_a_cc_d) 
      annotation (Placement(transformation(extent={{162,158},{182,178}})));
    Buildings.Fluid.HeatExchangers.HeaterCoolerPrescribed RHC(redeclare package
        Medium = MediumA,
      Q_flow_nominal=Q_rhc_d,
      dp_nominal=dp_rhc_d,
      allowFlowReversal=false,
      m_flow_nominal=m_a_cc_d) "VAV Box reheat coil" 
      annotation (Placement(transformation(extent={{466,158},{486,178}})));
    Buildings.Fluid.Sensors.Temperature Tmix(redeclare package Medium = MediumA)
      "Mixed air temperature" 
      annotation (Placement(transformation(extent={{92,186},{112,206}})));
    Buildings.Fluid.Sensors.Temperature Tsa(redeclare package Medium = MediumA)
      "supplied air temperature" 
      annotation (Placement(transformation(extent={{320,126},{340,146}})));
    Buildings.Fluid.Sensors.Pressure pressure(redeclare package Medium = MediumA) 
      annotation (Placement(transformation(extent={{316,178},{336,198}})));
    parameter Modelica.SIunits.HeatFlowRate Q_rhc_d=20000
      "Heat flow rate at u=1, positive for heating";
    parameter Modelica.SIunits.Pressure dp_rhc_d=87 "Pressure";
    parameter Modelica.SIunits.Pressure dp_fil_d=100
      "filter design pressure drop";
    parameter Modelica.SIunits.VolumeFlowRate V_fan_d=2
      "supply air fan design volume flow rate";
    parameter Modelica.SIunits.Pressure dp_fan_d=461
      "design supply air fan head";
    Modelica.Blocks.Math.Gain gain(k=m_a_hc_d) 
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={214,68})));
    Buildings.Fluid.Sources.Boundary_pT Amb1(
      use_p_in=false,
      redeclare package Medium = MediumB,
      use_T_in=false,
      nPorts=1,
      p=100000) "ambient condition" 
      annotation (Placement(transformation(extent={{162,94},{184,116}})));
    Buildings.Fluid.Sources.Boundary_pT Amb2(
      use_p_in=false,
      redeclare package Medium = MediumB,
      use_T_in=false,
      nPorts=1,
      p=100000) "ambient condition" 
      annotation (Placement(transformation(extent={{-11,-11},{11,11}},
          rotation=90,
          origin={251,131})));
    Modelica.Fluid.Sources.MassFlowSource_T chiller(
      redeclare package Medium = MediumB,
      use_m_flow_in=true,
      T=T_ew_cc_d,
      nPorts=1) "simple chiller model" 
      annotation (Placement(transformation(extent={{-9,-9.5},{9,9.5}},
          rotation=90,
          origin={297,123.5})));
    Modelica.Blocks.Math.Gain gain1(k=m_w_cc_d) 
      annotation (Placement(transformation(extent={{300,60},{320,80}})));
    Buildings.Fluid.Delays.DelayFirstOrder del(
      nPorts=3,
      redeclare package Medium = MediumA,
      tau=20,
      m_flow_nominal=m_a_cc_d) 
      annotation (Placement(transformation(extent={{136,168},{156,188}})));

    Room room(
      nPorts=2,
      redeclare package MediumA = MediumA,
      VRoo=VRoo,
      UA=UA,
      Q_sen_d=Q_sen_d) 
      annotation (Placement(transformation(extent={{542,198},{578,234}})));
    parameter Modelica.SIunits.MassFlowRate m_a_cc_d=2.31
      "Q_cc_d/cp_a/12.7cooling coil air side nominal mass flow rate";
    parameter Modelica.SIunits.MassFlowRate m_a_hc_d=2.31
      "heating coil air side nominal mass flow rate";
    parameter Modelica.SIunits.MassFlowRate m_w_cc_d=1.257
      "Nominal mass flow rate";
    parameter Modelica.SIunits.Temperature T_ea_cc_d = 26.7+273.15
      "cooling coil entering air temp at design condition";
    parameter Modelica.SIunits.Temperature T_la_cc_d = 26.7+273.15-Q_cc_d/cp_a/m_a_cc_d
      "cooling coil leaving air temp at design condition";
    parameter Modelica.SIunits.Temperature T_ew_cc_d = T_ew_cc_d_C+273.15
      "cooling coil enetering chilled water temp at design condition in K" 
                                                                     annotation(Evaluate=false);
    parameter Modelica.SIunits.Temperature T_ew_cc_d_C = 7.2
      "cooling coil enetering chilled water temp at design condition in C";
    parameter Modelica.SIunits.HeatFlowRate Q_cc_d=29454
      "cooling coil design cooling capacity";
    parameter Modelica.SIunits.Pressure dp_a_cc_d=165
      "cooling coil air side design pressure drop";
    parameter Modelica.SIunits.Pressure dp_w_cc_d=4783
      "cooling coil design chilled water pressure drop";
    parameter Modelica.SIunits.MassFlowRate m_w_hc_d=0.801
      "heating coil design mass flow rate";
    parameter Modelica.SIunits.Pressure dp_a_hc_d=28.6
      "heating coil air side design pressure drop";
    parameter Modelica.SIunits.Pressure dp_w_hc_d=2989
      "heating coil design hot water pressure drop";
    parameter Modelica.SIunits.HeatFlowRate Q_hc_d=37015
      "heating coil design capacity";
    parameter Modelica.SIunits.Temperature T_ea_hc_d = 15.6+273.15
      "heating coil entering air temp at design condition";
    parameter Modelica.SIunits.Temperature T_la_hc_d = 15.6+273.15+Q_hc_d/cp_a/m_a_hc_d
      "heating coil leaving air temp at design condition";
    parameter Modelica.SIunits.Temperature T_ew_hc_d = T_ew_hc_d_C+273.15
      "heating coil enetering hot water temp at design condition in K";
    parameter Modelica.SIunits.Temperature T_ew_hc_d_C = 82.2
      "heating coil enetering hot water temp at design condition in C";
     Buildings.Fluid.FixedResistances.FixedResistanceDpM Duct(
      redeclare package Medium = MediumA,
      allowFlowReversal=false,
      m_flow_nominal=m_a_cc_d,
      dp_nominal=dp_dt_d) "total duct work" 
      annotation (Placement(transformation(extent={{510,158},{530,178}})));
    parameter Modelica.SIunits.Pressure dp_dt_d=100
      "total duct work pressure drop at design condition";
    Buildings.Fluid.HeatExchangers.ConstantEffectiveness HC(
      redeclare package Medium1 = MediumA,
      redeclare package Medium2 = MediumB,
      m1_flow_nominal=m_a_hc_d,
      m2_flow_nominal=m_w_hc_d,
      dp1_nominal=dp_a_hc_d,
      dp2_nominal=dp_w_hc_d,
      eps=eps_hc) "heating coil" 
      annotation (Placement(transformation(extent={{200,156},{220,176}})));
    Buildings.Fluid.HeatExchangers.ConstantEffectiveness CC(redeclare package
        Medium1 = MediumA, redeclare package Medium2 = MediumB,
      m1_flow_nominal=m_a_cc_d,
      m2_flow_nominal=m_w_cc_d,
      dp1_nominal=dp_a_cc_d,
      dp2_nominal=dp_w_cc_d,
      eps=eps_cc) "cooling coil" 
      annotation (Placement(transformation(extent={{250,154},{270,174}})));
    parameter Real eps_hc=(T_la_hc_d-T_ea_hc_d)/(T_ew_hc_d-T_ea_hc_d)
      "heating coil heat exchange effectiveness";
    parameter Real eps_cc=(T_ea_cc_d-T_la_cc_d)/(T_ea_cc_d-T_ew_cc_d)
      "cooling coil heat exchange effectiveness";
    parameter Modelica.SIunits.Area VAVFA=V_fan_d/3.6 "vav box inlet face area";
    Modelica.SIunits.Velocity AirVel(start=0)
      "air velocity at fan outlet/vav inlet";
    Modelica.SIunits.Pressure AirDyP( start=0)
      "air dynamic pressure at fan outlet/vav inlet";
    parameter Modelica.SIunits.Density AirDen=1.2 "air density";
    Buildings.Fluid.Sensors.Temperature Tsa_h(redeclare package Medium = 
          MediumA) "supplied air temperature after heating coil" 
      annotation (Placement(transformation(extent={{212,180},{232,200}})));
    Buildings.Utilities.IO.BCVTB.BCVTB cliBCVTB(
      samplePeriod=1,
      nDblRea=21,
      nDblWri=30,
      uStart={293.15,0,100,293.15,293.15,355.15,293.15,293.15,280.35,0,0,0,0,0,
          1,0,293.15,0,0,0,0,20,0,0.8,0.2,20,20,20,20,20}) 
      annotation (Placement(transformation(extent={{48,64},{68,84}})));
    DeMultiplexN OutVar "Variables read from Flex" 
      annotation (Placement(transformation(extent={{74,-72},{154,8}})));
    Modelica.Blocks.Logical.Switch EcoEnb
      "Enable economizer based on return and outside air temp" 
      annotation (Placement(transformation(extent={{2,214},{22,234}})));
    Modelica.Blocks.Logical.GreaterEqual TempEco
      "temperature economizer comparing outside air and return air temp" 
      annotation (Placement(transformation(extent={{-48,214},{-28,234}})));
    Modelica.Blocks.Math.Max max 
      annotation (Placement(transformation(extent={{46,206},{66,226}})));
    LimPID CVC(
      Ti=1,
      Td=60,
      yMax=1,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI)
      "cooling valvel controller" 
      annotation (Placement(transformation(extent={{264,58},{282,76}})));
    LimPID DmprC(
      Ti=1,
      Td=60,
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0) "VAV box damper controller" 
      annotation (Placement(transformation(extent={{192,340},{210,358}})));
    LimPID EcoC(
      Ti=1,
      Td=60,
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0.3) "Economizer dampers controller" 
      annotation (Placement(transformation(extent={{-48,256},{-30,274}})));
    Modelica.Blocks.Math.Add MATSP(k2=-1)
      "mixed air temp set point equals to supply air temp set point minus 1 degree C"
      annotation (Placement(transformation(extent={{-30,296},{-10,316}})));
    Modelica.Blocks.Sources.Constant FanDT(k=1)
      "air temperature rise accross supply air fan" 
      annotation (Placement(transformation(extent={{-74,290},{-54,310}})));
    Modelica.Blocks.Math.Add add(k1=-1) 
      annotation (Placement(transformation(extent={{292,190},{272,210}})));
    LimPID FanC(
      Ti=1,
      Td=60,
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0) "Fan speed controller" 
      annotation (Placement(transformation(extent={{230,254},{248,272}})));
    Modelica.Blocks.Math.Max FanSpd "ensure fan running higher than min speed" 
      annotation (Placement(transformation(extent={{268,266},{288,286}})));
    Modelica.Blocks.Sources.Constant Pamb(k=101325) "atmosphere pressure" 
      annotation (Placement(transformation(extent={{368,270},{348,290}})));
    Modelica.Blocks.Sources.RealExpression DynP(y=AirDyP)
      "air dynamic pressure" 
      annotation (Placement(transformation(extent={{300,242},{280,262}})));
    Modelica.Blocks.Math.Add add1(
                                 k1=-1) 
      annotation (Placement(transformation(extent={{264,218},{244,238}})));
    LimPID HVC(
      Ti=1,
      Td=60,
      yMax=1,
      yMin=0,
      controllerType=Modelica.Blocks.Types.SimpleController.PI)
      "heating valvel controller" 
      annotation (Placement(transformation(extent={{288,-4},{306,14}})));
    Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=283.15) 
      annotation (Placement(transformation(extent={{238,-34},{258,-14}})));
    Modelica.Blocks.Logical.LessEqual lessEqual 
      annotation (Placement(transformation(extent={{240,-72},{260,-52}})));
    Modelica.Blocks.Logical.And and1 
      annotation (Placement(transformation(extent={{284,-48},{304,-28}})));
    Modelica.Blocks.Logical.Switch HVSwt "enable heating coil only in winter" 
      annotation (Placement(transformation(extent={{328,-48},{348,-28}})));
    Modelica.Blocks.Sources.Constant Zero(k=0) 
      annotation (Placement(transformation(extent={{292,-80},{312,-60}})));
    Modelica.Blocks.Math.Add HCSP(k2=-274.15)
      "mixed air temp set point equals to supply air temp set point minus 1 degree C"
      annotation (Placement(transformation(extent={{420,-14},{440,6}})));
    Modelica.Blocks.Sources.Constant HCDT(k=1) 
      annotation (Placement(transformation(extent={{360,-18},{380,2}})));
    Modelica.Blocks.Math.Max max1 
      annotation (Placement(transformation(extent={{238,324},{258,344}})));
    LimPID RHVC(
      Ti=1,
      Td=60,
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMin=0) "VAV box reheating valve controller" 
      annotation (Placement(transformation(extent={{396,334},{414,352}})));
    MultiplexN InVar "variables write to Flex" 
      annotation (Placement(transformation(extent={{-76,2},{2,80}})));
    Buildings.Fluid.Sensors.RelativePressure fildp(redeclare package Medium = 
          MediumA) "filter pressure drop" 
      annotation (Placement(transformation(extent={{104,304},{138,338}})));
    Buildings.Fluid.Sensors.Temperature Thwr(redeclare package Medium = MediumB)
      "hot water return temp" 
      annotation (Placement(transformation(extent={{430,102},{450,122}})));
    Buildings.Fluid.Sensors.Temperature Tcwr(redeclare package Medium = MediumB)
      "chilled water return temp" 
      annotation (Placement(transformation(extent={{486,94},{506,114}})));
    Modelica.Blocks.Sources.RealExpression Wfan(y=SupF.W_total) "fan power " 
      annotation (Placement(transformation(extent={{0,-70},{-20,-50}})));
    Modelica.Blocks.Sources.RealExpression fanFlow(y=SupF.V_flow)
      "fan volume flow rate" 
      annotation (Placement(transformation(extent={{0,-48},{-20,-28}})));
    Buildings.Fluid.Sensors.Temperature Tsadf(redeclare package Medium = 
          MediumA) "supplied air temperature after reheat coil" 
      annotation (Placement(transformation(extent={{524,106},{544,126}})));
    Buildings.Fluid.Sensors.Temperature Tsa_cc(
                                              redeclare package Medium = 
          MediumA) "supplied air temperature after cooling coil" 
      annotation (Placement(transformation(extent={{342,228},{362,248}})));
    Modelica.Blocks.Math.Add add2 
      annotation (Placement(transformation(extent={{376,222},{396,242}})));
    Modelica.Blocks.Sources.Constant KtoC(k=-273.15) 
      annotation (Placement(transformation(extent={{566,368},{546,388}})));
    Modelica.Blocks.Math.Add add3 
      annotation (Placement(transformation(extent={{356,128},{376,148}})));
    Modelica.Blocks.Math.Add add4 
      annotation (Placement(transformation(extent={{552,114},{572,134}})));
    Modelica.Blocks.Math.Add add5 
      annotation (Placement(transformation(extent={{558,248},{578,268}})));
    Modelica.Blocks.Math.Add add6 
      annotation (Placement(transformation(extent={{30,298},{50,318}})));
    Modelica.Blocks.Math.Add add7 
      annotation (Placement(transformation(extent={{422,258},{442,278}})));
    Modelica.Blocks.Math.Add add8 
      annotation (Placement(transformation(extent={{458,108},{478,128}})));
    Modelica.Blocks.Math.Add add9 
      annotation (Placement(transformation(extent={{548,58},{568,78}})));
    Modelica.Blocks.Math.Add add10 
      annotation (Placement(transformation(extent={{50,348},{70,368}})));
    Modelica.Blocks.Math.Add MATSP1(
                                   k2=-1)
      "mixed air temp set point equals to supply air temp set point minus 1 degree C"
      annotation (Placement(transformation(extent={{-22,338},{-2,358}})));
    Modelica.Blocks.Sources.Constant const(k=1) "constant 1" 
      annotation (Placement(transformation(extent={{-70,346},{-50,366}})));
  equation
          AirVel=SupF.V_flow/VAVFA;
          AirDyP=0.5*AirDen*AirVel^2;
    connect(Amb.ports[2], Econ.port_Out) annotation (Line(
        points={{58,161},{74,161},{74,159.2},{89.74,159.2}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Amb.ports[3], Econ.port_Exh) annotation (Line(
        points={{58,158.067},{74,158.067},{74,150.8},{89.74,150.8}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(SupF.port_b, VAV.port_a) annotation (Line(
        points={{310,162},{334,162},{334,166},{378,166}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(VAV.port_b, RHC.port_a) annotation (Line(
        points={{398,166},{406,166},{406,168},{466,168}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pressure.port, SupF.port_b) annotation (Line(
        points={{326,178},{320,178},{320,162},{310,162}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tsa.port, SupF.port_b) annotation (Line(
        points={{330,126},{330,118},{320,118},{320,162},{310,162}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(gain1.y, chiller.m_flow_in) 
                                     annotation (Line(
        points={{321,70},{324,70},{324,72},{326,72},{326,104},{289.4,104},{
            289.4,114.5}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Econ.port_Sup, del.ports[1]) annotation (Line(
        points={{115.74,164.8},{130.87,164.8},{130.87,168},{143.333,168}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(filter.port_a, del.ports[2]) annotation (Line(
        points={{162,168},{146,168}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tmix.port, del.ports[3]) annotation (Line(
        points={{102,186},{126,186},{126,168},{148.667,168}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(room.ports[1], Econ.port_Ret) annotation (Line(
        points={{556.4,198},{576,198},{576,142},{116,142},{116,150.8}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(RHC.port_b, Duct.port_a) annotation (Line(
        points={{486,168},{510,168}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Duct.port_b, room.ports[2]) annotation (Line(
        points={{530,168},{542,168},{542,198},{563.6,198}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(filter.port_b, HC.port_a1) annotation (Line(
        points={{182,168},{192,168},{192,172},{200,172}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Amb1.ports[1], HC.port_b2) annotation (Line(
        points={{184,105},{194,105},{194,160},{200,160}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(HC.port_a2, Boi.ports[1]) annotation (Line(
        points={{220,160},{220,148.25},{222,138.5},{221,138.5}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(HC.port_b1, CC.port_a1)                     annotation (Line(
        points={{220,172},{236,172},{236,170},{250,170}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(CC.port_b2, Amb2.ports[1])                     annotation (Line(
        points={{250,158},{250,142},{251,142}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(CC.port_a2, chiller.ports[1])                     annotation (Line(
        points={{270,158},{284,158},{284,132.5},{297,132.5}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(CC.port_b1, SupF.port_a)                     annotation (Line(
        points={{270,170},{284,170},{284,162},{296,162}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tsa_h.port, HC.port_b1) annotation (Line(
        points={{222,180},{228,180},{228,172},{220,172}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(cliBCVTB.yR, OutVar.u) annotation (Line(
        points={{69,74},{78,74},{78,54},{44,54},{44,-32},{66,-32}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(CVC.y, gain1.u) annotation (Line(
        points={{282.9,67},{291.45,67},{291.45,70},{298,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y4[1], DmprC.u_s) annotation (Line(
        points={{100.2,11.6},{100.2,132},{-96,132},{-96,349},{190.2,349}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(max.y, Econ.y) annotation (Line(
        points={{67,216},{70,216},{70,170.4},{87.4,170.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y5[1], max.u2) annotation (Line(
        points={{108.6,11.6},{108.6,136},{26,136},{26,210},{44,210}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(TempEco.y, EcoEnb.u2) annotation (Line(
        points={{-27,224},{0,224}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(OutVar.y5[1], EcoEnb.u3) annotation (Line(
        points={{108.6,11.6},{108.6,136},{-10,136},{-10,216},{0,216}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(EcoEnb.y, max.u1) annotation (Line(
        points={{23,224},{32,224},{32,222},{44,222}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(EcoC.y, EcoEnb.u1) annotation (Line(
        points={{-29.1,265},{-20,265},{-20,232},{0,232}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(FanDT.y, MATSP.u2) annotation (Line(
        points={{-53,300},{-32,300}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y3[1], MATSP.u1) annotation (Line(
        points={{91.8,11.6},{91.8,346},{-38,346},{-38,312},{-32,312}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y3[1], CVC.u_s) annotation (Line(
        points={{91.8,11.6},{91.8,38},{250,38},{250,67},{262.2,67}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(MATSP.y, EcoC.u_s) annotation (Line(
        points={{-9,306},{-2,306},{-2,282},{-58,282},{-58,265},{-49.8,265}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y6[1], TempEco.u1) annotation (Line(
        points={{116.6,11.6},{116.6,144},{-82,144},{-82,224},{-50,224}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y7[1], EcoC.P_gain) annotation (Line(
        points={{124.8,11.6},{124.8,248},{-48,248},{-48,254.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y8[1], EcoC.T_i) annotation (Line(
        points={{133,11.6},{133,246},{-30.18,246},{-30.18,254.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(pressure.p, add.u2) annotation (Line(
        points={{337,188},{342,188},{342,194},{294,194}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(FanC.y, FanSpd.u2)   annotation (Line(
        points={{248.9,263},{257.45,263},{257.45,270},{266,270}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(FanSpd.y, SupF.y_in) annotation (Line(
        points={{289,276},{303,276},{303,169}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(FanSpd.u1, OutVar.y9[1]) annotation (Line(
        points={{266,282},{141,282},{141,11.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y10[1], FanC.P_gain)   annotation (Line(
        points={{148.2,11.6},{148.2,242},{230,242},{230,252.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y11[1], FanC.T_i)   annotation (Line(
        points={{157.8,6.6},{247.82,6.6},{247.82,252.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y12[1], FanC.u_s)   annotation (Line(
        points={{157.8,-1.4},{190,-1.4},{190,263},{228.2,263}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Pamb.y, add.u1) annotation (Line(
        points={{347,280},{318,280},{318,206},{294,206}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add1.y, FanC.u_m) annotation (Line(
        points={{243,228},{239,228},{239,252.2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(DynP.y, add1.u1) annotation (Line(
        points={{279,252},{276,252},{276,234},{266,234}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add.y, add1.u2) annotation (Line(
        points={{271,200},{264,200},{264,214},{274,214},{274,222},{266,222}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, Boi.m_flow_in) annotation (Line(
        points={{214,79},{214,120.5},{213.4,120.5}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(EcoEnb.y, lessEqual.u1) annotation (Line(
        points={{23,224},{36,224},{36,248},{158,248},{158,48},{198,48},{198,42},{206,
            42},{206,-62},{238,-62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y5[1], lessEqual.u2) annotation (Line(
        points={{108.6,11.6},{108.6,46},{180,46},{180,-70},{238,-70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(lessEqualThreshold.y, and1.u1) annotation (Line(
        points={{259,-24},{269.5,-24},{269.5,-38},{282,-38}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(lessEqual.y, and1.u2) annotation (Line(
        points={{261,-62},{272,-62},{272,-46},{282,-46}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(and1.y, HVSwt.u2) annotation (Line(
        points={{305,-38},{326,-38}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(HVC.y, HVSwt.u1) annotation (Line(
        points={{306.9,5},{320,5},{320,-30},{326,-30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Zero.y, HVSwt.u3) annotation (Line(
        points={{313,-70},{320,-70},{320,-46},{326,-46}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(HVSwt.y, gain.u) annotation (Line(
        points={{349,-38},{390,-38},{390,32},{214,32},{214,56}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y3[1], HCSP.u1) annotation (Line(
        points={{91.8,11.6},{91.8,40},{402,40},{402,2},{418,2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(HCDT.y, HCSP.u2) annotation (Line(
        points={{381,-8},{400,-8},{400,-10},{418,-10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(HCSP.y, HVC.u_s) annotation (Line(
        points={{441,-4},{456,-4},{456,36},{272,36},{272,5},{286.2,5}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y13[1], HVC.P_gain) annotation (Line(
        points={{157.6,-10},{224,-10},{224,-14},{288,-14},{288,-5.89}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y14[1], HVC.T_i) annotation (Line(
        points={{157.8,-17.8},{190,-17.8},{190,-6},{274,-6},{274,-20},{305.82,
            -20},{305.82,-5.89}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y15[1], CVC.P_gain) annotation (Line(
        points={{157.8,-25.4},{200,-25.4},{200,18},{264,18},{264,56.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y16[1], CVC.T_i) annotation (Line(
        points={{157.8,-33.8},{170,-33.8},{170,28},{281.82,28},{281.82,56.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(DmprC.y, max1.u1) annotation (Line(
        points={{210.9,349},{222.45,349},{222.45,340},{236,340}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y17[1], DmprC.P_gain) annotation (Line(
        points={{157.8,-41.8},{192,-41.8},{192,338.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y18[1], DmprC.T_i) annotation (Line(
        points={{157.8,-49.8},{209.82,-49.8},{209.82,338.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y19[1], max1.u2) annotation (Line(
        points={{157.6,-58},{176,-58},{176,328},{236,328}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y2[1], RHVC.u_s) annotation (Line(
        points={{84.6,11.6},{84.6,368},{380,368},{380,343},{394.2,343}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y20[1], RHVC.P_gain) annotation (Line(
        points={{157.8,-65.8},{168,-65.8},{168,304},{396,304},{396,332.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y21[1], RHVC.T_i) annotation (Line(
        points={{152.2,-76.2},{474,-76.2},{474,92},{413.82,92},{413.82,332.11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(RHVC.y, RHC.u) annotation (Line(
        points={{414.9,343},{448,343},{448,174},{464,174}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(max1.y, VAV.y) annotation (Line(
        points={{259,334},{294,334},{294,326},{336,326},{336,216},{388,216},{
            388,174}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(InVar.y, cliBCVTB.uR) annotation (Line(
        points={{5.9,41},{24.95,41},{24.95,74},{46,74}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(max.y, InVar.u2[1]) annotation (Line(
        points={{67,216},{70,216},{70,104},{-7.555,104},{-7.555,83.12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fildp.port_b, filter.port_b) annotation (Line(
        points={{138,321},{162,321},{162,318},{182,318},{182,168}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(fildp.port_a, filter.port_a) annotation (Line(
        points={{104,321},{102,321},{102,262},{162,262},{162,168}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(fildp.p_rel, InVar.u3[1]) annotation (Line(
        points={{121,305.7},{121,292},{46,292},{46,258},{-15.745,258},{-15.745,
            82.925}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Thwr.port, HC.port_b2) annotation (Line(
        points={{440,102},{426,102},{200,98},{200,160}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tcwr.port, CC.port_b2) annotation (Line(
        points={{496,94},{496,86},{250,86},{250,158}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(FanSpd.y, InVar.u10[1]) annotation (Line(
        points={{289,276},{300,276},{300,278},{-76,278},{-76,108},{-70.345,108},
            {-70.345,82.925}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Wfan.y, InVar.u11[1]) annotation (Line(
        points={{-21,-60},{-96,-60},{-96,77.66},{-78.73,77.66}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add1.y, InVar.u12[1]) annotation (Line(
        points={{243,228},{76,228},{76,194},{-90,194},{-90,70.64},{-78.73,70.64}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(fanFlow.y, InVar.u13[1]) annotation (Line(
        points={{-21,-38},{-54,-38},{-54,-16},{-90,-16},{-90,62.45},{-78.73,
            62.45}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fanFlow.y, InVar.u14[1]) annotation (Line(
        points={{-21,-38},{-94,-38},{-94,54.065},{-78.925,54.065}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(max1.y, InVar.u15[1]) annotation (Line(
        points={{259,334},{290,334},{290,374},{272,374},{272,372},{-88,372},{
            -88,46.46},{-78.73,46.46}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(RHVC.y, InVar.u16[1]) annotation (Line(
        points={{414.9,343},{434,343},{434,378},{-86,378},{-86,39.05},{-78.73,
            39.05}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tsadf.port, RHC.port_b) annotation (Line(
        points={{534,106},{534,98},{506,98},{506,168},{486,168}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(gain1.y, InVar.u18[1]) annotation (Line(
        points={{321,70},{410,70},{410,62},{510,62},{510,-80},{-10,-80},{-10,
            -44},{-94,-44},{-94,23.06},{-78.73,23.06}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, InVar.u19[1]) annotation (Line(
        points={{214,79},{536,79},{536,-72},{-48,-72},{-48,-54},{-92,-54},{-92,
            15.65},{-78.73,15.65}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tsa_cc.port, CC.port_b1) annotation (Line(
        points={{352,228},{352,176},{290,176},{290,170},{270,170}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tsa_cc.T, add2.u1) annotation (Line(
        points={{359,238},{374,238}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(KtoC.y, add2.u2) annotation (Line(
        points={{545,378},{454,378},{454,380},{364,380},{364,226},{374,226}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add2.y, InVar.u8[1]) annotation (Line(
        points={{397,232},{402,232},{402,118},{-54.745,118},{-54.745,83.12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tsa.T, add3.u2) annotation (Line(
        points={{337,136},{344,136},{344,132},{354,132}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(KtoC.y, add3.u1) annotation (Line(
        points={{545,378},{340,378},{340,144},{354,144}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add3.y, CVC.u_m) annotation (Line(
        points={{377,138},{390,138},{390,46},{273,46},{273,56.2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add3.y, HVC.u_m) annotation (Line(
        points={{377,138},{386,138},{386,-16},{297,-16},{297,-5.8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(HVSwt.y, InVar.u20[1]) annotation (Line(
        points={{349,-38},{360,-38},{360,-84},{-44,-84},{-44,-50},{-86,-50},{
            -86,7.85},{-78.73,7.85}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(CVC.y, InVar.u21[1]) annotation (Line(
        points={{282.9,67},{288,67},{288,20},{276,20},{276,-92},{-56,-92},{-56,
            -34},{-74.05,-34},{-74.05,-0.34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add3.y, InVar.u22[1]) annotation (Line(
        points={{377,138},{384,138},{384,-96},{-50,-96},{-50,-24},{-66.25,-24},
            {-66.25,-0.34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tsadf.T, add4.u2) annotation (Line(
        points={{541,116},{546,116},{546,118},{550,118}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(KtoC.y, add4.u1) annotation (Line(
        points={{545,378},{540,378},{540,130},{550,130}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add4.y, InVar.u17[1]) annotation (Line(
        points={{573,124},{576,124},{576,-82},{-38,-82},{-38,-38},{-98,-38},{-98,31.25},
            {-78.73,31.25}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(room.TRoo, add5.u2) annotation (Line(
        points={{579.8,225.36},{588,225.36},{588,240},{546,240},{546,252},{556,252}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(KtoC.y, add5.u1) annotation (Line(
        points={{545,378},{532,378},{532,264},{556,264}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add5.y, RHVC.u_m) annotation (Line(
        points={{579,258},{586,258},{586,322},{405,322},{405,332.2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add5.y, DmprC.u_m) annotation (Line(
        points={{579,258},{588,258},{588,324},{201,324},{201,338.2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add5.y, InVar.u1[1]) annotation (Line(
        points={{579,258},{586,258},{586,96},{-0.34,96},{-0.34,83.12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tmix.T, add6.u2) annotation (Line(
        points={{109,196},{112,196},{112,288},{18,288},{18,302},{28,302}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(KtoC.y, add6.u1) annotation (Line(
        points={{545,378},{324,378},{324,380},{14,380},{14,314},{28,314}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add6.y, EcoC.u_m) annotation (Line(
        points={{51,308},{52,308},{52,240},{-39,240},{-39,254.2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add6.y, InVar.u4[1]) annotation (Line(
        points={{51,308},{60,308},{60,266},{-23.155,266},{-23.155,82.925}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tsa_h.T, add7.u2) annotation (Line(
        points={{229,190},{252,190},{252,184},{412,184},{412,262},{420,262}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(KtoC.y, add7.u1) annotation (Line(
        points={{545,378},{482,378},{482,376},{416,376},{416,274},{420,274}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add7.y, InVar.u7[1]) annotation (Line(
        points={{443,268},{452,268},{452,288},{-46.75,288},{-46.75,83.12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add7.y, InVar.u5[1]) annotation (Line(
        points={{443,268},{452,268},{452,288},{-31.345,288},{-31.345,82.925}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Thwr.T, add8.u2) annotation (Line(
        points={{447,112},{456,112}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(KtoC.y, add8.u1) annotation (Line(
        points={{545,378},{492,378},{492,376},{450,376},{450,124},{456,124}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add8.y, InVar.u6[1]) annotation (Line(
        points={{479,118},{488,118},{488,102},{-38.95,102},{-38.95,83.12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tcwr.T, add9.u2) annotation (Line(
        points={{503,104},{510,104},{510,102},{522,102},{522,62},{546,62}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(KtoC.y, add9.u1) annotation (Line(
        points={{545,378},{520,378},{520,114},{528,114},{528,74},{546,74}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add9.y, InVar.u9[1]) annotation (Line(
        points={{569,68},{588,68},{588,50},{8,50},{8,112},{-62.545,112},{
            -62.545,82.925}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(OutVar.y1[1], add10.u2) annotation (Line(
        points={{76.4,11.6},{76.4,334},{40,334},{40,352},{48,352}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(KtoC.y, add10.u1) annotation (Line(
        points={{545,378},{346,378},{346,380},{38,380},{38,364},{48,364}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add10.y, room.TAmb) annotation (Line(
        points={{71,358},{98,358},{98,390},{498,390},{498,216},{538.4,216}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add10.y, Amb.T_in) annotation (Line(
        points={{71,358},{80,358},{80,180},{20,180},{20,165.4},{33.8,165.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add10.y, lessEqualThreshold.u) annotation (Line(
        points={{71,358},{220,358},{220,-24},{236,-24}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutVar.y1[1], TempEco.u2) annotation (Line(
        points={{76.4,11.6},{76.4,200},{-66,200},{-66,216},{-50,216}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fanFlow.y, InVar.u23[1]) annotation (Line(
        points={{-21,-38},{-40,-38},{-40,-10},{-58.45,-10},{-58.45,-0.34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, MATSP1.u1) annotation (Line(
        points={{-49,356},{-36,356},{-36,354},{-24,354}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(max.y, MATSP1.u2) annotation (Line(
        points={{67,216},{70,216},{70,330},{-32,330},{-32,342},{-24,342}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(MATSP1.y, InVar.u24[1]) annotation (Line(
        points={{-1,348},{24,348},{24,-18},{-50.65,-18},{-50.65,-0.34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(max.y, InVar.u25[1]) annotation (Line(
        points={{67,216},{68,216},{68,-20},{-42.85,-20},{-42.85,-0.34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add5.y, InVar.u26[1]) annotation (Line(
        points={{579,258},{590,258},{590,26},{34,26},{34,-24},{-35.05,-24},{
            -35.05,-0.34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add6.y, InVar.u27[1]) annotation (Line(
        points={{51,308},{60,308},{60,-18},{-27.25,-18},{-27.25,-0.34}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add8.y, InVar.u28[1]) annotation (Line(
        points={{479,118},{490,118},{490,-28},{-19.45,-28},{-19.45,-0.73}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add9.y, InVar.u29[1]) annotation (Line(
        points={{569,68},{574,68},{574,-88},{-11.65,-88},{-11.65,-0.73}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(add3.y, InVar.u30[1]) annotation (Line(
        points={{377,138},{408,138},{408,-48},{-3.85,-48},{-3.85,-0.73}},
        color={0,0,127},
        smooth=Smooth.None));
  end HVAC_v3;

  model OAMixingBoxMinimumDamper "Outside air mixing box"
    extends Buildings.BaseClasses.BaseIcon;
    outer Modelica.Fluid.System system "System wide properties";
    replaceable package Medium = 
        Modelica.Media.Interfaces.PartialMedium "Medium in the component" 
      annotation (choicesAllMatching = true);
    import Modelica.Constants;

    parameter Boolean allowFlowReversal = system.allowFlowReversal
      "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);

    Buildings.Fluid.Actuators.Dampers.Exponential damOA(A=AOut,
      redeclare package Medium = Medium,
      m_flow_nominal=m0Out_flow) 
      annotation (Placement(transformation(extent={{-42,-30},{-22,-10}}, rotation=
             0)));
    parameter Modelica.SIunits.Area AOutMin
      "Face area minimum outside air damper";
    parameter Modelica.SIunits.Area AOut "Face area outside air damper";
    Buildings.Fluid.Actuators.Dampers.Exponential damExh(A=AExh,
      redeclare package Medium = Medium,
      m_flow_nominal=m0Exh_flow) "Exhaust air damper" 
      annotation (Placement(transformation(extent={{-22,-90},{-42,-70}}, rotation=
             0)));
    parameter Modelica.SIunits.Area AExh "Face area exhaust air damper";
    Buildings.Fluid.Actuators.Dampers.Exponential damRec(A=ARec,
      redeclare package Medium = Medium,
      m_flow_nominal=m0Rec_flow) "Recirculation air damper" 
                                 annotation (Placement(transformation(
          origin={28,-10},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    parameter Modelica.SIunits.Area ARec "Face area recirculation air damper";

    parameter Modelica.SIunits.MassFlowRate m0OutMin_flow
      "Mass flow rate minimum outside air damper" 
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.SIunits.Pressure dpOutMin_nominal
      "Pressure drop minimum outside air leg (without damper)" 
       annotation (Dialog(group="Nominal condition"));

    parameter Modelica.SIunits.MassFlowRate m0Out_flow
      "Mass flow rate outside air damper" 
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.SIunits.Pressure dpOut_nominal
      "Pressure drop outside air leg (without damper)" 
       annotation (Dialog(group="Nominal condition"));

    parameter Modelica.SIunits.MassFlowRate m0Rec_flow
      "Mass flow rate recirculation air damper" 
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.SIunits.Pressure dpRec_nominal
      "Pressure drop recirculation air leg (without damper)" 
       annotation (Dialog(group="Nominal condition"));

    parameter Modelica.SIunits.MassFlowRate m0Exh_flow
      "Mass flow rate exhaust air damper" 
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.SIunits.Pressure dpExh_nominal
      "Pressure drop exhaust air leg (without damper)" 
       annotation (Dialog(group="Nominal condition"));

    Buildings.Fluid.FixedResistances.FixedResistanceDpM preDroOut(
                                                             m_flow_nominal=
          m0Out_flow, dp_nominal=dpOut_nominal, redeclare package Medium = Medium)
      "Pressure drop for outside air branch" annotation (Placement(transformation(
            extent={{-82,-30},{-62,-10}}, rotation=0)));
    Buildings.Fluid.FixedResistances.FixedResistanceDpM preDroExh(
                                                             m_flow_nominal=
          m0Exh_flow, dp_nominal=dpExh_nominal, redeclare package Medium = Medium)
      "Pressure drop for exhaust air branch" 
      annotation (Placement(transformation(extent={{-62,-90},{-82,-70}}, rotation=
             0)));
    Buildings.Fluid.FixedResistances.FixedResistanceDpM preDroRec(
                                                             m_flow_nominal=
          m0Rec_flow, dp_nominal=dpRec_nominal, redeclare package Medium = Medium)
      "Pressure drop for recirculation air branch" 
      annotation (Placement(transformation(
          origin={28,-50},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
              -100},{100,100}}),
                        graphics),
                         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-96,-14},{-26,-28}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-38,28},{92,14}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-96,22},{-26,16}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-94,-74},{96,-86}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{6,28},{18,-74}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-38,28},{-26,-26}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-82,6},{-64,32},{-56,32},{-74,6},{-82,6}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-84,-34},{-66,-8},{-58,-8},{-76,-34},{-84,-34}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-54,-92},{-36,-66},{-28,-66},{-46,-92},{-54,-92}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-2,-42},{16,-16},{24,-16},{6,-42},{-2,-42}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{66,28},{88,20},{66,14},{66,28}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{48,22},{68,20}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{74,-80},{94,-82}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{76,-74},{52,-80},{76,-86},{76,-74}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-102,72},{-76,50}},
            lineColor={0,0,255},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="y"),
          Text(
            extent={{-96,110},{-70,88}},
            lineColor={0,0,255},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="yMin")}),
      Documentation(revisions="<html>
<ul>
<li>
July 20, 2007 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>",   info="<html>
<p>
Model of an outside air mixing box with air dampers and a flow path for the minimum outside air flow rate.
</p>
</html>"));
    Modelica.Fluid.Interfaces.FluidPort_a port_Out(redeclare package Medium = 
          Medium, m_flow(start=0, min=if allowFlowReversal then -Constants.inf else 
                  0))
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-112,-30},{-92,-10}},
            rotation=0)));
    Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium = 
          Medium, m_flow(start=0, max=if allowFlowReversal then +Constants.inf else 
                  0))
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-92,-90},{-112,-70}},
            rotation=0)));
    Modelica.Fluid.Interfaces.FluidPort_a port_Ret(redeclare package Medium = 
          Medium, m_flow(start=0, min=if allowFlowReversal then -Constants.inf else 
                  0))
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{110,-90},{90,-70}}, rotation=
              0)));
    Modelica.Fluid.Interfaces.FluidPort_b port_Sup(redeclare package Medium = 
          Medium, m_flow(start=0, max=if allowFlowReversal then +Constants.inf else 
                  0))
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{108,10},{88,30}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealInput y
      "Damper position (0: closed, 1: open)" 
      annotation (Placement(transformation(extent={{-140,40},{-100,80}}, rotation=
             0)));
    Modelica.Blocks.Sources.Constant uni(k=1) "Unity signal" 
      annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));

    Modelica.Blocks.Math.Add add(k2=-1) 
                               annotation (Placement(transformation(extent={{40,
              60},{60,80}}, rotation=0)));
  protected
    Modelica.Fluid.Interfaces.FluidPort_b port_Ret1(redeclare package Medium = 
          Medium) annotation (Placement(transformation(extent={{27,-81},{29,-79}},
            rotation=0)));
  protected
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium = 
          Medium) annotation (Placement(transformation(extent={{27,19},{29,21}},
            rotation=0)));
  equation
    connect(preDroOut.port_b, damOA.port_a)    annotation (Line(points={{-62,-20},
            {-42,-20}}, color={0,127,255}));
    connect(y, damOA.y) annotation (Line(points={{-120,60},{-58,60},{-58,-12},{
            -32,-12}}, color={0,0,127}));
    connect(y, damExh.y) annotation (Line(points={{-120,60},{-58,60},{-58,-64},
            {-32,-64},{-32,-68},{-32,-72}},
                                         color={0,0,127}));
    connect(damExh.port_b, preDroExh.port_a) annotation (Line(points={{-42,-80},{
            -62,-80}}, color={0,127,255}));
    connect(preDroExh.port_b, port_Exh) annotation (Line(points={{-82,-80},{-102,
            -80}}, color={0,127,255}));
    connect(preDroOut.port_a, port_Out) annotation (Line(points={{-82,-20},{-102,
            -20}}, color={0,127,255}));
    connect(uni.y, add.u1) annotation (Line(points={{1,90},{20,90},{20,76},{38,76}},
          color={0,0,127}));
    connect(y, add.u2) annotation (Line(points={{-120,60},{-42,60},{-42,64},{38,
            64}}, color={0,0,127}));
    connect(add.y, damRec.y) annotation (Line(points={{61,70},{68,70},{68,-28},
            {20,-28},{20,-10}},color={0,0,127}));
    connect(port_Ret, port_Ret1) annotation (Line(points={{100,-80},{28,-80}},
          color={0,127,255}));
    connect(preDroRec.port_a, port_Ret1) annotation (Line(points={{28,-60},{28,
            -80}}, color={0,127,255}));
    connect(damExh.port_a, port_Ret1) annotation (Line(points={{-22,-80},{28,-80}},
          color={0,127,255}));
    connect(port_Sup, port_b1) 
      annotation (Line(points={{98,20},{28,20}}, color={0,127,255}));
    connect(damRec.port_b, port_b1) 
      annotation (Line(points={{28,0},{28,20}},            color={0,127,255}));
    connect(damOA.port_b, port_b1) annotation (Line(points={{-22,-20},{4,-20},{4,
            20},{28,20}}, color={0,127,255}));
    connect(preDroRec.port_b, damRec.port_a) annotation (Line(points={{28,-40},{
            28,-20}}, color={0,127,255}));
  end OAMixingBoxMinimumDamper;

  block MultiplexN "Multiplexer block for six input connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of input signal connector 1";
    parameter Integer n2=1 "dimension of input signal connector 2";
    parameter Integer n3=1 "dimension of input signal connector 3";
    parameter Integer n4=1 "dimension of input signal connector 4";
    parameter Integer n5=1 "dimension of input signal connector 5";
    parameter Integer n6=1 "dimension of input signal connector 6";
    parameter Integer n7=1 "dimension of input signal connector 7";
    parameter Integer n8=1 "dimension of input signal connector 8";
    parameter Integer n9=1 "dimension of input signal connector 9";
    parameter Integer n10=1 "dimension of input signal connector 10";
    parameter Integer n11=1 "dimension of input signal connector 11";
    parameter Integer n12=1 "dimension of input signal connector 12";
    parameter Integer n13=1 "dimension of input signal connector 13";
    parameter Integer n14=1 "dimension of input signal connector 14";
    parameter Integer n15=1 "dimension of input signal connector 15";
    parameter Integer n16=1 "dimension of input signal connector 16";
    parameter Integer n17=1 "dimension of input signal connector 17";
    parameter Integer n18=1 "dimension of input signal connector 18";
    parameter Integer n19=1 "dimension of input signal connector 19";
    parameter Integer n20=1 "dimension of input signal connector 20";
    parameter Integer n21=1 "dimension of input signal connector 21";
    parameter Integer n22=1 "dimension of input signal connector 22";
    parameter Integer n23=1 "dimension of input signal connector 23";
    parameter Integer n24=1 "dimension of input signal connector 24";
    parameter Integer n25=1 "dimension of input signal connector 25";
    parameter Integer n26=1 "dimension of input signal connector 26";
    parameter Integer n27=1 "dimension of input signal connector 27";
    parameter Integer n28=1 "dimension of input signal connector 28";
    parameter Integer n29=1 "dimension of input signal connector 29";
    parameter Integer n30=1 "dimension of input signal connector 30";
    Modelica.Blocks.Interfaces.RealInput u1[n1]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=-90,
          origin={94,108})));
    Modelica.Blocks.Interfaces.RealInput u2[n2]
      "Connector of Real input signals 2" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                          rotation=-90,
          origin={75.5,108})));
    Modelica.Blocks.Interfaces.RealInput u3[n3]
      "Connector of Real input signals 3" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                         rotation=-90,
          origin={54.5,107.5})));
    Modelica.Blocks.Interfaces.RealInput u4[n4]
      "Connector of Real input signals 4" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},rotation=-90,
          origin={35.5,107.5})));
    Modelica.Blocks.Interfaces.RealInput u5[n5]
      "Connector of Real input signals 5" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}}, rotation=-90,
          origin={14.5,107.5})));
    Modelica.Blocks.Interfaces.RealInput u6[n6]
      "Connector of Real input signals 6" annotation (Placement(transformation(
            extent={{-7,-7},{7,7}},         rotation=-90,
          origin={-5,108})));
   Modelica.Blocks.Interfaces.RealInput u7[n7]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=-90,
          origin={-25,108})));
    Modelica.Blocks.Interfaces.RealInput u8[n8]
      "Connector of Real input signals 2" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                          rotation=-90,
          origin={-45.5,108})));
    Modelica.Blocks.Interfaces.RealInput u9[n9]
      "Connector of Real input signals 3" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                         rotation=-90,
          origin={-65.5,107.5})));
    Modelica.Blocks.Interfaces.RealInput u10[n10]
      "Connector of Real input signals 4" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},rotation=-90,
          origin={-85.5,107.5})));
    Modelica.Blocks.Interfaces.RealInput u11[n11]
      "Connector of Real input signals 5" annotation (Placement(transformation(
            extent={{-114,87},{-100,101}},  rotation=0)));
    Modelica.Blocks.Interfaces.RealInput u12[n12]
      "Connector of Real input signals 6" annotation (Placement(transformation(
            extent={{-114,69},{-100,83}},   rotation=0)));
   Modelica.Blocks.Interfaces.RealInput u13[n13]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-113,49},{-101,61}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealInput u14[n14]
      "Connector of Real input signals 2" annotation (Placement(transformation(
            extent={{-114,27},{-101,40}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealInput u15[n15]
      "Connector of Real input signals 3" annotation (Placement(transformation(
            extent={{-114,7},{-100,21}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealInput u16[n16]
      "Connector of Real input signals 4" annotation (Placement(transformation(
            extent={{-114,-12},{-100,2}},  rotation=0)));
    Modelica.Blocks.Interfaces.RealInput u17[n17]
      "Connector of Real input signals 5" annotation (Placement(transformation(
            extent={{-114,-32},{-100,-18}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealInput u18[n18]
      "Connector of Real input signals 6" annotation (Placement(transformation(
            extent={{-114,-53},{-100,-39}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u19[n19]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-113,-71},{-101,-59}},
                                          rotation=0)));

    Modelica.Blocks.Interfaces.RealOutput y[n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13+n14+n15+n16+n17+n18+n19+n20+n21+n22+n23+n24+n25+n26+n27+n28+n29+n30]
      "Connector of Real output signals" annotation (Placement(transformation(
            extent={{100,-10},{120,10}}, rotation=0)));
    annotation (
      Documentation(info="<HTML>
<p>
The output connector is the <b>concatenation</b> of the six input connectors.
Note, that the dimensions of the input connector signals have to be
explicitly defined via parameters n1, n2, n3, n4, n5 and n6.
</p>
</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{8,0},{102,0}}, color={0,0,127}),
          Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-99,85},{-61,85},{-3,11}}, color={0,0,127}),
          Line(points={{-100,51},{-61,51},{-7,6}}, color={0,0,127}),
          Line(points={{-101,17},{-60,17},{-9,2}}, color={0,0,127}),
          Line(points={{-100,-18},{-60,-18},{-11,-4}}, color={0,0,127}),
          Line(points={{-99,-50},{-60,-50},{-9,-6}}, color={0,0,127}),
          Line(points={{-100,-85},{-60,-85},{-3,-10}}, color={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Line(points={{8,0},{102,0}}, color={0,0,255}),
            Ellipse(
            extent={{-15,15},{15,-15}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));

  Modelica.Blocks.Interfaces.RealInput u20[n20]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-113,-91},{-101,-79}},
                                          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput u21[n21]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={-95,-106})));
  Modelica.Blocks.Interfaces.RealInput u22[n22]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={-75,-106})));
  Modelica.Blocks.Interfaces.RealInput u23[n23]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={-55,-106})));
  Modelica.Blocks.Interfaces.RealInput u24[n24]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={-35,-106})));
  Modelica.Blocks.Interfaces.RealInput u25[n25]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={-15,-106})));
  Modelica.Blocks.Interfaces.RealInput u26[n26]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={5,-106})));
  Modelica.Blocks.Interfaces.RealInput u27[n27]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={25,-106})));
  Modelica.Blocks.Interfaces.RealInput u28[n28]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={45,-107})));
  Modelica.Blocks.Interfaces.RealInput u29[n29]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={65,-107})));
  Modelica.Blocks.Interfaces.RealInput u30[n30]
      "Connector of Real input signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},       rotation=90,
          origin={85,-107})));
  equation
    [y] = [u1;u2;u3;u4;u5;u6;u7;u8;u9;u10;u11;u12;u13;u14;u15;u16;u17;u18;u19;u20;u21;u22;u23;u24;u25;u26;u27;u28;u29;u30];
  end MultiplexN;

  block DeMultiplexN "DeMultiplexer block for six output connectors"
    extends Modelica.Blocks.Interfaces.BlockIcon;
    parameter Integer n1=1 "dimension of output signal connector 1";
    parameter Integer n2=1 "dimension of output signal connector 2";
    parameter Integer n3=1 "dimension of output signal connector 3";
    parameter Integer n4=1 "dimension of output signal connector 4";
    parameter Integer n5=1 "dimension of output signal connector 5";
    parameter Integer n6=1 "dimension of output signal connector 6";
    parameter Integer n7=1 "dimension of output signal connector 7";
    parameter Integer n8=1 "dimension of output signal connector 8";
    parameter Integer n9=1 "dimension of output signal connector 9";
    parameter Integer n10=1 "dimension of output signal connector 10";
    parameter Integer n11=1 "dimension of output signal connector 11";
    parameter Integer n12=1 "dimension of output signal connector 12";
    parameter Integer n13=1 "dimension of output signal connector 13";
    parameter Integer n14=1 "dimension of output signal connector 14";
    parameter Integer n15=1 "dimension of output signal connector 15";
    parameter Integer n16=1 "dimension of output signal connector 16";
    parameter Integer n17=1 "dimension of output signal connector 17";
    parameter Integer n18=1 "dimension of output signal connector 18";
    parameter Integer n19=1 "dimension of output signal connector 19";
    parameter Integer n20=1 "dimension of output signal connector 20";
    parameter Integer n21=1 "dimension of output signal connector 21";
    /*parameter Integer n22=1 "dimension of output signal connector 22";
  parameter Integer n23=1 "dimension of output signal connector 23";
  parameter Integer n24=1 "dimension of output signal connector 24";
  parameter Integer n25=1 "dimension of output signal connector 25";
  parameter Integer n26=1 "dimension of output signal connector 26";
  parameter Integer n27=1 "dimension of output signal connector 27";
  parameter Integer n28=1 "dimension of output signal connector 28";
  parameter Integer n29=1 "dimension of output signal connector 29";
  parameter Integer n30=1 "dimension of output signal connector 30";*/
    Modelica.Blocks.Interfaces.RealInput u[n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13+n14+n15+n16+n17+n18+n19+n20+n21]
      "Connector of Real input signals" annotation (Placement(transformation(
            extent={{-140,-20},{-100,20}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y1[n1]
      "Connector of Real output signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},      rotation=90,
          origin={-94,109})));
    Modelica.Blocks.Interfaces.RealOutput y2[n2]
      "Connector of Real output signals 2" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                        rotation=90,
          origin={-73.5,109})));
    Modelica.Blocks.Interfaces.RealOutput y3[n3]
      "Connector of Real output signals 3" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                       rotation=90,
          origin={-55.5,109})));
    Modelica.Blocks.Interfaces.RealOutput y4[n4]
      "Connector of Real output signals 4" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                         rotation=90,
          origin={-34.5,109})));
    Modelica.Blocks.Interfaces.RealOutput y5[n5]
      "Connector of Real output signals 5" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                          rotation=90,
          origin={-13.5,109})));
    Modelica.Blocks.Interfaces.RealOutput y6[n6]
      "Connector of Real output signals 6" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},rotation=90,
          origin={6.5,109})));
    annotation (
      Documentation(info="<HTML>
<p>
The input connector is <b>splitted</b> up into six output connectors.
Note, that the dimensions of the output connector signals have to be
explicitly defined via parameters n1, n2, n3, n4, n5 and n6.
</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Ellipse(
            extent={{-14,16},{16,-14}},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,127}),
          Line(points={{-100,0},{-6,0}}, color={0,0,127}),
          Line(points={{99,90},{60,90},{5,10}}, color={0,0,127}),
          Line(points={{100,53},{60,53},{8,6}}, color={0,0,127}),
          Line(points={{100,18},{59,18},{7,2}}, color={0,0,127}),
          Line(points={{100,-19},{60,-19},{13,-2}}, color={0,0,127}),
          Line(points={{99,-54},{60,-54},{9,-1}}, color={0,0,127}),
          Line(points={{100,-91},{60,-91},{3,-7}}, color={0,0,127})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={Line(points={{-100,0},{-6,0}}, color={0,0,255}),
            Ellipse(
            extent={{-14,15},{16,-15}},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255})}));

    Modelica.Blocks.Interfaces.RealOutput y7[n7]
      "Connector of Real output signals 1" annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},      rotation=90,
          origin={27,109})));
    Modelica.Blocks.Interfaces.RealOutput y8[n8]
      "Connector of Real output signals 2" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                        rotation=90,
          origin={47.5,109})));
    Modelica.Blocks.Interfaces.RealOutput y9[n8]
      "Connector of Real output signals 3" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                       rotation=90,
          origin={67.5,109})));
    Modelica.Blocks.Interfaces.RealOutput y10[
                                             n10]
      "Connector of Real output signals 4" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                         rotation=90,
          origin={85.5,109})));
    Modelica.Blocks.Interfaces.RealOutput y11[
                                             n11]
      "Connector of Real output signals 5" annotation (Placement(transformation(
            extent={{103,90},{116,103}},  rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y12[
                                             n12]
      "Connector of Real output signals 6" annotation (Placement(transformation(
            extent={{103,70},{116,83}},    rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y13[
                                             n13]
      "Connector of Real output signals 1" annotation (Placement(transformation(
            extent={{103,49},{115,61}},  rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y14[
                                             n14]
      "Connector of Real output signals 2" annotation (Placement(transformation(
            extent={{103,29},{116,42}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y15[
                                             n15]
      "Connector of Real output signals 3" annotation (Placement(transformation(
            extent={{103,10},{116,23}},rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y16[
                                             n16]
      "Connector of Real output signals 4" annotation (Placement(transformation(
            extent={{103,-11},{116,2}},  rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y17[
                                             n17]
      "Connector of Real output signals 5" annotation (Placement(transformation(
            extent={{103,-31},{116,-18}}, rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y18[
                                             n18]
      "Connector of Real output signals 6" annotation (Placement(transformation(
            extent={{103,-51},{116,-38}},  rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y19[
                                             n19]
      "Connector of Real output signals 1" annotation (Placement(transformation(
            extent={{103,-71},{115,-59}},rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y20[
                                             n20]
      "Connector of Real output signals 2" annotation (Placement(transformation(
            extent={{103,-91},{116,-78}},
                                        rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput y21[
                                             n21]
      "Connector of Real output signals 3" annotation (Placement(transformation(
            extent={{-6.5,-6.5},{6.5,6.5}},
                                       rotation=-90,
          origin={95.5,-110.5})));
  equation
    [u] = [y1;y2;y3;y4;y5;y6;y7;y8;y9;y10;y11;y12;y13;y14;y15;y16;y17;y18;y19;y20;y21];
  end DeMultiplexN;

  block LimPID
    "P, PI, PD, and PID controller with limited output, anti-windup compensation and setpoint weighting"
    import Modelica.Blocks.Types.InitPID;
    import Modelica.Blocks.Types.SimpleController;
    extends Modelica.Blocks.Interfaces.SVcontrol;
    output Real controlError = u_s - u_m
      "Control error (set point - measurement)";

    parameter Modelica.Blocks.Types.SimpleController controllerType=
           Modelica.Blocks.Types.SimpleController.PID "Type of controller";
    parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small, start=1)
      "Time constant of Integrator block" 
       annotation(Dialog(enable=controllerType==SimpleController.PI or 
                                controllerType==SimpleController.PID));
    parameter Modelica.SIunits.Time Td(min=0, start=0.1)
      "Time constant of Derivative block" 
         annotation(Dialog(enable=controllerType==SimpleController.PD or 
                                  controllerType==SimpleController.PID));
    parameter Real yMax(start=1) "Upper limit of output";
    parameter Real yMin=-yMax "Lower limit of output";
    parameter Real wp(min=0) = 1
      "Set-point weight for Proportional block (0..1)";
    parameter Real wd(min=0) = 0 "Set-point weight for Derivative block (0..1)"
         annotation(Dialog(enable=controllerType==SimpleController.PD or 
                                  controllerType==SimpleController.PID));
    parameter Real Ni(min=100*Modelica.Constants.eps) = 0.9
      "Ni*Ti is time constant of anti-windup compensation" 
       annotation(Dialog(enable=controllerType==SimpleController.PI or 
                                controllerType==SimpleController.PID));
    parameter Real Nd(min=100*Modelica.Constants.eps) = 10
      "The higher Nd, the more ideal the derivative block" 
         annotation(Dialog(enable=controllerType==SimpleController.PD or 
                                  controllerType==SimpleController.PID));
    parameter Modelica.Blocks.Types.InitPID initType= Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
      "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                       annotation(Evaluate=true,
        Dialog(group="Initialization"));
    parameter Boolean limitsAtInit = true
      "= false, if limits are ignored during initializiation" 
      annotation(Evaluate=true, Dialog(group="Initialization",
                         enable=controllerType==SimpleController.PI or 
                                controllerType==SimpleController.PID));
    parameter Real xi_start=0
      "Initial or guess value value for integrator output (= integrator state)"
      annotation (Dialog(group="Initialization",
                  enable=controllerType==SimpleController.PI or 
                         controllerType==SimpleController.PID));
    parameter Real xd_start=0
      "Initial or guess value for state of derivative block" 
      annotation (Dialog(group="Initialization",
                           enable=controllerType==SimpleController.PD or 
                                  controllerType==SimpleController.PID));
    parameter Real y_start=0 "Initial value of output" 
      annotation(Dialog(enable=initType == InitPID.InitialOutput, group=
            "Initialization"));

    annotation (defaultComponentName="PID",
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
          Polygon(
            points={{90,-80},{68,-72},{68,-88},{90,-80}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-80,50},{-80,-20},{30,60},{80,60}}, color={0,
                0,127}),
          Text(
            extent={{-20,-20},{80,-60}},
            lineColor={192,192,192},
            textString="PID")}),
      Documentation(info="<HTML>
<p>
Via parameter <b>controllerType</b> either <b>P</b>, <b>PI</b>, <b>PD</b>,
or <b>PID</b> can be selected. If, e.g., PI is selected, all components belonging to the
D-part are removed from the block (via conditional declarations).
The example model
<a href=\"Modelica://Modelica.Blocks.Examples.PID_Controller\">Modelica.Blocks.Examples.PID_Controller</a>
demonstrates the usage of this controller.
Several practical aspects of PID controller design are incorporated
according to chapter 3 of the book:
</p>

<dl>
<dt>&Aring;str&ouml;m K.J., and H&auml;gglund T.:</dt>
<dd> <b>PID Controllers: Theory, Design, and Tuning</b>.
     Instrument Society of America, 2nd edition, 1995.
</dd>
</dl>

<p>
Besides the additive <b>proportional, integral</b> and <b>derivative</b>
part of this controller, the following features are present:
</p>
<ul>
<li> The output of this controller is limited. If the controller is
     in its limits, anti-windup compensation is activated to drive
     the integrator state to zero. </li>
<li> The high-frequency gain of the derivative part is limited
     to avoid excessive amplification of measurement noise.</li>
<li> Setpoint weighting is present, which allows to weight
     the setpoint in the proportional and the derivative part
     independantly from the measurement. The controller will respond
     to load disturbances and measurement noise independantly of this setting
     (parameters wp, wd). However, setpoint changes will depend on this
     setting. For example, it is useful to set the setpoint weight wd
     for the derivative part to zero, if steps may occur in the
     setpoint signal.</li>
</ul>

<p>
The parameters of the controller can be manually adjusted by performing
simulations of the closed loop system (= controller + plant connected
together) and using the following strategy:
</p>

<ol>
<li> Set very large limits, e.g., yMax = Modelica.Constants.inf</li>
<li> Select a <b>P</b>-controller and manually enlarge parameter <b>k</b>
     (the total gain of the controller) until the closed-loop response
     cannot be improved any more.</li>
<li> Select a <b>PI</b>-controller and manually adjust parameters
     <b>k</b> and <b>Ti</b> (the time constant of the integrator).
     The first value of Ti can be selected, such that it is in the
     order of the time constant of the oscillations occuring with
     the P-controller. If, e.g., vibrations in the order of T=10 ms
     occur in the previous step, start with Ti=0.01 s.</li>
<li> If you want to make the reaction of the control loop faster
     (but probably less robust against disturbances and measurement noise)
     select a <b>PID</b>-Controller and manually adjust parameters
     <b>k</b>, <b>Ti</b>, <b>Td</b> (time constant of derivative block).</li>
<li> Set the limits yMax and yMin according to your specification.</li>
<li> Perform simulations such that the output of the PID controller
     goes in its limits. Tune <b>Ni</b> (Ni*Ti is the time constant of
     the anti-windup compensation) such that the input to the limiter
     block (= limiter.u) goes quickly enough back to its limits.
     If Ni is decreased, this happens faster. If Ni=infinity, the
     anti-windup compensation is switched off and the controller works bad.</li>
</ol>

<p>
<b>Initialization</b>
</p>

<p>
This block can be initialized in different
ways controlled by parameter <b>initType</b>. The possible
values of initType are defined in
<a href=\"Modelica://Modelica.Blocks.Types.InitPID\">Modelica.Blocks.Types.InitPID</a>.
This type is identical to
<a href=\"Modelica://Modelica.Blocks.Types.Init\">Types.Init</a>,
with the only exception that the additional option
<b>DoNotUse_InitialIntegratorState</b> is added for
backward compatibility reasons (= integrator is initialized with
InitialState whereas differential part is initialized with
NoInit which was the initialization in version 2.2 of the Modelica
standard library).
</p>

<p>
Based on the setting of initType, the integrator (I) and derivative (D)
blocks inside the PID controller are initialized according to the following table:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>initType</b></td>
      <td valign=\"top\"><b>I.initType</b></td>
      <td valign=\"top\"><b>D.initType</b></td></tr>

  <tr><td valign=\"top\"><b>NoInit</b></td>
      <td valign=\"top\">NoInit</td>
      <td valign=\"top\">NoInit</td></tr>

  <tr><td valign=\"top\"><b>SteadyState</b></td>
      <td valign=\"top\">SteadyState</td>
      <td valign=\"top\">SteadyState</td></tr>

  <tr><td valign=\"top\"><b>InitialState</b></td>
      <td valign=\"top\">InitialState</td>
      <td valign=\"top\">InitialState</td></tr>

  <tr><td valign=\"top\"><b>InitialOutput</b><br>
          and initial equation: y = y_start</td>
      <td valign=\"top\">NoInit</td>
      <td valign=\"top\">SteadyState</td></tr>

  <tr><td valign=\"top\"><b>DoNotUse_InitialIntegratorState</b></td>
      <td valign=\"top\">InitialState</td>
      <td valign=\"top\">NoInit</td></tr>
</table>

<p>
In many cases, the most useful initial condition is
<b>SteadyState</b> because initial transients are then no longer
present. If initType = InitPID.SteadyState, then in some
cases difficulties might occur. The reason is the
equation of the integrator:
</p>

<pre>
   <b>der</b>(y) = k*u;
</pre>

<p>
The steady state equation \"der(x)=0\" leads to the condition that the input u to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <b>singular</b>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is natural to
initialize it with zero. As sketched this is, however, not possible.
The solution is to not initialize u_m or the variable that is used
to compute u_m by an algebraic equation.
</p>

<p>
If parameter <b>limitAtInit</b> = <b>false</b>, the limits at the
output of this controller block are removed from the initialization problem which
leads to a much simpler equation system. After initialization has been
performed, it is checked via an assert whether the output is in the
defined limits. For backward compatibility reasons
<b>limitAtInit</b> = <b>true</b>. In most cases it is best
to use <b>limitAtInit</b> = <b>false</b>.
</p>
</HTML>
"),   Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));

    Modelica.Blocks.Math.Add addP(k1=wp, k2=-1) 
      annotation (Placement(transformation(extent={{-80,40},{-60,60}}, rotation=
             0)));
    Modelica.Blocks.Math.Add addD(k1=wd, k2=-1) if with_D 
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}},
            rotation=0)));
    Modelica.Blocks.Math.Gain P(k=1) 
                       annotation (Placement(transformation(extent={{-40,40},{
              -20,60}}, rotation=0)));
    Modelica.Blocks.Continuous.Integrator I(
      y_start=xi_start,
      initType=if initType == InitPID.SteadyState then InitPID.SteadyState else 
          if initType == InitPID.InitialState or initType == InitPID.DoNotUse_InitialIntegratorState then 
                InitPID.InitialState else InitPID.NoInit,
      k=1/Ti) if                                             with_I 
      annotation (Placement(transformation(extent={{-40,-60},{-20,-40}},
            rotation=0)));
    Modelica.Blocks.Continuous.Derivative D(
      k=Td,
      T=max([Td/Nd,1.e-14]),
      x_start=xd_start,
      initType=if initType == InitPID.SteadyState or initType == InitPID.InitialOutput then 
                InitPID.SteadyState else if initType == InitPID.InitialState then 
                InitPID.InitialState else InitPID.NoInit) if with_D 
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
            rotation=0)));
    Modelica.Blocks.Math.Add3 addPID 
                            annotation (Placement(transformation(
            extent={{7,12},{27,32}},  rotation=0)));
    Modelica.Blocks.Math.Add3 addI(k2=-1) if with_I 
                                           annotation (Placement(
          transformation(extent={{-80,-60},{-60,-40}}, rotation=0)));
    Modelica.Blocks.Math.Add addSat(k1=+1, k2=-1) if with_I 
      annotation (Placement(transformation(
          origin={80,-50},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Blocks.Math.Gain gainTrack(k=1/Ni) if     with_I 
      annotation (Placement(transformation(extent={{7,-87},{-13,-67}}, rotation=
             0)));
    Modelica.Blocks.Nonlinear.Limiter limiter(
      uMax=yMax,
      uMin=yMin,
      limitsAtInit=limitsAtInit) 
      annotation (Placement(transformation(extent={{71,36},{91,56}},  rotation=
              0)));
  protected
    parameter Boolean with_I = controllerType==SimpleController.PI or 
                               controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
    parameter Boolean with_D = controllerType==SimpleController.PD or 
                               controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
  public
    Modelica.Blocks.Sources.Constant Dzero(k=0) if not with_D 
      annotation (Placement(transformation(extent={{-30,20},{-20,30}}, rotation=
             0)));
    Modelica.Blocks.Sources.Constant Izero(k=0) if not with_I 
      annotation (Placement(transformation(extent={{10,-55},{0,-45}}, rotation=
              0)));
    Modelica.Blocks.Math.Product product 
      annotation (Placement(transformation(extent={{43,7},{63,27}})));
    Modelica.Blocks.Interfaces.RealInput P_gain
      "Connector of Real input signal 2" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={-100,-121})));
    Modelica.Blocks.Math.Division division 
      annotation (Placement(transformation(extent={{60,-87},{40,-67}})));
    Modelica.Blocks.Math.Division division1 
      annotation (Placement(transformation(extent={{-4,-27},{16,-7}})));
    Modelica.Blocks.Interfaces.RealInput T_i "PI controller integrator time" 
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={98,-121})));
  initial equation
    if initType==InitPID.InitialOutput then
       y = y_start;
    end if;
  equation
    assert(yMax >= yMin, "LimPID: Limits must be consistent. However, yMax (=" + String(yMax) +
                         ") < yMin (=" + String(yMin) + ")");
    if initType == InitPID.InitialOutput and (y_start < yMin or y_start > yMax) then
        Modelica.Utilities.Streams.error("LimPID: Start value y_start (=" + String(y_start) +
           ") is outside of the limits of yMin (=" + String(yMin) +") and yMax (=" + String(yMax) + ")");
    end if;
    assert(limitsAtInit or not limitsAtInit and y >= yMin and y <= yMax,
           "LimPID: During initialization the limits have been switched off.\n" +
           "After initialization, the output y (=" + String(y) +
           ") is outside of the limits of yMin (=" + String(yMin) +") and yMax (=" + String(yMax) + ")");

    connect(u_s, addP.u1) annotation (Line(points={{-120,0},{-96,0},{-96,56},{
            -82,56}}, color={0,0,127}));
    connect(u_s, addD.u1) annotation (Line(points={{-120,0},{-96,0},{-96,6},{
            -82,6}}, color={0,0,127}));
    connect(u_s, addI.u1) annotation (Line(points={{-120,0},{-96,0},{-96,-42},{
            -82,-42}}, color={0,0,127}));
    connect(addP.y, P.u) annotation (Line(points={{-59,50},{-42,50}}, color={0,
            0,127}));
    connect(addD.y, D.u) 
      annotation (Line(points={{-59,0},{-42,0}}, color={0,0,127}));
    connect(addI.y, I.u) annotation (Line(points={{-59,-50},{-42,-50}}, color={
            0,0,127}));
    connect(P.y, addPID.u1) annotation (Line(points={{-19,50},{-10,50},{-10,30},{5,
            30}},    color={0,0,127}));
    connect(D.y, addPID.u2) 
      annotation (Line(points={{-19,0},{-10,0},{-10,22},{5,22}},
                                                color={0,0,127}));
    connect(limiter.y, addSat.u1) annotation (Line(points={{92,46},{94,46},{94,-20},
            {86,-20},{86,-38}},      color={0,0,127}));
    connect(limiter.y, y) 
      annotation (Line(points={{92,46},{101,46},{101,0},{110,0}},
                                                color={0,0,127}));
    connect(gainTrack.y, addI.u3) annotation (Line(points={{-14,-77},{-88,-77},{-88,
            -58},{-82,-58}},     color={0,0,127}));
    connect(u_m, addP.u2) annotation (Line(
        points={{0,-120},{0,-92},{-92,-92},{-92,44},{-82,44}},
        color={0,0,127},
        thickness=0.5));
    connect(u_m, addD.u2) annotation (Line(
        points={{0,-120},{0,-92},{-92,-92},{-92,-6},{-82,-6}},
        color={0,0,127},
        thickness=0.5));
    connect(u_m, addI.u2) annotation (Line(
        points={{0,-120},{0,-92},{-92,-92},{-92,-50},{-82,-50}},
        color={0,0,127},
        thickness=0.5));
    connect(Dzero.y, addPID.u2) annotation (Line(points={{-19.5,25},{-14,25},{-14,
            22},{5,22}},    color={0,0,127}));
    connect(addPID.y, product.u1) annotation (Line(
        points={{28,22},{27,22},{27,23},{41,23}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(product.y, limiter.u) annotation (Line(
        points={{64,17},{62,17},{62,46},{69,46}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(addSat.u2, product.y) annotation (Line(
        points={{74,-38},{66,-38},{66,17},{64,17}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(product.u2, P_gain) annotation (Line(
        points={{41,11},{41,-61},{-100,-61},{-100,-121}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(division.u1, addSat.y) annotation (Line(
        points={{62,-71},{71,-71},{71,-61},{80,-61}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(division.u2, P_gain) annotation (Line(
        points={{62,-83},{74,-83},{74,-96},{-100,-96},{-100,-121}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gainTrack.u, division.y) annotation (Line(
        points={{9,-77},{39,-77}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(I.y, division1.u1) annotation (Line(
        points={{-19,-50},{-14,-50},{-14,-11},{-6,-11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Izero.y, division1.u1) annotation (Line(
        points={{-0.5,-50},{-11,-50},{-11,-11},{-6,-11}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(division1.u2, T_i) annotation (Line(
        points={{-6,-23},{-20,-23},{-20,-34},{65,-34},{65,-121},{98,-121}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(division1.y, addPID.u3) annotation (Line(
        points={{17,-17},{20,-17},{20,-16},{22,-16},{22,8},{-5,8},{-5,14},{5,14}},
        color={0,0,127},
        smooth=Smooth.None));

  end LimPID;
end LH_v3;
