within ;
package LH_v2
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
  model HVAC_v2

    inner Modelica.Fluid.System system 
      annotation (Placement(transformation(extent={{-94,-88},{-74,-68}})));
    //replaceable package MediumA = Buildings.Media.IdealGases.SimpleAir;
    replaceable package MediumA = Buildings.Media.GasesPTDecoupled.SimpleAir;
    replaceable package MediumB = Buildings.Media.ConstantPropertyLiquidWater;
    parameter Modelica.SIunits.Volume VRoo=800 "Room volume";
    parameter Modelica.SIunits.ThermalConductance UA=200 "UA value of room" annotation(Evaluate=false);
    parameter Modelica.SIunits.HeatFlowRate Q_sen_d=8000
      "Fixed heat flow rate at port" annotation(Evaluate=false);
    Modelica.Blocks.Continuous.LimPID DmprC(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=60,
      Td=60,
      yMax=-0.3,
      yMin=-1,
      k=1) "VAV damper controller" 
      annotation (Placement(transformation(extent={{184,96},{204,116}})));
    Buildings.Fluid.Actuators.Dampers.VAVBoxExponential VAV(redeclare package
        Medium = MediumA,
      use_v_nominal=true,
      dp_nominal=P_vd,
      A=1,
      allowFlowReversal=false,
      m_flow_nominal=m_a_cc_d,
      v_nominal=3.6) "VAV box serving the single zone" 
      annotation (Placement(transformation(extent={{232,34},{252,54}})));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{380,180}}),
                           graphics), Icon(coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{380,180}})));
    Modelica.Blocks.Sources.Constant Tc(k=297.15) "room temp cooling set point"
      annotation (Placement(transformation(extent={{132,130},{152,150}})));
    parameter Modelica.SIunits.Pressure P_vd = 3;
    parameter Modelica.SIunits.SpecificHeatCapacity cp_a=1005;
    parameter Modelica.SIunits.SpecificHeatCapacity cp_w=4200;
    Buildings.Fluid.Movers.FlowMachine_y SupF(
      redeclare package Medium = MediumA,
      redeclare function efficiencyCharacteristic = 
          Buildings.Fluid.Movers.BaseClasses.Characteristics.constantEfficiency
          ( eta_nominal=0.8),
      use_y_in=true,
      V=0.5,
      redeclare function flowCharacteristic = 
          Buildings.Fluid.Movers.BaseClasses.Characteristics.quadraticFlow (
            V_flow_nominal={1.888,2.36,2.832}, dp_nominal={540.6,460.8,386.1}))
      "Supply air fan" 
      annotation (Placement(transformation(extent={{188,33},{202,47}})));

    Modelica.Fluid.Sources.MassFlowSource_T Boi(
      redeclare package Medium = MediumB,
      use_m_flow_in=true,
      T=T_ew_hc_d,
      nPorts=1) "Boiler" 
      annotation (Placement(transformation(extent={{-9,-9.5},{9,9.5}},
          rotation=90,
          origin={113,7.5})));

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
      annotation (Placement(transformation(extent={{-18,26},{8,54}})));
    Buildings.Fluid.Sources.Boundary_pT Amb(
      redeclare package Medium = MediumA,
      nPorts=3,
      use_p_in=false,
      use_T_in=true) "ambient condition" 
      annotation (Placement(transformation(extent={{-72,28},{-50,50}})));
    Buildings.Fluid.FixedResistances.FixedResistanceDpM filter(redeclare
        package Medium = 
                 MediumA,
      dp_nominal=dp_fil_d,
      allowFlowReversal=false,
      m_flow_nominal=m_a_cc_d) 
      annotation (Placement(transformation(extent={{54,36},{74,56}})));
    Buildings.Fluid.HeatExchangers.HeaterCoolerPrescribed RHC(redeclare package
        Medium = MediumA,
      Q_flow_nominal=Q_rhc_d,
      dp_nominal=dp_rhc_d,
      allowFlowReversal=false,
      m_flow_nominal=m_a_cc_d) "VAV Box reheat coil" 
      annotation (Placement(transformation(extent={{278,34},{298,54}})));
    Buildings.Fluid.Sensors.Temperature Tmix(redeclare package Medium = MediumA)
      "Mixed air temperature" 
      annotation (Placement(transformation(extent={{6,60},{26,80}})));
    Modelica.Blocks.Continuous.LimPID EcoC(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=60,
      Td=60,
      y_start=0,
      yMax=-0.1,
      yMin=-1) "Economizer controller" 
      annotation (Placement(transformation(extent={{-36,102},{-16,122}})));
    Buildings.Fluid.Sensors.Temperature Tsa(redeclare package Medium = MediumA)
      "supplied air temperature" 
      annotation (Placement(transformation(extent={{212,4},{232,24}})));
    Modelica.Blocks.Continuous.LimPID CCC(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=60,
      Td=60,
      k=1,
      y_start=0,
      yMax=0,
      yMin=-1) "cooling coil controller" 
      annotation (Placement(transformation(extent={{158,-62},{178,-42}})));
    Modelica.Blocks.Sources.Constant Tssp(k=288.15) "supply air temp set point"
      annotation (Placement(transformation(extent={{124,-76},{144,-56}})));
    Modelica.Blocks.Continuous.LimPID HCC(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=60,
      Td=60,
      yMin=0,
      yMax=1) "heating coil controller" 
      annotation (Placement(transformation(extent={{92,-62},{112,-42}})));
    Modelica.Blocks.Continuous.LimPID RHCC(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=60,
      Td=60,
      yMin=0,
      k=1.5,
      yMax=1) "reheat coil controller" 
      annotation (Placement(transformation(extent={{240,96},{260,116}})));
    Modelica.Blocks.Continuous.LimPID FanC(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ti=60,
      Td=60,
      yMax=1,
      y_start=0,
      yMin=0.3,
      k=1) "fan speed controller" 
      annotation (Placement(transformation(extent={{134,96},{154,116}})));
    Buildings.Fluid.Sensors.Pressure pressure(redeclare package Medium = MediumA) 
      annotation (Placement(transformation(extent={{208,56},{228,76}})));
    Modelica.Blocks.Sources.Constant Prsp(k=250 + 101325)
      "duct static press set point" 
      annotation (Placement(transformation(extent={{92,96},{112,116}})));
    parameter Modelica.SIunits.HeatFlowRate Q_rhc_d=20000
      "Heat flow rate at u=1, positive for heating";
    parameter Modelica.SIunits.Pressure dp_rhc_d=87 "Pressure";
    parameter Modelica.SIunits.Pressure dp_fil_d=100
      "filter design pressure drop";
    Modelica.Blocks.Math.Gain gain(k=m_a_hc_d) 
      annotation (Placement(transformation(extent={{64,-22},{84,-2}})));
    Buildings.Fluid.Sources.Boundary_pT Amb1(
      use_p_in=false,
      redeclare package Medium = MediumB,
      use_T_in=false,
      nPorts=1,
      p=100000) "ambient condition" 
      annotation (Placement(transformation(extent={{54,2},{76,24}})));
    Buildings.Fluid.Sources.Boundary_pT Amb2(
      use_p_in=false,
      redeclare package Medium = MediumB,
      use_T_in=false,
      nPorts=1,
      p=100000) "ambient condition" 
      annotation (Placement(transformation(extent={{-11,-11},{11,11}},
          rotation=90,
          origin={143,9})));
    Modelica.Fluid.Sources.MassFlowSource_T chiller(
      redeclare package Medium = MediumB,
      use_m_flow_in=true,
      T=T_ew_cc_d,
      nPorts=1) "simple chiller model" 
      annotation (Placement(transformation(extent={{-9,-9.5},{9,9.5}},
          rotation=90,
          origin={189,1.5})));
    Modelica.Blocks.Math.Gain gain1(k=-1*m_a_cc_d) 
      annotation (Placement(transformation(extent={{192,-62},{212,-42}})));
    Buildings.Fluid.Delays.DelayFirstOrder del(
      nPorts=3,
      redeclare package Medium = MediumA,
      tau=20,
      m_flow_nominal=m_a_cc_d) 
      annotation (Placement(transformation(extent={{28,46},{48,66}})));

    Room room(
      nPorts=2,
      redeclare package MediumA = MediumA,
      VRoo=VRoo,
      UA=UA,
      Q_sen_d=Q_sen_d) 
      annotation (Placement(transformation(extent={{330,72},{366,108}})));
    Modelica.Blocks.Sources.Sine TOutBC(
      freqHz=1/86400,
      offset=283.15,
      amplitude=5,
      phase=-1.5707963267949) "Outside air temperature" 
      annotation (Placement(transformation(extent={{4,364},{24,384}})));
    Modelica.Blocks.Sources.Sine TOutBC1(
      freqHz=1/86400,
      offset=283.15,
      amplitude=5,
      phase=-1.5707963267949) "Outside air temperature" 
      annotation (Placement(transformation(extent={{4,364},{24,384}})));
    Modelica.Blocks.Sources.Sine TOutBC2(
      freqHz=1/86400,
      offset=283.15,
      amplitude=5,
      phase=-1.5707963267949) "Outside air temperature" 
      annotation (Placement(transformation(extent={{4,364},{24,384}})));
    Modelica.Blocks.Sources.Sine OAT(
      freqHz=1/86400,
      offset=303.15,
      amplitude=3,
      phase=-1.5707963267949) "OAT" 
      annotation (Placement(transformation(extent={{-4,138},{16,158}})));
    parameter Modelica.SIunits.MassFlowRate m_a_cc_d=2.31
      "Q_cc_d/cp_a/12.7cooling coil air side nominal mass flow rate";
    parameter Modelica.SIunits.MassFlowRate m_a_hc_d=Q_hc_d/cp_a/15
      "heating coil air side nominal mass flow rate";
    parameter Modelica.SIunits.MassFlowRate m_w_cc_d=Q_cc_d/cp_w/5.58
      "Nominal mass flow rate";
    parameter Modelica.SIunits.Temperature T_ea_cc_d = 26.7+273.15
      "cooling coil entering air temp at design condition";
    parameter Modelica.SIunits.Temperature T_la_cc_d = 26.7+273.15-Q_cc_d/cp_a/m_a_cc_d
      "cooling coil entering air temp at design condition";
    parameter Modelica.SIunits.Temperature T_ew_cc_d = 7.2+273.15
      "cooling coil enetering chilled water temp at design condition" 
                                                                     annotation(Evaluate=false);
    parameter Modelica.SIunits.HeatFlowRate Q_cc_d=29454
      "cooling coil design cooling capacity";
    parameter Modelica.SIunits.Pressure dp_a_cc_d=165
      "cooling coil air side design pressure drop";
    parameter Modelica.SIunits.Pressure dp_w_cc_d=4783
      "cooling coil design chilled water pressure drop";
    parameter Modelica.SIunits.MassFlowRate m_w_hc_d=Q_hc_d/cp_w/11
      "heating coil design mass flow rate";
    parameter Modelica.SIunits.Pressure dp_a_hc_d=28.6
      "heating coil air side design pressure drop";
    parameter Modelica.SIunits.Pressure dp_w_hc_d=2989
      "heating coil design hot water pressure drop";
    parameter Modelica.SIunits.HeatFlowRate Q_hc_d=37015
      "heating coil design capacity";
    parameter Modelica.SIunits.Temperature T_ea_hc_d = 15.6+273.15
      "heating coil entering air temp at design condition";
    parameter Modelica.SIunits.Temperature T_ew_hc_d = 82.2+273.15
      "heating coil enetering hot water temp at design condition";
     Buildings.Fluid.FixedResistances.FixedResistanceDpM Duct(
      redeclare package Medium = MediumA,
      allowFlowReversal=false,
      m_flow_nominal=m_a_cc_d,
      dp_nominal=dp_dt_d) "total duct work" 
      annotation (Placement(transformation(extent={{318,34},{338,54}})));
    parameter Modelica.SIunits.Pressure dp_dt_d=100
      "total duct work pressure drop at design condition";
    Modelica.Blocks.Math.Gain gain2(k=-1) 
      annotation (Placement(transformation(extent={{266,-4},{286,16}})));
    Modelica.Blocks.Sources.Step step(
      height=-2,
      offset=297.15,
      startTime=1200) 
      annotation (Placement(transformation(extent={{94,132},{114,152}})));
    Buildings.Fluid.HeatExchangers.ConstantEffectiveness HC(
      redeclare package Medium1 = MediumA,
      redeclare package Medium2 = MediumB,
      m1_flow_nominal=m_a_hc_d,
      m2_flow_nominal=m_w_hc_d,
      dp1_nominal=dp_a_hc_d,
      dp2_nominal=dp_w_hc_d,
      eps=eps_hc) "heating coil" 
      annotation (Placement(transformation(extent={{92,34},{112,54}})));
    Buildings.Fluid.HeatExchangers.ConstantEffectiveness CC(redeclare package
        Medium1 = MediumA, redeclare package Medium2 = MediumB,
      m1_flow_nominal=m_a_cc_d,
      m2_flow_nominal=m_w_cc_d,
      dp1_nominal=dp_a_cc_d,
      dp2_nominal=dp_w_cc_d,
      eps=eps_cc) "cooling coil" 
      annotation (Placement(transformation(extent={{142,32},{162,52}})));
    parameter Real eps_hc=15/(T_ew_hc_d-T_ea_hc_d)
      "heating coil heat exchange effectiveness";
    parameter Real eps_cc=(T_ea_cc_d-T_la_cc_d)/(T_ea_cc_d-T_ew_cc_d)
      "cooling coil heat exchange effectiveness";
    Modelica.Blocks.Sources.Constant Tmsp(k=283.15) "mixed air temp set point" 
      annotation (Placement(transformation(extent={{-72,104},{-52,124}})));
    Modelica.Blocks.Sources.Constant Th(k=290.15) "room temp heating set point"
      annotation (Placement(transformation(extent={{186,136},{206,156}})));
    Buildings.Fluid.Sensors.Temperature Tsa_h(redeclare package Medium = 
          MediumA) "supplied air temperature after heating coil" 
      annotation (Placement(transformation(extent={{118,52},{138,72}})));
    Modelica.Blocks.Sources.Constant Tssp1(k=284.15)
      "supply air temp set point" 
      annotation (Placement(transformation(extent={{52,-60},{72,-40}})));
    Modelica.Blocks.Math.Gain gain3(k=-1) 
      annotation (Placement(transformation(extent={{-42,64},{-22,84}})));
    Buildings.Utilities.IO.BCVTB.BCVTB cliBCVTB(
      samplePeriod=60,
      nDblWri=2,
      nDblRea=2,
      uStart={297.15,288.15})
      annotation (Placement(transformation(extent={{-44,-22},{-24,-2}})));
    Modelica.Blocks.Routing.Multiplex2 multiplex2_1
      annotation (Placement(transformation(extent={{-80,-22},{-60,-2}})));
    Modelica.Blocks.Routing.DeMultiplex2 deMultiplex2_1
      annotation (Placement(transformation(extent={{-6,-22},{14,-2}})));
  equation
    connect(Amb.ports[2], Econ.port_Out) annotation (Line(
        points={{-50,39},{-34,39},{-34,37.2},{-18.26,37.2}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Amb.ports[3], Econ.port_Exh) annotation (Line(
        points={{-50,36.0667},{-34,36.0667},{-34,28.8},{-18.26,28.8}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(SupF.port_b, VAV.port_a) annotation (Line(
        points={{202,40},{226,40},{226,44},{232,44}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(VAV.port_b, RHC.port_a) annotation (Line(
        points={{252,44},{278,44}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pressure.port, SupF.port_b) annotation (Line(
        points={{218,56},{212,56},{212,40},{202,40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tsa.port, SupF.port_b) annotation (Line(
        points={{222,4},{222,-4},{212,-4},{212,40},{202,40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pressure.p, FanC.u_m) annotation (Line(
        points={{229,66},{236,66},{236,84},{144,84},{144,94}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Prsp.y, FanC.u_s) annotation (Line(
        points={{113,106},{132,106}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tsa.T, CCC.u_m) annotation (Line(
        points={{229,14},{234,14},{234,-78},{168,-78},{168,-64}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tmix.T, EcoC.u_m) annotation (Line(
        points={{23,70},{34,70},{34,90},{-26,90},{-26,100}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(RHCC.y, RHC.u) annotation (Line(
        points={{261,106},{266,106},{266,50},{276,50}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(FanC.y, SupF.y_in) annotation (Line(
        points={{155,106},{166,106},{166,60},{195,60},{195,47}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(HCC.y, gain.u) annotation (Line(
        points={{113,-52},{122,-52},{122,-28},{52,-28},{52,-12},{62,-12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, Boi.m_flow_in) annotation (Line(
        points={{85,-12},{105.4,-12},{105.4,-1.5}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(CCC.y, gain1.u) annotation (Line(
        points={{179,-52},{190,-52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain1.y, chiller.m_flow_in) 
                                     annotation (Line(
        points={{213,-52},{216,-52},{216,-50},{218,-50},{218,-18},{181.4,-18},{181.4,
            -7.5}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Econ.port_Sup, del.ports[1]) annotation (Line(
        points={{7.74,42.8},{22.87,42.8},{22.87,46},{35.3333,46}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(filter.port_a, del.ports[2]) annotation (Line(
        points={{54,46},{38,46}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tmix.port, del.ports[3]) annotation (Line(
        points={{16,60},{18,60},{18,46},{40.6667,46}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(room.ports[1], Econ.port_Ret) annotation (Line(
        points={{344.4,72},{352,72},{352,-96},{46,-96},{46,26},{8,26},{8,28.8}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(room.TRoo, RHCC.u_m) annotation (Line(
        points={{367.8,99.36},{368,99.36},{368,126},{286,126},{286,78},{262,78},{262,
            94},{250,94}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(room.TRoo, DmprC.u_m) annotation (Line(
        points={{367.8,99.36},{360,99.36},{360,134},{216,134},{216,86},{194,86},{194,
            94}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(RHC.port_b, Duct.port_a) annotation (Line(
        points={{298,44},{318,44}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Duct.port_b, room.ports[2]) annotation (Line(
        points={{338,44},{342,44},{342,72},{351.6,72}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(DmprC.y, gain2.u) annotation (Line(
        points={{205,106},{224,106},{224,84},{256,84},{256,6},{264,6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain2.y, VAV.y) annotation (Line(
        points={{287,6},{296,6},{296,24},{264,24},{264,62},{242,62},{242,52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(filter.port_b, HC.port_a1) annotation (Line(
        points={{74,46},{84,46},{84,50},{92,50}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Amb1.ports[1], HC.port_b2) annotation (Line(
        points={{76,13},{86,13},{86,38},{92,38}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(HC.port_a2, Boi.ports[1]) annotation (Line(
        points={{112,38},{112,26.25},{114,16.5},{113,16.5}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(HC.port_b1, CC.port_a1)                     annotation (Line(
        points={{112,50},{128,50},{128,48},{142,48}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(CC.port_b2, Amb2.ports[1])                     annotation (Line(
        points={{142,36},{142,20},{143,20}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(CC.port_a2, chiller.ports[1])                     annotation (Line(
        points={{162,36},{176,36},{176,10.5},{189,10.5}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(CC.port_b1, SupF.port_a)                     annotation (Line(
        points={{162,48},{176,48},{176,40},{188,40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tmsp.y, EcoC.u_s) annotation (Line(
        points={{-51,114},{-46,114},{-46,112},{-38,112}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Th.y, RHCC.u_s) annotation (Line(
        points={{207,146},{230,146},{230,112},{238,112},{238,106}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tsa_h.port, HC.port_b1) annotation (Line(
        points={{128,52},{120,52},{120,50},{112,50}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tsa_h.T, HCC.u_m) annotation (Line(
        points={{135,62},{136,62},{136,30},{132,30},{132,-34},{116,-34},{116,
            -76},{102,-76},{102,-64}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tssp1.y, HCC.u_s) annotation (Line(
        points={{73,-50},{82,-50},{82,-52},{90,-52}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(EcoC.y, gain3.u) annotation (Line(
        points={{-15,112},{-8,112},{-8,84},{-54,84},{-54,74},{-44,74}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain3.y, Econ.y) annotation (Line(
        points={{-21,74},{-18,74},{-18,60},{-36,60},{-36,48.4},{-20.6,48.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OAT.y, Amb.T_in) annotation (Line(
        points={{17,148},{26,148},{26,166},{-96,166},{-96,43.4},{-74.2,43.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OAT.y, room.TAmb) annotation (Line(
        points={{17,148},{30,148},{30,162},{298,162},{298,90},{326.4,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tsa.T, multiplex2_1.u2[1]) annotation (Line(
        points={{229,14},{244,14},{244,-90},{-54,-90},{-54,-46},{-92,-46},{-92,
            -18},{-82,-18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(room.TRoo, multiplex2_1.u1[1]) annotation (Line(
        points={{367.8,99.36},{374,99.36},{374,-84},{-64,-84},{-64,-36},{-96,
            -36},{-96,-6},{-82,-6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(multiplex2_1.y, cliBCVTB.uR) annotation (Line(
        points={{-59,-12},{-46,-12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(cliBCVTB.yR, deMultiplex2_1.u) annotation (Line(
        points={{-23,-12},{-8,-12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(deMultiplex2_1.y1[1], DmprC.u_s) annotation (Line(
        points={{15,-6},{22,-6},{22,-8},{34,-8},{34,122},{174,122},{174,106},{
            182,106}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(deMultiplex2_1.y2[1], CCC.u_s) annotation (Line(
        points={{15,-18},{24,-18},{24,-74},{150,-74},{150,-52},{156,-52}},
        color={0,0,127},
        smooth=Smooth.None));
  end HVAC_v2;

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

  block LimPID
    "P, PI, PD, and PID controller with limited output, anti-windup compensation and setpoint weighting"
    import Modelica.Blocks.Types.InitPID;
    import Modelica.Blocks.Types.SimpleController;
    extends Modelica.Blocks.Interfaces.SVcontrol;
    output Real controlError = u_s - u_m
      "Control error (set point - measurement)";

    parameter Modelica.Blocks.Types.SimpleController controllerType=
           Modelica.Blocks.Types.SimpleController.PID "Type of controller";
    RealInput k(start=1) "Gain of controller";
    parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small, start=0.5)
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
      k=1/Ti,
      y_start=xi_start,
      initType=if initType == InitPID.SteadyState then InitPID.SteadyState else 
          if initType == InitPID.InitialState or initType == InitPID.DoNotUse_InitialIntegratorState then 
                InitPID.InitialState else InitPID.NoInit) if with_I 
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
    Modelica.Blocks.Math.Gain gainPID(k=k) 
                                  annotation (Placement(transformation(extent={
              {30,-10},{50,10}}, rotation=0)));
    Modelica.Blocks.Math.Add3 addPID 
                            annotation (Placement(transformation(
            extent={{0,-10},{20,10}}, rotation=0)));
    Modelica.Blocks.Math.Add3 addI(k2=-1) if with_I 
                                           annotation (Placement(
          transformation(extent={{-80,-60},{-60,-40}}, rotation=0)));
    Modelica.Blocks.Math.Add addSat(k1=+1, k2=-1) if with_I 
      annotation (Placement(transformation(
          origin={80,-50},
          extent={{-10,-10},{10,10}},
          rotation=270)));
    Modelica.Blocks.Math.Gain gainTrack(k=1/(k*Ni)) if with_I 
      annotation (Placement(transformation(extent={{40,-80},{20,-60}}, rotation=
             0)));
    Modelica.Blocks.Nonlinear.Limiter limiter(
      uMax=yMax,
      uMin=yMin,
      limitsAtInit=limitsAtInit) 
      annotation (Placement(transformation(extent={{70,-10},{90,10}}, rotation=
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
      annotation (Placement(transformation(extent={{34,39},{54,59}})));
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
    connect(P.y, addPID.u1) annotation (Line(points={{-19,50},{-10,50},{-10,8},
            {-2,8}}, color={0,0,127}));
    connect(D.y, addPID.u2) 
      annotation (Line(points={{-19,0},{-2,0}}, color={0,0,127}));
    connect(I.y, addPID.u3) annotation (Line(points={{-19,-50},{-10,-50},{-10,
            -8},{-2,-8}}, color={0,0,127}));
    connect(addPID.y, gainPID.u) 
      annotation (Line(points={{21,0},{28,0}}, color={0,0,127}));
    connect(gainPID.y, addSat.u2) annotation (Line(points={{51,0},{60,0},{60,
            -20},{74,-20},{74,-38}}, color={0,0,127}));
    connect(gainPID.y, limiter.u) 
      annotation (Line(points={{51,0},{68,0}}, color={0,0,127}));
    connect(limiter.y, addSat.u1) annotation (Line(points={{91,0},{94,0},{94,
            -20},{86,-20},{86,-38}}, color={0,0,127}));
    connect(limiter.y, y) 
      annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
    connect(addSat.y, gainTrack.u) annotation (Line(points={{80,-61},{80,-70},{
            42,-70}}, color={0,0,127}));
    connect(gainTrack.y, addI.u3) annotation (Line(points={{19,-70},{-88,-70},{
            -88,-58},{-82,-58}}, color={0,0,127}));
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
    connect(Dzero.y, addPID.u2) annotation (Line(points={{-19.5,25},{-14,25},{
            -14,0},{-2,0}}, color={0,0,127}));
    connect(Izero.y, addPID.u3) annotation (Line(points={{-0.5,-50},{-10,-50},{
            -10,-8},{-2,-8}}, color={0,0,127}));
  end LimPID;
end LH_v2;
