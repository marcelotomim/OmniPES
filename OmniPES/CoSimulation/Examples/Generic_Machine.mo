within OmniPES.CoSimulation.Examples;

model Generic_Machine
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-54, 46}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
    Placement(visible = true, transformation(origin = {78, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
    Placement(visible = true, transformation(origin = {40, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(visible = true, transformation(origin = {73, 15}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));

  Modelica.Blocks.Interfaces.RealInput Vi(start = 0) annotation(
    Placement(visible = true, transformation(origin = {32, -26}, extent = {{12, -12}, {-12, 12}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage1 annotation(
    Placement(visible = true, transformation(origin = {-36, -22}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput Vr(start = 1) annotation(
    Placement(visible = true, transformation(origin = {32, -6}, extent = {{12, -12}, {-12, 12}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealOutput Ii annotation(
    Placement(visible = true, transformation(origin = {-92, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-102, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealOutput Ir annotation(
    Placement(visible = true, transformation(origin = {-92, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-112, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

model IEEE_AC4A
  extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
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
  connect(controlledVoltage1.Vi, Vi) annotation(
    Line(points = {{-14, -14}, {-2, -14}, {-2, -26}, {32, -26}}, color = {0, 0, 127}));
  connect(controlledVoltage1.Vr, Vr) annotation(
    Line(points = {{-14, -6}, {32, -6}}, color = {0, 0, 127}));
  connect(SM.terminal, controlledVoltage1.p) annotation(
    Line(points = {{58, 15}, {-36, 15}, {-36, -2}}, color = {0, 0, 255}));
connect(controlledVoltage1.Ir, Ir) annotation(
    Line(points = {{-58, -6}, {-72, -6}, {-72, -20}, {-92, -20}}, color = {0, 0, 127}));
connect(controlledVoltage1.Ii, Ii) annotation(
    Line(points = {{-58, -14}, {-64, -14}, {-64, -40}, {-92, -40}}, color = {0, 0, 127}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")));
end Generic_Machine;