within OmniPES.Transient.Examples.PSCC24;

model tutorial_system_SVR
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {101.5, 30.5}, extent = {{-21.5, -21.5}, {21.5, 21.5}}, rotation = 0)));
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
  OmniPES.Transient.Machines.GenericSynchronousMachine G2(redeclare OmniPES.Transient.Examples.PSCC24.Controllers.AVR_SRV avr, redeclare OmniPES.Transient.Machines.Interfaces.Model_2_1_Electric electrical, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_P restriction, smData = G2_data, specs = G2_pf_data, redeclare OmniPES.Transient.Examples.PSCC24.Controllers.SpeedGovernor sreg) annotation(
    Placement(visible = true, transformation(origin = {-68, 27}, extent = {{-14, -14}, {14, 14}}, rotation = 180)));
  OmniPES.Transient.Machines.GenericSynchronousMachine G1(redeclare OmniPES.Transient.Examples.PSCC24.Controllers.AVR_SRV avr, redeclare OmniPES.Transient.Machines.Interfaces.Model_2_1_Electric electrical, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_TH restriction, smData = G1_data, specs = G1_pf_data, redeclare OmniPES.Transient.Examples.PSCC24.Controllers.SpeedGovernor sreg) annotation(
    Placement(visible = true, transformation(origin = {-68, -27}, extent = {{-14.5, -14.5}, {14.5, 14.5}}, rotation = 180)));
  parameter OmniPES.Transient.Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {144, -3}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData G2_data(H = 3.0, MVAb = 150, T1d0 = 9.0, T1q0 = 0, T2d0 = 0.025, T2q0 = 0.08, X1d = 0.4, X1q = 0, X2d = 0.25, X2q = 0.25, Xd = 1.4, Xl = 0.15, Xq = 0.75) annotation(
    Placement(visible = true, transformation(origin = {-100, 41}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData G1_data(H = 3.0, MVAb = 50, T1d0 = 9.0, T1q0 = 0, T2d0 = 0.025, T2q0 = 0.08, X1d = 0.4, X1q = 0, X2d = 0.25, X2q = 0.25, Xd = 1.4, Xl = 0.15, Xq = 0.75) annotation(
    Placement(visible = true, transformation(origin = {-100, -17}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Loads.ZIPLoad load(Psp = 120, Qsp = 0, dyn_par = loadData, ss_par = loadData) annotation(
    Placement(visible = true, transformation(origin = {144, -27}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData G2_pf_data(Psp = 90., Vsp = 1.025) annotation(
    Placement(visible = true, transformation(origin = {-100, 19}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData G1_pf_data(Vsp = 1.017) annotation(
    Placement(visible = true, transformation(origin = {-100, -39}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Examples.PSCC24.Controllers.Plant_SVR g1_srv annotation(
    Placement(visible = true, transformation(origin = {-156, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Examples.PSCC24.Controllers.Plant_SVR g2_srv(init = Modelica.Blocks.Types.Init.SteadyState)  annotation(
    Placement(transformation(origin = {-156, 45}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Transient.Examples.PSCC24.Controllers.Central_SVR central_SVR annotation(
    Placement(visible = true, transformation(origin = {-156, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
equation
  G1.avr.Vext = g1_srv.Vref + central_SVR.Vref;
  G2.avr.Vext = g2_srv.Vref + central_SVR.Vref;
  g1_srv.Qg = G1.electrical.Qt;
  g2_srv.Qg = G2.electrical.Qt;
  central_SVR.Qin[1] = G1.electrical.Qt;
  central_SVR.Qin[2] = G2.electrical.Qt;
  g1_srv.Qcom = central_SVR.Qout[1];
  g2_srv.Qcom = central_SVR.Qout[2];
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
    Line(points = {{125.64, -27}, {105.64, -27}}, color = {0, 0, 255}));
protected
  annotation(
    Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1}), graphics = {Text(origin = {-186, 54}, extent = {{-15, 7}, {16, -7}}, textString = "Qcom[1]", fontSize = 14), Text(origin = {-179.5, 40}, extent = {{-7, 4}, {8, -4}}, textString = "Qg", fontSize = 14), Text(origin = {-178.5, -45}, extent = {{-7, 4}, {8, -4}}, textString = "Qg", fontSize = 14), Text(origin = {-185, -33}, extent = {{-15, 8}, {15, -8}}, textString = "Qcom[2]", fontSize = 14), Text(origin = {-187, -7}, extent = {{-12, 4}, {13, -4}}, textString = "Vpilot", fontSize = 14), Text(origin = {-182, 7}, extent = {{-10, 7}, {10, -7}}, textString = "Qin", fontSize = 14), Text(origin = {-135, 40}, extent = {{-10, 7}, {10, -7}}, textString = "Vref", fontSize = 14), Text(origin = {-135, -40}, extent = {{-10, 7}, {10, -7}}, textString = "Vref", fontSize = 14), Text(origin = {-133, -7}, extent = {{-10, 7}, {10, -7}}, textString = "Vref", fontSize = 14), Text(origin = {-134, 7}, extent = {{-10, 7}, {10, -7}}, textString = "Qcom", fontSize = 14)}),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.001));
end tutorial_system_SVR;