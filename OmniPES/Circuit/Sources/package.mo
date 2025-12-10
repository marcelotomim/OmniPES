within OmniPES.Circuit;

package Sources "Electrical voltage and current sources"
  extends Modelica.Icons.SourcesPackage;
  
  annotation (Documentation(info="<html>
<p>
This package contains models of electrical sources for circuit simulation 
in the OmniPES library.
</p>

<h4>Available Components</h4>
<p>
The following electrical sources are available:
</p>
<ul>
<li><a href=\"modelica://OmniPES.Circuit.Sources.VoltageSource\">VoltageSource</a> - 
Ideal voltage source</li>
<li><a href=\"modelica://OmniPES.Circuit.Sources.CurrentSource\">CurrentSource</a> - 
Ideal current source</li>
<li><a href=\"modelica://OmniPES.Circuit.Sources.ControlledVoltageSource\">ControlledVoltageSource</a> - 
Controlled voltage source with input signal</li>
</ul>
</html>"));
end Sources;