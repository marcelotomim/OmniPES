within OmniPES.Circuit.Interfaces;

model IdealTransformer
  parameter Real a = 1.0 "Transformer ratio";
  PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NegativePin n annotation(
    Placement(visible = true, transformation(origin = {104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  p.v = a*n.v;
  n.i + a*p.i = Complex(0);
  annotation(
    Icon(graphics = {Line(origin = {72, 0}, points = {{-27, 0}, {30, 0}}), Line(origin = {-72, 0}, points = {{-30, 0}, {27, 0}}), Ellipse(origin = {-17, 0}, extent = {{-28, 28}, {28, -28}}, endAngle = 360), Ellipse(origin = {17, 0}, extent = {{-28, 28}, {28, -28}}, endAngle = 360), Ellipse(origin = {-48, 28}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}, endAngle = 360)}));
end IdealTransformer;