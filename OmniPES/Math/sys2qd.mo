within OmniPES.Math;

function sys2qd
  extends Modelica.Icons.Function;
  import Modelica.Units.SI;
  import Modelica.Math.cos;
  import Modelica.Math.sin;
  input Complex A;
  input SI.Angle delta;
  output Complex Aqd;
algorithm
  Aqd.re := A.re*cos(delta) + A.im*sin(delta);
  Aqd.im := A.re*sin(delta) - A.im*cos(delta);
  annotation(Documentation(info="<html><body>
<h4>Description</h4>
<p>Transforms a complex quantity from the phasor system reference frame to a rotating d-q reference frame. While commonly used for synchronous machines (transforming to the rotor reference frame), this function performs a general coordinate transformation applicable to any rotating reference frame synchronized with a given angle.</p>

<h4>Reference Frame Transformation</h4>
<p>This function performs a coordinate transformation between two rotating reference frames:</p>
<ul>
  <li><strong>Input frame</strong>: Phasor system reference (typically aligned with network voltage or a fixed network reference)</li>
  <li><strong>Output frame</strong>: Rotating d-q frame, synchronized with a specified angle</li>
  <li><strong>Rotation angle</strong>: &delta; = angle of the rotating frame relative to the system reference</li>
</ul>

<h4>Reference Frame Definition</h4>
<p>The two reference frames are related by a rotation angle &delta;:</p>
<div style=\"text-align:center; margin:0px 0;\"><img src=\"modelica://OmniPES/Resources/Images/sys2qd.png\" alt=\"System (blue) axes and machine q (red) / d (green) axes with rotation angle &delta;\" style=\"max-width:260px; display:block; margin:0 auto;\"></div>
<p><strong>Blue axes</strong>: System reference frame (Real and Imaginary).<br/>
<strong>Red axis</strong>: q-axis, advanced by &delta; from the Real axis.<br/>
<strong>Green axis</strong>: d-axis, 90&deg; lagging behind the q-axis.</p>

<h4>Transformation Equations</h4>
<p>The rotation transformation is defined as:</p>
<p><strong>A<sub>q</sub> = A<sub>re</sub>&middot;cos(&delta;) + A<sub>im</sub>&middot;sin(&delta;)</strong></p>
<p><strong>A<sub>d</sub> = A<sub>re</sub>&middot;sin(&delta;) - A<sub>im</sub>&middot;cos(&delta;)</strong></p>
<p>Where Aqd.re = A<sub>q</sub> (q-axis component) and Aqd.im = A<sub>d</sub> (d-axis component)</p>

<h4>Inputs</h4>
<ul>
  <li><strong>A</strong>: Complex quantity in the phasor system reference frame (e.g., voltage, current, or flux)</li>
  <li><strong>&delta;</strong>: Rotation angle (&delta;) in radians, defining the orientation of the d-q frame relative to the system frame</li>
</ul>

<h4>Outputs</h4>
<ul>
  <li><strong>Aqd</strong>: Complex quantity in the rotating d-q reference frame where:
    <ul>
      <li>Real component (Aqd.re) = q-axis component (quadrature axis, leading)</li>
      <li>Imaginary component (Aqd.im) = d-axis component (direct axis, lagging)</li>
    </ul>
  </li>
</ul>

<h4>Example</h4>
<p>If a complex quantity in system frame is A = 1.0 + j&middot;0.0 (aligned with reference) and the rotation angle is &delta; = pi/6 (30 deg):</p>
<p>Aqd = sys2qd(1.0 + j&middot;0.0, pi/6)</p>
<p>Result: Aqd.re = 0.866 (q-component), Aqd.im = -0.5 (d-component)</p>

<h4>Related Functions</h4>
<ul>
  <li><a href=\"modelica://Modelica.Math.sin\">Modelica.Math.sin</a>: Sine function used in the rotation</li>
  <li><a href=\"modelica://Modelica.Math.cos\">Modelica.Math.cos</a>: Cosine function used in the rotation</li>
  <li><a href=\"modelica://OmniPES.Math.polar2cart\">OmniPES.Math.polar2cart</a>: Conversion between polar and Cartesian complex forms</li>
</ul>
</body></html>"));
end sys2qd;