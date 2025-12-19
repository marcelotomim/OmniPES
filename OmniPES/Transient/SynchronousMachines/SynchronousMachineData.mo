within OmniPES.Transient.SynchronousMachines;

record SynchronousMachineData
  extends Modelica.Icons.Record;  
  import Modelica.Units.SI;
  import OmniPES.Transient.SynchronousMachines.Interfaces.Models;
  parameter Models model_type = Models.Turbo;
  parameter SI.ApparentPower MVAb(displayUnit="MVA") = 100e6 "Machine base power" annotation(
    Dialog(group = "Machine Base Quatities"));
  parameter Integer Nmaq = 1 "Number of parallel machines" annotation(
    Dialog(group = "Machine Base Quatities"));
  parameter SI.PerUnit Ra = 0.0 "armature resistance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit Xl = 0.2 "leakage reactance" annotation(
    Dialog(group = "Electrical Data", enable = (model_type == Models.Hydro) or (model_type == Models.Turbo)));
  parameter SI.PerUnit Xd = 1.8 "d-axis synchronous reactance" annotation(
    Dialog(group = "Electrical Data", enable = model_type <> Models.Classic));
  parameter SI.PerUnit Xq = 1.7 "q-axis synchronous reactance" annotation(
    Dialog(group = "Electrical Data", enable = model_type <> Models.Classic));
  parameter SI.PerUnit X1d = 0.3 "d-axis transient reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit X1q = 0.55 "q-axis transient reactance" annotation(
    Dialog(group = "Electrical Data", enable = (model_type == Models.E1qd) or (model_type == Models.Hydro) or (model_type == Models.Turbo)));
  parameter SI.PerUnit X2d = 0.25 "d-axis subtransient reactance" annotation(
    Dialog(group = "Electrical Data", enable = (model_type == Models.Hydro) or (model_type == Models.Turbo)));
  parameter SI.PerUnit X2q = 0.25 "q-axis subtransient reactance" annotation(
    Dialog(group = "Electrical Data", enable = (model_type == Models.Turbo)));
  parameter SI.Time T1d0 = 8.00 "d-axis open-circuit transient time constant" annotation(
    Dialog(group = "Electrical Data", enable = model_type <> Models.Classic));
  parameter SI.Time T1q0 = 0.4 "q-axis open-circuit transient time constant" annotation(
    Dialog(group = "Electrical Data", enable = (model_type == Models.E1qd) or (model_type == Models.Hydro) or (model_type == Models.Turbo)));
  parameter SI.Time T2d0 = 0.03 "d-axis open-circuit subtransient time constant" annotation(
    Dialog(group = "Electrical Data", enable = (model_type == Models.Hydro) or (model_type == Models.Turbo)));
  parameter SI.Time T2q0 = 0.05 "q-axis open-circuit subtransient time constant" annotation(
    Dialog(group = "Electrical Data", enable = (model_type == Models.Turbo)));
  parameter SI.Time H = 5 "constant of inertia" annotation(
    Dialog(group = "Mechanical Data"));
  parameter SI.PerUnit D = 0.0 "damping constant" annotation(
    Dialog(group = "Mechanical Data"));
annotation(defaultComponentPrefixes = "parameter",
    Documentation(info= "<html><head></head><body>
<h3>Overview</h3>
<p>
<strong>SynchronousMachineData</strong> stores nameplate and dynamic parameters for a synchronous generator in per‑unit of the specific machine base values, used by electrical and mechanical submodels in <a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a> and related interfaces.
</p>

<h4>Model Type</h4>
<ul>
  <li><strong>model_type</strong>: selects the electrical model family (e.g., <code>Classic</code>, <code>E1qd</code>, <code>Hydro</code>, <code>Turbo</code>). This drives enablement of parameters such as <code>Xq</code>, <code>X2q</code>, and time constants.</li>
  <li>See electrical variants: <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Classical_Electric\">Classical_Electric</a>, <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_1_0_Electric\">Model_1_0_Electric</a>, <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_1_Electric\">Model_2_1_Electric</a>, <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric\">Model_2_2_Electric</a>.</li>
  
</ul>

<h4>Base Quantities</h4>
<ul>
  <li><strong>MVAb</strong> [MVA]: machine base apparent power.</li>
  <li><strong>Nmaq</strong> [-]: number of identical parallel machines associated with this power plant (note: scales electrical and mechanical quantities).</li>
</ul>

<h4>Model Type → Enabled Parameters</h4>
<p>The record UI enables parameters depending on <code>model_type</code>:</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"4\" style=\"border-collapse:collapse;\">
  <tbody><tr>
    <th>Parameter</th><th>Enabled when</th>
  </tr>
  <tr><td><code>Xl</code></td><td><code>Hydro</code> or <code>Turbo</code></td></tr>
  <tr><td><code>Xd</code>, <code>Xq</code></td><td>not <code>Classic</code></td></tr>
  <tr><td><code>X1q</code></td><td><code>E1qd</code> or <code>Hydro</code> or <code>Turbo</code></td></tr>
  <tr><td><code>X2d</code></td><td><code>Hydro</code> or <code>Turbo</code></td></tr>
  <tr><td><code>X2q</code></td><td><code>Turbo</code></td></tr>
  <tr><td><code>T1d0</code></td><td>not <code>Classic</code></td></tr>
  <tr><td><code>T1q0</code></td><td><code>E1qd</code> or <code>Hydro</code> or <code>Turbo</code></td></tr>
  <tr><td><code>T2d0</code></td><td><code>Hydro</code> or <code>Turbo</code></td></tr>
  <tr><td><code>T2q0</code></td><td><code>Turbo</code></td></tr>
  <tr><td><code>Ra</code>, <code>X1d</code>, <code>H</code>, <code>D</code></td><td>always enabled</td></tr>
  <tr><td><code>MVAb</code>, <code>Nmaq</code></td><td>base quantities (always enabled)</td></tr>
  <tr><td><em>Note</em></td><td>Enablement reflects the actual <code>annotation(Dialog(enable=...))</code> conditions in this record.</td></tr>
</tbody></table>

<h4>Electrical Data</h4>
<ul>
  <li><strong>Ra</strong> [pu]: armature resistance.</li>
  <li><strong>Xl</strong> [pu]: leakage reactance.</li>
  <li><strong>Xd</strong>, <strong>Xq</strong> [pu]: synchronous reactances in d‑ and q‑axes.</li>
  <li><strong>X1d</strong>, <strong>X1q</strong> [pu]: transient reactances.</li>
  <li><strong>X2d</strong>, <strong>X2q</strong> [pu]: subtransient reactances.</li>
  <li><strong>T1d0</strong>, <strong>T1q0</strong> [s]: open‑circuit transient time constants (d/q).</li>
  <li><strong>T2d0</strong>, <strong>T2q0</strong> [s]: open‑circuit subtransient time constants (d/q).</li>
</ul>

<h4>Mechanical Data</h4>
<ul>
  <li><strong>H</strong> [s]: inertia constant (stored energy at rated speed per MVA base).</li>
  <li><strong>D</strong> [pu]: damping coefficient.</li>
</ul>

<h4>Usage</h4>
<ul>
  <li>Pass this record to <a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a> via <code>smData</code>. Internally, values are converted to the system base (see <code>convData</code> in the machine).</li>
  <li>Enable/disable parameters are controlled by <code>model_type</code>. See table above for details.</li>
  <li><strong>convData</strong>: the machine creates a converted copy of this record on the system base using <a href=\"modelica://OmniPES.Transient.SynchronousMachines.ConvertBase\">ConvertBase</a> (<code>MVAs</code>, <code>MVAb</code>, <code>Nmaq</code> scaling). Electrical and mechanical (inertia) models read from this converted record.</li>
</ul>

<h4>Example</h4>
<pre>parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData gen_data(
  MVAb=100e6, Nmaq=1,
  Ra=0.0, Xl=0.2,
  Xd=1.8, Xq=1.7,
  X1d=0.3, X1q=0.55,
  X2d=0.25, X2q=0.25,
  T1d0=8.0, T1q0=0.4,
  T2d0=0.03, T2q0=0.05,
  H=6.5, D=0.0);
</pre>

<h4>See Also</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a></li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.RestrictionData\">RestrictionData</a> (power‑flow specs)</li>
  <li><a href=\"modelica://OmniPES.Transient.Controllers.Interfaces.PartialAVR\">Controllers.Interfaces.PartialAVR</a>, <a href=\"modelica://OmniPES.Transient.Controllers.Interfaces.PartialSpeedRegulator\">Controllers.Interfaces.PartialSpeedRegulator</a>, <a href=\"modelica://OmniPES.Transient.Controllers.Interfaces.PartialPSS\">Controllers.Interfaces.PartialPSS</a></li>
</ul>

</body></html>"));
end SynchronousMachineData;