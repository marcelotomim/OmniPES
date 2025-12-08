within OmniPES.Circuit.Basic;

model Ground
  Circuit.Interfaces.PositivePin p annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  p.v.re = 0;
  p.v.im = 0;
  annotation(
    Diagram,
    Icon(graphics = {Line(origin = {0, -40}, points = {{-60, 0}, {60, 0}, {60, 0}}), Line(origin = {0, -60}, points = {{-40, 0}, {40, 0}}), Line(origin = {0, -80}, points = {{-20, 0}, {20, 0}}), Line(origin = {0, -15}, points = {{0, 5}, {0, -25}})}, coordinateSystem(initialScale = 0.1)),
    Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.PositivePin\">OmniPES.Circuit.Interfaces.PositivePin</a>: Node pin fixed to ground potential</li>
</ul>
</body></html>"));
end Ground;