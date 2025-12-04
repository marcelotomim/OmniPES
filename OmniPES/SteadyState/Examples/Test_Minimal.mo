within OmniPES.SteadyState.Examples;

model Test_Minimal
  OmniPES.SteadyState.Sources.VTHSource voltageSource annotation(
    Placement(transformation(origin = {-88, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 5e7, r = 0, x = 0.05) annotation(
    Placement(transformation(origin = {37, -5}, extent = {{-15, -15}, {15, 15}})));
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {-69, 61}, extent = {{-19, -19}, {19, 19}})));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(transformation(origin = {-60, 2}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.SteadyState.Sources.PQSource pQSource(Psp = 1e8, Qsp = 0, voltage_limits = false) annotation(
    Placement(transformation(origin = {88, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(transformation(origin = {66, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(transformation(origin = {4, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer twoWindingTransformer(tap = 1.05, x = 0.01) annotation(
    Placement(transformation(origin = {-28, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.SteadyState.Loads.ZIPLoad load(Psp = 5e7, Qsp = 1e7, ss_par = loadData) annotation(
    Placement(transformation(origin = {5, -37}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData loadData(pi = 0.75, qz = 1) annotation(
    Placement(transformation(origin = {-30, -48}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(voltageSource.p, bus1.p) annotation(
    Line(points = {{-77.8, 0}, {-72.8, 0}, {-72.8, 0.2}, {-59.8, 0.2}}, color = {0, 0, 255}));
  connect(tLine.n, bus3.p) annotation(
    Line(points = {{53.5, -0.5}, {57.5, -0.5}, {57.5, 0}, {66, 0}}, color = {0, 0, 255}));
  connect(pQSource.p, bus3.p) annotation(
    Line(points = {{77.8, 0}, {65.8, 0}}, color = {0, 0, 255}));
  connect(tLine.p, bus2.p) annotation(
    Line(points = {{20.5, -0.5}, {12.5, -0.5}, {12.5, 0}, {4, 0}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.p, bus1.p) annotation(
    Line(points = {{-39, 0}, {-61, 0}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.n, bus2.p) annotation(
    Line(points = {{-17, 0}, {4, 0}}, color = {0, 0, 255}));
  connect(bus2.p, load.p) annotation(
    Line(points = {{4, 0}, {4, -13}, {5, -13}, {5, -26}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Test_Minimal;