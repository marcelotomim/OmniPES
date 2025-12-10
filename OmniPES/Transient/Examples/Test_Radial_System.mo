within OmniPES.Transient.Examples;

model Test_Radial_System
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {-70, 72}, extent = {{-18, -18}, {18, 18}})));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
    Placement(transformation(origin = {-90, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData gen1_specs(Psp = 1e8, Qsp = 0.0, Vsp = 1.0, theta_sp = 0) annotation(
    Placement(transformation(origin = {82, 68}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.15) annotation(
    Placement(visible = true, transformation(origin = {2, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(transformation(origin = {-72, 22}, extent = {{-6, -6}, {6, 6}})));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(transformation(origin = {-32, 22}, extent = {{-6, -6}, {6, 6}})));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(transformation(origin = {46, 22}, extent = {{-6, -6}, {6, 6}})));
  //
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.15) annotation(
    Placement(visible = true, transformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.1) annotation(
    Placement(transformation(origin = {-52, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric electrical(is_saturable = true, redeclare OmniPES.Transient.SynchronousMachines.SaturationFunctions.Exponential_2 sat_d), redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV restriction, redeclare OmniPES.Transient.Controllers.AVR.ConstantEfd avr, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg, avr_on = false, sreg_on = true) annotation(
    Placement(transformation(origin = {80, 22}, extent = {{-10, -10}, {10, 10}})));
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData gen1_data(D = 0, H = 6.5, Nmaq = 1, Ra = 0.0, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7, MVAb = 1e8, model_type = OmniPES.Transient.SynchronousMachines.Interfaces.Models.Turbo) annotation(
    Placement(visible = true, transformation(origin = {82, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Switches.Fault fault(t_off = 0.2, t_on = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(impedance.p, bus3.p) annotation(
    Line(points = {{12, 22}, {46, 22}}, color = {0, 0, 255}));
  connect(impedance.n, bus2.p) annotation(
    Line(points = {{-8, 22}, {-32, 22}}, color = {0, 0, 255}));
  connect(impedance2.p, bus2.p) annotation(
    Line(points = {{-42, 22}, {-32, 22}}, color = {0, 0, 255}));
  connect(bus3.p, SM.terminal) annotation(
    Line(points = {{46, 22}, {70, 22}}, color = {0, 0, 255}));
  connect(impedance2.n, bus1.p) annotation(
    Line(points = {{-62, 22}, {-72, 22}}, color = {0, 0, 255}));
  connect(voltageSource.p, bus1.p) annotation(
    Line(points = {{-80, 22}, {-72, 22}}, color = {0, 0, 255}));
  connect(impedance1.n, bus2.p) annotation(
    Line(points = {{-8, 0}, {-32, 0}, {-32, 22}}, color = {0, 0, 255}));
  connect(impedance1.p, bus3.p) annotation(
    Line(points = {{12, 0}, {32, 0}, {32, 22}, {46, 22}}, color = {0, 0, 255}));
  connect(impedance1.n, fault.T) annotation(
    Line(points = {{-8, 0}, {-10, 0}, {-10, -20}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Test_Radial_System;