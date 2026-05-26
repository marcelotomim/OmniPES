within OmniPES.Transient.SynchronousMachines;

model GenericSynchronousMachine
  OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
    Placement(transformation(origin = {-89.5, 19.5}, extent = {{-9.5, -9.5}, {9.5, 9.5}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  //
  // Machine parameters
  //
  outer SystemData data;
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {0, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  final parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData convData = ConvertBase(smData, data.Sbase) "Record with machine parameters in the system base";
  //
  // Power Flow Restriction
  //
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData specs "Record with load flow specs." annotation(
    Dialog(tab = "Power Flow Restriction", group = "Parameters"),
    Placement(visible = true, transformation(origin = {-40, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  //
  replaceable OmniPES.Transient.SynchronousMachines.Interfaces.Restriction restriction annotation(
    Placement(transformation(origin = {59, 71}, extent = {{-19, -19}, {19, 19}}))) constrainedby OmniPES.Transient.SynchronousMachines.Interfaces.Restriction(param = specs) annotation(
     choicesAllMatching = true,
     Dialog(tab = "Power Flow Restriction", group = "Model"),
     Placement(transformation(origin = {55, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  //
  // Electrical Model
  //
  replaceable OmniPES.Transient.SynchronousMachines.Interfaces.PartialElectrical electrical(smData = convData) constrainedby OmniPES.Transient.SynchronousMachines.Interfaces.PartialElectrical(smData = convData) annotation(
     Evaluate = true,
     choicesAllMatching = true,
     Dialog(tab = "Electrical Model", group = "Model"),
     Placement(transformation(origin = {-11.5, 2.5}, extent = {{-20.5, -20.5}, {20.5, 20.5}})));
  //
  // Mechanical Model
  //
  OmniPES.Transient.SynchronousMachines.Interfaces.Inertia inertia(smData = convData) annotation(
    Placement(transformation(origin = {67, 3}, extent = {{-20, -20}, {20, 20}})));
  //
  // Automatic Voltage Regulator
  //
  parameter Boolean avr_on = false annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(tab = "Controllers", group = "Automatic Voltage Regulator", enable = electrical.allow_ctrl));
  //
  replaceable OmniPES.Transient.Controllers.AVR.ConstantEfd avr if avr_on annotation(
    Placement(transformation(origin = {-68, -10}, extent = {{-10, 10}, {10, -10}}))) constrainedby OmniPES.Transient.Controllers.Interfaces.PartialAVR annotation(
     choicesAllMatching = true,
     Dialog(tab = "Controllers", group = "Automatic Voltage Regulator", enable = avr_on),
     Placement(transformation(origin = {-68, -10}, extent = {{-10, 10}, {10, -10}})));
  //
  // Speed Regulator
  //
  parameter Boolean sreg_on = false annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(tab = "Controllers", group = "Speed Regulator", enable = electrical.allow_ctrl));
  //
  replaceable OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg if sreg_on annotation(
    Placement(transformation(origin = {64, -44}, extent = {{-10, 10}, {10, -10}}, rotation = -180))) constrainedby OmniPES.Transient.Controllers.Interfaces.PartialSpeedRegulator annotation(
     choicesAllMatching = true,
     Dialog(tab = "Controllers", group = "Speed Regulator", enable = sreg_on),
     Placement(transformation(origin = {64, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //
  // PSS
  //
  parameter Boolean pss_on = false "enabled only if avr_on == true" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(tab = "Controllers", group = "Power System Stabilizer", enable = avr_on));
  //
  replaceable OmniPES.Transient.Controllers.PSS.NoPSS pss if pss_on and avr_on annotation(
    Placement(transformation(origin = {4, -69}, extent = {{-10, 10}, {10, -10}}, rotation = -180))) constrainedby OmniPES.Transient.Controllers.Interfaces.PartialPSS annotation(
     Dialog(tab = "Controllers", group = "Power System Stabilizer", enable = pss_on),
     choicesAllMatching = true,
     Placement(transformation(origin = {4, -69}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //
equation
  restriction.P = electrical.Pt;
  restriction.Q = electrical.Qt;
  restriction.V = electrical.Vabs;
  restriction.theta = electrical.theta;
  if sreg_on then
    connect(sreg.wctrl, inertia.omega) annotation(
      Line(points = {{75, -44}, {94, -44}, {94, -9}, {89, -9}}, color = {0, 0, 127}));
    connect(sreg.Pm, inertia.Pm) annotation(
      Line(points = {{53, -44}, {29, -44}, {29, -9}, {45, -9}}, color = {0, 0, 127}));
  else
    der(inertia.Pm) = 0;
  end if;
  if avr_on then
    connect(avr.Efd, electrical.Efd) annotation(
      Line(points = {{-57, -10}, {-34, -10}}, color = {0, 0, 127}));
    connect(electrical.Vt, avr.Vctrl) annotation(
      Line(points = {{11.05, -9.8}, {21.05, -9.8}, {21.05, -43.8}, {-85.95, -43.8}, {-85.95, -15.8}, {-78.95, -15.8}}, color = {0, 0, 127}));
    if pss_on then
      connect(pss.omega, inertia.omega) annotation(
        Line(points = {{15, -69}, {94, -69}, {94, -9}, {89, -9}}, color = {0, 0, 127}));
      connect(pss.Vsad, avr.Vsad) annotation(
        Line(points = {{-7, -69}, {-96, -69}, {-96, -4}, {-79, -4}}, color = {0, 0, 127}));
    else
      avr.Vsad = 0.0;
    end if;
  else
    der(electrical.Efd) = 0;
  end if;
  connect(electrical.Pe, inertia.Pe) annotation(
    Line(points = {{11.05, 14.8}, {45.05, 14.8}}, color = {0, 0, 127}));
  connect(inertia.delta, electrical.delta) annotation(
    Line(points = {{89, 15}, {94, 15}, {94, 33}, {-52, 33}, {-52, 15}, {-34, 15}}, color = {0, 0, 127}));
  connect(terminal, electrical.terminal) annotation(
    Line(points = {{-89.5, 19.5}, {-65, 19.5}, {-65, 2.5}, {-34, 2.5}}, color = {0, 0, 255}));
  connect(electrical.signalBus, sreg.signalBus) annotation(
    Line(points = {{-11, 25}, {-12, 25}, {-12, 40}, {104, 40}, {104, -33}, {64, -33}}, color = {255, 204, 51}, thickness = 0.5));
  connect(electrical.signalBus, pss.signalBus) annotation(
    Line(points = {{-11, 25}, {18, 25}, {18, -58}, {4, -58}}, color = {255, 204, 51}, thickness = 0.5));
  connect(avr.signalBus, electrical.signalBus) annotation(
    Line(points = {{-68, -21}, {-68, -26}, {-110, -26}, {-110, 40}, {-11, 40}, {-11, 25}}, color = {255, 204, 51}, thickness = 0.5));
  annotation(
    Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text(origin = {32, 0}, extent = {{65, -55}, {-65, 55}}, textString = "G")}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Text(origin = {28.5, 20}, extent = {{-4, 7}, {5, -7}}, textString = "Pe"), Text(origin = {35, -5}, extent = {{-4, 7}, {5, -7}}, textString = "Pm", textColor = if sreg_on then {0, 0, 0} else {255, 0, 0}), Text(origin = {97, 24}, extent = {{-2, 6}, {3, -6}}, textString = "δ"), Text(origin = {98, -22}, extent = {{-2, 6}, {3, -6}}, textString = "ω"), Text(origin = {-53, -62}, extent = {{-7, 7}, {9, -7}}, textString = "Vsad", textColor = if pss_on then {0, 0, 0} else {195, 195, 195}), Text(origin = {-46, -15}, extent = {{-5, 5}, {6, -5}}, textString = "Efd", textColor = if avr_on then {0, 0, 0} else {255, 0, 0}), Text(origin = {-30.5, -39}, extent = {{-4, 7}, {5, -7}}, textString = "Vt", textColor = if avr_on then {0, 0, 0} else {195, 195, 195})}),
    Documentation(info = "<html><head></head><body>
<h3>Overview</h3>
<p>
<strong>GenericSynchronousMachine</strong> is the core generator model for the Transient subpackage. It provides a flexible framework to study electromechanical dynamics by <em>redeclaring</em> electrical, power flow restrictions (initial conditions), and controller models.
</p>

<h4>Interfaces</h4>
<ul>
  <li><strong>terminal</strong>: <a href=\"modelica://OmniPES.Circuit.Interfaces.PositivePin\">PositivePin</a> electrical connection to the network.</li>
</ul>

<h4>Parameters &amp; Records</h4>
<ul>
  <li><strong>smData</strong>: <a href=\"modelica://OmniPES.Transient.SynchronousMachines.SynchronousMachineData\">SynchronousMachineData</a> — rated values and machine electrical constants.</li>
  <li><strong>convData</strong>: internally converted machine data in system base (<code>Sbase</code>), produced by <a href=\"modelica://OmniPES.Transient.SynchronousMachines.ConvertBase\">ConvertBase</a>.</li>
  <li><strong>specs</strong>: <a href=\"modelica://OmniPES.Transient.SynchronousMachines.RestrictionData\">RestrictionData</a> — power-flow specifications (Psp, Qsp, Vsp, theta_sp).</li>
</ul>

<h4>Redeclarable Submodels</h4>
<ul>
  <li><strong>power-flow restrictions</strong> (<a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction\">Interfaces.Restriction</a>)
    <ul>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PQ\">Restriction_PQ</a> — specified P and Q</li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV\">Restriction_PV</a> — specified P and V</li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_VTH\">Restriction_VTH</a> — specified V and angle (swing bus)</li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_P\">Restriction_P</a> — specified P</li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_TH\">Restriction_TH</a> — specified angle</li>
    </ul>
  </li>
  <li><strong>electrical</strong> (<a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.PartialElectrical\">Interfaces.PartialElectrical</a>)
    <ul>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Classical_Electric\">Classical_Electric</a></li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_1_0_Electric\">Model_1_0_Electric</a></li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_1_Electric\">Model_2_1_Electric</a></li>
      <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric\">Model_2_2_Electric</a></li>
    </ul>
  </li>
  <li><strong>inertia</strong>: <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Inertia\">Interfaces.Inertia</a> — mechanical rotor/inertia model.</li>
  <li><strong>avr</strong> (<em>optional</em>): <a href=\"modelica://OmniPES.Transient.Controllers.Interfaces.PartialAVR\">Controllers.Interfaces.PartialAVR</a> (default <a href=\"modelica://OmniPES.Transient.Controllers.AVR.ConstantEfd\">ConstantEfd</a>)</li>
  <li><strong>sreg</strong> (<em>optional</em>): <a href=\"modelica://OmniPES.Transient.Controllers.Interfaces.PartialSpeedRegulator\">Controllers.Interfaces.PartialSpeedRegulator</a> (default <a href=\"modelica://OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm\">ConstantPm</a>)</li>
  <li><strong>pss</strong> (<em>optional</em>): <a href=\"modelica://OmniPES.Transient.Controllers.Interfaces.PartialPSS\">Controllers.Interfaces.PartialPSS</a> (default <a href=\"modelica://OmniPES.Transient.Controllers.PSS.NoPSS\">NoPSS</a>)</li>
  
</ul>

<h4>Signals &amp; Equations</h4>
<p>This section maps the main variables between submodels, as one can also see in the Diagram View.</p>
<p style=\"text-align:center; margin: 8px 0 16px 0;\">
  <img src=\"modelica://OmniPES.Resources.Images/GenericSynchronousMachine.svg\" alt=\"Generic Synchronous Machine Diagram\" style=\"max-width:100%;\"/>
  <br/>
  <em>Diagram rendering embedded from Resources/Images.</em>
  <br/>
  <small><strong>Legend</strong>: yellow bus lines = <code>signalBus</code>. Published fields from electrical: <code>TerminalActivePower</code> (= <code>Pt</code>), <code>TerminalReactivePower</code> (= <code>Qt</code>). AVR receives <code>Vctrl</code> directly from <code>Vt</code>.</small>
</p>
<ul>
  <li><strong>Power-flow bindings</strong> (initial condition enforcement):
    <ul>
      <li><code>restriction.P</code> = <code>electrical.Pt</code> (active power at terminal)</li>
      <li><code>restriction.Q</code> = <code>electrical.Qt</code> (reactive power at terminal)</li>
      <li><code>restriction.V</code> = <code>electrical.Vabs</code> (voltage magnitude at terminal)</li>
      <li><code>restriction.theta</code> = <code>electrical.theta</code> (voltage angle at terminal)</li>
    </ul>
  </li>
  <li><strong>Electro‑mechanical coupling</strong>:
    <ul>
      <li><code>electrical.Pe</code> → <code>inertia.Pe</code> (air‑gap electrical power to mechanical block)</li>
      <li><code>inertia.delta</code> → <code>electrical.delta</code> (rotor angle to electrical model)</li>
      <li><code>inertia.omega</code> feeds regulators (when enabled)</li>
      <li><code>inertia.Pm</code> is set by speed regulator if present; otherwise held constant</li>
    </ul>
  </li>
  <li><strong>Controllers</strong> (if enabled):
    <ul>
      <li><em>AVR</em>: <code>avr.Efd</code> → <code>electrical.Efd</code> (field voltage); <code>electrical.Vt</code> → <code>avr.Vctrl</code> (voltage feedback)</li>
      <li><em>PSS</em>: <code>inertia.omega</code> → <code>pss.omega</code>; <code>pss.Vsad</code> → <code>avr.Vsad</code> (stabilizing signal)</li>
      <li><em>Speed Regulator</em>: <code>inertia.omega</code> → <code>sreg.wctrl</code> (speed input); <code>sreg.Pm</code> → <code>inertia.Pm</code> (mechanical power command)</li>
      <li><em>Signal buses</em>: <code>electrical.signalBus</code> ↔ <code>avr.signalBus</code>, <code>sreg.signalBus</code>, <code>pss.signalBus</code> — shared measurement/aux channels for controllers (yellow bus in diagram). Exposed extra fields include <code>signalBus.TerminalActivePower</code> (= <code>electrical.Pt</code>) and <code>signalBus.TerminalReactivePower</code> (= <code>electrical.Qt</code>), that can be used for designing specific controllers.</li>
    </ul>
  </li>
</ul>

<h4>Usage Example</h4>
<pre>model Example
  inner OmniPES.SystemData data(Sbase=100e6, fb=60);
  OmniPES.Circuit.Interfaces.Bus bus;

  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData gen_data(
    MVAb=100e6, H=6.5, Xd=1.8, Xq=1.7, X1d=0.3, X1q=0.55, X2d=0.25, X2q=0.25,
    T1d0=8, T2d0=0.03, T1q0=0.4, T2q0=0.05, Xl=0.2, Ra=0.0);

  parameter OmniPES.Transient.SynchronousMachines.RestrictionData gen_specs(
    Psp=80e6, Qsp=0.0, Vsp=1.02, theta_sp=0);

  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine gen(
    smData=gen_data, specs=gen_specs,
    redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV restriction,
    redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_1_Electric electrical,
    avr_on=false, sreg_on=false, pss_on=false);

equation
  connect(bus.p, gen.terminal);
end Example;
</pre>

<h4>Related</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.SynchronousMachineData\">SynchronousMachineData</a></li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.RestrictionData\">RestrictionData</a></li>
  <li><a href=\"modelica://OmniPES.Transient.Controllers.AVR.ConstantEfd\">Controllers.AVR.ConstantEfd</a>, <a href=\"modelica://OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm\">Controllers.SpeedRegulators.ConstantPm</a>, <a href=\"modelica://OmniPES.Transient.Controllers.PSS.NoPSS\">Controllers.PSS.NoPSS</a></li>
</ul>

</body></html>"));
end GenericSynchronousMachine;