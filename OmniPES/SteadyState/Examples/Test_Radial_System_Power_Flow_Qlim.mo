within OmniPES.SteadyState.Examples;

model Test_Radial_System_Power_Flow_Qlim
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 0.98) annotation(
    Placement(visible = true, transformation(origin = {-108, -2}, extent = {{-22, -22}, {22, 22}}, rotation = -90)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {52, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.01) annotation(
    Placement(visible = true, transformation(origin = {74, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Interfaces.Bus bus annotation(
    Placement(visible = true, transformation(origin = {94, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 150, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {2, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine_switched tLine1(Q = 150, r = 0, t_open = 2, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {2, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.ZIPLoad zip(Psp = 100, Qsp = 50, ss_par = load_data) annotation(
    Placement(visible = true, transformation(origin = {-47, -35}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData load_data annotation(
    Placement(visible = true, transformation(origin = {-46, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Sources.PVSource_Qlim pVSource_Qlim(Psp = 100, Qmax = +3000, Qmin = -80, Vsp = 1.0) annotation(
    Placement(visible = true, transformation(origin = {133.556, -7}, extent = {{-23, -25.5556}, {23, 20.4444}}, rotation = -90)));
equation
  connect(voltageSource.p, impedance2.n) annotation(
    Line(points = {{-108, 20}, {-80, 20}}, color = {0, 0, 255}));
  connect(impedance2.p, bus1.p) annotation(
    Line(points = {{-60, 20}, {-50.4, 20}, {-50.4, 18}, {-46.8, 18}}, color = {0, 0, 255}));
  connect(bus2.p, impedance1.n) annotation(
    Line(points = {{52, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(impedance1.p, bus.p) annotation(
    Line(points = {{84, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(tLine.n, bus2.p) annotation(
    Line(points = {{14, 30}, {38, 30}, {38, 22}, {52, 22}, {52, 16}}, color = {0, 0, 255}));
  connect(tLine.p, bus1.p) annotation(
    Line(points = {{-8, 30}, {-34, 30}, {-34, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
  connect(zip.p, bus1.p) annotation(
    Line(points = {{-47, -20}, {-47, -6}, {-46, -6}, {-46, 18}}, color = {0, 0, 255}));
  connect(pVSource_Qlim.p, bus.p) annotation(
    Line(points = {{134, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(tLine1.p, bus1.p) annotation(
    Line(points = {{-9, -1}, {-34, -1}, {-34, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(tLine1.n, bus2.p) annotation(
    Line(points = {{13, -1}, {40, -1}, {40, 16}, {52, 16}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end Test_Radial_System_Power_Flow_Qlim;