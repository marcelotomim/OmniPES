within OmniPES.Transient.Examples.PSCC24;

model tutorial_system_SVR
  inner OmniPES.SystemData data annotation(
    Placement(transformation(origin = {98.5, 32.5}, extent = {{-16.5, -16.5}, {16.5, 16.5}})));
  Modelica.Units.SI.Angle d12;
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-34, -25}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-34, 29}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus10 annotation(
    Placement(visible = true, transformation(origin = {35, -25}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus20 annotation(
    Placement(visible = true, transformation(origin = {36, 29}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus30 annotation(
    Placement(visible = true, transformation(origin = {106, -25}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo1(x = 0.2) annotation(
    Placement(visible = true, transformation(origin = {0, -27}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo2(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {0, 27}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance line1(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {55, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line21(x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {75, -27}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line22(t_open = 25, x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {75, -47}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine G2(redeclare OmniPES.Transient.Examples.PSCC24.Controllers.AVR_SRV avr, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_1_Electric electrical, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_P restriction, smData = G2_data, specs = G2_pf_data, redeclare OmniPES.Transient.Examples.PSCC24.Controllers.SpeedGovernor sreg, avr_on = true, sreg_on = true) annotation(
    Placement(visible = true, transformation(origin = {-68, 27}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
  OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine G1(redeclare OmniPES.Transient.Examples.PSCC24.Controllers.AVR_SRV avr, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_1_Electric electrical, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_TH restriction, smData = G1_data, specs = G1_pf_data, redeclare OmniPES.Transient.Examples.PSCC24.Controllers.SpeedGovernor sreg, avr_on = true, sreg_on = true) annotation(
    Placement(visible = true, transformation(origin = {-68, -27}, extent = {{-14.5, -14.5}, {14.5, 14.5}}, rotation = 180)));
  parameter OmniPES.Transient.Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {144, -3}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData G2_data(H = 3.0, MVAb = 1.5e8, T1d0 = 9.0, T1q0 = 0, T2d0 = 0.025, T2q0 = 0.08, X1d = 0.4, X1q = 0, X2d = 0.25, X2q = 0.25, Xd = 1.4, Xl = 0.15, Xq = 0.75) annotation(
    Placement(visible = true, transformation(origin = {-100, 41}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData G1_data(H = 3.0, MVAb = 5e7, T1d0 = 9.0, T1q0 = 0, T2d0 = 0.025, T2q0 = 0.08, X1d = 0.4, X1q = 0, X2d = 0.25, X2q = 0.25, Xd = 1.4, Xl = 0.15, Xq = 0.75) annotation(
    Placement(visible = true, transformation(origin = {-100, -17}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Loads.ZIPLoad load(Psp = 1.2e8, Qsp = 0, dyn_par = loadData, ss_par = loadData) annotation(
    Placement(transformation(origin = {146, -43}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData G2_pf_data(Psp = 9e7, Vsp = 1.025) annotation(
    Placement(visible = true, transformation(origin = {-100, 19}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.SynchronousMachines.RestrictionData G1_pf_data(Vsp = 1.017) annotation(
    Placement(visible = true, transformation(origin = {-100, -39}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Examples.PSCC24.Controllers.Plant_SVR g1_srv(init = Modelica.Blocks.Types.Init.NoInit) annotation(
    Placement(transformation(origin = {-159, -42}, extent = {{-12, -12}, {12, 12}})));
  OmniPES.Transient.Examples.PSCC24.Controllers.Plant_SVR g2_srv(init = Modelica.Blocks.Types.Init.SteadyState) annotation(
    Placement(transformation(origin = {-160, 42}, extent = {{-13, -13}, {13, 13}})));
  OmniPES.Transient.Examples.PSCC24.Controllers.Central_SVR central_SVR annotation(
    Placement(transformation(origin = {-162.5, 1.5}, extent = {{-15.5, -15.5}, {15.5, 15.5}})));
equation
  G1.avr.Vext = g1_srv.Vref + central_SVR.Vref;
  G2.avr.Vext = g2_srv.Vref + central_SVR.Vref;
  g1_srv.Qg = G1.electrical.Qt;
  g2_srv.Qg = G2.electrical.Qt;
  central_SVR.Qin = {G1.electrical.Qt, G2.electrical.Qt};
  central_SVR.Qout = {g1_srv.Qcom, g2_srv.Qcom};
  central_SVR.Vpilot = bus30.V;
  d12 = G1.inertia.delta - G2.inertia.delta;
  connect(G2.terminal, bus2.p) annotation(
    Line(points = {{-54, 27}, {-34, 27}}, color = {0, 0, 255}));
  connect(trafo2.p, bus2.p) annotation(
    Line(points = {{-17.6, 27}, {-33.6, 27}}, color = {0, 0, 255}));
  connect(trafo2.n, bus20.p) annotation(
    Line(points = {{17.6, 27}, {35.6, 27}}, color = {0, 0, 255}));
  connect(G1.terminal, bus1.p) annotation(
    Line(points = {{-53.5, -27}, {-34, -27}}, color = {0, 0, 255}));
  connect(trafo1.p, bus1.p) annotation(
    Line(points = {{-17.6, -27}, {-33.6, -27}}, color = {0, 0, 255}));
  connect(trafo1.n, bus10.p) annotation(
    Line(points = {{17.6, -27}, {34.2, -27}}, color = {0, 0, 255}));
  connect(line1.p, bus20.p) annotation(
    Line(points = {{55, 9.6}, {55, 26.6}, {36, 26.6}}, color = {0, 0, 255}));
  connect(line1.n, bus10.p) annotation(
    Line(points = {{54.8, -10}, {54.8, -27}, {34.8, -27}}, color = {0, 0, 255}));
  connect(line21.p, bus10.p) annotation(
    Line(points = {{65.4, -27}, {35.4, -27}}, color = {0, 0, 255}));
  connect(line22.p, bus10.p) annotation(
    Line(points = {{65.4, -47}, {35.4, -47}, {35.4, -27}}, color = {0, 0, 255}));
  connect(line22.n, bus30.p) annotation(
    Line(points = {{85, -47}, {106, -47}, {106, -27}}, color = {0, 0, 255}));
  connect(line21.n, bus30.p) annotation(
    Line(points = {{85, -27.2}, {106, -27.2}}, color = {0, 0, 255}));
  connect(load.p, bus30.p) annotation(
    Line(points = {{146, -27}, {105.64, -27}}, color = {0, 0, 255}));
protected
public
  annotation(
    Icon(coordinateSystem(extent = {{-250, -100}, {200, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-250, -100}, {200, 100}}, grid = {1, 1}), graphics = {Text(origin = {-194, 49.5}, extent = {{-12, 6}, {13, -5}}, textString = "Qcom[1]"), Text(origin = {-184.5, 35}, extent = {{-7, 4}, {8, -4}}, textString = "Qg"), Text(origin = {-182.5, -50}, extent = {{-7, 4}, {8, -4}}, textString = "Qg"), Text(origin = {-200, -7}, extent = {{-18, 5}, {19, -4}}, textString = "Vpilot"), Text(origin = {-192.5, 11}, extent = {{-7, 4}, {8, -4}}, textString = "Qin"), Text(origin = {-191, -35.5}, extent = {{-12, 6}, {13, -5}}, textString = "Qcom[2]"), Text(origin = {-134.5, 42}, extent = {{-7, 4}, {8, -4}}, textString = "Vref"), Text(origin = {-133.5, -8}, extent = {{-7, 4}, {8, -4}}, textString = "Vref"), Text(origin = {-133.5, -42}, extent = {{-7, 4}, {8, -4}}, textString = "Vref"), Text(origin = {-134.5, 11}, extent = {{-7, 4}, {8, -4}}, textString = "Qcom")}),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.001));
end tutorial_system_SVR;