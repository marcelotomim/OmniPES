within OmniPES.CoSimulation;

model Teste_01
  parameter Real dt = 0.1;
  OmniPES.CoSimulation.BergeronLink bl_1(restrictionData = specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction) annotation(
    Placement(visible = true, transformation(origin = {2, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource slack_cs annotation(
    Placement(visible = true, transformation(origin = {-88, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.SteadyState.Loads.ZIPLoad zIPLoad_cs(Psp = 100, Qsp = 0) annotation(
    Placement(visible = true, transformation(origin = {196, 32}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  inner OmniPES.SystemData data(wref = 0) annotation(
    Placement(visible = true, transformation(origin = {-71, 77}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tl2_cs(Q = 0, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {128, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_load_cs annotation(
    Placement(visible = true, transformation(origin = {156, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_m annotation(
    Placement(visible = true, transformation(origin = {98, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData specs(Psp = 100., Qsp = 10.1021, Vsp = 0.984222, theta_sp = -5.8315) annotation(
    Placement(visible = true, transformation(origin = {36, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine1(Q = 0, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-54, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_k annotation(
    Placement(visible = true, transformation(origin = {-26, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_int annotation(
    Placement(visible = true, transformation(origin = {22, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tl2(Q = 0, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {52, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource slack annotation(
    Placement(visible = true, transformation(origin = {-58, -50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Interfaces.Bus bus_load annotation(
    Placement(visible = true, transformation(origin = {80, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.ZIPLoad zIPLoad(Psp = 100, Qsp = 0) annotation(
    Placement(visible = true, transformation(origin = {120, -44}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tl1_cs(Q = 0, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-54, 28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tl1(Q = 0, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-18, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.CoSimulation.BergeronLink bl_2(restrictionData = specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_VTH restriction) annotation(
    Placement(visible = true, transformation(origin = {70, 32}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(zIPLoad_cs.p, bus_load_cs.p) annotation(
    Line(points = {{173.56, 32}, {155.56, 32}}, color = {0, 0, 255}));
  connect(tl2_cs.n, bus_load_cs.p) annotation(
    Line(points = {{139, 33}, {155, 33}, {155, 31}}, color = {0, 0, 255}));
  connect(tl2_cs.p, bus_m.p) annotation(
    Line(points = {{117, 33}, {97, 33}, {97, 31}}, color = {0, 0, 255}));
  connect(slack_cs.p, tLine1.p) annotation(
    Line(points = {{-88, 32.2}, {-64, 32.2}}, color = {0, 0, 255}));
  connect(tLine1.n, bus_k.p) annotation(
    Line(points = {{-43, 31}, {-34, 31}, {-34, 30}, {-26, 30}}, color = {0, 0, 255}));
  connect(bl_1.pin_p, bus_k.p) annotation(
    Line(points = {{-8, 32}, {-26, 32}, {-26, 30}}, color = {0, 0, 255}));
  connect(slack.p, tl1.p) annotation(
    Line(points = {{-58, -40}, {-44, -40}, {-44, -41}, {-29, -41}}, color = {0, 0, 255}));
  connect(tl1.n, bus_int.p) annotation(
    Line(points = {{-7, -41}, {22, -41}, {22, -44}}, color = {0, 0, 255}));
  connect(tl2.p, bus_int.p) annotation(
    Line(points = {{42, -42}, {22, -42}, {22, -44}}, color = {0, 0, 255}));
  connect(tl2.n, bus_load.p) annotation(
    Line(points = {{64, -42}, {80, -42}, {80, -44}}, color = {0, 0, 255}));
  connect(zIPLoad.p, bus_load.p) annotation(
    Line(points = {{98, -44}, {80, -44}}, color = {0, 0, 255}));
  connect(bl_2.pin_p, bus_m.p) annotation(
    Line(points = {{82, 32}, {98, 32}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.01));
end Teste_01;