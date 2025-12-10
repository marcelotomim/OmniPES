within OmniPES.Transient.Examples;

model Test_Generic_Load_Default
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {-103, 67}, extent = {{-35, -35}, {35, 35}})));
  OmniPES.Transient.Loads.ZIPLoad zip(Psp = 1e8, Qsp = 5e7) annotation(
    Placement(transformation(origin = {93, -17}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(magnitude = 1.09) annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.30) annotation(
    Placement(visible = true, transformation(origin = {-24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus annotation(
    Placement(visible = true, transformation(origin = {28, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.30) annotation(
    Placement(visible = true, transformation(origin = {-24, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Scopes.Ammeter ammeter annotation(
    Placement(visible = true, transformation(origin = {48, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Switches.TimedBreaker brk1(t_open = 0.5) annotation(
    Placement(visible = true, transformation(origin = {6, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(impedance.p, voltageSource.p) annotation(
    Line(points = {{-33.6, 0}, {-80, 0}}, color = {0, 0, 255}));
  connect(impedance.n, bus.p) annotation(
    Line(points = {{-14, -0.2}, {28, -0.2}, {28, -2.2}}, color = {0, 0, 255}));
  connect(impedance1.p, impedance.p) annotation(
    Line(points = {{-33.6, -22}, {-39.6, -22}, {-39.6, 0}, {-33.6, 0}, {-33.6, 0}}, color = {0, 0, 255}));
  connect(bus.p, ammeter.p) annotation(
    Line(points = {{27.8, -2}, {37.8, -2}, {37.8, -2}, {37.8, -2}}, color = {0, 0, 255}));
  connect(ammeter.n, zip.p) annotation(
    Line(points = {{58, -2.2}, {63, -2.2}, {63, -2}, {93, -2}}, color = {0, 0, 255}, thickness = 0.5));
  connect(impedance1.n, brk1.p) annotation(
    Line(points = {{-14, -22}, {-4, -22}}, color = {0, 0, 255}));
  connect(brk1.n, bus.p) annotation(
    Line(points = {{16, -22}, {22, -22}, {22, -2}, {28, -2}}, color = {0, 0, 255}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    experiment(StartTime = 0, StopTime = 3, Tolerance = 1e-06, Interval = 0.006));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Test_Generic_Load_Default;