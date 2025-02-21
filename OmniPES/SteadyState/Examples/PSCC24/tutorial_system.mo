within OmniPES.SteadyState.Examples.PSCC24;

model tutorial_system
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {107, 46}, extent = {{-23, -23}, {23, 23}})));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(transformation(origin = {-93, -21}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(transformation(origin = {-92, 50}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus10 annotation(
    Placement(transformation(origin = {-17, -19}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus20 annotation(
    Placement(transformation(origin = {-17, 50}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus30 annotation(
    Placement(transformation(origin = {86, -22}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo1(x = 0.2) annotation(
    Placement(transformation(origin = {-55, -21}, extent = {{-15, -15}, {15, 15}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo2(x = 0.07) annotation(
    Placement(transformation(origin = {-53, 50}, extent = {{-15, -15}, {15, 15}})));
  OmniPES.Circuit.Basic.SeriesImpedance line1(x = 0.07) annotation(
    Placement(transformation(origin = {13.5, 12.5}, extent = {{-13.5, -13.5}, {13.5, 13.5}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line21(x = 0.18) annotation(
    Placement(transformation(origin = {44.5, -21.5}, extent = {{-16.5, -16.5}, {16.5, 16.5}})));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line22(t_open = 2500, x = 0.18, open = false) annotation(
    Placement(transformation(origin = {45.5, -43.5}, extent = {{-15.5, -15.5}, {15.5, 15.5}})));
  OmniPES.SteadyState.Loads.ZIPLoad load(Psp = 1.2e8, Qsp = 0, useExternalPsp = true, useExternalQsp = false) annotation(
    Placement(transformation(origin = {133.945, -76.9444}, extent = {{-18, -20}, {18, 15.9999}}, rotation = -90)));
  replaceable OmniPES.SteadyState.Sources.VTHSource_Qlim_sigmoid G1(Qmax = 2.6e7, Vsp = 1.017, angle = 0.0, useExternalVoltageSpec = false, useExternalPowerSpec = false) annotation(
    Placement(transformation(origin = {-134, -21}, extent = {{-21, -21}, {21, 21}}, rotation = 180)));
  replaceable OmniPES.SteadyState.Sources.PVSource_Qlim_sigmoid G2(Psp = 9e7, Qmax = 7.8e7, Vsp = 1.025, useExternalVoltageSpec = false, useExternalPowerSpec = true) annotation(
    Placement(transformation(origin = {-127, 50}, extent = {{-21, -21}, {21, 21}}, rotation = 180)));
  Modelica.Blocks.Sources.Ramp rampP(duration = 140, height = 140e6, startTime = 0) annotation(
    Placement(transformation(origin = {-224, -8}, extent = {{-14, -14}, {14, 14}})));
  Modelica.Blocks.Math.Gain gain(k = 3/4) annotation(
    Placement(transformation(origin = {-173.5, 42.5}, extent = {{-11.5, -11.5}, {11.5, 11.5}})));
equation
  connect(bus2.p, trafo2.p) annotation(
    Line(points = {{-91.7, 50}, {-69.5, 50}}, color = {0, 0, 255}));
  connect(trafo2.n, bus20.p) annotation(
    Line(points = {{-36.5, 50}, {-17, 50}}, color = {0, 0, 255}));
  connect(bus1.p, trafo1.p) annotation(
    Line(points = {{-92.7, -21}, {-71.5, -21}}, color = {0, 0, 255}));
  connect(trafo1.n, bus10.p) annotation(
    Line(points = {{-38.5, -21}, {-17, -21}}, color = {0, 0, 255}));
  connect(line22.p, bus10.p) annotation(
    Line(points = {{30.62, -43.5}, {-17.38, -43.5}, {-17.38, -21}, {-16.98, -21}}, color = {0, 0, 255}));
  connect(line1.n, bus10.p) annotation(
    Line(points = {{13.23, -1}, {13.23, -21}, {-17.17, -21}}, color = {0, 0, 255}));
  connect(line21.p, bus10.p) annotation(
    Line(points = {{28.66, -21.5}, {14.36, -21.5}, {14.36, -21}, {-16.94, -21}}, color = {0, 0, 255}));
  connect(line21.n, bus30.p) annotation(
    Line(points = {{61, -21.83}, {86, -21.83}}, color = {0, 0, 255}));
  connect(G1.p, bus1.p) annotation(
    Line(points = {{-112.58, -21}, {-93, -21}}, color = {0, 0, 255}));
  connect(load.p, bus30.p) annotation(
    Line(points = {{131.945, -58.5844}, {131.945, -21.5844}, {85.9448, -21.5844}}, color = {0, 0, 255}));
  connect(gain.y, G2.dPsp) annotation(
    Line(points = {{-161, 42.5}, {-150.6, 42.5}, {-150.6, 42}, {-141, 42}}, color = {0, 0, 127}));
  connect(G2.p, bus2.p) annotation(
    Line(points = {{-106, 50}, {-91.15, 50}}, color = {0, 0, 255}));
  connect(line1.p, bus20.p) annotation(
    Line(points = {{13.5, 25.46}, {13.5, 50.06}, {-17, 50.06}}, color = {0, 0, 255}));
  connect(line22.n, bus30.p) annotation(
    Line(points = {{61, -43.5}, {86, -43.5}, {86, -22.5}}, color = {0, 0, 255}));
  connect(rampP.y, gain.u) annotation(
    Line(points = {{-209, -8}, {-199, -8}, {-199, 42.5}, {-187, 42.5}}, color = {0, 0, 127}));
  connect(rampP.y, load.dPsp) annotation(
    Line(points = {{-209, -8}, {-199, -8}, {-199, -70}, {119, -70}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1}), graphics = {Text(origin = {-157.5, 5}, extent = {{-1.5, -1}, {1.5, 1}}, textString = "text")}),
    experiment(StartTime = 0, StopTime = 101, Tolerance = 1e-06, Interval = 0.1),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS_V,LOG_STATS,LOG_STATS_V", s = "dassl", variableFilter = ".*"));
end tutorial_system;