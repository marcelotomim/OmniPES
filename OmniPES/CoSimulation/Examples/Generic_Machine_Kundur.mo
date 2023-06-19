within OmniPES.CoSimulation.Examples;

model Generic_Machine_Kundur
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
    Placement(visible = true, transformation(origin = {78, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
    Placement(visible = true, transformation(origin = {40, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(visible = true, transformation(origin = {73, 15}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));

  Modelica.Blocks.Interfaces.RealInput Vi(start = 0) annotation(
    Placement(visible = true, transformation(origin = {35, -67}, extent = {{15, -15}, {-15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage1 annotation(
    Placement(visible = true, transformation(origin = {-36, -22}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput Vr(start = 1) annotation(
    Placement(visible = true, transformation(origin = {35, -21}, extent = {{13, -13}, {-13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

model IEEE_AC4A
  extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
  Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1, k3 = +1) annotation(
    Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(strict = false, u(start = 1), uMax = 4, uMin = -4) annotation(
    Placement(visible = true, transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
    Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 200) annotation(
    Placement(visible = true, transformation(origin = {16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0.0) annotation(
    Placement(visible = true, transformation(origin = {-134, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(add3.u3, Vsad) annotation(
    Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
  connect(Vref.y, add3.u2) annotation(
    Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
  connect(limiter.y, Efd) annotation(
    Line(points = {{87, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(firstOrder.u, Vctrl) annotation(
    Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
  connect(firstOrder.y, add3.u1) annotation(
    Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
  connect(gain.y, limiter.u) annotation(
    Line(points = {{27, 0}, {64, 0}}, color = {0, 0, 127}));
  connect(add3.y, gain.u) annotation(
    Line(points = {{-32, 0}, {4, 0}}, color = {0, 0, 127}));
  connect(const.y, Vref.u) annotation(
    Line(points = {{-122, 0}, {-102, 0}}, color = {0, 0, 127}));
end IEEE_AC4A;

model PSS_1
  extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialPSS;
  parameter Real Tw = 10.0;
  parameter Real T1 = 0.05;
  parameter Real T2 = 0.02;
  parameter Real T3 = 3.0;
  parameter Real T4 = 5.4;
  parameter Real Kstab = 20.0;
  Modelica.Blocks.Continuous.TransferFunction Washout(a = {Tw, 1}, b = {Tw, 0}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
    Placement(visible = true, transformation(origin = {-38, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction LeadLag1(a = {T2, 1}, b = {T1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction LeadLag2(a = {T4, 1}, b = {T3, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = Kstab) annotation(
    Placement(visible = true, transformation(origin = {-74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 0.2, uMin = -0.2) annotation(
    Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(omega, gain.u) annotation(
    Line(points = {{-120, 0}, {-86, 0}}, color = {0, 0, 127}));
  connect(gain.y, Washout.u) annotation(
    Line(points = {{-63, 0}, {-50, 0}}, color = {0, 0, 127}));
  connect(Washout.y, LeadLag1.u) annotation(
    Line(points = {{-27, 0}, {-12, 0}}, color = {0, 0, 127}));
  connect(LeadLag1.y, LeadLag2.u) annotation(
    Line(points = {{11, 0}, {28, 0}}, color = {0, 0, 127}));
  connect(LeadLag2.y, limiter.u) annotation(
    Line(points = {{52, 0}, {68, 0}}, color = {0, 0, 127}));
  connect(limiter.y, Vsad) annotation(
    Line(points = {{91, 0}, {110, 0}}, color = {0, 0, 127}));
end PSS_1;


equation
  connect(controlledVoltage1.Vi, Vi) annotation(
    Line(points = {{-14, -14}, {-2, -14}, {-2, -66}, {36, -66}}, color = {0, 0, 127}));
  connect(controlledVoltage1.Vr, Vr) annotation(
    Line(points = {{-14, -6}, {14, -6}, {14, -20}, {36, -20}}, color = {0, 0, 127}));
  connect(SM.terminal, controlledVoltage1.p) annotation(
    Line(points = {{58, 15}, {-36, 15}, {-36, -2}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")));
end Generic_Machine_Kundur;