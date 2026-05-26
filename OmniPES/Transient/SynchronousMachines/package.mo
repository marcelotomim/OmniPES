within OmniPES.Transient;

package SynchronousMachines
  









  annotation(
    Icon(coordinateSystem(initialScale = 0.4, grid = {0.5, 0.5}), graphics = {Ellipse(origin = {14, -5}, lineThickness = 1, extent = {{-114, 105}, {86, -95}}, endAngle = 360), Line(origin = {-28.88, 28.79}, points = {{-31.1188, -28.7929}, {-27.1188, -8.79289}, {-21.1188, 11.2071}, {-9.1188, 27.2071}, {8.88124, 27.2071}, {18.8812, 11.2071}, {24.8812, -8.79289}, {28.8812, -28.7929}}, thickness = 1, smooth = Smooth.Bezier), Line(origin = {31.12, -29.21}, points = {{-31.1188, 28.7929}, {-27.1188, 8.79289}, {-21.1188, -11.2071}, {-11.1188, -29.2071}, {8.88124, -29.2071}, {18.8812, -11.2071}, {24.8812, 8.79289}, {28.8812, 28.7929}}, thickness = 1, smooth = Smooth.Bezier)}),
    Diagram(coordinateSystem(extent = {{-100, -150}, {100, 100}})),
    Documentation(info = "<html><head></head><body>
<h2>SynchronousMachines Subpackage</h2>
<p>
This subpackage contains models of synchronous machines with various electrical complexities (Classical, IEEE models 1.0, 2.1 and 2.2) and initial condition restriction models (PQ, PV, VTH, P, TH). These models are designed for electromechanical transient stability analysis within the OmniPES Transient framework.
</p>

<h3>Main Models</h3>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a> — Core synchronous machine model</li> 
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
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines  .Interfaces.Classical_Electric\">Classical_Electric</a></li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_1_0_Electric\">Model_1_0_Electric</a></li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_1_Electric\">Model_2_1_Electric</a></li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric\">Model_2_2_Electric</a></li>
    </ul>
  </li>
</ul>

<h3>Data Records</h3>
<p><a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a> model relies on parameter records to organize machine parameters and initial operating specifications:</p>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.SynchronousMachineData\">SynchronousMachineData</a>: rated values and electrical constants (e.g., Xd, Xq, X1d, X2d, time constants, inertia H, damping, etc.).</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.RestrictionData\">RestrictionData</a>: power-flow specifications used for initial conditions (e.g., Psp, Qsp, Vsp, theta_sp).</li>
</ul>
<p>These records are passed to <a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a> via parameters <code>smData</code>.</p>


</body></html>"));
  end SynchronousMachines;