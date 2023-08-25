within OmniPES.SteadyState.Examples.PSCC24;

model tutorial_system_SVR_SS
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {76.5, 40.5}, extent = {{-21.5, -21.5}, {21.5, 21.5}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_1 annotation(
    Placement(visible = true, transformation(origin = {-90, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_2 annotation(
    Placement(visible = true, transformation(origin = {-90, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
  OmniPES.SteadyState.Sources.Ctrl_VTHSource_Qlim G1(Qmax = 26, Vsp = 1.017)  annotation(
    Placement(visible = true, transformation(origin = {-119.5, -52.5}, extent = {{-12.5, -12.5}, {12.5, 12.5}}, rotation = -90)));
  OmniPES.SteadyState.Sources.Ctrl_PVSource_Qlim G2(Psp = 90., Qmax = 78., Vsp = 1.025)  annotation(
    Placement(visible = true, transformation(origin = {-120, 40}, extent = {{-10, -10}, {10, 8}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line_22(x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {58, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.Ctrl_ZIPLoad load(Psp = 120, Qsp = 0, ss_par = loadData)  annotation(
    Placement(visible = true, transformation(origin = {161, -40.4}, extent = {{-13, -13}, {13, 10.4}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_P(duration = 190, height = 140, startTime = 2000) annotation(
    Placement(visible = true, transformation(origin = {-201, -101}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 3/4) annotation(
    Placement(visible = true, transformation(origin = {-156, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter SteadyState.Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {158, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Real ref_2, ref_1, Qtotal;
  Boolean overvoltage;
//  Boolean not_volt_ctrl;
//  Real frozen(start=0, fixed);
equation
//  der(frozen) = 0;
//  not_volt_ctrl = not G1.volt_ctrl;
//  when edge(not_volt_ctrl) then
//    reinit(frozen, pre(ref_1)+1e-4);
//  end when;
  Qtotal = G1.S.im + G2.S.im;
  bus_30.V = 1.0;
  0 = if G1.volt_ctrl then G1.S.im - (1/4)*Qtotal else ref_1 - 1;
  G1.dVsp = ref_1;
  G2.dVsp = ref_2;
  overvoltage = bus_2.V <= 1.1 or bus_30.V <= 1.1;
//  assert(overvoltage, "Maximum voltage was reached.");
  
  connect(trafo_2.p, bus_2.p) annotation(
    Line(points = {{-68, 50}, {-90, 50}}, color = {0, 0, 255}));
  connect(trafo_2.n, bus_20.p) annotation(
    Line(points = {{-32, 50}, {0, 50}, {0, 48}}, color = {0, 0, 255}));
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
  connect(line_21.n, bus_30.p) annotation(
    Line(points = {{68, -40}, {122, -40}}, color = {0, 0, 255}));
  connect(G1.p, bus_1.p) annotation(
    Line(points = {{-119.5, -40}, {-90, -40}}, color = {0, 0, 255}));
  connect(G2.p, bus_2.p) annotation(
    Line(points = {{-120, 50}, {-90, 50}}, color = {0, 0, 255}));
  connect(line_22.p, bus_10.p) annotation(
    Line(points = {{48, -58}, {1, -58}, {1, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line_22.n, bus_30.p) annotation(
    Line(points = {{68, -58}, {122, -58}, {122, -40}}, color = {0, 0, 255}));
  connect(load.p, bus_30.p) annotation(
    Line(points = {{148, -40}, {122, -40}}, color = {0, 0, 255}));
  connect(gain.y, G2.dPsp) annotation(
    Line(points = {{-145, 44}, {-128, 44}}, color = {0, 0, 127}));
  connect(ramp_P.y, gain.u) annotation(
    Line(points = {{-190, -101}, {-177, -101}, {-177, 44}, {-168, 44}}, color = {0, 0, 127}));
  connect(ramp_P.y, load.dPsp) annotation(
    Line(points = {{-190, -101}, {157, -101}, {157, -50}, {156, -50}}, color = {0, 0, 127}));

protected
  annotation(
    Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}}, grid = {1, 1})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.001));
end tutorial_system_SVR_SS;