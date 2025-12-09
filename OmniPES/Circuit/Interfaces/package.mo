within OmniPES.Circuit;

package Interfaces "Connector and partial model interfaces for electrical circuits"
  extends Modelica.Icons.InterfacesPackage;
  
  annotation (Documentation(info="<html>
<p>
This package contains connectors and partial models that define the interfaces 
for electrical circuit components in the OmniPES library.
</p>

<h4>Connectors</h4>
<p>
The following connectors are available for connecting electrical components:
</p>
<ul>
<li><a href=\"modelica://OmniPES.Circuit.Interfaces.PositivePin\">PositivePin</a> - 
Positive electrical pin connector</li>
<li><a href=\"modelica://OmniPES.Circuit.Interfaces.NegativePin\">NegativePin</a> - 
Negative electrical pin connector</li>
<li><a href=\"modelica://OmniPES.Circuit.Interfaces.Bus\">Bus</a> - 
Electrical bus connector </li>
</ul>

<h4>Partial Models</h4>
<p>
The following partial models provide base implementations for common component types:
</p>
<ul>
<li><a href=\"modelica://OmniPES.Circuit.Interfaces.SeriesComponent\">SeriesComponent</a> - 
Base model for series electrical components (two-pin components)</li>
<li><a href=\"modelica://OmniPES.Circuit.Interfaces.ShuntComponent\">ShuntComponent</a> - 
Base model for shunt electrical components (components connected to the reference)</li>
<li><a href=\"modelica://OmniPES.Circuit.Interfaces.IdealTransformer\">IdealTransformer</a> - 
Base model for ideal transformer components</li>
</ul>
</html>"));
end Interfaces;