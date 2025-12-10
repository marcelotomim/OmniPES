within OmniPES.Circuit.Basic;

model ShuntAdmittance
  import Modelica.Units.SI;
  extends Circuit.Interfaces.ShuntComponent;
  parameter SI.PerUnit g "parallel conductance";
  parameter SI.PerUnit b "parallel susceptance";
equation
  i = Complex(g, b)*v;
  annotation(
    Icon(graphics = {Rectangle(origin = {1, -1}, fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-27, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {24, 0}}), Line(origin = {112, 0}, points = {{0, 22}, {0, -22}}), Line(origin = {100, 0}, points = {{0, 30}, {0, -30}}), Line(origin = {122, 0}, points = {{0, 12}, {0, -12}})}, coordinateSystem(initialScale = 0.1)),
    Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.ShuntComponent\">OmniPES.Circuit.Interfaces.ShuntComponent</a>: Base one-terminal shunt connector</li>
  <li><a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>: Per-unit conductance and susceptance types</li>
</ul>
</body></html>"));
end ShuntAdmittance;