within OmniPES.Circuit.Basic;

model SeriesImpedance_switched
  parameter Modelica.Units.SI.PerUnit r = 0;
  parameter Modelica.Units.SI.PerUnit x = 0;
  parameter Modelica.Units.SI.Time t_open = 0.3;
  OmniPES.Circuit.Basic.SeriesImpedance Z(r = r, x = x)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.NegativePin n annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Switches.TimedBreaker brk(t_open = t_open)  annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Z.n, n) annotation(
    Line(points = {{10, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(brk.p, p) annotation(
    Line(points = {{-60, 0}, {-102, 0}}, color = {0, 0, 255}));
  connect(brk.n, Z.p) annotation(
    Line(points = {{-40, 0}, {-10, 0}}, color = {0, 0, 255}));

 annotation(
    Icon(graphics = {Rectangle(origin = {1, -1}, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-13, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {14, 0}}), Text(extent = {{-60, 33}, {60, -33}}, textString = "SW")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end SeriesImpedance_switched;