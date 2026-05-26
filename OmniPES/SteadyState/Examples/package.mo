within OmniPES.SteadyState;

package Examples
  extends Modelica.Icons.ExamplesPackage;

  annotation (Documentation(info="<html>
<p>
This package contains steady-state example models for phasor-domain studies in the OmniPES library.
</p>

<h4>Available Examples</h4>
<ul>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.Test_Minimal\">Test_Minimal</a> – Minimal steady-state test case</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.Test_Radial_System_Power_Flow\">Test_Radial_System_Power_Flow</a> – Radial system power-flow example</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.Kundur_Two_Area_System_SteadyState\">Kundur_Two_Area_System_SteadyState</a> – Kundur two-area system (steady-state)</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.Kundur_Two_Area_System_ShortCircuit\">Kundur_Two_Area_System_ShortCircuit</a> – Kundur two-area system (short-circuit study)</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.Test_Radial_System_Power_Flow_Qlim_sigmoid\">Test_Radial_System_Power_Flow_Qlim_sigmoid</a> – Radial system power-flow with sigmoid Q-limits</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.Test_Radial_System_Power_Flow_Qlim_discrete\">Test_Radial_System_Power_Flow_Qlim_discrete</a> – Radial system power-flow with discrete Q-limits</li>
<li><a href=\"modelica://OmniPES.SteadyState.Examples.IEEE_ACCESS_2025\">IEEE_ACCESS_2025</a> – Tutorial systems and related controllers used in the paper <a href=\"https://doi.org/10.1109/ACCESS.2025.3553782\">\"Introduction to OmniPES: A Modelica Library for Power Systems Modeling and Analysis\"</a>, published in the IEEE ACCESS.</li>
</ul>
</p>

<h4>See Also</h4>
<ul>
  <li>Steady-state ZIP load usage: <a href=\"modelica://OmniPES.SteadyState.Examples.Test_Minimal\">Test_Minimal</a>, <a href=\"modelica://OmniPES.SteadyState.Examples.IEEE_ACCESS_2025.tutorial_system_sigmoid\">tutorial_system_sigmoid</a></li>
  <li>Transient ZIP load usage: <a href=\"modelica://OmniPES.Transient.Examples.IEEE9bus\">Transient.IEEE9bus</a>, <a href=\"modelica://OmniPES.Transient.Examples.IEEE_ACCESS_2025.tutorial_system\">Transient.tutorial_system</a>, <a href=\"modelica://OmniPES.Transient.Examples.IEEE_ACCESS_2025.tutorial_system_SVR\">Transient.tutorial_system_SVR</a></li>
</ul>
</html>"));
end Examples;