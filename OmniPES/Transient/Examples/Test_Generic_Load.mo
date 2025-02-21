within OmniPES.Transient.Examples;

model Test_Generic_Load
  inner OmniPES.SystemData data(Sbase = 1e8, fb = 60) annotation(
    Placement(transformation(origin = {-116, 74}, extent = {{-20, -20}, {20, 20}})));
  OmniPES.Transient.Loads.ZIPLoad zip(Psp = 1e8, Qsp = 5e7, ss_par = ssData, dyn_par = dynData) annotation(
    Placement(transformation(origin = {71, -25}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(magnitude = 1.09) annotation(
    Placement(transformation(origin = {-92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  parameter OmniPES.Transient.Loads.Interfaces.LoadData ssData(pi = 0, pz = 0, qi = 0, qz = 0) annotation(
    Placement(transformation(origin = {94, -10}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.30) annotation(
    Placement(visible = true, transformation(origin = {-24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Loads.Interfaces.LoadData dynData(pi = 0, pz = 1, qi = 0, qz = 1) annotation(
    Placement(transformation(origin = {126, -10}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus annotation(
    Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.30) annotation(
    Placement(visible = true, transformation(origin = {-24, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Scopes.Ammeter ammeter annotation(
    Placement(visible = true, transformation(origin = {48, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Switches.TimedBreaker brk1(t_open = 0.2) annotation(
    Placement(visible = true, transformation(origin = {4, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(impedance.p, voltageSource.p) annotation(
    Line(points = {{-33.6, 0}, {-82, 0}}, color = {0, 0, 255}));
  connect(impedance.n, bus.p) annotation(
    Line(points = {{-14, -0.2}, {28, -0.2}, {28, -2.2}}, color = {0, 0, 255}));
  connect(impedance1.p, impedance.p) annotation(
    Line(points = {{-33.6, -22}, {-39.6, -22}, {-39.6, 0}, {-33.6, 0}, {-33.6, 0}}, color = {0, 0, 255}));
  connect(bus.p, ammeter.p) annotation(
    Line(points = {{27.8, -2}, {37.8, -2}, {37.8, -2}, {37.8, -2}}, color = {0, 0, 255}));
  connect(ammeter.n, zip.p) annotation(
    Line(points = {{58, -2.2}, {71, -2.2}, {71, -10}}, color = {0, 0, 255}, thickness = 0.5));
  connect(impedance1.n, brk1.p) annotation(
    Line(points = {{-14, -22}, {-6, -22}}, color = {0, 0, 255}));
  connect(brk1.n, bus.p) annotation(
    Line(points = {{14, -22}, {16, -22}, {16, -2}, {28, -2}}, color = {0, 0, 255}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.006));
end Test_Generic_Load;