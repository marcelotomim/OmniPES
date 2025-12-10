within OmniPES.Circuit.Basic;

model Shunt_Reactor
  import Modelica.Units.SI;
  outer SystemData data;
  parameter SI.ReactivePower NominalPower(displayUnit="Mvar");
  extends Circuit.Basic.ShuntAdmittance(redeclare final parameter SI.PerUnit g = 0, redeclare final parameter SI.PerUnit b = -NominalPower/data.Sbase);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Basic.ShuntAdmittance\">OmniPES.Circuit.Basic.ShuntAdmittance</a>: Base shunt admittance model</li>
  <li><a href=\"modelica://OmniPES.SystemData\">OmniPES.SystemData</a>: System base data (outer)</li>
  <li><a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>: Reactive power and per-unit types</li>
</ul>
</body></html>"));
end Shunt_Reactor;