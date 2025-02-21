within OmniPES.SteadyState.Examples.PSCC24;

model tutorial_system_SVR_SS
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(transformation(origin = {-89, -35}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(transformation(origin = {-89, 34}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus10 annotation(
    Placement(transformation(origin = {-13, -35}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus20 annotation(
    Placement(transformation(origin = {-13, 34}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus30 annotation(
    Placement(transformation(origin = {90, -33}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo1(x = 0.2) annotation(
    Placement(transformation(origin = {-52, -35}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo2(x = 0.07) annotation(
    Placement(transformation(origin = {-52, 34}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.SeriesImpedance line1(x = 0.07) annotation(
    Placement(transformation(origin = {39, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line21(x = 0.18) annotation(
    Placement(transformation(origin = {60, -35}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line22(t_open = 2500, x = 0.18) annotation(
    Placement(transformation(origin = {60, -53}, extent = {{-10, -10}, {10, 10}})));
  replaceable OmniPES.SteadyState.Sources.VTHSource_Qlim_sigmoid G1(Qmax = 2.6e7, Vsp = 1.017, useExternalVoltageSpec = true, useExternalPowerSpec = false) annotation(
    Placement(transformation(origin = {-126, -35}, extent = {{-21, -21}, {21, 21}}, rotation = 180)));
  replaceable OmniPES.SteadyState.Sources.PVSource_Qlim_sigmoid G2(Psp = 9e7, Qmax = 7.8e7, Vsp = 1.025, useExternalVoltageSpec = true, useExternalPowerSpec = true) annotation(
    Placement(transformation(origin = {-127.5, 33.5}, extent = {{-21.5, -21.5}, {21.5, 21.5}}, rotation = 180)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData loadData annotation(
    Placement(transformation(origin = {120, -8}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp rampP (duration = 140, height = 140e6, startTime = 0) annotation(
    Placement(transformation(origin = {-199, -26}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = 3/4)  annotation(
    Placement(transformation(origin = {-161.5, 25.5}, extent = {{-6.5, -6.5}, {6.5, 6.5}})));
  Real ref2, ref1;
  OmniPES.SteadyState.Loads.ZIPLoad load(Psp = 1.2e8, Qsp = 0, ss_par = loadData, useExternalPsp = true, useExternalQsp = false) annotation(
    Placement(transformation(origin = {126.056, -77.9444}, extent = {{-10, -11.1111}, {10, 8.88886}}, rotation = -90)));
  OmniPES.SystemData data annotation(
    Placement(transformation(origin = {76.5, 36.5}, extent = {{-14.5, -14.5}, {14.5, 14.5}})));
equation
  bus30.V = 1.0;
  G1.S.im = (1/3)*G2.S.im;
  G1.dVsp = ref1;
  G2.dVsp = ref2;
  connect(G2.p, bus2.p) annotation(
    Line(points = {{-105.57, 33.5}, {-108.82, 33.5}, {-108.82, 34}, {-89, 34}}, color = {0, 0, 255}));
  connect(bus2.p, trafo2.p) annotation(
    Line(points = {{-89, 34}, {-63, 34}}, color = {0, 0, 255}));
  connect(trafo2.n, bus20.p) annotation(
    Line(points = {{-41, 34}, {-13, 34}}, color = {0, 0, 255}));
  connect(bus1.p, trafo1.p) annotation(
    Line(points = {{-89, -35}, {-63, -35}}, color = {0, 0, 255}));
  connect(trafo1.n, bus10.p) annotation(
    Line(points = {{-41, -35}, {-13, -35}}, color = {0, 0, 255}));
  connect(bus20.p, line1.p) annotation(
    Line(points = {{-13, 34}, {38.3, 34}, {38.3, 14}, {39.3, 14}}, color = {0, 0, 255}));
  connect(line22.p, bus10.p) annotation(
    Line(points = {{50.4, -53}, {-13, -53}, {-13, -35}}, color = {0, 0, 255}));
  connect(line1.n, bus10.p) annotation(
    Line(points = {{38.8, -8}, {38.8, -35}, {-13, -35}}, color = {0, 0, 255}));
  connect(gain.y, G2.dPsp) annotation(
    Line(points = {{-154.35, 25.5}, {-154.35, 26}, {-142.35, 26}}, color = {0, 0, 127}));
  connect(rampP.y, gain.u) annotation(
    Line(points = {{-188, -26}, {-180, -26}, {-180, 25.5}, {-169, 25.5}}, color = {0, 0, 127}));
  connect(line21.p, bus10.p) annotation(
    Line(points = {{50.4, -35}, {-13, -35}}, color = {0, 0, 255}));
  connect(line21.n, bus30.p) annotation(
    Line(points = {{70, -35.2}, {90, -35.2}}, color = {0, 0, 255}));
  connect(G1.p, bus1.p) annotation(
    Line(points = {{-104.58, -35}, {-89, -35}}, color = {0, 0, 255}));
  connect(line22.n, bus30.p) annotation(
    Line(points = {{70, -53}, {90, -53}, {90, -35}}, color = {0, 0, 255}));
  connect(load.p, bus30.p) annotation(
    Line(points = {{125, -68}, {125, -33}, {90, -33}}, color = {0, 0, 255}));
  connect(load.dPsp, rampP.y) annotation(
    Line(points = {{118, -74}, {-180, -74}, {-180, -26}, {-188, -26}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
  experiment(StartTime = 0, StopTime = 119.5, Tolerance = 1e-06, Interval = 0.001),
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end tutorial_system_SVR_SS;