within OmniPES.Transient.Examples;

model Problema_4_3
  OmniPES.Circuit.Basic.TLine tLine(Q = 0, r = 0, x = 0.5) annotation(
    Placement(visible = true, transformation(origin = {2, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance trafo(x = 0.15) annotation(
    Placement(visible = true, transformation(origin = {-74, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
    Placement(visible = true, transformation(origin = {88, -12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Transient.Machines.ClassicalSynchronousMachine GS(redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PV restriction, smData = smData, specs = pfdata) annotation(
    Placement(visible = true, transformation(origin = {-143, -3}, extent = {{-13, -13}, {13, 13}}, rotation = 180)));
  Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-42, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {48, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OmniPES.SystemData data(Sbase = 2220) annotation(
    Placement(visible = true, transformation(origin = {-191, 69}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  parameter Machines.SynchronousMachineData smData(H = 3.5, MVAb = 2220, MVAs = 2220) annotation(
    Placement(visible = true, transformation(origin = {-162, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData pfdata(Psp = 1776, Vsp = 1.0) annotation(
    Placement(visible = true, transformation(origin = {-134, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Switches.Fault fault(X = 0.01, t_off = 100.2, t_on = 100.1) annotation(
    Placement(visible = true, transformation(origin = {-42, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Basic.TLine_switched tLine_switched(Q = 0, r = 0, t_open = 100.2, x = 0.93) annotation(
    Placement(visible = true, transformation(origin = {4, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(GS.terminal, bus1.p) annotation(
    Line(points = {{-130, -3}, {-118, -3}, {-118, -2}, {-104, -2}}, color = {0, 0, 255}));
  connect(bus1.p, trafo.p) annotation(
    Line(points = {{-104, -2}, {-94, -2}, {-94, -4}, {-84, -4}}, color = {0, 0, 255}));
  connect(trafo.n, bus2.p) annotation(
    Line(points = {{-64, -4}, {-42, -4}}, color = {0, 0, 255}));
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
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
    Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.001));
end Problema_4_3;