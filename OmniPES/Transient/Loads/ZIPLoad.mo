within OmniPES.Transient.Loads;

model ZIPLoad
   extends Interfaces.Partial_ZIPLoad;
equation
dp = 0;
dq = 0;
annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Documentation(info = "<html><head></head><body>
<h3>Overview</h3>
<p>
Transient <strong>ZIPLoad</strong> implements a voltage-dependent load with polynomial components: constant impedance (Z), constant current (I), and constant power (P). It is designed for electromechanical transient studies, with parameters that may differ from steady-state power flow modeling.
</p>

<h4>Parameters</h4>
<ul>
  <li><strong>Psp, Qsp</strong>: specified active and reactive power at nominal voltage.</li>
  <li><strong>ss_par</strong>: steady-state characteristics (optional, if inherited), typically a <a href=\"modelica://OmniPES.SteadyState.Loads.Interfaces.LoadData\">SteadyState.Loads.Interfaces.LoadData</a>.</li>
  <li><strong>dyn_par</strong>: transient characteristics, a <a href=\"modelica://OmniPES.Transient.Loads.Interfaces.LoadData\">Transient.Loads.Interfaces.LoadData</a> record, defining fractions for Z/I components during transients.</li>
</ul>

<h4>Usage Notes</h4>
<ul>
  <li>Use <strong>dyn_par</strong> to tailor load behavior under disturbances (e.g., higher Z fraction for credible voltage dips).</li>
  <li>In many studies, <strong>ss_par</strong> represents the operating point characteristics, while <strong>dyn_par</strong> governs short-term response.</li>
  <li>For purely steady-state power flow, prefer <a href=\"modelica://OmniPES.SteadyState.Loads.ZIPLoad\">SteadyState.ZIPLoad</a>.</li></ul><ul>
</ul>

</body></html>"));

end ZIPLoad;