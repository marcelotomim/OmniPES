within OmniPES.SteadyState.Examples;

package IEEE_ACCESS_2025 "Tutorial systems from IEEE Access 2025 paper"
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<p>
This package contains tutorial systems and controller models used in the paper 
<a href=\"https://doi.org/10.1109/ACCESS.2025.3553782\">Introduction to OmniPES: A Modelica Library for Power Systems Modeling and Analysis</a>, 
published in IEEE Access (2025).
</p>

<h4>Tutorial Systems</h4>
<ul>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.IEEE_ACCESS_2025.tutorial_system_sigmoid\">tutorial_system_sigmoid</a> – 
tutorial system example for testing reactive power limits by means of sigmoid functions</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.IEEE_ACCESS_2025.tutorial_system_discrete\">tutorial_system_discrete</a> – 
tutorial system example for testing reactive power limits by means of discrete saturation</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.IEEE_ACCESS_2025.tutorial_system_SVR_SS_sigmoid\">tutorial_system_SVR_SS_sigmoid</a> – 
tutorial system example for with steady-state secondary voltage regulation (SVR); reactive power limits by means of sigmoid functions.</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.IEEE_ACCESS_2025.tutorial_system_SVR_SS_discrete\">tutorial_system_SVR_SS_discrete</a> – 
tutorial system example for with discrete steady-state secondary voltage regulation (SVR); reactive power limits by means of discrete saturation.</li>
</ul>
</html>"));
end IEEE_ACCESS_2025;