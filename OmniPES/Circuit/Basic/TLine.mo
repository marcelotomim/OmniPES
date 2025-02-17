within OmniPES.Circuit.Basic;

model TLine
  import Modelica.Units.SI;
  outer SystemData data;
  parameter SI.PerUnit r "series resistance";
  parameter SI.PerUnit x "series reactance";
  parameter SI.ReactivePower Q(displayUnit="Mvar") "capacitive loading";
  final parameter SI.ReactivePower Qmin(displayUnit="Mvar") = 1e-5 "minimum capacitive loading";
  Circuit.Interfaces.PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.NegativePin n annotation(
    Placement(visible = true, transformation(origin = {40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  final parameter SI.ComplexPerUnit Y = 1/Complex(r, x);
  final parameter SI.ComplexPerUnit Ysh = Complex(0.0, Q/2/data.Sbase) if Q > Qmin;
equation

if Q > Qmin then
  p.i = (Y+Ysh)*p.v - Y*n.v;
  n.i = (Y+Ysh)*n.v - Y*p.v;
else
  p.i + n.i = Complex(0.0);
  p.i = Y*(p.v - n.v);
end if;

  annotation(
    Icon(graphics = {Line(origin = {-80, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Rectangle(origin = {-60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {-60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {-60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {-60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Line(origin = {60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {0, 30}, rotation = -90, extent = {{-10, 20}, {10, -20}}), Line(origin = {-40, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {40, 30}, points = {{20, 0}, {-20, 0}}), Line(origin = {80, 30}, points = {{-20, 0}, {20, 0}})}, coordinateSystem(initialScale = 0.1)));
end TLine;