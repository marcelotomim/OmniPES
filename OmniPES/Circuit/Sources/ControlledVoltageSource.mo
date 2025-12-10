within OmniPES.Circuit.Sources;

model ControlledVoltageSource
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import OmniPES.Math.polar2cart;
  Modelica.Units.SI.ComplexPerUnit S "generate apparent power";
  Modelica.ComplexBlocks.Interfaces.ComplexInput u annotation(
    Placement(transformation(origin = {-62, -48}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {75, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  v = u;
  S = -v*conj(i);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.ShuntComponent\">OmniPES.Circuit.Interfaces.ShuntComponent</a>: Base one-terminal shunt connector</li>
  <li><a href=\"modelica://Modelica.ComplexMath.conj\">Modelica.ComplexMath.conj</a>: Conjugate used for apparent power</li>
  <li><a href=\"modelica://Modelica.ComplexBlocks.Interfaces.ComplexInput\">Modelica.ComplexBlocks.Interfaces.ComplexInput</a>: Complex input connector</li>
  <li><a href=\"modelica://OmniPES.Icons.Vsource\">OmniPES.Icons.Vsource</a>: Source icon base</li>
  <li><a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>: Apparent power units</li>
</ul>
</body></html>"));
end ControlledVoltageSource;