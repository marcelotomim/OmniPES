within OmniPES.Transient.Examples;

model Test_Generic_Machine_2
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {-78, 80}, extent = {{-16, -16}, {16, 16}})));
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData gen_data(D = 10, H = 5, MVAb = 1e8, Nmaq = 1, Ra = 0.0, X1d = 0.2, X1q = 0.2, Xd = 1.0, Xl = 0.0, Xq = 0.8) annotation(
    Placement(transformation(origin = {68, 34}, extent = {{-10, -10}, {10, 10}})));
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData gen1_specs(Psp = 8e7, Qsp = 0, Vsp = 1.05) annotation(
    Placement(transformation(origin = {36, 34}, extent = {{-10, -10}, {10, 10}})));
  //
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine SM(smData = gen_data, specs = gen1_specs, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_1_0_Electric electrical, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV restriction, redeclare OmniPES.Transient.Controllers.AVR.ConstantEfd avr, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(transformation(origin = {52, 4}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine SM2(smData = gen_data, specs = gen1_specs, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_1_0_Electric electrical, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_VTH restriction, redeclare OmniPES.Transient.Controllers.AVR.ConstantEfd avr, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(transformation(origin = {-60, 4}, extent = {{10, -10}, {-10, 10}})));
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData gen2_specs(Psp = 0., Qsp = 0, Vsp = 1.0, theta_sp = 0) annotation(
    Placement(transformation(origin = {-64, 34}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TwoWindingTransformer twoWindingTransformer(tap = 1, x = 0.05) annotation(
    Placement(transformation(origin = {-28, 4}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Basic.TLine tLine(Q = 0, r = 0, x = 0.1) annotation(
    Placement(transformation(origin = {12, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(SM2.terminal, twoWindingTransformer.p) annotation(
    Line(points = {{-50, 4}, {-38, 4}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.n, tLine.p) annotation(
    Line(points = {{-17, 4}, {1, 4}}, color = {0, 0, 255}));
  connect(tLine.n, SM.terminal) annotation(
    Line(points = {{23, 3}, {41, 3}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-06, Interval = 0.0001),
    Diagram);
end Test_Generic_Machine_2;