within OmniPES.QuasiSteadyState.Examples.PSCC24;

model tutorial_system
  Modelica.Units.SI.Angle d12;
  OmniPES.Circuit.Interfaces.Bus bus_1 annotation(
    Placement(visible = true, transformation(origin = {-90, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_10 annotation(
    Placement(visible = true, transformation(origin = {0, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_20 annotation(
    Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_30 annotation(
    Placement(visible = true, transformation(origin = {122, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo_1(x = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo_2(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance line_1(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {20, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line_21(x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {58, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {76.5, 40.5}, extent = {{-21.5, -21.5}, {21.5, 21.5}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {160, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G2(redeclare AVR avr,redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_1_Electric electrical, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, smData = G2_data, specs = G2_pf_data, redeclare SpeedGovernor sreg)  annotation(
    Placement(visible = true, transformation(origin = {-124, 50}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G1(redeclare AVR avr,redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_1_Electric electrical, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction,smData = G1_data, specs = G1_pf_data, redeclare SpeedGovernor sreg)  annotation(
    Placement(visible = true, transformation(origin = {-126, -40}, extent = {{-14.5, -14.5}, {14.5, 14.5}}, rotation = 180)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData G2_data(H = 3.0, MVAb = 150, T1d0 = 9.0, T1q0 = 0, T2d0 = 0.025, T2q0 = 0.08, X1d = 0.4, X1q = 0, X2d = 0.25, X2q = 0.25, Xd = 1.4, Xl = 0.15, Xq = 0.75)  annotation(
    Placement(visible = true, transformation(origin = {-162, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData G1_data(H = 3.0, MVAb = 50, T1d0 = 9.0, T1q0 = 0, T2d0 = 0.025, T2q0 = 0.08, X1d = 0.4, X1q = 0, X2d = 0.25, X2q = 0.25, Xd = 1.4, Xl = 0.15, Xq = 0.75) annotation(
    Placement(visible = true, transformation(origin = {-162, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Loads.ZIPLoad load(Pesp = 120, Qesp = 0, dyn_par = loadData, ss_par = loadData)  annotation(
    Placement(visible = true, transformation(origin = {160, -40}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData G2_pf_data(Pesp = 90., Vesp = 1.025)  annotation(
    Placement(visible = true, transformation(origin = {-162, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData G1_pf_data(Vesp = 1.017) annotation(
    Placement(visible = true, transformation(origin = {-162, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  model AVR
    extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
    parameter Real ka = 100;
    parameter Modelica.Units.SI.Time T = 0.05;
    parameter OmniPES.Units.PerUnit Efd_max = 7.0;
    parameter OmniPES.Units.PerUnit Efd_min = -7.0;
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(initType = Modelica.Blocks.Types.Init.SteadyState, k = ka/T, outMax = Efd_max, outMin = Efd_min)  annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/ka)  annotation(
      Placement(visible = true, transformation(origin = {10, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant zero(k = 0.0) annotation(
      Placement(visible = true, transformation(origin = {-178, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {-142, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(k = {-1, 1, 1, -1}, nin = 4)  annotation(
      Placement(visible = true, transformation(origin = {-46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(limIntegrator.y, Efd) annotation(
      Line(points = {{12, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(gain.u, limIntegrator.y) annotation(
      Line(points = {{22, -52}, {54, -52}, {54, 0}, {12, 0}}, color = {0, 0, 127}));
    connect(zero.y, Vref.u) annotation(
      Line(points = {{-167, 0}, {-154, 0}}, color = {0, 0, 127}));
  connect(sum1.y, limIntegrator.u) annotation(
      Line(points = {{-34, 0}, {-12, 0}}, color = {0, 0, 127}));
  connect(Vctrl, sum1.u[1]) annotation(
      Line(points = {{-112, 60}, {-82, 60}, {-82, 0}, {-58, 0}}, color = {0, 0, 127}));
  connect(Vref.y, sum1.u[2]) annotation(
      Line(points = {{-130, 0}, {-58, 0}}, color = {0, 0, 127}));
  connect(Vsad, sum1.u[3]) annotation(
      Line(points = {{-112, -60}, {-82, -60}, {-82, 0}, {-58, 0}}, color = {0, 0, 127}));
  connect(gain.y, sum1.u[4]) annotation(
      Line(points = {{0, -52}, {-68, -52}, {-68, 0}, {-58, 0}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 80}})));
  end AVR;

  OmniPES.Circuit.Basic.SeriesImpedance_switched line_22(t_open = 25, x = 0.18)  annotation(
    Placement(visible = true, transformation(origin = {58, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  model SpeedGovernor
    extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialSpeedRegulator;
    parameter Real R = 0.04;
    parameter Modelica.Units.SI.Time Tg = 0.5;
  Modelica.Blocks.Sources.Constant zero(k = 0.0) annotation(
      Placement(visible = true, transformation(origin = {-20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = -1)  annotation(
      Placement(visible = true, transformation(origin = {-54, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/R)  annotation(
      Placement(visible = true, transformation(origin = {-12, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
      Placement(visible = true, transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = Tg, initType = Modelica.Blocks.Types.Init.SteadyState)  annotation(
      Placement(visible = true, transformation(origin = {74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator wref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {-108, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant constant1(k = 0.0) annotation(
      Placement(visible = true, transformation(origin = {-144, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(wctrl, add.u1) annotation(
      Line(points = {{-120, 60}, {-84, 60}, {-84, 6}, {-66, 6}}, color = {0, 0, 127}));
    connect(add1.u2, gain.y) annotation(
      Line(points = {{24, -6}, {13, -6}, {13, 0}, {0, 0}}, color = {0, 0, 127}));
    connect(gain.u, add.y) annotation(
      Line(points = {{-24, 0}, {-42, 0}}, color = {0, 0, 127}));
    connect(add1.y, firstOrder.u) annotation(
      Line(points = {{48, 0}, {62, 0}}, color = {0, 0, 127}));
    connect(firstOrder.y, Pm) annotation(
      Line(points = {{86, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(constant1.y, wref.u) annotation(
      Line(points = {{-133, -6}, {-120, -6}}, color = {0, 0, 127}));
    connect(wref.y, add.u2) annotation(
      Line(points = {{-96, -6}, {-66, -6}}, color = {0, 0, 127}));
  connect(zero.y, add1.u1) annotation(
      Line(points = {{-9, 40}, {6, 40}, {6, 6}, {24, 6}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 80}})));
  end SpeedGovernor;

  OmniPES.Circuit.Interfaces.Bus bus_2 annotation(
    Placement(visible = true, transformation(origin = {-90, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  d12 = G1.inertia.delta - G2.inertia.delta;
  connect(G2.terminal, bus_2.p) annotation(
    Line(points = {{-110, 50}, {-90, 50}}, color = {0, 0, 255}));
  connect(trafo_2.p, bus_2.p) annotation(
    Line(points = {{-68, 50}, {-90, 50}}, color = {0, 0, 255}));
  connect(trafo_2.n, bus_20.p) annotation(
    Line(points = {{-32, 50}, {0, 50}, {0, 48}}, color = {0, 0, 255}));
  connect(G1.terminal, bus_1.p) annotation(
    Line(points = {{-111, -40}, {-90, -40}}, color = {0, 0, 255}));
  connect(trafo_1.p, bus_1.p) annotation(
    Line(points = {{-68, -40}, {-90, -40}}, color = {0, 0, 255}));
  connect(trafo_1.n, bus_10.p) annotation(
    Line(points = {{-32, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line_1.p, bus_20.p) annotation(
    Line(points = {{20, 20}, {20, 48}, {0, 48}}, color = {0, 0, 255}));
  connect(line_1.n, bus_10.p) annotation(
    Line(points = {{20, 0}, {20, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line_21.p, bus_10.p) annotation(
    Line(points = {{48, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line_22.p, bus_10.p) annotation(
    Line(points = {{48, -60}, {0, -60}, {0, -40}}, color = {0, 0, 255}));
  connect(line_22.n, bus_30.p) annotation(
    Line(points = {{68, -60}, {122, -60}, {122, -40}}, color = {0, 0, 255}));
  connect(line_21.n, bus_30.p) annotation(
    Line(points = {{68, -40}, {122, -40}}, color = {0, 0, 255}));
  connect(load.p, bus_30.p) annotation(
    Line(points = {{142, -40}, {122, -40}}, color = {0, 0, 255}));
  annotation(
    Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.001));
end tutorial_system;