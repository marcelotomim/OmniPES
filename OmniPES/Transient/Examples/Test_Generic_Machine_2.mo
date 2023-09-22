within OmniPES.Transient.Examples;

model Test_Generic_Machine_2
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-74, 80}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData gen1_data(D = 10, H = 5, MVAb = 100, Nmaq = 1, Ra = 0.0, X1d = 0.2, X1q = 0.2, Xd = 1.0, Xl = 0.0, Xq = 0.8) annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData gen1_specs(Psp = 80., Qsp = 0, Vsp = 1.05) annotation(
    Placement(visible = true, transformation(origin = {24, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //
  OmniPES.Transient.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.Transient.Machines.Interfaces.Model_1_0_Electric electrical, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PV restriction, redeclare OmniPES.Transient.Controllers.AVR.ConstantEfd avr, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(visible = true, transformation(origin = {40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Machines.GenericSynchronousMachine SM2(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.Transient.Machines.Interfaces.Model_1_0_Electric electrical, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_VTH restriction, redeclare OmniPES.Transient.Controllers.AVR.ConstantEfd avr, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(visible = true, transformation(origin = {-72, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData gen2_specs(Psp = 0., Qsp = 0, Vsp = 1.0, theta_sp = 0) annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer twoWindingTransformer(tap = 1, x = 0.05) annotation(
    Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 50, r = 1e-5, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {0, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SM2.terminal, twoWindingTransformer.p) annotation(
    Line(points = {{-62, 20}, {-50, 20}}, color = {0, 0, 255}));
  connect(twoWindingTransformer.n, tLine.p) annotation(
    Line(points = {{-28, 20}, {-10, 20}}, color = {0, 0, 255}));
  connect(tLine.n, SM.terminal) annotation(
    Line(points = {{12, 20}, {30, 20}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    Diagram);
end Test_Generic_Machine_2;