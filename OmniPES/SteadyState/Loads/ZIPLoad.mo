within OmniPES.SteadyState.Loads;

model ZIPLoad
  extends Interfaces.Partial_Load;
  parameter Modelica.Units.SI.PerUnit Vdef = 1.0 "Voltage at which the specified power is defined"; 
  parameter Interfaces.LoadData ss_par = Interfaces.LoadData() "ZIP load parameters" annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Real pp = 1 - ss_par.pi - ss_par.pz;
  parameter Real pi = ss_par.pi;
  parameter Real pz = ss_par.pz;
  parameter Real qq = 1 - ss_par.qi - ss_par.qz;
  parameter Real qi = ss_par.qi;
  parameter Real qz = ss_par.qz;
equation
  S.re = (Psp+dpsp)/data.Sbase*(pp + pi*(V/Vdef) + pz*(V/Vdef)^2);
  S.im = (Qsp+dqsp)/data.Sbase*(qq + qi*(V/Vdef) + qz*(V/Vdef)^2);
  annotation(
    Documentation(info= "<html><head></head><body>
<h3>Overview</h3>
<p>
Steady-state <strong>ZIPLoad</strong> models voltage-dependent load behavior using polynomial components: constant impedance (Z), constant current (I), and constant power (P). It is intended for power flow analyses where power-flow restrictions are enforced at each step.
</p>

<h4>Parameters</h4>
<ul>
  <li><strong>Psp, Qsp</strong>: specified active and reactive power at nominal voltage.</li>
  <li><strong>Vdef</strong>: voltage at which specified power is defined.</li>
  <li><strong>ss_par</strong>: steady-state characteristics, a <a href=\"modelica://OmniPES.SteadyState.Loads.Interfaces.LoadData\">SteadyState.Loads.Interfaces.LoadData</a> record providing fractions for Z/I/P behavior.</li>
</ul>

<h4>Usage Notes</h4>
<ul>
  <li>Use this model for traditional power flow and quasi-steady-state studies.</li>
  <li>For transient stability analysis with distinct short-term behavior, prefer <a href=\"modelica://OmniPES.Transient.Loads.ZIPLoad\">Transient.ZIPLoad</a> and set <strong>dyn_par</strong> via <a href=\"modelica://OmniPES.Transient.Loads.Interfaces.LoadData\">Transient.Loads.Interfaces.LoadData</a>.</li></ul><ul>
</ul>

</body></html>"));

end ZIPLoad;