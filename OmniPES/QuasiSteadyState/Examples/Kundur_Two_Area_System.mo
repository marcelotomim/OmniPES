within OmniPES.QuasiSteadyState.Examples;

model Kundur_Two_Area_System
  Real d13, d23, d43;
  inner OmniPES.SystemData data(Sbase = 100, fb = 60) annotation(
    Placement(visible = true, transformation(origin = {-1, 67}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen_data_1(D = 0, H = 6.5, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
    Placement(visible = true, transformation(origin = {-202, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus7 annotation(
    Placement(visible = true, transformation(origin = {-108, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus8 annotation(
    Placement(visible = true, transformation(origin = {-30, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G3(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_2, specs = gen3_specs) annotation(
    Placement(visible = true, transformation(origin = {218, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G4(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_2, specs = gen4_specs) annotation(
    Placement(visible = true, transformation(origin = {168, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G2(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_1, specs = gen2_specs) annotation(
    Placement(visible = true, transformation(origin = {-214, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine G1(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PV restriction, redeclare IEEE_AC4A avr, redeclare PSS_1 pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg, smData = gen_data_1, specs = gen1_specs) annotation(
    Placement(visible = true, transformation(origin = {-258, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen3_specs(Vesp = 1.030, theta_esp = 0) annotation(
    Placement(visible = true, transformation(origin = {222, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.030, theta_esp = 0) annotation(
    Placement(visible = true, transformation(origin = {-254, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen4_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.010, theta_esp = 0) annotation(
    Placement(visible = true, transformation(origin = {172, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen2_specs(Pesp = 700., Qesp = 0.0, Vesp = 1.010, theta_esp = 0) annotation(
    Placement(visible = true, transformation(origin = {-204, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {-72, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine1(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {-70, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine2(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {16, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus9 annotation(
    Placement(visible = true, transformation(origin = {64, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine4(Q = 0.175*10, r = 0.0001*10, x = 0.001*10) annotation(
    Placement(visible = true, transformation(origin = {88, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine5(Q = 0.175*25, r = 0.0001*25, x = 0.001*25) annotation(
    Placement(visible = true, transformation(origin = {132, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus10 annotation(
    Placement(visible = true, transformation(origin = {108, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus11 annotation(
    Placement(visible = true, transformation(origin = {154, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine6(Q = 0.175*10, r = 0.0001*10, x = 0.001*10) annotation(
    Placement(visible = true, transformation(origin = {-128, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine7(Q = 0.175*25, r = 0.0001*25, x = 0.001*25) annotation(
    Placement(visible = true, transformation(origin = {-168, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus5 annotation(
    Placement(visible = true, transformation(origin = {-196, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus6 annotation(
    Placement(visible = true, transformation(origin = {-150, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance trafo(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {-212, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {176, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {-162, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {130, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-230, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-186, -6}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus3 annotation(
    Placement(visible = true, transformation(origin = {198, 16}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus4 annotation(
    Placement(visible = true, transformation(origin = {150, -18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));

  OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor(NominalPower = 200) annotation(
    Placement(visible = true, transformation(origin = {-128, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.Shunt_Capacitor shunt_Capacitor1(NominalPower = 350) annotation(
    Placement(visible = true, transformation(origin = {84, -26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.QuasiSteadyState.Loads.ZIPLoad L1(Pesp = 967, Qesp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
    Placement(visible = true, transformation(origin = {-108, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData ssLoadData(pi = 0, qz = 0) annotation(
    Placement(visible = true, transformation(origin = {-130, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData dynLoadData(pi = 0, pz = 1, qz = 1) annotation(
    Placement(visible = true, transformation(origin = {-96, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Loads.ZIPLoad L2(Pesp = 1767, Qesp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
    Placement(visible = true, transformation(origin = {64, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));

  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen_data_2(D = 0, H = 6.175, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
    Placement(visible = true, transformation(origin = {170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Switches.Fault fault(R = 0, X = 1e-3, t_off = 0.3, t_on = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-30, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine_switched tLine21(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {16, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

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
  d13 = G1.inertia.delta - G3.inertia.delta;
  d23 = G2.inertia.delta - G3.inertia.delta;
  d43 = G4.inertia.delta - G3.inertia.delta;
  connect(G1.terminal, bus1.p) annotation(
    Line(points = {{-248, 18}, {-230, 18}}, color = {0, 0, 255}));
  connect(trafo.p, bus1.p) annotation(
    Line(points = {{-222, 18}, {-230, 18}}, color = {0, 0, 255}));
  connect(trafo.n, bus5.p) annotation(
    Line(points = {{-202, 18}, {-199, 18}, {-199, 16}, {-196, 16}}, color = {0, 0, 255}));
  connect(tLine7.p, bus5.p) annotation(
    Line(points = {{-178, 20}, {-187, 20}, {-187, 16}, {-196, 16}}, color = {0, 0, 255}));
  connect(tLine7.n, bus6.p) annotation(
    Line(points = {{-156, 20}, {-154, 20}, {-154, 16}, {-150, 16}}, color = {0, 0, 255}));
  connect(tLine6.p, bus6.p) annotation(
    Line(points = {{-138, 18}, {-144, 18}, {-144, 16}, {-150, 16}}, color = {0, 0, 255}));
  connect(tLine6.n, bus7.p) annotation(
    Line(points = {{-116, 18}, {-108, 18}, {-108, 16}}, color = {0, 0, 255}));
  connect(tLine.p, bus7.p) annotation(
    Line(points = {{-83, 27}, {-94, 27}, {-94, 16}, {-108, 16}}, color = {0, 0, 255}));
  connect(tLine1.p, bus7.p) annotation(
    Line(points = {{-81, 1}, {-94, 1}, {-94, 16}, {-108, 16}}, color = {0, 0, 255}));
  connect(tLine.n, bus8.p) annotation(
    Line(points = {{-61, 27}, {-46, 27}, {-46, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine1.n, bus8.p) annotation(
    Line(points = {{-59, 1}, {-46, 1}, {-46, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine2.p, bus8.p) annotation(
    Line(points = {{6, 28}, {-18, 28}, {-18, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine2.n, bus9.p) annotation(
    Line(points = {{28, 28}, {42, 28}, {42, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(tLine4.p, bus9.p) annotation(
    Line(points = {{78, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(tLine4.n, bus10.p) annotation(
    Line(points = {{100, 16}, {108, 16}, {108, 14}}, color = {0, 0, 255}));
  connect(tLine5.p, bus10.p) annotation(
    Line(points = {{122, 16}, {115, 16}, {115, 14}, {108, 14}}, color = {0, 0, 255}));
  connect(tLine5.n, bus11.p) annotation(
    Line(points = {{144, 16}, {148, 16}, {148, 14}, {154, 14}}, color = {0, 0, 255}));
  connect(impedance.p, bus11.p) annotation(
    Line(points = {{166, 14}, {154, 14}}, color = {0, 0, 255}));
  connect(impedance.n, bus3.p) annotation(
    Line(points = {{186, 14}, {198, 14}}, color = {0, 0, 255}));
  connect(G3.terminal, bus3.p) annotation(
    Line(points = {{208, 14}, {198, 14}}, color = {0, 0, 255}));
  connect(G4.terminal, bus4.p) annotation(
    Line(points = {{158, -18}, {154, -18}, {154, -20}, {150, -20}}, color = {0, 0, 255}));
  connect(impedance2.n, bus4.p) annotation(
    Line(points = {{140, -20}, {150, -20}}, color = {0, 0, 255}));
  connect(impedance2.p, bus10.p) annotation(
    Line(points = {{120, -20}, {108, -20}, {108, 14}}, color = {0, 0, 255}));
  connect(shunt_Capacitor1.p, bus9.p) annotation(
    Line(points = {{84, -16}, {70, -16}, {70, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(L2.p, bus9.p) annotation(
    Line(points = {{64, -20}, {64, 16}}, color = {0, 0, 255}));
  connect(fault.T, bus8.p) annotation(
    Line(points = {{-30, -18}, {-30, 16}}, color = {0, 0, 255}));
  connect(L1.p, bus7.p) annotation(
    Line(points = {{-108, -20}, {-108, 16}}, color = {0, 0, 255}));
  connect(shunt_Capacitor.p, bus7.p) annotation(
    Line(points = {{-128, -16}, {-114, -16}, {-114, 16}, {-108, 16}}, color = {0, 0, 255}));
  connect(impedance1.n, bus6.p) annotation(
    Line(points = {{-152, -8}, {-150, -8}, {-150, 16}}, color = {0, 0, 255}));
  connect(impedance1.p, bus2.p) annotation(
    Line(points = {{-172, -8}, {-186, -8}}, color = {0, 0, 255}));
  connect(G2.terminal, bus2.p) annotation(
    Line(points = {{-204, -8}, {-186, -8}}, color = {0, 0, 255}));
  connect(bus8.p, tLine21.p) annotation(
    Line(points = {{-30, 16}, {-18, 16}, {-18, -4}, {6, -4}}, color = {0, 0, 255}));
  connect(tLine21.n, bus9.p) annotation(
    Line(points = {{28, -4}, {42, -4}, {42, 16}, {64, 16}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.001),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
    Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})));
end Kundur_Two_Area_System;