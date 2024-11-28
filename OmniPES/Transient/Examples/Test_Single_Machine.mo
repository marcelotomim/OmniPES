within OmniPES.Transient.Examples;

model Test_Single_Machine
  inner SystemData data(Sbase = 100) annotation(
    Placement(visible = true, transformation(origin = {-76, 78}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.05) annotation(
    Placement(transformation(origin = {-32, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter Transient.Machines.RestrictionData gen1_specs(Psp = 0.9*100, Qsp = 0.5*100, theta_sp = 0) annotation(
    Placement(transformation(origin = {32, 28}, extent = {{-10, -10}, {10, 10}})));
  Circuit.Interfaces.Bus bus annotation(
    Placement(transformation(origin = {0, 2}, extent = {{-6, -6}, {6, 6}})));
  //
  Transient.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.Transient.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PQ restriction, avr_on = true, redeclare FieldStep avr) annotation(
    Placement(transformation(origin = {44, 0}, extent = {{-10, -10}, {10, 10}})));
  parameter Transient.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, Nmaq = 1, Ra = 0, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7, MVAb = 100) annotation(
    Placement(transformation(origin = {68, 28}, extent = {{-10, -10}, {10, 10}})));

  model FieldStep
    extends OmniPES.Transient.Controllers.Interfaces.PartialAVR;
    Real dEfd, Efd0;
  equation
    der(Efd0) = 0;
    Efd = Efd0 + dEfd;
    dEfd = if time > 0.1 and time < 10 then 0.1*Efd0 else 0.0;
  end FieldStep;
equation
  connect(SM.terminal, bus.p) annotation(
    Line(points = {{34, 0}, {0, 0}, {0, 1}}, color = {0, 0, 255}));
  connect(voltageSource.p, bus.p) annotation(
    Line(points = {{-32, 0}, {0, 0}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.001),
    uses(Modelica(version = "3.2.2")));
end Test_Single_Machine;