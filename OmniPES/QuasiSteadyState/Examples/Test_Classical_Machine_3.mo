within OmniPES.QuasiSteadyState.Examples;

model Test_Classical_Machine_3
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-68, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 5, MVAb = 100, Nmaq = 1, Ra = 0.0, X1d = 0.2, X1q = 0.2, Xd = 1.0, Xl = 0.0, Xq = 0.8) annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Psp = 80., Qsp = 0, Vsp = 1.0) annotation(
    Placement(visible = true, transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //
  OmniPES.QuasiSteadyState.Machines.ClassicalSynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, smData = gen1_data, specs = gen1_specs) annotation(
    Placement(visible = true, transformation(origin = {67, 21}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(magnitude = 1.05) annotation(
    Placement(visible = true, transformation(origin = {-66, 12}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 0, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-6, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Switches.Fault fault(X = 1e-4) annotation(
    Placement(visible = true, transformation(origin = {20, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tLine.n, SM.terminal) annotation(
    Line(points = {{5, 21}, {56, 21}}, color = {0, 0, 255}));
  connect(tLine.p, voltageSource.p) annotation(
    Line(points = {{-17, 21}, {-66, 21}, {-66, 20}}, color = {0, 0, 255}));
  connect(fault.T, tLine.n) annotation(
    Line(points = {{20, 8}, {6, 8}, {6, 22}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    Diagram);
end Test_Classical_Machine_3;