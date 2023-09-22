within OmniPES.Transient.Examples;
model Test_Radial_System_CTRL
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData gen1_data(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.025, X2q = 0.025, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
    Placement(visible = true, transformation(origin = {70, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource(angle = 0, magnitude = 1.0) annotation(
    Placement(visible = true, transformation(origin = {-110, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter OmniPES.Transient.Machines.RestrictionData gen1_specs(Psp = 500., Qsp = 0.0, Vsp = 1.030, theta_sp = 0) annotation(
    Placement(visible = true, transformation(origin = {32, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.04) annotation(
    Placement(visible = true, transformation(origin = {6, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {50, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-64, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Transient.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.Transient.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(visible = true, transformation(origin = {76, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance1(x = 0.04) annotation(
    Placement(visible = true, transformation(origin = {6, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Switches.Fault fault(X = 1e-4, t_off = 0.2, t_on = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-22, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-90, 16}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));

model IEEE_AC4A
  extends OmniPES.Transient.Controllers.Interfaces.PartialAVR;
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
  connect(impedance.p, bus3.p) annotation(
    Line(points = {{16, 18}, {49.2, 18}}, color = {0, 0, 255}));
  connect(impedance.n, bus2.p) annotation(
    Line(points = {{-4, 18}, {-46, 18}, {-46, 18.4}}, color = {0, 0, 255}));
  connect(impedance2.p, bus2.p) annotation(
    Line(points = {{-54, 18}, {-46.8, 18}}, color = {0, 0, 255}));
  connect(bus3.p, SM.terminal) annotation(
    Line(points = {{49.88, 18.8}, {62.88, 18.8}, {62.88, 20}, {66, 20}}, color = {0, 0, 255}));
  connect(seriesImpedance1.n, bus2.p) annotation(
    Line(points = {{-4, -2}, {-32, -2}, {-32, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(seriesImpedance1.p, bus3.p) annotation(
    Line(points = {{16, -2}, {32, -2}, {32, 18}, {50, 18}}, color = {0, 0, 255}));
  connect(seriesImpedance1.n, fault.T) annotation(
    Line(points = {{-4, -2}, {-22, -2}, {-22, -30}}, color = {0, 0, 255}));
  connect(voltageSource.p, bus1.p) annotation(
    Line(points = {{-110, 6}, {-112, 6}, {-112, 14}, {-90, 14}}, color = {0, 0, 255}));
  connect(bus1.p, impedance2.n) annotation(
    Line(points = {{-90, 14}, {-74, 14}, {-74, 18}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")),
    Diagram);
end Test_Radial_System_CTRL;