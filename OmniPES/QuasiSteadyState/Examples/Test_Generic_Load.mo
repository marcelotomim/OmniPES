within OmniPES.QuasiSteadyState.Examples;

model Test_Generic_Load
  inner OmniPES.SystemData data(Sbase = 100, fb = 60) annotation(
    Placement(visible = true, transformation(origin = {-117, 81}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Loads.ZIPLoad zip(Psp = 100., Qsp = 50., ss_par = ssData, dyn_par = dynData) annotation(
    Placement(visible = true, transformation(origin = {95, -3}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(magnitude = 1.09) annotation(
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData ssData(pi = 0, pz = 0, qi = 0, qz = 0) annotation(
    Placement(visible = true, transformation(origin = {68, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.30) annotation(
    Placement(visible = true, transformation(origin = {-24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData dynData(pi = 0, pz = 1, qi = 0, qz = 1) annotation(
    Placement(visible = true, transformation(origin = {92, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
    Line(points = {{-33.6, 0}, {-85.6, 0}}, color = {0, 0, 255}));
  connect(impedance.n, bus.p) annotation(
    Line(points = {{-14, -0.2}, {28, -0.2}, {28, -2.2}}, color = {0, 0, 255}));
  connect(impedance1.p, impedance.p) annotation(
    Line(points = {{-33.6, -22}, {-39.6, -22}, {-39.6, 0}, {-33.6, 0}, {-33.6, 0}}, color = {0, 0, 255}));
  connect(bus.p, ammeter.p) annotation(
    Line(points = {{27.8, -2}, {37.8, -2}, {37.8, -2}, {37.8, -2}}, color = {0, 0, 255}));
  connect(ammeter.n, zip.p) annotation(
    Line(points = {{58, -2.2}, {63, -2.2}, {63, -3}, {80, -3}}, color = {0, 0, 255}));
  connect(impedance1.n, brk1.p) annotation(
    Line(points = {{-14, -22}, {-6, -22}}, color = {0, 0, 255}));
  connect(brk1.n, bus.p) annotation(
    Line(points = {{14, -22}, {16, -22}, {16, -2}, {28, -2}}, color = {0, 0, 255}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-6, Interval = 0.006));
end Test_Generic_Load;