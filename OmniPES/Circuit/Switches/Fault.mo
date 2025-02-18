within OmniPES.Circuit.Switches;

model Fault
  import Modelica.Units.SI;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  parameter Modelica.Units.SI.PerUnit R = 0 "fault series resistance";
  parameter Modelica.Units.SI.PerUnit X = 1e-3 "fault series reactance";
  parameter SI.Time t_on = 0.1 "fault application time";
  parameter SI.Time t_off = 0.2 "fault clearing time";
  Circuit.Interfaces.PositivePin T annotation(
    Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1.77636e-15, 100}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Modelica.Units.SI.PerUnit If "fault current magnitude";
  Boolean on "auxiliary " annotation(HideResult = true);
  Boolean off "auxiliary " annotation(HideResult = true);
  Basic.ShuntImpedance shuntImpedance(r = R, x = X) annotation(
    Placement(transformation(origin = {0, 36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
protected
  Circuit.Switches.Breaker breaker annotation(
    Placement(visible = true, transformation(origin = {0, 76}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
initial equation
  breaker.open = true;
equation
  If = abs(T.i);
  on = time > t_on;
  off = time > t_off;
  when {on, off} then
    breaker.open = not pre(breaker.open);
  end when;
  connect(breaker.p, T) annotation(
    Line(points = {{0, 86}, {0, 110}}, color = {0, 0, 255}));
  connect(breaker.n, shuntImpedance.p) annotation(
    Line(points = {{0, 66}, {0, 46}}, color = {0, 0, 255}));
  annotation(
    Icon(coordinateSystem(grid = {0.5, 0.5}, initialScale = 0.1), graphics = {Rectangle(origin = {-15, -1}, extent = {{-45, 71}, {75, -71}}), Line(origin = {0, 86}, points = {{0, 16}, {0, -16}}), Polygon(origin = {-1, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, lineThickness = 0.5, points = {{-11, 60}, {-31, 28}, {-11, 28}, {-31, -4}, {-11, -4}, {-29, -52}, {21, -4}, {7, -4}, {27, 28}, {9, 28}, {29, 60}, {-11, 60}})}),
    Diagram(coordinateSystem(grid = {0.5, 0.5})),
    __OpenModelica_commandLineOptions = "");
end Fault;