within OmniPES.CoSimulation.Examples;

model Test_Classical_Machine
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-74, 64}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
    Placement(visible = true, transformation(origin = {50, 52}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
    Placement(visible = true, transformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  //
  OmniPES.QuasiSteadyState.Machines.Classical_SynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, smData = gen1_data, specs = gen1_specs) annotation(
    Placement(visible = true, transformation(origin = {62, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vr(start = 1) annotation(
    Placement(visible = true, transformation(origin = {39, -29}, extent = {{13, -13}, {-13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vi(start = 0) annotation(
    Placement(visible = true, transformation(origin = {39, -75}, extent = {{15, -15}, {-15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage1 annotation(
    Placement(visible = true, transformation(origin = {-32, -30}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
Modelica.Blocks.Interfaces.RealOutput Ir annotation(
    Placement(visible = true, transformation(origin = {-92, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-112, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealOutput Ii annotation(
    Placement(visible = true, transformation(origin = {-92, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-102, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(SM.terminal, controlledVoltage1.p) annotation(
    Line(points = {{44, 0}, {-32, 0}, {-32, -10}}, color = {0, 0, 255}));
  connect(controlledVoltage1.Vr, Vr) annotation(
    Line(points = {{-10, -14}, {18, -14}, {18, -28}, {40, -28}}, color = {0, 0, 127}));
  connect(controlledVoltage1.Vi, Vi) annotation(
    Line(points = {{-10, -22}, {2, -22}, {2, -74}, {40, -74}}, color = {0, 0, 127}));
connect(controlledVoltage1.Ir, Ir) annotation(
    Line(points = {{-54, -14}, {-68, -14}, {-68, -20}, {-92, -20}}, color = {0, 0, 127}));
connect(controlledVoltage1.Ii, Ii) annotation(
    Line(points = {{-54, -22}, {-60, -22}, {-60, -40}, {-92, -40}}, color = {0, 0, 127}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    Diagram);
end Test_Classical_Machine;