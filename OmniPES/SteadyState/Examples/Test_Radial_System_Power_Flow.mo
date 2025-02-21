within OmniPES.SteadyState.Examples;

model Test_Radial_System_Power_Flow
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-66, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 0.98) annotation(
    Placement(transformation(origin = {-106, 18}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {52, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.01) annotation(
    Placement(transformation(origin = {76, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
    Placement(transformation(origin = {-70, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.SteadyState.Sources.PVSource pVSource(Psp = 1e8, Vsp = 1.0) annotation(
    Placement(transformation(origin = {123, 17}, extent = {{-13, -13}, {13, 13}})));
  OmniPES.Circuit.Interfaces.Bus bus annotation(
    Placement(visible = true, transformation(origin = {94, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 1.5e8, r = 0, x = 0.1) annotation(
    Placement(transformation(origin = {2, 20}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.SteadyState.Loads.ZIPLoad zip(Psp = 1e8, Qsp = 5e7, ss_par = load_data) annotation(
    Placement(transformation(origin = {-46, -28}, extent = {{-14, -14}, {14, 14}}, rotation = -90)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData load_data annotation(
    Placement(transformation(origin = {-48, -66}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TLine_switched tLine_switched( r = 0, t_open_p = 2, t_open_n = 2, x = 0.1, Q = 1.5e8) annotation(
    Placement(transformation(origin = {2, -8}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(voltageSource.p, impedance2.n) annotation(
    Line(points = {{-94, 18}, {-80, 18}}, color = {0, 0, 255}));
  connect(impedance2.p, bus1.p) annotation(
    Line(points = {{-60, 18}, {-46.8, 18}}, color = {0, 0, 255}));
  connect(bus2.p, impedance1.n) annotation(
    Line(points = {{52, 16}, {66, 16}}, color = {0, 0, 255}));
  connect(impedance1.p, bus.p) annotation(
    Line(points = {{86, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(pVSource.p, bus.p) annotation(
    Line(points = {{110, 17}, {105.5, 17}, {105.5, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(tLine.n, bus2.p) annotation(
    Line(points = {{13, 23}, {13, 22}, {52, 22}, {52, 16}}, color = {0, 0, 255}));
  connect(tLine.p, bus1.p) annotation(
    Line(points = {{-9, 23}, {-9, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
  connect(zip.p, bus1.p) annotation(
    Line(points = {{-46, -14}, {-46, 18}}, color = {0, 0, 255}));
  connect(tLine_switched.p, bus1.p) annotation(
    Line(points = {{-9, -5}, {-38, -5}, {-38, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(tLine_switched.n, bus2.p) annotation(
    Line(points = {{13, -5}, {38, -5}, {38, 16}, {52, 16}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end Test_Radial_System_Power_Flow;