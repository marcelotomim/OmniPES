within OmniPES.Transient.SynchronousMachines;

record RestrictionData
  extends Modelica.Icons.Record;
  import Modelica.Units.SI;
  parameter SI.ActivePower Psp(displayUnit="MW") = 0.0 "Generated Active Power" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter SI.ReactivePower Qsp(displayUnit="Mvar") = 0.0 "Generated Rective Power" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter SI.PerUnit Vsp = 1.0 "Bus voltage magnitude" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter SI.Angle theta_sp(displayUnit = "deg") = 0 "Bus voltage angle" annotation(
    Dialog(group = "Steady-State Specifications"));
annotation(defaultComponentPrefixes = "parameter",
    Documentation(info="<html><head></head><body>
<h3>Overview</h3>
<p>
<strong>RestrictionData</strong> is a parameter record that stores power-flow specifications, important for defining initial operating conditions 
for synchronous generators within the OmniPES Transient framework. These specifications define the steady-state operating point 
(active power, reactive power, voltage magnitude, and bus angle) and are used by power-flow restriction models to enforce 
initial conditions during transient stability simulations.
</p>

<h3>Context and Usage</h3>
<p>
The OmniPES library implements <em>embedded power-flow restrictions</em>, meaning that instead of computing initial conditions 
externally, the power-flow constraints are directly embedded in the generator 
component models. This approach enables rapid prototyping of power systems without requiring external power-flow solvers.
</p>
<p>
<strong>RestrictionData</strong> is used in conjunction with:
</p>
<ul>
<li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction\">Restriction</a> models 
  (base class and specializations) — which use the specifications to enforce initial power-flow conditions.</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a> 
  — the core generator model where this record is instantiated as the <code>specs</code> parameter.</li>
</ul>

<h3>Parameters</h3>

<h4>Psp — Active Power Specification</h4>
<ul>
  <li><strong>Type:</strong> SI.ActivePower [W]</li>
  <li><strong>Display Unit:</strong> MW</li>
  <li><strong>Default:</strong> 0.0 W</li>
  <li><strong>Description:</strong> Rated active power output (generation) at the initial operating point, expressed in watts. 
  Positive values indicate power generation.</li>
  <li><strong>Usage:</strong> Required by restriction models that enforce specified active power 
  (<a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PQ\">Restriction_PQ</a>, 
  <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV\">Restriction_PV</a>, 
  <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_P\">Restriction_P</a>).</li>
</ul>

<h4>Qsp — Reactive Power Specification</h4>
<ul>
  <li><strong>Type:</strong> SI.ReactivePower [Var]</li>
  <li><strong>Display Unit:</strong> Mvar</li>
  <li><strong>Default:</strong> 0.0 Var</li>
  <li><strong>Description:</strong> Rated reactive power output at the initial operating point, expressed in volt-ampere-reactive. 
  Positive values indicate reactive power generation (capacitive support).</li>
  <li><strong>Usage:</strong> Used by the <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PQ\">Restriction_PQ</a> 
  model which enforces both specified active and reactive power.</li>
</ul>

<h4>Vsp — Voltage Magnitude Specification</h4>
<ul>
  <li><strong>Type:</strong> SI.PerUnit [pu]</li>
  <li><strong>Default:</strong> 1.0 pu</li>
  <li><strong>Description:</strong> Bus voltage magnitude at the generator terminal in per-unit form. Standard convention is 
  1.0 pu for rated voltage.</li>
  <li><strong>Valid Range:</strong> Typically 0.95–1.05 pu for normal operation (can vary by system design).</li>
  <li><strong>Usage:</strong> Required by restriction models that enforce constant voltage 
  (<a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV\">Restriction_PV</a>, 
  <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_VTH\">Restriction_VTH</a>).</li>
  <li><strong>Note:</strong> This voltage is the controlled voltage at the generator bus.</li>
</ul>

<h4>theta_sp — Bus Voltage Angle Specification</h4>
<ul>
  <li><strong>Type:</strong> SI.Angle [rad]</li>
  <li><strong>Display Unit:</strong> deg (degrees)</li>
  <li><strong>Default:</strong> 0 rad (0 degrees)</li>
  <li><strong>Description:</strong> Bus voltage phase angle (voltage phasor argument) at the initial operating point. 
  Expressed in radians; typically displayed in degrees for user convenience.</li>
  <li><strong>Reference:</strong> Angles are measured relative to a synchronous reference frame. The swing bus (slack bus) 
  is conventionally assigned 0 degrees as the reference.</li>
  <li><strong>Usage:</strong> Required by the <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_VTH\">Restriction_VTH</a> 
  model (constant voltage and angle, typical for swing/slack bus), and by the 
  <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_TH\">Restriction_TH</a> model 
  (constant angle only).</li>
</ul>

<h3>Restriction Models and Parameter Usage</h3>
<p>
Different restriction models within <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces\">Interfaces</a> 
use different combinations of parameters from <strong>RestrictionData</strong>:
</p>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"5\" style=\"border-collapse:collapse; text-align:center;\">
  <tbody>
    <tr>
      <th style=\"text-align:left;\">Restriction Model</th>
      <th>Psp</th>
      <th>Qsp</th>
      <th>Vsp</th>
      <th>theta_sp</th>
      <th style=\"text-align:left;\">Description</th>
    </tr>
    <tr style=\"background-color:#f0f0f0;\">
      <td style=\"text-align:left;\"><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PQ\">Restriction_PQ</a></td>
      <td>✓</td>
      <td>✓</td>
      <td></td>
      <td></td>
      <td style=\"text-align:left;\">Constant P and Q (PQ bus)</td>
    </tr>
    <tr>
      <td style=\"text-align:left;\"><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV\">Restriction_PV</a></td>
      <td>✓</td>
      <td></td>
      <td>✓</td>
      <td></td>
      <td style=\"text-align:left;\">Constant P and V (PV bus, typical for generators)</td>
    </tr>
    <tr style=\"background-color:#f0f0f0;\">
      <td style=\"text-align:left;\"><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_VTH\">Restriction_VTH</a></td>
      <td></td>
      <td></td>
      <td>✓</td>
      <td>✓</td>
      <td style=\"text-align:left;\">Constant V and θ (swing/slack bus)</td>
    </tr>
    <tr>
      <td style=\"text-align:left;\"><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_P\">Restriction_P</a></td>
      <td>✓</td>
      <td></td>
      <td></td>
      <td></td>
      <td style=\"text-align:left;\">Constant P only (P bus)</td>
    </tr>
    <tr style=\"background-color:#f0f0f0;\">
      <td style=\"text-align:left;\"><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_TH\">Restriction_TH</a></td>
      <td></td>
      <td></td>
      <td></td>
      <td>✓</td>
      <td style=\"text-align:left;\">Constant θ only (angle bus)</td>
    </tr>
  </tbody>
</table>

<h3>Usage Example</h3>
<p>
Below is a typical usage in a transient stability model:
</p>
<pre style=\"background-color:#f5f5f5; padding:10px; border:1px solid #ccc; border-radius:4px;\">
model Example_System
  inner OmniPES.SystemData data annotation(Placement(...));
  
  // Machine data (electrical parameters)
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData gen_data(
    MVAb = 1e8,  // 100 MVA base
    H = 5,       // inertia constant
    Xd = 1.8,    // d-axis synchronous reactance
    ...
  ) annotation(Placement(...));
  
  // Initial condition specification
  parameter OmniPES.Transient.SynchronousMachines.<strong>RestrictionData</strong> gen_specs(
    Psp = 8e7,    // 80 MW active power
    Qsp = 0.0,    // 0 Mvar reactive power
    Vsp = 1.05,   // 105% voltage (5% overvoltage)
    theta_sp = 0.0 // 0 degrees angle
  ) annotation(Placement(...));
  
  // Generator with PV restriction (constant P and V)
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine gen(
    smData = gen_data,
    specs = gen_specs,  // use the RestrictionData record
    redeclare ... Restriction_PV restriction  // enforce Psp and Vsp
  ) annotation(Placement(...));
  
  ...
end Example_System;
</pre>

<h3>Related Subpackages and Examples</h3>
<ul>
  <li><strong>Transient Examples:</strong> See example models in <a href=\"modelica://OmniPES.Transient.Examples\">OmniPES.Transient.Examples</a> 
  for realistic usage patterns (e.g., <code>Test_Generic_Machine_2</code>, <code>Test_Radial_System_Classical</code>, 
  <code>IEEE9bus</code>).</li>
  <li><strong>Steady-State Framework:</strong> For comparison, see 
  <a href=\"modelica://OmniPES.SteadyState.Sources\">OmniPES.SteadyState.Sources</a> which implements power-flow 
  specifications for steady-state analysis.</li>
</ul>

</body></html>"));
end RestrictionData;