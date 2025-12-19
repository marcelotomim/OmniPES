within OmniPES;

package Transient
  extends OmniPES.Icons.TransientPackage;
  annotation(
    Documentation(info= "<html><head></head><body>
<h2>Transient Package</h2>
<p>
The <strong>Transient</strong> subpackage contains models for electromechanical transient stability analysis, including synchronous machine models and their controllers. This framework considers the premises of transient stability programs, which allow the inclusion of slow dynamics associated with generation, load, and other system controlling devices. Embedded power-flow restrictions aid users in automatically determining initial conditions without the need for external power flow calculations.
</p>

<h3>Main Subpackages</h3>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines\">SynchronousMachines</a> — Synchronous machine models with various electrical complexities (Classical, IEEE models 1.0, 2.1 and 2.2)</li>
  <li><a href=\"modelica://OmniPES.Transient.Controllers\">Controllers</a> — Automatic voltage regulators (AVR), speed governors, and power system stabilizers (PSS)</li>
  <li><a href=\"modelica://OmniPES.Transient.Loads\">Loads</a> — Dynamic polynomial load models with distinct steady-state and transient behavior</li>
  <li><a href=\"modelica://OmniPES.Transient.FACTS\">FACTS</a> — Flexible AC transmission system devices (STATCOM)</li>
  <li><a href=\"modelica://OmniPES.Transient.Examples\">Examples</a> — Demonstration models including benchmark systems, fault analysis, and controller testing</li>
</ul>

<h3>Key Models</h3>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a> — Core synchronous machine model</li>
  <li><a href=\"modelica://OmniPES.Transient.Loads.ZIPLoad\">ZIPLoad</a> — Dynamic polynomial load model for transient studies</li>
  <li><strong>Restriction (Initial Condition) Models:</strong>
    <ul>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PQ\">Restriction_PQ</a> — specified P and Q</li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV\">Restriction_PV</a> — specified P and V</li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_VTH\">Restriction_VTH</a> — specified V and angle (swing/stack bus)</li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_P\">Restriction_P</a> — specified P</li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_TH\">Restriction_TH</a> — specified angle</li>
    </ul>
  </li>
  <li><strong>Electrical Models:</strong>
    <ul>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Classical_Electric\">Classical_Electric</a></li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_1_0_Electric\">Model_1_0_Electric</a></li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_1_Electric\">Model_2_1_Electric</a></li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric\">Model_2_2_Electric</a></li>
    </ul>
  </li>
  <li><strong>Controllers:</strong>
    <ul>
      <li>AVR: <a href=\"modelica://OmniPES.Transient.Controllers.AVR.ConstantEfd\">ConstantEfd</a></li>
      <li>PSS: <a href=\"modelica://OmniPES.Transient.Controllers.PSS.NoPSS\">NoPSS</a></li>
      <li>Speed Regulator: <a href=\"modelica://OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm\">ConstantPm</a></li>
    </ul>
  </li>
</ul>

<h3>Examples</h3>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.Examples.Kundur_Two_Area_System\">Kundur_Two_Area_System</a></li>
  <li><a href=\"modelica://OmniPES.Transient.Examples.IEEE9bus\">IEEE9bus</a></li>
  <li><a href=\"modelica://OmniPES.Transient.Examples.Test_Radial_System\">Test_Radial_System</a></li>
  <li><a href=\"modelica://OmniPES.Transient.Examples.Test_Generic_Machine\">Test_Generic_Machine</a></li>
  <li><a href=\"modelica://OmniPES.Transient.Examples.Test_Breaker\">Test_Breaker</a></li>
</ul>

<h3>Steady-State Initial Conditions</h3>
<p>The OmniPES library provides embedded calculation of initial conditions from typical power-flow specifications. Generators receive a power-flow data record (detailed below) to define active power, reactive power, voltage magnitude and angle at the terminal, depending on the chosen restriction model.</p>
<p>Restriction models can be redeclared as needed for specifying initial operating conditions for generators:</p>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PQ\">Restriction_PQ</a>: specified active and reactive power</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV\">Restriction_PV</a>: specified active power and voltage magnitude</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_VTH\">Restriction_VTH</a>: specified voltage magnitude and angle (swing bus)</li>
</ul>

<p>For special study cases, additional restriction models, that define incomplete power-flow restrictions, are available:</p>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_P\">Restriction_P</a>: specified active power</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_TH\">Restriction_TH</a>: specified angle</li>
</ul>
<p>An usage example for these restriction models can be found in test case <a href=\"modelica://OmniPES.Transient.Examples.IEEE_ACCESS_2025.tutorial_system_SVR\">tutorial_system_SVR</a>.</p>

</body></html>"));
end Transient;