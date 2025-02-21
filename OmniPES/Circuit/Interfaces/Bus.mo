within OmniPES.Circuit.Interfaces;

model Bus
  import Modelica.Units.SI;
  import Modelica.ComplexMath.arg;
  import Modelica.ComplexMath.abs;
  PositivePin p(v.re(start = 1.0)) annotation(
    Placement(transformation(extent = {{-100, -100}, {100, 100}}), iconTransformation(origin = {3, 2.98023e-08}, extent = {{-10, -100}, {10, 100}})));
  SI.PerUnit V(start = 1.0) "node voltage magnitude";
  SI.Angle angle(start = 0, displayUnit = "deg")  "node voltage phase";
equation
  V = abs(p.v);
  angle = arg(p.v);
  p.i = Complex(0);
  annotation(
    Icon(graphics = {Rectangle(origin = {-7, 3}, extent = {{1, 97}, {13, -105}}), Text(origin = {0, 142}, textColor = {26, 95, 180}, extent = {{-150, 30}, {150, -30}}, textString = "%name")}));
end Bus;