within OmniPES.SteadyState.Examples.PSCC24;

model tutorial_system_SVR_SS
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {63, 50}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-100, -13}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {-100, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus10 annotation(
    Placement(visible = true, transformation(origin = {-24, -13}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus20 annotation(
    Placement(visible = true, transformation(origin = {-24, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus30 annotation(
    Placement(visible = true, transformation(origin = {79, -13}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo1(x = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-64, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo2(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {-64, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance line1(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {28, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line21(x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {49, -15}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line22(t_open = 2500, x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {49, -33}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.ZIPLoad load(Psp = 1.2e8, Qsp = 0, ss_par = loadData, useExternalPsp = true, useExternalQsp = false) annotation(
    Placement(visible = true, transformation(origin = {108.5, -15.4444}, extent = {{-18.5, -20.5556}, {18.5, 16.4444}}, rotation = 0)));
  replaceable OmniPES.SteadyState.Sources.VTHSource_Qlim_sigmoid G1(Qmax = 2.6e7, Vsp = 1.017, useExternalVoltageSpec = true, useExternalPowerSpec = false) annotation(
    Placement(transformation(origin = {-137, -15}, extent = {{-21, -21}, {21, 21}}, rotation = 180)));
  replaceable OmniPES.SteadyState.Sources.PVSource_Qlim_sigmoid G2(Psp = 9e7, Qmax = 7.8e7, Vsp = 1.025, useExternalVoltageSpec = true, useExternalPowerSpec = true) annotation(
    Placement(transformation(origin = {-138.5, 53.5}, extent = {{-21.5, -21.5}, {21.5, 21.5}}, rotation = 180)));
  parameter OmniPES.SteadyState.Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {109, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp rampP (duration = 140, height = 140e6, startTime = 0) annotation(
    Placement(visible = true, transformation(origin = {-210, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 3/4)  annotation(
    Placement(transformation(origin = {-172.5, 45.5}, extent = {{-6.5, -6.5}, {6.5, 6.5}})));
  Real ref2, ref1;
equation 
  bus30.V = 1.0;
  G1.S.im = (1/3)*G2.S.im; 
  G1.dVsp = ref1;
  G2.dVsp = ref2;
 
  connect(G2.p, bus2.p) annotation(
    Line(points = {{-117, 53.5}, {-120.25, 53.5}, {-120.25, 54}, {-100, 54}}, color = {0, 0, 255}));
  connect(bus2.p, trafo2.p) annotation(
    Line(points = {{-100, 54}, {-75, 54}}, color = {0, 0, 255}));
  connect(trafo2.n, bus20.p) annotation(
    Line(points = {{-53, 54}, {-24, 54}}, color = {0, 0, 255}));
  connect(bus1.p, trafo1.p) annotation(
    Line(points = {{-100.2, -15}, {-75, -15}}, color = {0, 0, 255}));
  connect(trafo1.n, bus10.p) annotation(
    Line(points = {{-53, -15}, {-24, -15}}, color = {0, 0, 255}));
  connect(bus20.p, line1.p) annotation(
    Line(points = {{-24, 54}, {27, 54}, {27, 32}, {28, 32}}, color = {0, 0, 255}));
  connect(line22.p, bus10.p) annotation(
    Line(points = {{39, -33}, {-24, -33}, {-24, -15}}, color = {0, 0, 255}));
  connect(load.p, bus30.p) annotation(
    Line(points = {{90, -15}, {79, -15}}, color = {0, 0, 255}));
  connect(line1.n, bus10.p) annotation(
    Line(points = {{28, 12}, {28, -15}, {-24, -15}}, color = {0, 0, 255}));
  connect(gain.y, G2.dPsp) annotation(
    Line(points = {{-165, 45.5}, {-165, 46}, {-153, 46}}, color = {0, 0, 127}));
  connect(rampP.y, gain.u) annotation(
    Line(points = {{-199, -6}, {-191, -6}, {-191, 45.5}, {-180, 45.5}}, color = {0, 0, 127}));
  connect(line21.p, bus10.p) annotation(
    Line(points = {{39, -15}, {-24, -15}}, color = {0, 0, 255}));
  connect(line21.n, bus30.p) annotation(
    Line(points = {{59, -15}, {79, -15}}, color = {0, 0, 255}));
  connect(rampP.y, load.dPsp) annotation(
    Line(points = {{-199, -6}, {-191, -6}, {-191, -69}, {101, -69}, {101, -30}}, color = {0, 0, 127}));
  connect(G1.p, bus1.p) annotation(
    Line(points = {{-116, -15}, {-100, -15}}, color = {0, 0, 255}));
  connect(line22.n, bus30.p) annotation(
    Line(points = {{59, -33}, {79, -33}, {79, -15}}, color = {0, 0, 255}));
  annotation(
    Icon(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-260, -120}, {200, 80}}, grid = {1, 1})),
  experiment(StartTime = 0, StopTime = 119.5, Tolerance = 1e-06, Interval = 0.001),
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end tutorial_system_SVR_SS;