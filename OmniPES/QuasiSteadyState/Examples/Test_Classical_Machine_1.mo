within OmniPES.QuasiSteadyState.Examples;

model Test_Classical_Machine_1
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-68, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 5, MVAb = 100, Nmaq = 1, Ra = 0.0, X1d = 0.2, X1q = 0.2, Xd = 1.0, Xl = 0.0, Xq = 0.8) annotation(
    Placement(visible = true, transformation(origin = {47, 53}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Psp = 100, Qsp = 50, Vsp = 1.0) annotation(
    Placement(visible = true, transformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  //
  OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, smData = gen1_data, specs = gen1_specs) annotation(
    Placement(visible = true, transformation(origin = {62, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage annotation(
    Placement(visible = true, transformation(origin = {-39, -31}, extent = {{-21, -21}, {21, 21}}, rotation = -90)));
  Modelica.Blocks.Sources.Step step(height = -0.99, offset = 1, startTime = 0.1) annotation(
    Placement(visible = true, transformation(origin = {78, -30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {24, -22}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step1(height = 0.99, startTime = 0.2) annotation(
    Placement(visible = true, transformation(origin = {78, -64}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step11(height = 0) annotation(
    Placement(visible = true, transformation(origin = {18, -68}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(controlledVoltage.p, SM.terminal) annotation(
    Line(points = {{-39, -10}, {-39, 0.42}, {44, 0.42}}, color = {0, 0, 255}));
  connect(add.y, controlledVoltage.Vr) annotation(
    Line(points = {{13, -22}, {4, -22}, {4, -14}, {-16, -14}}, color = {0, 0, 127}));
  connect(step11.y, controlledVoltage.Vi) annotation(
    Line(points = {{8, -68}, {-2, -68}, {-2, -22}, {-16, -22}}, color = {0, 0, 127}));
  connect(step.y, add.u1) annotation(
    Line(points = {{68, -30}, {52, -30}, {52, -16}, {36, -16}}, color = {0, 0, 127}));
  connect(step1.y, add.u2) annotation(
    Line(points = {{68, -64}, {46, -64}, {46, -28}, {36, -28}}, color = {0, 0, 127}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    Diagram);
end Test_Classical_Machine_1;