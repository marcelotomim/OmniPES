within OmniPES.Transient.Examples;

model Kundur_Two_Area_System_ShortCircuit
  Real d13;
  inner OmniPES.SystemData data(Sbase = 100, fb = 60) annotation(
    Placement(visible = true, transformation(origin = {1, 71}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData gen_data_1(D = 0, H = 6.5e10, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
    Placement(visible = true, transformation(origin = {-202, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus7 annotation(
    Placement(visible = true, transformation(origin = {-108, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus8 annotation(
    Placement(visible = true, transformation(origin = {-30, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  //
  OmniPES.Transient.Machines.ClassicalSynchronousMachine G3(redeclare OmniPES.Transient.Machines.Interfaces.Restriction_VTH restriction, smData = gen_data_2, specs = gen3_specs) annotation(
    Placement(visible = true, transformation(origin = {218, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Machines.ClassicalSynchronousMachine G4(redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PV restriction, smData = gen_data_2, specs = gen4_specs) annotation(
    Placement(visible = true, transformation(origin = {168, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Machines.ClassicalSynchronousMachine G2(redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PV restriction, smData = gen_data_1, specs = gen2_specs) annotation(
    Placement(visible = true, transformation(origin = {-200, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Transient.Machines.ClassicalSynchronousMachine G1(redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PV restriction, smData = gen_data_1, specs = gen1_specs) annotation(
    Placement(visible = true, transformation(origin = {-250, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  parameter OmniPES.Transient.Machines.RestrictionData gen3_specs(Psp = 0., Qsp = 0.0, Vsp = 1.030, theta_sp = 0) annotation(
    Placement(visible = true, transformation(origin = {222, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData gen1_specs(Psp = 700., Qsp = 0.0, Vsp = 1.030, theta_sp = 0) annotation(
    Placement(visible = true, transformation(origin = {-254, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData gen4_specs(Psp = 700., Qsp = 0.0, Vsp = 1.010, theta_sp = 0) annotation(
    Placement(visible = true, transformation(origin = {172, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData gen2_specs(Psp = 700., Qsp = 0.0, Vsp = 1.010, theta_sp = 0) annotation(
    Placement(visible = true, transformation(origin = {-204, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {-66, 24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine1(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {-66, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
    Placement(visible = true, transformation(origin = {-214, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {176, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.15*100/900) annotation(
    Placement(visible = true, transformation(origin = {-168, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
    Placement(visible = true, transformation(origin = {84, -24}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Transient.Loads.ZIPLoad L1(Psp = 967, Qsp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
    Placement(visible = true, transformation(origin = {-108, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter OmniPES.Transient.Loads.Interfaces.LoadData ssLoadData(pi = 0, qz = 0) annotation(
    Placement(visible = true, transformation(origin = {-130, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Loads.Interfaces.LoadData dynLoadData(pi = 0, pz = 1, qz = 1) annotation(
    Placement(visible = true, transformation(origin = {-96, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Loads.ZIPLoad L2(Psp = 1767, Qsp = 100, dyn_par = dynLoadData, ss_par = ssLoadData) annotation(
    Placement(visible = true, transformation(origin = {64, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData gen_data_2(D = 0, H = 6.175e10, MVAb = 900, Nmaq = 1, Ra = 0.0025, T1d0 = 8, T1q0 = 0.4, T2d0 = 0.03, T2q0 = 0.05, X1d = 0.3, X1q = 0.55, X2d = 0.25, X2q = 0.25, Xd = 1.8, Xl = 0.2, Xq = 1.7) annotation(
    Placement(visible = true, transformation(origin = {170, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine3(Q = 0.175*110, r = 0.0001*110, x = 0.001*110) annotation(
    Placement(visible = true, transformation(origin = {16, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.CurrentSource currentSource(magnitude = 1) annotation(
    Placement(visible = true, transformation(origin = {-64, -48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  d13 = G1.inertia.delta - G3.inertia.delta;
  connect(tLine.p, bus7.p) annotation(
    Line(points = {{-77, 27}, {-88, 27}, {-88, 20}, {-108, 20}, {-108, 16}}, color = {0, 0, 255}));
  connect(tLine2.n, bus9.p) annotation(
    Line(points = {{27, 27}, {56, 27}, {56, 18}, {64, 18}, {64, 16}}, color = {0, 0, 255}));
  connect(tLine4.n, bus10.p) annotation(
    Line(points = {{99, 15}, {108, 15}, {108, 14}}, color = {0, 0, 255}));
  connect(tLine5.p, bus10.p) annotation(
    Line(points = {{121, 15}, {108, 15}, {108, 14}}, color = {0, 0, 255}));
  connect(bus9.p, tLine4.p) annotation(
    Line(points = {{64, 16}, {76, 16}, {76, 15}, {77, 15}}, color = {0, 0, 255}));
  connect(tLine5.n, bus11.p) annotation(
    Line(points = {{143, 15}, {154, 15}, {154, 14}}, color = {0, 0, 255}));
  connect(tLine6.n, bus7.p) annotation(
    Line(points = {{-117, 17}, {-108, 17}, {-108, 16}}, color = {0, 0, 255}));
  connect(tLine6.p, bus6.p) annotation(
    Line(points = {{-139, 17}, {-150, 17}, {-150, 16}}, color = {0, 0, 255}));
  connect(tLine7.n, bus6.p) annotation(
    Line(points = {{-157, 19}, {-150, 19}, {-150, 16}}, color = {0, 0, 255}));
  connect(tLine7.p, bus5.p) annotation(
    Line(points = {{-179, 19}, {-196, 19}, {-196, 16}}, color = {0, 0, 255}));
  connect(trafo.n, bus5.p) annotation(
    Line(points = {{-204, 18}, {-196, 18}, {-196, 16}}, color = {0, 0, 255}));
  connect(bus11.p, impedance.p) annotation(
    Line(points = {{154, 14}, {166, 14}}, color = {0, 0, 255}));
  connect(impedance1.n, bus6.p) annotation(
    Line(points = {{-158, -8}, {-158, 0}, {-150, 0}, {-150, 16}}, color = {0, 0, 255}));
  connect(impedance2.p, bus10.p) annotation(
    Line(points = {{120, -20}, {108, -20}, {108, 14}}, color = {0, 0, 255}));
  connect(G1.terminal, bus1.p) annotation(
    Line(points = {{-240, 18}, {-230, 18}, {-230, 18}, {-230, 18}}, color = {0, 0, 255}));
  connect(trafo.p, bus1.p) annotation(
    Line(points = {{-224, 18}, {-230, 18}}, color = {0, 0, 255}));
  connect(G2.terminal, bus2.p) annotation(
    Line(points = {{-190, -8}, {-186, -8}, {-186, -8}, {-186, -8}}, color = {0, 0, 255}));
  connect(impedance1.p, bus2.p) annotation(
    Line(points = {{-178, -8}, {-186, -8}}, color = {0, 0, 255}));
  connect(impedance2.n, bus4.p) annotation(
    Line(points = {{140, -20}, {150, -20}}, color = {0, 0, 255}));
  connect(G4.terminal, bus4.p) annotation(
    Line(points = {{158, -18}, {150, -18}, {150, -20}, {150, -20}}, color = {0, 0, 255}));
  connect(impedance.n, bus3.p) annotation(
    Line(points = {{186, 14}, {198, 14}}, color = {0, 0, 255}));
  connect(G3.terminal, bus3.p) annotation(
    Line(points = {{208, 14}, {198, 14}, {198, 14}, {198, 14}}, color = {0, 0, 255}));
  connect(tLine1.p, bus7.p) annotation(
    Line(points = {{-77, 1}, {-92, 1}, {-92, 12}, {-108, 12}, {-108, 16}}, color = {0, 0, 255}));
  connect(shunt_Capacitor.p, bus7.p) annotation(
    Line(points = {{-128, -16}, {-128, 0}, {-108, 0}, {-108, 16}}, color = {0, 0, 255}));
  connect(shunt_Capacitor1.p, bus9.p) annotation(
    Line(points = {{84, -14}, {72, -14}, {72, 12}, {64, 12}, {64, 16}}, color = {0, 0, 255}));
  connect(L2.p, bus9.p) annotation(
    Line(points = {{64, -20}, {64, -20}, {64, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(tLine.n, bus8.p) annotation(
    Line(points = {{-54, 28}, {-40, 28}, {-40, 20}, {-30, 20}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine1.n, bus8.p) annotation(
    Line(points = {{-54, 2}, {-40, 2}, {-40, 12}, {-30, 12}, {-30, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine2.p, bus8.p) annotation(
    Line(points = {{6, 28}, {-18, 28}, {-18, 20}, {-30, 20}, {-30, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(L1.p, bus7.p) annotation(
    Line(points = {{-108, -20}, {-108, -20}, {-108, 16}, {-108, 16}}, color = {0, 0, 255}));
  connect(tLine3.p, bus8.p) annotation(
    Line(points = {{6, 0}, {-14, 0}, {-14, 16}, {-30, 16}}, color = {0, 0, 255}));
  connect(tLine3.n, bus9.p) annotation(
    Line(points = {{28, 0}, {48, 0}, {48, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(currentSource.p, bus7.p) annotation(
    Line(points = {{-64, -38}, {-90, -38}, {-90, 16}, {-108, 16}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-300, -100}, {300, 100}})),
    Icon(coordinateSystem(extent = {{-300, -100}, {300, 100}})));
end Kundur_Two_Area_System_ShortCircuit;