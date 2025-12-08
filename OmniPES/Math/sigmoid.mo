within OmniPES.Math;

function sigmoid
  extends Modelica.Icons.Function;
  input Real x "input variable";
  input Real x0 = 0 "input variable value for asymptotes midpoint";
  input Real left_asym = 0.5 "left horizontal asymptote";
  input Real right_asym = 10.0 "right horizontal asymptote";
  input Real growth_rate = 1 "growth rate";
  output Real y "output variable";
algorithm
  y := left_asym + (right_asym-left_asym)/(1+exp(-growth_rate*(x-x0)));
  annotation(Documentation(info="<html><body>
<h4>Description</h4>
<p>Implements a generalized sigmoid function that produces a smooth, continuous transition between two asymptotic values. </p>

<h4>Mathematical Definition</h4>
<p>The generalized sigmoid function is defined as:</p>
<p style=\"text-align:center;\"><strong>y = left_asym + (right_asym - left_asym) / (1 + exp(-growth_rate &times; (x - x<sub>0</sub>)))</strong></p>

<h4>Parameters</h4>
<ul>
  <li><strong>x</strong>: Input variable</li>
  <li><strong>x0</strong> (default = 0): The x-value at which the midpoint of the transition occurs (where the slope is maximum)</li>
  <li><strong>left_asym</strong> (default = 0.5): The horizontal asymptote approached as x → -&infin;</li>
  <li><strong>right_asym</strong> (default = 10.0): The horizontal asymptote approached as x → +&infin;</li>
  <li><strong>growth_rate</strong> (default = 1): Controls the steepness of the transition; larger values produce sharper transitions</li>
</ul>

<h4>Output</h4>
<ul>
  <li><strong>y</strong>: The sigmoid function output, always bounded between left_asym and right_asym</li>
</ul>

<h4>Function Visualization</h4>
<p style=\"text-align:center;\"><img src=\"modelica://OmniPES/Resources/Images/sigmoid.png\" alt=\"Sigmoid function with default parameters showing asymptotes and center point\" style=\"max-width:400px; display:block; margin:0 auto;\"></p>

<h4>Key Properties</h4>
<ul>
  <li><strong>Range</strong>: left_asym &lt; y &lt; right_asym (strictly between asymptotes for finite x)</li>
  <li><strong>Monotonicity</strong>: Monotonically increasing if growth_rate &gt; 0, monotonically decreasing if growth_rate &lt; 0</li>
  <li><strong>Smoothness</strong>: Infinitely differentiable, ideal for gradient-based optimization and control applications</li>
  <li><strong>Symmetry</strong>: Centered at x<sub>0</sub>; the transition is symmetric around this point in normalized coordinates</li>
</ul>

<h4>Applications</h4>
<ul>
  <li>Smooth saturation modeling in actuators and power electronics</li>
  <li>Rate limiters with smooth transitions</li>
  <li>Control system activation functions</li>
  <li>Soft switching or soft logic operations</li>
  <li>Neural network approximations in control systems</li>
</ul>

<h4>Examples</h4>
<p><strong>Example 1: Standard sigmoid (shifted and scaled)</strong></p>
<p>y = sigmoid(x, x0=0, left_asym=0, right_asym=1, growth_rate=1)</p>
<p>Produces a standard sigmoid from 0 to 1, centered at x = 0</p>

<p><strong>Example 2: Smooth saturation</strong></p>
<p>y = sigmoid(x, x0=5, left_asym=0, right_asym=10, growth_rate=2)</p>
<p>Creates a smooth transition from 0 to 10, centered at x = 5, with steeper slope</p>

<p><strong>Example 3: Offset asymptotes</strong></p>
<p>y = sigmoid(x, x0=1, left_asym=2, right_asym=8, growth_rate=0.5)</p>
<p>Produces a gentle transition between 2 and 8, centered at x = 1</p>

<h4>Related Functions</h4>
<ul>
  <li><a href=\"modelica://Modelica.Math.exp\">Modelica.Math.exp</a>: Exponential function used in the sigmoid calculation</li>
</ul>
</body></html>"));
end sigmoid;