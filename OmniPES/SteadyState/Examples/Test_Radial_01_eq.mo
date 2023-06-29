within OmniPES.SteadyState.Examples;

model Test_Radial_01_eq
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.Circuit.Basic.TLine_eq tLine(Q = 0, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-18, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {12, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1) annotation(
    Placement(visible = true, transformation(origin = {-70, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.TLine_eq tLine1(Q = 0, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {54, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {96, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.SteadyState.Sources.PVSource pVSource(Psp = 60., Vsp = 0.95) annotation(
    Placement(visible = true, transformation(origin = {4, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(tLine.p, bus1.p) annotation(
    Line(points = {{-29, 23}, {-34, 23}, {-34, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
  connect(tLine.n, bus2.p) annotation(
    Line(points = {{-7, 23}, {12, 23}, {12, 17}}, color = {0, 0, 255}));
  connect(bus2.p, tLine1.p) annotation(
    Line(points = {{11.88, 16.8}, {43, 16.8}, {43, 17}}, color = {0, 0, 255}));
  connect(tLine1.n, bus3.p) annotation(
    Line(points = {{65, 17}, {96, 17}}, color = {0, 0, 255}));
  connect(voltageSource.p, bus1.p) annotation(
    Line(points = {{-70, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(pVSource.p, bus2.p) annotation(
    Line(points = {{4, -8}, {4, 16}, {12, 16}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end Test_Radial_01_eq;