within OmniPES.Transient.Examples.PSCC24;

model tutorial_system
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {67.5, 45.5}, extent = {{-21.5, -21.5}, {21.5, 21.5}}, rotation = 0)));
  Modelica.Units.SI.Angle d12;
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-90, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-90, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus10 annotation(
    Placement(visible = true, transformation(origin = {0, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus20 annotation(
    Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus30 annotation(
    Placement(visible = true, transformation(origin = {122, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo1(x = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo2(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {-50, 50}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance line1(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {20, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line21(x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {58, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line22(t_open = 25, x = 0.18)  annotation(
    Placement(visible = true, transformation(origin = {58, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Machines.GenericSynchronousMachine G2(redeclare OmniPES.Transient.Examples.PSCC24.Controllers.AVR avr,redeclare OmniPES.Transient.Machines.Interfaces.Model_2_1_Electric electrical, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PV restriction, smData = G2_data, specs = G2_pf_data, redeclare OmniPES.Transient.Examples.PSCC24.Controllers.SpeedGovernor sreg)  annotation(
    Placement(visible = true, transformation(origin = {-123, 50}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
  OmniPES.Transient.Machines.GenericSynchronousMachine G1(redeclare OmniPES.Transient.Examples.PSCC24.Controllers.AVR avr,redeclare OmniPES.Transient.Machines.Interfaces.Model_2_1_Electric electrical, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_VTH restriction,smData = G1_data, specs = G1_pf_data, redeclare OmniPES.Transient.Examples.PSCC24.Controllers.SpeedGovernor sreg)  annotation(
    Placement(visible = true, transformation(origin = {-126, -40}, extent = {{-14.5, -14.5}, {14.5, 14.5}}, rotation = 180)));
  parameter OmniPES.Transient.Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {160, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData G2_data(H = 3.0, MVAb = 150, T1d0 = 9.0, T1q0 = 0, T2d0 = 0.025, T2q0 = 0.08, X1d = 0.4, X1q = 0, X2d = 0.25, X2q = 0.25, Xd = 1.4, Xl = 0.15, Xq = 0.75)  annotation(
    Placement(visible = true, transformation(origin = {-162, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData G1_data(H = 3.0, MVAb = 50, T1d0 = 9.0, T1q0 = 0, T2d0 = 0.025, T2q0 = 0.08, X1d = 0.4, X1q = 0, X2d = 0.25, X2q = 0.25, Xd = 1.4, Xl = 0.15, Xq = 0.75) annotation(
    Placement(visible = true, transformation(origin = {-162, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Loads.ZIPLoad load(Psp = 120, Qsp = 0, dyn_par = loadData, ss_par = loadData)  annotation(
    Placement(visible = true, transformation(origin = {160, -40}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData G2_pf_data(Psp = 90., Vsp = 1.025)  annotation(
    Placement(visible = true, transformation(origin = {-162, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData G1_pf_data(Vsp = 1.017) annotation(
    Placement(visible = true, transformation(origin = {-162, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  d12 = G1.inertia.delta - G2.inertia.delta;
  connect(G2.terminal, bus2.p) annotation(
    Line(points = {{-109, 50}, {-90, 50}}, color = {0, 0, 255}));
  connect(trafo2.p, bus2.p) annotation(
    Line(points = {{-68, 50}, {-90, 50}}, color = {0, 0, 255}));
  connect(trafo2.n, bus20.p) annotation(
    Line(points = {{-32, 50}, {0, 50}, {0, 48}}, color = {0, 0, 255}));
  connect(G1.terminal, bus1.p) annotation(
    Line(points = {{-111, -40}, {-90, -40}}, color = {0, 0, 255}));
  connect(trafo1.p, bus1.p) annotation(
    Line(points = {{-68, -40}, {-90, -40}}, color = {0, 0, 255}));
  connect(trafo1.n, bus10.p) annotation(
    Line(points = {{-32, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line1.p, bus20.p) annotation(
    Line(points = {{20, 20}, {20, 48}, {0, 48}}, color = {0, 0, 255}));
  connect(line1.n, bus10.p) annotation(
    Line(points = {{20, 0}, {20, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line21.p, bus10.p) annotation(
    Line(points = {{48, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line22.p, bus10.p) annotation(
    Line(points = {{48, -60}, {0, -60}, {0, -40}}, color = {0, 0, 255}));
  connect(line22.n, bus30.p) annotation(
    Line(points = {{68, -60}, {122, -60}, {122, -40}}, color = {0, 0, 255}));
  connect(line21.n, bus30.p) annotation(
    Line(points = {{68, -40}, {122, -40}}, color = {0, 0, 255}));
  connect(load.p, bus30.p) annotation(
    Line(points = {{142, -40}, {122, -40}}, color = {0, 0, 255}));
  annotation(
    Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.001));
end tutorial_system;