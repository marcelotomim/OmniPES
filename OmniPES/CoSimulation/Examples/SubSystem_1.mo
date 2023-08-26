within OmniPES.CoSimulation.Examples;

model SubSystem_1
  import Modelica.ComplexMath.conj;
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.025, X2q = 0.025, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
    Placement(visible = true, transformation(origin = {88, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
    Placement(visible = true, transformation(origin = {-88, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Psp = 700., Qsp = 0.0, Vsp = 1.030, theta_sp = 0) annotation(
    Placement(visible = true, transformation(origin = {50, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.025) annotation(
    Placement(visible = true, transformation(origin = {-20, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {50, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.025) annotation(
    Placement(visible = true, transformation(origin = {-66, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(visible = true, transformation(origin = {72, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  OmniPES.QuasiSteadyState.Loads.ZIPLoad zIPLoad(Psp = 100., Qsp = 50.) annotation(
    Placement(visible = true, transformation(origin = {63, -27}, extent = {{-15, -15}, {15, 15}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance(x = 0.025) annotation(
    Placement(visible = true, transformation(origin = {26, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {4, -2}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.CoSimulation.Adaptors.ControlledCurrent controlledCurrent annotation(
    Placement(visible = true, transformation(origin = {4, -64}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput Ir annotation(
    Placement(visible = true, transformation(origin = {58, -74}, extent = {{-8, -8}, {8, 8}}, rotation = 180), iconTransformation(origin = {117, 81}, extent = {{-17, -17}, {17, 17}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealInput Ii annotation(
    Placement(visible = true, transformation(origin = {58, -86}, extent = {{-8, -8}, {8, 8}}, rotation = 180), iconTransformation(origin = {117, 41}, extent = {{-17, -17}, {17, 17}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealOutput Vr annotation(
    Placement(visible = true, transformation(origin = {-48, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Vi annotation(
    Placement(visible = true, transformation(origin = {-48, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine_switched tLine_switched(Q = 0, r = 0, x = 0.05) annotation(
    Placement(visible = true, transformation(origin = {4, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

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
  //initial equation
  //  controlledCurrent.v.re = 0.989789;
  //  controlledCurrent.v.im = 0.180676;
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
  connect(voltageSource.p, impedance2.n) annotation(
    Line(points = {{-88, 19.4}, {-89, 19.4}, {-89, 20.4}, {-76, 20.4}}, color = {0, 0, 255}));
  connect(impedance2.p, bus1.p) annotation(
    Line(points = {{-56.4, 20}, {-46.8, 20}, {-46.8, 18}}, color = {0, 0, 255}));
  connect(bus2.p, SM.terminal) annotation(
    Line(points = {{49.88, 18.8}, {62.88, 18.8}, {62.88, 18}, {62, 18}}, color = {0, 0, 255}));
  connect(zIPLoad.p, bus2.p) annotation(
    Line(points = {{63, -12}, {63, 18}, {50, 18}}, color = {0, 0, 255}));
  connect(impedance.n, bus1.p) annotation(
    Line(points = {{-30, -4}, {-37, -4}, {-37, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(impedance.p, bus3.p) annotation(
    Line(points = {{-10, -4}, {4, -4}}, color = {0, 0, 255}));
  connect(seriesImpedance.n, bus3.p) annotation(
    Line(points = {{16, -4}, {4, -4}}, color = {0, 0, 255}));
  connect(bus2.p, seriesImpedance.p) annotation(
    Line(points = {{50, 18}, {50, -4}, {36, -4}}, color = {0, 0, 255}));
  connect(controlledCurrent.p, bus3.p) annotation(
    Line(points = {{4, -54}, {4, -4}}, color = {0, 0, 255}));
  connect(controlledCurrent.Vr, Vr) annotation(
    Line(points = {{-7, -56}, {-25, -56}, {-25, -52}, {-49, -52}}, color = {0, 0, 127}));
  connect(controlledCurrent.Vi, Vi) annotation(
    Line(points = {{-7, -60}, {-33, -60}, {-33, -76}, {-49, -76}}, color = {0, 0, 127}));
  connect(Ir, controlledCurrent.Ir) annotation(
    Line(points = {{58, -74}, {38, -74}, {38, -56}, {16, -56}}, color = {0, 0, 127}));
  connect(Ii, controlledCurrent.Ii) annotation(
    Line(points = {{58, -86}, {26, -86}, {26, -60}, {16, -60}}, color = {0, 0, 127}));
  connect(tLine_switched.p, bus1.p) annotation(
    Line(points = {{-7, 41}, {-36, 41}, {-36, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(tLine_switched.n, bus2.p) annotation(
    Line(points = {{15, 41}, {32, 41}, {32, 18}, {50, 18}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 1e-3, Tolerance = 1e-06, Interval = 0.001),
    uses(Modelica(version = "3.2.2")));
end SubSystem_1;