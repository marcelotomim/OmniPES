within OmniPES.QuasiSteadyState.Examples.PSCC24;

model tutorial_system_SVR_QSS
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {76.5, 40.5}, extent = {{-21.5, -21.5}, {21.5, 21.5}}, rotation = 0)));
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
  OmniPES.QuasiSteadyState.Examples.PSCC24.Controllers.Plant_SVR g1_srv(init = Modelica.Blocks.Types.Init.SteadyState)  annotation(
    Placement(visible = true, transformation(origin = {-232.5, -40.5}, extent = {{-13.5, -13.5}, {13.5, 13.5}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Examples.PSCC24.Controllers.Plant_SVR g2_srv annotation(
    Placement(visible = true, transformation(origin = {-231.5, 54.5}, extent = {{-13.5, -13.5}, {13.5, 13.5}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Examples.PSCC24.Controllers.Central_SVR central_SVR annotation(
    Placement(visible = true, transformation(origin = {-231.5, 8.5}, extent = {{-13.5, -13.5}, {13.5, 13.5}}, rotation = 0)));
  OmniPES.SteadyState.Sources.Ctrl_VTHSource_Qlim G1(Qmax = 26., Vsp = 1.017)  annotation(
    Placement(visible = true, transformation(origin = {-119.5, -52.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = -90)));
  OmniPES.SteadyState.Sources.Ctrl_PVSource_Qlim G2(Psp = 90., Qmax = 78., Vsp = 1.025)  annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-10, -10}, {10, 8}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line22(t_open = 2500, x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {58, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.Ctrl_ZIPLoad load(Psp = 120, Qsp = 0, ss_par = loadData, useExternalQsp = false)  annotation(
    Placement(visible = true, transformation(origin = {161, -40.4}, extent = {{-13, -13}, {13, 10.4}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampP (duration = 300, height = 238. - 120, startTime = 2500) annotation(
    Placement(visible = true, transformation(origin = {-189, -89}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 3/4) annotation(
    Placement(visible = true, transformation(origin = {-156, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter SteadyState.Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {158, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  G1.dVsp = g1_srv.Vref + central_SVR.Vref;
  G2.dVsp = g2_srv.Vref + central_SVR.Vref;
  g1_srv.Qcom = central_SVR.Qout[1];
  g1_srv.Qt = G1.S.im;
  g2_srv.Qcom = central_SVR.Qout[2];
  g2_srv.Qt = G2.S.im;
  central_SVR.Qin[1] = G1.S.im;
  central_SVR.Qin[2] = G2.S.im;
  central_SVR.Vpilot = bus30.V;
  connect(trafo2.p, bus2.p) annotation(
    Line(points = {{-68, 50}, {-90, 50}}, color = {0, 0, 255}));
  connect(trafo2.n, bus20.p) annotation(
    Line(points = {{-32, 50}, {0, 50}, {0, 48}}, color = {0, 0, 255}));
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
  connect(line21.n, bus30.p) annotation(
    Line(points = {{68, -40}, {122, -40}}, color = {0, 0, 255}));
  connect(G1.p, bus1.p) annotation(
    Line(points = {{-119.5, -40}, {-90, -40}}, color = {0, 0, 255}));
  connect(G2.p, bus2.p) annotation(
    Line(points = {{-120, 50}, {-90, 50}}, color = {0, 0, 255}));
  connect(line22.p, bus10.p) annotation(
    Line(points = {{48, -58}, {1, -58}, {1, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line22.n, bus30.p) annotation(
    Line(points = {{68, -58}, {122, -58}, {122, -40}}, color = {0, 0, 255}));
  connect(load.p, bus30.p) annotation(
    Line(points = {{148, -40}, {122, -40}}, color = {0, 0, 255}));
  connect(gain.y, G2.dPsp) annotation(
    Line(points = {{-145, 44}, {-128, 44}}, color = {0, 0, 127}));
  connect(rampP.y, gain.u) annotation(
    Line(points = {{-178, -89}, {-178, 44}, {-168, 44}}, color = {0, 0, 127}));
  connect(rampP.y, load.dPsp) annotation(
    Line(points = {{-178, -89}, {157, -89}, {157, -50}, {156, -50}}, color = {0, 0, 127}));
protected
  annotation(
    Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.01));
end tutorial_system_SVR_QSS;