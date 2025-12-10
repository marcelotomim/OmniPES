within OmniPES.SteadyState.Sources;

package Interfaces "Base partial models for steady-state sources"
  extends Modelica.Icons.InterfacesPackage;

  annotation (Documentation(info="<html>
<p>
This package contains partial models that define the interfaces for steady-state
voltage and power sources in the OmniPES library.
</p>

<h4>Partial Models</h4>
<ul>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.Interfaces.Partial_Source\">Partial_Source</a> –
Base partial model for steady-state sources</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.Interfaces.Partial_VSource_Qlim\">Partial_VSource_Qlim</a> –
Voltage source with reactive power limit interface</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.Interfaces.Partial_VSource_Qlim_sigmoid\">Partial_VSource_Qlim_sigmoid</a> –
Voltage source with smooth (sigmoid) reactive power limiting</li>
<li><a href=\"modelica://OmniPES.SteadyState.Sources.Interfaces.Partial_VSource_Qlim_discrete\">Partial_VSource_Qlim_discrete</a> –
Voltage source with discrete reactive power limiting</li>
</ul>
</html>"));
end Interfaces;