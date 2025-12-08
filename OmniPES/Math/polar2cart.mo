within OmniPES.Math;

function polar2cart
  extends Modelica.Icons.Function;
  import Modelica.ComplexMath.exp;
  import Modelica.ComplexMath.j;
  import Modelica.Constants.pi;
  import Modelica.Units.SI;
  input Real mag "Absolute value of the complex";
  input SI.Angle phase(displayUnit="deg") "Phase angle of the complex";
  output Complex z "Resultant complex number";
algorithm
  z := mag*exp(j*phase);
  annotation(Documentation(info="<html><body>
<h4>Description</h4>
<p>Converts a complex number from polar form (magnitude and phase angle) to Cartesian form (real and imaginary components).</p>

<h4>Mathematical Formula</h4>
<p>The conversion uses Euler's formula:</p>
<p><strong>z = mag &middot; e<sup>j·phase</sup> = mag &middot; cos(phase) + j &middot; mag &middot; sin(phase)</strong></p>

<h4>Inputs</h4>
<ul>
  <li><strong>mag</strong>: Magnitude (absolute value) of the complex number</li>
  <li><strong>phase</strong>: Phase angle in radians (displayed in degrees in tools)</li>
</ul>

<h4>Output</h4>
<ul>
  <li><strong>z</strong>: Complex number in Cartesian form (real + j&middot;imaginary)</li>
</ul>

<h4>Example</h4>
<p>polar2cart(1.0, 0.5236) converts magnitude 1.0 and phase 30° (0.5236 rad) to:</p>
<p>z = 0.866 + j&middot;0.5</p>

<h4>Related Functions</h4>
<ul>
  <li><a href=\"modelica://Modelica.ComplexMath.exp\">Modelica.ComplexMath.exp</a>: Complex exponential used in the implementation</li>
  <li><a href=\"modelica://Modelica.ComplexMath.j\">Modelica.ComplexMath.j</a>: Imaginary unit used in the exponential</li>
  <li><a href=\"modelica://OmniPES.Math.sys2qd\">OmniPES.Math.sys2qd</a>: Transformation between system and rotating d-q reference frames</li>
</ul>
</body></html>"));
end polar2cart;