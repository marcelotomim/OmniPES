within OmniPES.SteadyState;

package Sources "Steady-state voltage and power sources"
  extends Modelica.Icons.SourcesPackage;

  annotation (Documentation(info="<html>
<p>
This package provides steady-state source models for phasor-domain simulations 
in the OmniPES library.
</p>

<h4>Available Components</h4>
<ul>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.Interfaces\">Interfaces</a> – 
Base partial models for steady-state sources</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.VTHSource\">VTHSource</a> – 
Thevenin-equivalent voltage source</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.PQSource\">PQSource</a> – 
Constant P–Q power source</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.PVSource\">PVSource</a> – 
Constant P with regulated voltage magnitude</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.PVSource_Qlim_discrete\">PVSource_Qlim_discrete</a> – 
PV source with discrete reactive power limits</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.PVSource_Qlim_sigmoid\">PVSource_Qlim_sigmoid</a> – 
PV source with smooth (sigmoid) reactive power limits</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.VTHSource_Qlim_discrete\">VTHSource_Qlim_discrete</a> – 
Thevenin source with discrete reactive power limits</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.VTHSource_Qlim_sigmoid\">VTHSource_Qlim_sigmoid</a> – 
Thevenin source with smooth (sigmoid) reactive power limits</li>
</ul>
</html>"));
end Sources;