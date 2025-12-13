within OmniPES.Transient;

package Examples
  extends Modelica.Icons.ExamplesPackage;
  annotation (Documentation(info="<html>
<p>
This package contains transient stability example models for electromechanical dynamics studies in the OmniPES library.
</p>

<h4>Representative Examples</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.Examples.Kundur_Two_Area_System\">Kundur_Two_Area_System</a> – Benchmark two-area system with AVR/PSS and dynamic loads</li>
  <li><a href=\"modelica://OmniPES.Transient.Examples.IEEE9bus\">IEEE9bus</a> – Classical test system with transient loads</li>
  <li><a href=\"modelica://OmniPES.Transient.Examples.Test_Radial_System\">Test_Radial_System</a> – Radial network under transient disturbances</li>
  <li><a href=\"modelica://OmniPES.Transient.Examples.Test_Generic_Machine\">Test_Generic_Machine</a> – Generic synchronous machine setup</li>
  <li><a href=\"modelica://OmniPES.Transient.Examples.Test_Breaker\">Test_Breaker</a> – Breaker operation and fault studies</li>
</ul>

<h4>See Also</h4>
<ul>
  <li>Transient ZIP load usage: <a href=\"modelica://OmniPES.Transient.Loads.ZIPLoad\">Transient.Loads.ZIPLoad</a></li>
  <li>Steady-state ZIP load usage: <a href=\"modelica://OmniPES.SteadyState.Examples.Test_Minimal\">SteadyState.Test_Minimal</a>, <a href=\"modelica://OmniPES.SteadyState.Examples.IEEE_ACCESS_2025.tutorial_system_sigmoid\">SteadyState.tutorial_system_sigmoid</a></li>
</ul>

</html>"));
end Examples;