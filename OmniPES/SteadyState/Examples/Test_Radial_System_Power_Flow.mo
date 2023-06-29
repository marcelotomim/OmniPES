within OmniPES.SteadyState.Examples;

model Test_Radial_System_Power_Flow
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-66, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 0.98) annotation(
    Placement(visible = true, transformation(origin = {-96, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {52, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.01) annotation(
    Placement(visible = true, transformation(origin = {74, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.SteadyState.Sources.PVSource pVSource(Psp = 100, Vsp = 1.0) annotation(
    Placement(visible = true, transformation(origin = {115, 3}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
  OmniPES.Circuit.Interfaces.Bus bus annotation(
    Placement(visible = true, transformation(origin = {94, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 150, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {2, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.ZIPLoad zip(Psp = 100, Qsp = 50, ss_par = load_data) annotation(
    Placement(visible = true, transformation(origin = {-46, -40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData load_data annotation(
    Placement(visible = true, transformation(origin = {-46, -64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine_switched tLine_switched(Q = 150, r = 0, t_open = 2, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {0, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(voltageSource.p, impedance2.n) annotation(
    Line(points = {{-96, 20}, {-80, 20}}, color = {0, 0, 255}));
  connect(impedance2.p, bus1.p) annotation(
    Line(points = {{-60, 20}, {-50.4, 20}, {-50.4, 18}, {-46.8, 18}}, color = {0, 0, 255}));
  connect(bus2.p, impedance1.n) annotation(
    Line(points = {{52, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(impedance1.p, bus.p) annotation(
    Line(points = {{84, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(pVSource.p, bus.p) annotation(
    Line(points = {{115, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(tLine.n, bus2.p) annotation(
    Line(points = {{14, 30}, {38, 30}, {38, 22}, {52, 22}, {52, 16}}, color = {0, 0, 255}));
  connect(tLine.p, bus1.p) annotation(
    Line(points = {{-8, 30}, {-34, 30}, {-34, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
  connect(zip.p, bus1.p) annotation(
    Line(points = {{-46, -30}, {-46, 18}}, color = {0, 0, 255}));
  connect(tLine_switched.p, bus1.p) annotation(
    Line(points = {{-10, -8}, {-38, -8}, {-38, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(tLine_switched.n, bus2.p) annotation(
    Line(points = {{12, -8}, {38, -8}, {38, 16}, {52, 16}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end Test_Radial_System_Power_Flow;