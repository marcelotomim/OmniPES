within OmniPES.QuasiSteadyState.Examples;

model Test_Radial_System
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-76, 78}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
    Placement(visible = true, transformation(origin = {-98, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 500., Qesp = 0.0, Vesp = 1.03, theta_esp = 0) annotation(
    Placement(visible = true, transformation(origin = {52, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.040) annotation(
    Placement(visible = true, transformation(origin = {2, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-86, 22}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {50, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.040) annotation(
    Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-66, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_1_0_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare OmniPES.QuasiSteadyState.Controllers.AVR.ConstantEfd avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(visible = true, transformation(origin = {74, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
    Placement(visible = true, transformation(origin = {82, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Switches.Fault fault(t_off = 0.2, t_on = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.Shunt_Reactor reactor(NominalPower = 10)  annotation(
    Placement(visible = true, transformation(origin = {-46, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(impedance.p, bus3.p) annotation(
    Line(points = {{12, 22}, {49.2, 22}, {49.2, 18}}, color = {0, 0, 255}));
  connect(impedance.n, bus2.p) annotation(
    Line(points = {{-8, 22}, {-46, 22}, {-46, 18.4}}, color = {0, 0, 255}));
  connect(impedance2.p, bus2.p) annotation(
    Line(points = {{-56.4, 20}, {-46.8, 20}, {-46.8, 18}}, color = {0, 0, 255}));
  connect(bus3.p, SM.terminal) annotation(
    Line(points = {{49.88, 18.8}, {62.88, 18.8}, {62.88, 20}, {64, 20}}, color = {0, 0, 255}));
  connect(impedance2.n, bus1.p) annotation(
    Line(points = {{-76, 20}, {-86, 20}, {-86, 20}, {-86, 20}}, color = {0, 0, 255}));
  connect(voltageSource.p, bus1.p) annotation(
    Line(points = {{-98, 20}, {-86, 20}, {-86, 20}, {-86, 20}}, color = {0, 0, 255}));
  connect(impedance1.n, bus2.p) annotation(
    Line(points = {{-8, 0}, {-32, 0}, {-32, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(impedance1.p, bus3.p) annotation(
    Line(points = {{12, 0}, {32, 0}, {32, 18}, {50, 18}}, color = {0, 0, 255}));
  connect(impedance1.n, fault.T) annotation(
    Line(points = {{-8, 0}, {-10, 0}, {-10, -20}}, color = {0, 0, 255}));
  connect(reactor.p, bus2.p) annotation(
    Line(points = {{-46, -8}, {-46, 18}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")));
end Test_Radial_System;