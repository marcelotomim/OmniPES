within OmniPES;

package Transient
  extends OmniPES.Icons.TransientPackage;
  annotation(
    Documentation(info="<html>
<body>
<h4>Overview</h4>
<p>
The <strong>Transient</strong> subpackage contains models for electromechanical transient stability analysis, including synchronous machine models and their controllers. This framework considers the premises of transient stability programs, which allow the inclusion of slow dynamics associated with generation, load, and other system controlling devices. Embedded power-flow restrictions automatically determine initial conditions without the need for external power flow calculations.
</p>

<h4>Main Subpackages</h4>
<ul>
<li><a href=\"modelica://OmniPES.Transient.SynchronousMachines\">SynchronousMachines</a> &mdash; Synchronous machine models with various electrical complexities (Classical, Model 1.0, Model 2.1, Model 2.2)</li>
<li><a href=\"modelica://OmniPES.Transient.Controllers\">Controllers</a> &mdash; Automatic voltage regulators (AVR), speed governors, and power system stabilizers (PSS)</li>
<li><a href=\"modelica://OmniPES.Transient.Loads\">Loads</a> &mdash; Dynamic polynomial load models with distinct steady-state and transient behavior</li>
<li><a href=\"modelica://OmniPES.Transient.FACTS\">FACTS</a> &mdash; Flexible AC transmission system devices (STATCOM)</li>
<li><a href=\"modelica://OmniPES.Transient.Examples\">Examples</a> &mdash; Demonstration models including benchmark systems, fault analysis, and controller testing</li>
</ul>

<h4>Usage</h4>
<p>
Use Transient models when analyzing power system dynamics during disturbances such as faults, load changes, or generation trips. The GenericSynchronousMachine model allows redeclaration of electrical models (Classical, Model 1.0, 2.1, 2.2) and restriction models (PQ, PV, VTH, P) to match study requirements. Combine with Circuit components to build complete network models. For quasi-static studies without fast dynamics, use the <a href=\"modelica://OmniPES.SteadyState\">SteadyState</a> subpackage instead.
</p>
</body>
</html>"));
end Transient;