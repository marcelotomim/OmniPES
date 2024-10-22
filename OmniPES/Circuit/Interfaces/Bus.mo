within OmniPES.Circuit.Interfaces;

model Bus
  import Modelica.Units.SI;
  import Modelica.ComplexMath.arg;
  import Modelica.ComplexMath.abs;
  PositivePin p(v.re(start = 1.0)) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-100, -100}, {100, 100}}, rotation = 0), iconTransformation(origin = {-2, -20}, extent = {{-15, -150}, {15, 150}}, rotation = 0)));
  Modelica.Units.SI.PerUnit V(start = 1.0);
  SI.Angle angle(start = 0, displayUnit = "deg");
equation
  V = abs(p.v);
  angle = arg(p.v);
  p.i = Complex(0);
  annotation(
    Icon(graphics = {Rectangle(origin = {-7, 3}, extent = {{1, 97}, {13, -105}}), Text(origin = {-5, 163}, lineColor = {0, 0, 255}, extent = {{-83, 41}, {83, -41}}, textString = "%name")}));
end Bus;
