within OmniPES.Circuit.Sources;

model VoltageSource
  import Modelica.Units.SI;
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import OmniPES.Math.polar2cart;
  parameter SI.PerUnit magnitude = 1.0 "voltage magnitude";
  parameter SI.Angle angle(displayUnit="deg") = 0.0 "voltage phase";
  SI.ComplexPerUnit S "generated apparent power";
equation
  v = polar2cart(magnitude, angle);
  S = -v*conj(i);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.ShuntComponent\">OmniPES.Circuit.Interfaces.ShuntComponent</a>: Base one-terminal shunt connector</li>
  <li><a href=\"modelica://OmniPES.Math.polar2cart\">OmniPES.Math.polar2cart</a>: Polar-to-Cartesian conversion used for complex voltage</li>
  <li><a href=\"modelica://Modelica.ComplexMath.conj\">Modelica.ComplexMath.conj</a>: Conjugate used for apparent power</li>
  <li><a href=\"modelica://OmniPES.Icons.Vsource\">OmniPES.Icons.Vsource</a>: Source icon base</li>
  <li><a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>: Per-unit magnitude and angle types</li>
</ul>
</body></html>"));
end VoltageSource;