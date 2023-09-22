within OmniPES.Transient.Examples;

model Problema_4_3_Generic_Machine
  OmniPES.Circuit.Basic.TLine tLine(Q = 0, r = 0, x = 0.5) annotation(
    Placement(visible = true, transformation(origin = {2, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance trafo(x = 0.15) annotation(
    Placement(visible = true, transformation(origin = {-76, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
    Placement(visible = true, transformation(origin = {88, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-42, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OmniPES.SystemData data(Sbase = 2220.) annotation(
    Placement(visible = true, transformation(origin = {-191, 69}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData smData(H = 3.5, MVAb = 2220., MVAs = 2220.) annotation(
    Placement(visible = true, transformation(origin = {-156, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData pfdata(Psp = 1776., Vsp = 1.0) annotation(
    Placement(visible = true, transformation(origin = {-128, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Switches.Fault fault(X = 0.01, t_off = 0.2, t_on = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-42, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Basic.TLine_switched tLine_switched(Q = 0, r = 0, t_open = 0.2, x = 0.93) annotation(
    Placement(visible = true, transformation(origin = {4, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Machines.GenericSynchronousMachine GS(smData = smData, specs = pfdata, redeclare OmniPES.Transient.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(visible = true, transformation(origin = {-142, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));

model IEEE_AC4A
  extends OmniPES.Transient.Controllers.Interfaces.PartialAVR;
  Modelica.Blocks.Continuous.FirstOrder Rectifier(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 200) annotation(
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1) annotation(
    Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = +4, uMin = -4) annotation(
    Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction LeadLag(a = {1, 10}, b = {1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
    Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(add3.u3, Vsad) annotation(
    Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
  connect(Vref.y, add3.u2) annotation(
    Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
  connect(const.y, Vref.u) annotation(
    Line(points = {{-112, 0}, {-102, 0}, {-102, 0}, {-102, 0}}, color = {0, 0, 127}));
  connect(Rectifier.y, limiter.u) annotation(
    Line(points = {{51, 0}, {70, 0}}, color = {0, 0, 127}));
  connect(limiter.y, Efd) annotation(
    Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(add3.y, LeadLag.u) annotation(
    Line(points = {{-32, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 0, 127}));
  connect(LeadLag.y, Rectifier.u) annotation(
    Line(points = {{12, 0}, {28, 0}, {28, 0}, {28, 0}}, color = {0, 0, 127}));
  connect(firstOrder.u, Vctrl) annotation(
    Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
  connect(firstOrder.y, add3.u1) annotation(
    Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
end IEEE_AC4A;

equation
  connect(bus1.p, trafo.p) annotation(
    Line(points = {{-104, -2}, {-86, -2}}, color = {0, 0, 255}));
  connect(trafo.n, bus2.p) annotation(
    Line(points = {{-66, -2}, {-53, -2}, {-53, -4}, {-42, -4}}, color = {0, 0, 255}));
  connect(tLine.p, bus2.p) annotation(
    Line(points = {{-9, 13}, {-24, 13}, {-24, -4}, {-42, -4}}, color = {0, 0, 255}));
  connect(tLine.n, bus3.p) annotation(
    Line(points = {{13, 13}, {48, 13}, {48, -2}}, color = {0, 0, 255}));
  connect(voltageSource.p, bus3.p) annotation(
    Line(points = {{88, -2}, {48, -2}}, color = {0, 0, 255}));
  connect(bus2.p, fault.T) annotation(
    Line(points = {{-42, -4}, {-42, -36}}, color = {0, 0, 255}));
  connect(tLine_switched.p, bus2.p) annotation(
    Line(points = {{-6, -18}, {-28, -18}, {-28, -4}, {-42, -4}}, color = {0, 0, 255}));
  connect(tLine_switched.n, bus3.p) annotation(
    Line(points = {{16, -18}, {48, -18}, {48, -2}}, color = {0, 0, 255}));
  connect(GS.terminal, bus1.p) annotation(
    Line(points = {{-132, 2}, {-104, 2}, {-104, -2}}, color = {0, 0, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
    Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.001));
end Problema_4_3_Generic_Machine;