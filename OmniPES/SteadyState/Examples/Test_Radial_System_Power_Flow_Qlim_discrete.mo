within OmniPES.SteadyState.Examples;

model Test_Radial_System_Power_Flow_Qlim_discrete
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {52, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.01) annotation(
    Placement(visible = true, transformation(origin = {74, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
    Placement(transformation(origin = {-70, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {94, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 1e8, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {2, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable OmniPES.SteadyState.Sources.PVSource_Qlim_discrete pVSource_Qlim(Psp = 1e8, Qmax = 6e7, Qmin = -6e7, Vsp = 1.0, voltage_limits = true) annotation(
    Placement(transformation(origin = {128.556, 19.4444}, extent = {{-18, -20}, {18, 16}})));
  Circuit.Basic.TLine_switched tLine1(r = 0, x = 0.1, Q = 1e8, t_open_p = 2, t_open_n = 2, open_p = true, open_n = true) annotation(
    Placement(transformation(origin = {0, -8}, extent = {{-10, -10}, {10, 10}})));
  Sources.VTHSource vTHSource annotation(
    Placement(transformation(origin = {-115, 17}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
  Circuit.Switches.Breaker breaker annotation(
    Placement(transformation(origin = {52, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Circuit.Basic.Shunt_Reactor shunt_Reactor(NominalPower = 1.5e8) annotation(
    Placement(transformation(origin = {52, -48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 4, startValue = true) annotation(
    Placement(transformation(origin = {88, -20}, extent = {{10, -10}, {-10, 10}})));
equation
  connect(impedance2.p, bus1.p) annotation(
    Line(points = {{-60, 18}, {-46.8, 18}}, color = {0, 0, 255}));
  connect(bus2.p, impedance1.n) annotation(
    Line(points = {{52, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(impedance1.p, bus3.p) annotation(
    Line(points = {{84, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(tLine.n, bus2.p) annotation(
    Line(points = {{14, 30}, {38, 30}, {38, 22}, {52, 22}, {52, 16}}, color = {0, 0, 255}));
  connect(tLine.p, bus1.p) annotation(
    Line(points = {{-8, 30}, {-34, 30}, {-34, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
  connect(pVSource_Qlim.p, bus3.p) annotation(
    Line(points = {{110, 17}, {101, 17}, {101, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(tLine1.p, bus1.p) annotation(
    Line(points = {{-11, -5}, {-26, -5}, {-26, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(tLine1.n, bus2.p) annotation(
    Line(points = {{11, -5}, {34, -5}, {34, 16}, {52, 16}}, color = {0, 0, 255}));
  connect(vTHSource.p, impedance2.n) annotation(
    Line(points = {{-100, 17}, {-100, 18}, {-80, 18}}, color = {0, 0, 255}));
  connect(breaker.p, bus2.p) annotation(
    Line(points = {{52, -10}, {52, 16}}, color = {0, 0, 255}));
  connect(breaker.n, shunt_Reactor.p) annotation(
    Line(points = {{51.8, -30}, {51.8, -38}}, color = {0, 0, 255}));
  connect(booleanStep.y, breaker.ext_open) annotation(
    Line(points = {{77, -20}, {60, -20}}, color = {255, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 6, Tolerance = 1e-06, Interval = 0.01),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
  annotation(
    Documentation(info="<html>
<h3>Radial System with Discrete Reactive Power Limits (PVSource_Qlim_discrete)</h3>

<p>
This example mirrors the topology of <code>Test_Radial_System_Power_Flow</code> but specifically
exercises the discrete reactive power limiting behavior of
<code>PVSource_Qlim_discrete</code>. The network is radial with two parallel transmission lines (one fixed,
one switchable), an upstream Thevenin voltage source, and a remote PV source with Q-limits.
</p>

<h4>Topology and Components </h4>
<ul>
  <li><strong><code>data</code></strong>: inner <em>OmniPES.SystemData</em> (base power and frequency)</li>
  <li><strong><code>bus1</code></strong>, <strong><code>bus2</code></strong>, <strong><code>bus3</code></strong>: <em>OmniPES.Circuit.Interfaces.Bus</em> interconnection nodes</li>
  <li><strong><code>impedance2</code></strong>: <em>OmniPES.Circuit.Basic.SeriesImpedance</em> (x = 0.01) between upstream source and <code>bus1</code></li>
  <li><strong><code>impedance1</code></strong>: <em>OmniPES.Circuit.Basic.SeriesImpedance</em> (x = 0.01) between <code>bus2</code> and <code>bus3</code></li>
  <li><strong><code>tLine</code></strong>: <em>OmniPES.Circuit.Basic.TLine</em> (r = 0, x = 0.1, Q = 1e8) between <code>bus1</code> and <code>bus2</code></li>
  <li><strong><code>tLine1</code></strong>: <em>OmniPES.Circuit.Basic.TLine_switched</em> (r = 0, x = 0.1, Q = 100 Mvar, t_open_p = 2, t_open_n = 2, open_p = true, open_n = true) in parallel with <code>tLine</code></li>
  <li><strong><code>zip</code></strong>: (not present in this test) — replaced by shunt branch and breaker at <code>bus2</code></li>
  <li><strong><code>breaker</code></strong>: <em>OmniPES.Circuit.Switches.Breaker</em> inserting/removing the shunt branch at <code>bus2</code></li>
  <li><strong><code>shunt_Reactor</code></strong>: <em>OmniPES.Circuit.Basic.Shunt_Reactor</em> (NominalPower = 150 Mvar) connected via <code>breaker</code></li>
  <li><strong><code>booleanStep</code></strong>: <em>Modelica.Blocks.Sources.BooleanStep</em> (startTime = 4, startValue = true) to control <code>breaker.ext_open</code></li>
  <li><strong><code>vTHSource</code></strong>: <em>OmniPES.SteadyState.Sources.VTHSource</em> upstream Thevenin voltage source feeding <code>bus1</code> through <code>impedance2</code></li>
  <li><strong><code>pVSource_Qlim</code></strong>: replaceable <em>OmniPES.SteadyState.Sources.PVSource_Qlim_discrete</em>
      (Psp = 100 MW, Vsp = 1.0, Qmax = 60 Mvar, Qmin = -60 Mvar, voltage_limits = true) connected at <code>bus3</code></li>
  <li><strong><code>tLine</code></strong> and <strong><code>tLine1</code></strong> form two parallel feeders from <code>bus1</code> to <code>bus2</code></li>
  <li>All buses are interconnection nodes (no PV/slack designation). Sources are modeled as components injecting into buses.</li>
  
</ul>

<h4>Key Parameters and Signals</h4>
<ul>
  <li><strong>Reactive limits:</strong> <code>pVSource_Qlim.Qmax = 60 Mvar</code>, <code>pVSource_Qlim.Qmin = -60 Mvar</code> (discrete enforcement)</li>
  <li><strong>Voltage setpoint:</strong> <code>pVSource_Qlim.Vsp = 1.0</code> pu</li>
  <li><strong>Thevenin source:</strong> <code>vTHSource</code> provides upstream voltage support into <code>bus1</code></li>
  <li><strong>Feeder switching:</strong> <code>tLine1</code> opens at <code>t = 2 s</code> on both ends (<code>t_open_p</code>, <code>t_open_n</code>)</li>
  <li><strong>Shunt switching:</strong> <code>breaker.ext_open</code> driven by <code>booleanStep</code> at <code>t = 4 s</code></li>
</ul>

<h4>Simulation</h4>
<ul>
  <li>StartTime = 0 s, StopTime = 6 s</li>
  <li>Tolerance = 1e-6</li>
  <li>Output Interval = 0.01 s</li>
</ul>

<h4>What to Observe</h4>
<ul>
  <li>Before any disturbance, the <code>pVSource_Qlim</code> operates restricted at its minimum reactive power limit.</li>
  <li>At t = 2 s, when the parallel line opens, observe how <code>pVSource_Qlim</code> adjusts its reactive power output to keep its terminal voltage at the desired setpoint at 1 pu.</li>
  <li>At t = 4 s, when the shunt reactor is connected via the breaker, observe how <code>pVSource_Qlim</code> again modifies its reactive power output, hitting its maximum reactive power limit, loosing voltage control at its terminal.</li>
</ul>

<h4>Notes</h4>
<ul>
  <li>This example focuses on discrete reactive power limits; for smooth limits see <a href=\"modelica://OmniPES.SteadyState.Examples.Test_Radial_System_Power_Flow_Qlim_sigmoid\">Test_Radial_System_Power_Flow_Qlim_sigmoid</a>.</li>
</ul>
</html>"));

end Test_Radial_System_Power_Flow_Qlim_discrete;