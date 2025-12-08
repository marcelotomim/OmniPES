within OmniPES.Circuit.Sources;

model CurrentSource
  extends Icons.Isource;
  extends Circuit.Interfaces.ShuntComponent;
  import OmniPES.Math.polar2cart;
  import Modelica.Units.SI;
  parameter SI.PerUnit magnitude = 0.0 "current magnitude";
  parameter SI.Angle angle(displayUnit="deg") = 0.0 "current phase";
equation
  i = -polar2cart(magnitude, angle);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.ShuntComponent\">OmniPES.Circuit.Interfaces.ShuntComponent</a>: Base one-terminal shunt connector</li>
  <li><a href=\"modelica://OmniPES.Math.polar2cart\">OmniPES.Math.polar2cart</a>: Polar-to-Cartesian conversion used for complex current</li>
  <li><a href=\"modelica://OmniPES.Icons.Isource\">OmniPES.Icons.Isource</a>: Source icon base</li>
  <li><a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>: Per-unit magnitude and angle types</li>
</ul>
</body></html>"));
end CurrentSource;