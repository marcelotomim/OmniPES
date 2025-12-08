within OmniPES.Circuit.Basic;

model SeriesImpedance
  import Modelica.Units.SI;
  extends Circuit.Interfaces.SeriesComponent;
  parameter SI.PerUnit r = 0.0 "series resistance";
  parameter SI.PerUnit x = 0.0 "series reactance";
equation
  v = Complex(r, x)*i;
  annotation(
    Icon(graphics = {Rectangle(origin = {1, -1}, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-13, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {14, 0}})}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.SeriesComponent\">OmniPES.Circuit.Interfaces.SeriesComponent</a>: Base two-terminal series connector</li>
  <li><a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>: Per-unit resistance and reactance types</li>
</ul>
</body></html>"));
end SeriesImpedance;