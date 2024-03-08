within OmniPES.SteadyState.Examples.PSCC24;

model tutorial_system
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {63, 50}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-100, -13}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-100, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus10 annotation(
    Placement(visible = true, transformation(origin = {-24, -13}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus20 annotation(
    Placement(visible = true, transformation(origin = {-24, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus30 annotation(
    Placement(visible = true, transformation(origin = {79, -13}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo1(x = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-64, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo2(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {-64, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance line1(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {28, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line21(x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {49, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line22(t_open = 2500, x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {49, -33}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.ZIPLoad load(Psp = 120, Qsp = 0, ss_par = loadData, useExternalPsp = true, useExternalQsp = false) annotation(
    Placement(visible = true, transformation(origin = {108.5, -15.4444}, extent = {{-18.5, -20.5556}, {18.5, 16.4444}}, rotation = 0)));
  replaceable OmniPES.SteadyState.Sources.VTHSource_Qlim_sigmoid G1(Qmax = 26, Vsp = 1.017, angle = 0.0, useExternalVoltageSpec = false, useExternalPowerSpec = false) annotation(
    Placement(visible = true, transformation(origin = {-142, -36}, extent = {{-21, -21}, {21, 21}}, rotation = -90)));
  replaceable OmniPES.SteadyState.Sources.PVSource_Qlim_sigmoid G2(Psp = 90, Qmax = 78, Vsp = 1.025, useExternalVoltageSpec = false, useExternalPowerSpec = true) annotation(
    Placement(visible = true, transformation(origin = {-139.5, 32.5}, extent = {{-21.5, -21.5}, {21.5, 21.5}}, rotation = -90)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {109, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampP(duration = 100, height = 100, startTime = 25) annotation(
    Placement(visible = true, transformation(origin = {-210, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 3/4) annotation(
    Placement(transformation(origin = {-173.5, 41.5}, extent = {{-6.5, -6.5}, {6.5, 6.5}})));
equation
  connect(G2.p, bus2.p) annotation(
    Line(points = {{-139.5, 54}, {-100, 54}}, color = {0, 0, 255}));
  connect(bus2.p, trafo2.p) annotation(
    Line(points = {{-100, 54}, {-75, 54}}, color = {0, 0, 255}));
  connect(trafo2.n, bus20.p) annotation(
    Line(points = {{-53, 54}, {-24, 54}}, color = {0, 0, 255}));
  connect(bus1.p, trafo1.p) annotation(
    Line(points = {{-100.2, -15}, {-75, -15}}, color = {0, 0, 255}));
  connect(trafo1.n, bus10.p) annotation(
    Line(points = {{-53, -15}, {-24, -15}}, color = {0, 0, 255}));
  connect(bus20.p, line1.p) annotation(
    Line(points = {{-24, 54}, {27, 54}, {27, 32}, {28, 32}}, color = {0, 0, 255}));
  connect(line22.p, bus10.p) annotation(
    Line(points = {{39, -33}, {-24, -33}, {-24, -15}}, color = {0, 0, 255}));
  connect(load.p, bus30.p) annotation(
    Line(points = {{90, -15}, {79, -15}}, color = {0, 0, 255}));
  connect(line1.n, bus10.p) annotation(
    Line(points = {{28, 12}, {28, -15}, {-24, -15}}, color = {0, 0, 255}));
  connect(gain.y, G2.dPsp) annotation(
    Line(points = {{-166, 41.5}, {-155, 41.5}, {-155, 41}, {-156, 41}}, color = {0, 0, 127}));
  connect(rampP.y, gain.u) annotation(
    Line(points = {{-199, -6}, {-191, -6}, {-191, 41.5}, {-181, 41.5}}, color = {0, 0, 127}));
  connect(line21.p, bus10.p) annotation(
    Line(points = {{39, -15}, {-24, -15}}, color = {0, 0, 255}));
  connect(line21.n, bus30.p) annotation(
    Line(points = {{59, -15}, {79, -15}}, color = {0, 0, 255}));
  connect(rampP.y, load.dPsp) annotation(
    Line(points = {{-199, -6}, {-191, -6}, {-191, -69}, {101, -69}, {101, -30}}, color = {0, 0, 127}));
  connect(G1.p, bus1.p) annotation(
    Line(points = {{-142, -15}, {-100, -15}}, color = {0, 0, 255}));
  connect(line22.n, bus30.p) annotation(
    Line(points = {{59, -33}, {79, -33}, {79, -15}}, color = {0, 0, 255}));
  annotation(
    Icon(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.1),
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS_V,LOG_STATS,LOG_STATS_V", s = "dassl", variableFilter = ".*"));
end tutorial_system;