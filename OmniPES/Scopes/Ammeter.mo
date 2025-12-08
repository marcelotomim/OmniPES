within OmniPES.Scopes;

model Ammeter
  extends Circuit.Interfaces.SeriesComponent;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.arg;
  import Modelica.ComplexMath.abs;
  import Modelica.Units.SI;
  SI.PerUnit I;
  SI.ComplexPerUnit S;
  SI.Angle theta;
equation
  I = abs(p.i);
  theta = arg(p.i);
  S = p.v*conj(p.i);
  v = Complex(0);
  annotation(
    Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, endAngle = 360), Text(origin = {0, 1}, extent = {{-26, 25}, {26, -25}}, textString = "A"), Line(origin = {-70, 0}, points = {{-30, 0}, {30, 0}}), Line(origin = {70, 0}, points = {{-30, 0}, {30, 0}})}),
    Documentation(info="<html><body>
<h4>Description</h4>
<p>The Ammeter model is an ideal series measurement component that measures the magnitude, phase angle, and complex power of the current flowing through a branch. Being ideal, it has zero voltage drop across its terminals and does not affect the network solution.</p>

<h4>Model Structure</h4>
<p>This model extends <strong>Circuit.Interfaces.SeriesComponent</strong>, making it compatible with the series element framework in the OmniPES library.</p>

<h4>Model Variables</h4>
<ul>
  <li><strong>I</strong> [SI.PerUnit]: Magnitude of the current in per-unit values</li>
  <li><strong>theta</strong> [SI.Angle]: Phase angle of the current in radians</li>
  <li><strong>S</strong> [SI.ComplexPerUnit]: Complex apparent power</li>
  <li><strong>v</strong> [Complex]: Voltage across the ammeter (constrained to zero)</li>
  <li><strong>i</strong> [Complex]: Current through the ammeter (from p.i)</li>
</ul>

<h4>Usage</h4>
<p>Insert the Ammeter component in series with other circuit elements to measure:</p>
<ul>
  <li>Current flowing through a branch</li>
  <li>Current phase angle with respect to system reference</li>
  <li>Real and reactive power flow through the branch</li>
</ul>
<p>The ammeter is transparent to the circuit (zero impedance) and does not affect the network equations or solution.</p>

<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.SeriesComponent\">Circuit.Interfaces.SeriesComponent</a>: Base partial model for series elements</li>
</ul>
</body></html>"));
end Ammeter;