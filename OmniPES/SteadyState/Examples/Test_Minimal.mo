within OmniPES.SteadyState.Examples;

model Test_Minimal
  OmniPES.SteadyState.Sources.VTHSource voltageSource annotation(
    Placement(visible = true, transformation(origin = {-84, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 50, r = 0, x = 0.05) annotation(
    Placement(visible = true, transformation(origin = {39, -5}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-77, 69}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-58, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Sources.PQSource pQSource(P = 100, Q = 0) annotation(
    Placement(visible = true, transformation(origin = {86, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {68, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {6, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer twoWindingTransformer(tap = 1.05, x = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.ZIPLoad zIPLoad(Psp = 50, Qsp = 10, ss_par = loadData) annotation(
    Placement(visible = true, transformation(origin = {6, -60}, extent = {{-22, -22}, {22, 22}}, rotation = -90)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData loadData(pi = 0.75, qz = 1) annotation(
    Placement(visible = true, transformation(origin = {-38, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(voltageSource.p, bus1.p) annotation(
    Line(points = {{-84, 0.2}, {-58, 0.2}}, color = {0, 0, 255}));
  connect(tLine.n, bus3.p) annotation(
    Line(points = {{55.5, -0.5}, {59.5, -0.5}, {59.5, -1.5}, {67, -1.5}}, color = {0, 0, 255}));
  connect(pQSource.p, bus3.p) annotation(
    Line(points = {{86, 0.2}, {68, 0.2}}, color = {0, 0, 255}));
  connect(tLine.p, bus2.p) annotation(
    Line(points = {{22.5, -0.5}, {6.5, -0.5}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.p, bus1.p) annotation(
    Line(points = {{-37, 0}, {-59, 0}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.n, bus2.p) annotation(
    Line(points = {{-15, 0}, {5, 0}}, color = {0, 0, 255}));
  connect(bus2.p, zIPLoad.p) annotation(
    Line(points = {{6, 0}, {6, -38}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Test_Minimal;