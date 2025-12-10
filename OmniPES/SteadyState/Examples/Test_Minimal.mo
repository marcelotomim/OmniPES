within OmniPES.SteadyState.Examples;

model Test_Minimal
  OmniPES.SteadyState.Sources.VTHSource voltageSource annotation(
    Placement(transformation(origin = {-88, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 5e7, r = 0, x = 0.05) annotation(
    Placement(transformation(origin = {37, -5}, extent = {{-15, -15}, {15, 15}})));
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {-69, 61}, extent = {{-19, -19}, {19, 19}})));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(transformation(origin = {-60, 2}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.SteadyState.Sources.PQSource pQSource(Psp = 1e8, Qsp = 0, voltage_limits = false) annotation(
    Placement(transformation(origin = {88, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(transformation(origin = {66, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(transformation(origin = {4, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer twoWindingTransformer(tap = 1.05, x = 0.01) annotation(
    Placement(transformation(origin = {-28, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.SteadyState.Loads.ZIPLoad load(Psp = 5e7, Qsp = 1e7, ss_par = loadData) annotation(
    Placement(transformation(origin = {5, -37}, extent = {{-11, -11}, {11, 11}}, rotation = -90)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData loadData(pi = 0.75, qz = 1) annotation(
    Placement(transformation(origin = {-30, -48}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(voltageSource.p, bus1.p) annotation(
    Line(points = {{-77.8, 0}, {-72.8, 0}, {-72.8, 0.2}, {-59.8, 0.2}}, color = {0, 0, 255}));
  connect(tLine.n, bus3.p) annotation(
    Line(points = {{53.5, -0.5}, {57.5, -0.5}, {57.5, 0}, {66, 0}}, color = {0, 0, 255}));
  connect(pQSource.p, bus3.p) annotation(
    Line(points = {{77.8, 0}, {65.8, 0}}, color = {0, 0, 255}));
  connect(tLine.p, bus2.p) annotation(
    Line(points = {{20.5, -0.5}, {12.5, -0.5}, {12.5, 0}, {4, 0}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.p, bus1.p) annotation(
    Line(points = {{-39, 0}, {-61, 0}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.n, bus2.p) annotation(
    Line(points = {{-17, 0}, {4, 0}}, color = {0, 0, 255}));
  connect(bus2.p, load.p) annotation(
    Line(points = {{4, 0}, {4, -13}, {5, -13}, {5, -26}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
  annotation(
    Documentation(info="<html>
<h3>Minimal Steady-State Power-Flow Example</h3>

<p>
This example shows a simple working steady-state setup in OmniPES: one slack source feeding a
load through a transformer and a short transmission line, plus an additional PQ source at the
remote bus. Use it as a starting point to validate installations and to extend with more devices.
</p>

<h4>Network Topology</h4>
<ul>
<li><strong>Bus1</strong>: Slack bus (VTHSource)</li>
<li><strong>Bus2</strong>: Intermediate/load bus (transformer secondary, load connection)</li>
<li><strong>Bus3</strong>: Remote bus with PQ source</li>
</ul>

<h4>Main Components</h4>
<ul>
<li><strong>VTHSource</strong> (Bus1): Slack/thevenin source setting the reference voltage</li>
<li><strong>TwoWindingTransformer</strong> (Bus1–Bus2): tap = 1.05, x = 0.01 pu</li>
<li><strong>TLine</strong> (Bus2–Bus3): r = 0, x = 0.05 pu, Q = 5e7</li>
<li><strong>PQSource</strong> (Bus3): Psp = 100 MW, Qsp = 0 Mvar, voltage_limits = false</li>
<li><strong>ZIPLoad</strong> (Bus2): Psp = 50 MW, Qsp = 10 Mvar, parameters from LoadData</li>
<li><strong>LoadData</strong>: pi = 0.75 (constant impedance share of active power), qz = 1 (constant
    impedance share of reactive power)</li>
</ul>

<h4>Simulation Setup</h4>
<ul>
<li>StartTime = 0 s, StopTime = 1 s</li>
<li>Tolerance = 1e-6</li>
<li>Interval = 0.002 s (output)</li>
</ul>

<h4>Suggested Uses</h4>
<ul>
<li>Quick sanity check of the steady-state solver and connectors</li>
<li>Template to add additional lines, transformers, or control blocks</li>
<li>Sensitivity checks on transformer tap, line reactance, and load composition</li>
</ul>
</html>"));

end Test_Minimal;