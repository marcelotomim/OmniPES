within OmniPES.SteadyState.Examples.PSCC24;

model tutorial_system_SVR_SS
  OmniPES.Circuit.Interfaces.Bus bus_1 annotation(
    Placement(visible = true, transformation(origin = {-100, -13}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_2 annotation(
    Placement(visible = true, transformation(origin = {-100, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_10 annotation(
    Placement(visible = true, transformation(origin = {0, -13}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_20 annotation(
    Placement(visible = true, transformation(origin = {0, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_30 annotation(
    Placement(visible = true, transformation(origin = {120, -13}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo_1(x = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-50, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo_2(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {-50, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance line_1(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {28, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line_21(x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {65, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line_22(t_open = 2500, x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {65, -33}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.Ctrl_ZIPLoad load(Psp = 120, Qsp = 0, ss_par = loadData, useExternalPsp = true, useExternalQsp = false) annotation(
    Placement(visible = true, transformation(origin = {171.5, -15.4444}, extent = {{-18.5, -20.5556}, {18.5, 16.4444}}, rotation = 0)));
  OmniPES.SteadyState.Sources.Ctrl_VTHSource_Qlim G1(Qmax = 26, Vsp = 1.017, useExternalVoltageSpec = true) annotation(
    Placement(visible = true, transformation(origin = {-142, -36}, extent = {{-21, -21}, {21, 21}}, rotation = -90)));
  OmniPES.SteadyState.Sources.Ctrl_PVSource_Qlim G2(Psp = 90, Qmax = 78, Vsp = 1.025, useExternalPowerSpec = true, useExternalVoltageSpec = true) annotation(
    Placement(visible = true, transformation(origin = {-139.5, 32.5}, extent = {{-21.5, -21.5}, {21.5, 21.5}}, rotation = -90)));
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {91, 30}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {172, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_P(duration = 110, height = 110) annotation(
    Placement(visible = true, transformation(origin = {-223, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 3/4) annotation(
    Placement(visible = true, transformation(origin = {-181.5, 41.5}, extent = {{-6.5, -6.5}, {6.5, 6.5}}, rotation = 0)));
 Real ref_2, ref_1, Qtotal;
  Boolean overvoltage;
  Boolean not_volt_ctrl;
  discrete Real frozen_ref_1(start = 0);
equation
  not_volt_ctrl = not G1.volt_ctrl;
  when edge(not_volt_ctrl) then
    frozen_ref_1 = pre(ref_1) + 0.005;
  end when;
  
  bus_30.V = 1.0;
  0 = if G1.volt_ctrl then G1.S.im - (1/4)*Qtotal else ref_1 - frozen_ref_1;
  
  Qtotal = G1.S.im + G2.S.im; 
  G1.dVsp = ref_1;
  G2.dVsp = ref_2;
 
  overvoltage = bus_2.V <= 1.05;
  connect(G2.p, bus_2.p) annotation(
    Line(points = {{-139.5, 54}, {-100, 54}}, color = {0, 0, 255}));
  connect(bus_2.p, trafo_2.p) annotation(
    Line(points = {{-100, 54}, {-60, 54}}, color = {0, 0, 255}));
  connect(trafo_2.n, bus_20.p) annotation(
    Line(points = {{-38, 54}, {0, 54}}, color = {0, 0, 255}));
  connect(bus_1.p, trafo_1.p) annotation(
    Line(points = {{-100.2, -15}, {-60.2, -15}}, color = {0, 0, 255}));
  connect(trafo_1.n, bus_10.p) annotation(
    Line(points = {{-39, -15}, {-1, -15}}, color = {0, 0, 255}));
  connect(bus_20.p, line_1.p) annotation(
    Line(points = {{0, 54}, {28, 54}, {28, 32}}, color = {0, 0, 255}));
  connect(line_22.p, bus_10.p) annotation(
    Line(points = {{55, -33}, {-1, -33}, {-1, -15}, {0, -15}}, color = {0, 0, 255}));
  connect(load.p, bus_30.p) annotation(
    Line(points = {{153, -15}, {120, -15}}, color = {0, 0, 255}));
  connect(line_1.n, bus_10.p) annotation(
    Line(points = {{28, 12}, {28, -15}, {0, -15}}, color = {0, 0, 255}));
  connect(gain.y, G2.dPsp) annotation(
    Line(points = {{-174, 41.5}, {-156, 41.5}, {-156, 41}}, color = {0, 0, 127}));
  connect(ramp_P.y, gain.u) annotation(
    Line(points = {{-212, -6}, {-201, -6}, {-201, 41.5}, {-189, 41.5}}, color = {0, 0, 127}));
  connect(line_21.p, bus_10.p) annotation(
    Line(points = {{55, -15}, {0, -15}}, color = {0, 0, 255}));
  connect(line_21.n, bus_30.p) annotation(
    Line(points = {{75, -15}, {120, -15}}, color = {0, 0, 255}));
  connect(line_22.n, bus_30.p) annotation(
    Line(points = {{75, -33}, {120, -33}, {120, -15}}, color = {0, 0, 255}));
  connect(ramp_P.y, load.dPsp) annotation(
    Line(points = {{-212, -6}, {-201, -6}, {-201, -80}, {164, -80}, {164, -30}}, color = {0, 0, 127}));
  connect(G1.p, bus_1.p) annotation(
    Line(points = {{-142, -15}, {-100, -15}}, color = {0, 0, 255}));
  annotation(
    Icon(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.001));
end tutorial_system_SVR_SS;