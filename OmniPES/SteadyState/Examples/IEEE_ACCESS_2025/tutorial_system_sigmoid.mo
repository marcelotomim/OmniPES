within OmniPES.SteadyState.Examples.IEEE_ACCESS_2025;

model tutorial_system_sigmoid
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {107, 46}, extent = {{-23, -23}, {23, 23}})));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(transformation(origin = {-93, -21}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(transformation(origin = {-92, 50}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus10 annotation(
    Placement(transformation(origin = {-17, -19}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus20 annotation(
    Placement(transformation(origin = {-17, 50}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Interfaces.Bus bus30 annotation(
    Placement(transformation(origin = {86, -22}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo1(x = 0.2) annotation(
    Placement(transformation(origin = {-55, -21}, extent = {{-15, -15}, {15, 15}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo2(x = 0.07) annotation(
    Placement(transformation(origin = {-53, 50}, extent = {{-15, -15}, {15, 15}})));
  OmniPES.Circuit.Basic.SeriesImpedance line1(x = 0.07) annotation(
    Placement(transformation(origin = {13.5, 12.5}, extent = {{-13.5, -13.5}, {13.5, 13.5}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line21(x = 0.18) annotation(
    Placement(transformation(origin = {44.5, -21.5}, extent = {{-16.5, -16.5}, {16.5, 16.5}})));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line22(t_open = 2500, x = 0.18, open = false) annotation(
    Placement(transformation(origin = {45.5, -43.5}, extent = {{-15.5, -15.5}, {15.5, 15.5}})));
  OmniPES.SteadyState.Loads.ZIPLoad load(Psp = 1.2e8, Qsp = 0, useExternalPsp = true, useExternalQsp = false) annotation(
    Placement(transformation(origin = {133.945, -76.9444}, extent = {{-18, -20}, {18, 15.9999}}, rotation = -90)));
  replaceable OmniPES.SteadyState.Sources.VTHSource_Qlim_sigmoid G1(Qmax = 2.6e7, Vsp = 1.017, angle = 0.0, useExternalVoltageSpec = false, useExternalPowerSpec = false) annotation(
    Placement(transformation(origin = {-134, -21}, extent = {{-21, -21}, {21, 21}}, rotation = 180)));
  replaceable OmniPES.SteadyState.Sources.PVSource_Qlim_sigmoid G2(Psp = 9e7, Qmax = 7.8e7, Vsp = 1.025, useExternalVoltageSpec = false, useExternalPowerSpec = true) annotation(
    Placement(transformation(origin = {-127, 50}, extent = {{-21, -21}, {21, 21}}, rotation = 180)));
  Modelica.Blocks.Sources.Ramp rampP(duration = 140, height = 140e6, startTime = 0) annotation(
    Placement(transformation(origin = {-224, -8}, extent = {{-14, -14}, {14, 14}})));
  Modelica.Blocks.Math.Gain gain(k = 3/4) annotation(
    Placement(transformation(origin = {-173.5, 42.5}, extent = {{-11.5, -11.5}, {11.5, 11.5}})));
equation
  connect(bus2.p, trafo2.p) annotation(
    Line(points = {{-91.7, 50}, {-69.5, 50}}, color = {0, 0, 255}));
  connect(trafo2.n, bus20.p) annotation(
    Line(points = {{-36.5, 50}, {-17, 50}}, color = {0, 0, 255}));
  connect(bus1.p, trafo1.p) annotation(
    Line(points = {{-92.7, -21}, {-71.5, -21}}, color = {0, 0, 255}));
  connect(trafo1.n, bus10.p) annotation(
    Line(points = {{-38.5, -21}, {-17, -21}}, color = {0, 0, 255}));
  connect(line22.p, bus10.p) annotation(
    Line(points = {{30.62, -43.5}, {-17.38, -43.5}, {-17.38, -21}, {-16.98, -21}}, color = {0, 0, 255}));
  connect(line1.n, bus10.p) annotation(
    Line(points = {{13.23, -1}, {13.23, -21}, {-17.17, -21}}, color = {0, 0, 255}));
  connect(line21.p, bus10.p) annotation(
    Line(points = {{28.66, -21.5}, {14.36, -21.5}, {14.36, -21}, {-16.94, -21}}, color = {0, 0, 255}));
  connect(line21.n, bus30.p) annotation(
    Line(points = {{61, -21.83}, {86, -21.83}}, color = {0, 0, 255}));
  connect(G1.p, bus1.p) annotation(
    Line(points = {{-112.58, -21}, {-93, -21}}, color = {0, 0, 255}));
  connect(load.p, bus30.p) annotation(
    Line(points = {{131.945, -58.5844}, {131.945, -21.5844}, {85.9448, -21.5844}}, color = {0, 0, 255}));
  connect(gain.y, G2.dPsp) annotation(
    Line(points = {{-161, 42.5}, {-150.6, 42.5}, {-150.6, 42}, {-141, 42}}, color = {0, 0, 127}));
  connect(G2.p, bus2.p) annotation(
    Line(points = {{-106, 50}, {-91.15, 50}}, color = {0, 0, 255}));
  connect(line1.p, bus20.p) annotation(
    Line(points = {{13.5, 25.46}, {13.5, 50.06}, {-17, 50.06}}, color = {0, 0, 255}));
  connect(line22.n, bus30.p) annotation(
    Line(points = {{61, -43.5}, {86, -43.5}, {86, -22.5}}, color = {0, 0, 255}));
  connect(rampP.y, gain.u) annotation(
    Line(points = {{-209, -8}, {-199, -8}, {-199, 42.5}, {-187, 42.5}}, color = {0, 0, 127}));
  connect(rampP.y, load.dPsp) annotation(
    Line(points = {{-209, -8}, {-199, -8}, {-199, -70}, {119, -70}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1}), graphics = {Text(origin = {-157.5, 5}, extent = {{-1.5, -1}, {1.5, 1}}, textString = "text")}),
    experiment(StartTime = 0, StopTime = 101, Tolerance = 1e-06, Interval = 0.1),
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_EVENTS_V,LOG_STATS,LOG_STATS_V", s = "dassl", variableFilter = ".*"),
    Documentation(info="<html>
<h3>Tutorial System with Sigmoid Reactive Power Limiting</h3>

<p>
This tutorial system demonstrates the OmniPES library capabilities for steady-state power flow 
and secondary voltage regulation (SVR) with smooth (sigmoid) reactive power limiting functions.
</p>

<h4>System Overview</h4>

<p>
The test system consists of a three-bus network with two generators and one load, interconnected through transformers and transmission lines. The model demonstrates steady-state analysis capabilities with under load variations and reactive power control using sigmoid-type limiting functions.
</p>

<h4>System Components</h4>

<table border=\"1\" cellpadding=\"2\">
<tr><th>Component</th><th>Type</th><th>Location</th><th>Parameters</th></tr>
<tr><td>G1</td><td>VTHSource_Qlim_sigmoid</td><td>Bus 1</td><td>Vsp=1.017 pu, Qmax=26 Mvar</td></tr>
<tr><td>G2</td><td>PVSource_Qlim_sigmoid</td><td>Bus 2</td><td>Psp=90 MW, Vsp=1.025 pu, Qmax=78 Mvar</td></tr>
<tr><td>load</td><td>ZIPLoad</td><td>Bus 30</td><td>Psp=120 MW (variable), Qsp=0 Mvar</td></tr>
<tr><td>trafo1</td><td>TwoWindingTransformer</td><td>Bus 1-10</td><td>x=0.2 pu</td></tr>
<tr><td>trafo2</td><td>TwoWindingTransformer</td><td>Bus 2-20</td><td>x=0.07 pu</td></tr>
<tr><td>line1</td><td>SeriesImpedance</td><td>Bus 20-10</td><td>x=0.07 pu</td></tr>
<tr><td>line21</td><td>SeriesImpedance</td><td>Bus 10-30</td><td>x=0.18 pu</td></tr>
<tr><td>line22</td><td>SeriesImpedance_switched</td><td>Bus 10-30</td><td>x=0.18 pu (can be opened)</td></tr>
</table>

<h4>Key Features</h4>

<ul>
<li><strong>Sigmoid Reactive Power Limiting:</strong> Both generators use sigmoid-type (smooth) 
reactive power limiting functions instead of hard limits. </li>

<li><strong>Load Variations:</strong> The load active power increases linearly over 140 seconds 
from 120 MW to 260 MW (140 MW ramp), simulating load growth with time.</li>

<li><strong>Generator Power Dispatch:</strong> Generator G2 power output varies proportionally with 3/4th of the load increase, while G1 varies with the remaining 1/4th, demonstrating load sharing between generators.</li>

<li><strong>Line Contingency:</strong> The parallel line (Line22) can be opened, 
simulating a transmission line outage scenario.</li>

<li><strong>Steady-State Focus:</strong> This model emphasizes steady-state power flow calculations 
rather than dynamic transients.</li>
</ul>

<h4>Recommended Simulation Parameters</h4>

<ul>
<li><strong>Duration:</strong> 101 seconds</li>
<li><strong>Tolerance:</strong> 1e-06</li>
<li><strong>Solver:</strong> DASSL (Differential-Algebraic System Solver)</li>
<li><strong>Output Interval:</strong> 0.1 second</li>
</ul>

<h4>Main Control Signals</h4>

<ul>
<li><strong>rampP:</strong> Linear load increase from 0 to 140 MW over 140 seconds</li>
<li><strong>gain (3/4):</strong> Proportional power dispatch to generator G2, passed to its setpoint input <code>G2.dPsp</code>.</li>
<li><strong>load.dPsp:</strong> Active power setpoint for the load</li>
</ul>

<h4>Initial Operating Point</h4>

<ul>
<li><strong>Generator G1 (Bus 1):</strong>
  <ul>
    <li> slack node </li>
    <li> <em>voltage setpoint:</em> 1.017 pu (angle reference)</li>
  </ul>  
</li>
<li><strong>Generator G2 (Bus 2):</strong>
  <ul>
    <li> PV node </li>
    <li> <em>voltage setpoint:</em> 1.025 pu</li>
    <li> <em>active power setpoint:</em> 90 MW</li>
  </ul>  
</li>
<li><strong>Load (Bus 30):</strong>
  <ul>
    <li> PQ node </li>
    <li> <em>active power setpoint:</em> 120 MW</li>
    <li> <em>reactive power setpoint:</em> 0 Mvar</li>
  </ul>  
</li>
</ul>

<h4>Expected Behavior</h4>

<p>
During simulation, as the load increases:
</p>

<ol>
<li>Load active power increases linearly from 120 MW to 260 MW</li>
<li>Generator G2 output increases proportionally to the load increase</li>
<li>Generator G1 output increases in order keep the power balance</li>
<li>Bus voltages remain controlled by the generators' voltage setpoints and reactive power limits</li>
<li>Reactive power requirements increase due to higher transmission losses</li>
<li>When reactive power limits are reached, generators lose voltage controls and keep reactive power at the limit</li>
<li>The sigmoid reactive power limits ensure smooth control without abrupt changes</li>
</ol>

<h4>References</h4>

<p>
For more information on OmniPES library and these tutorial systems, please refer to:
</p>

<ul>
<li>Tomim, M. A., Henriques, R. M., and Passos Filho, J. A. (2025). 
<a href=\"https://doi.org/10.1109/ACCESS.2025.3553782\">Introduction to OmniPES: A Modelica Library 
for Power Systems Modeling and Analysis</a>. IEEE Access.</li>
</ul>
</html>"));

end tutorial_system_sigmoid;