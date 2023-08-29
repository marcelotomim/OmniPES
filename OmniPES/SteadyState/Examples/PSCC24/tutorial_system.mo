within OmniPES.SteadyState.Examples.PSCC24;

model tutorial_system
  OmniPES.Circuit.Interfaces.Bus bus_1 annotation(
    Placement(visible = true, transformation(origin = {-100, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_2 annotation(
    Placement(visible = true, transformation(origin = {-100, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_10 annotation(
    Placement(visible = true, transformation(origin = {0, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_20 annotation(
    Placement(visible = true, transformation(origin = {0, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus_30 annotation(
    Placement(visible = true, transformation(origin = {122, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo_1(x = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.TwoWindingTransformer trafo_2(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {-50, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance line_1(x = 0.07) annotation(
    Placement(visible = true, transformation(origin = {20, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.Circuit.Basic.SeriesImpedance line_21(x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {64, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance_switched line_22(t_open = 2500, x = 0.18) annotation(
    Placement(visible = true, transformation(origin = {64, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.SteadyState.Loads.Ctrl_ZIPLoad load(Psp = 120, Qsp = 0, ss_par = loadData, useExternalPsp = true, useExternalQsp = false) annotation(
    Placement(visible = true, transformation(origin = {187, -41.3333}, extent = {{-15, -16.6667}, {15, 13.3333}}, rotation = 0)));
  OmniPES.SteadyState.Sources.Ctrl_VTHSource_Qlim G1(Qmax = 26, Vsp = 1.017) annotation(
    Placement(visible = true, transformation(origin = {-141, -65}, extent = {{-25, -25}, {25, 25}}, rotation = -90)));
  OmniPES.SteadyState.Sources.Ctrl_PVSource_Qlim G2(Psp = 90,Qmax = 78, Vsp = 1.025, inc = 1000) annotation(
    Placement(visible = true, transformation(origin = {-141, 31}, extent = {{-23, -23}, {23, 23}}, rotation = -90)));
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {131, 69}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  parameter Loads.Interfaces.LoadData loadData annotation(
    Placement(visible = true, transformation(origin = {158, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Sources.Ramp ramp_P(duration = 110, height = 110) annotation(
    Placement(visible = true, transformation(origin = {-240, -104}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Gain gain(k = 3/4)  annotation(
    Placement(visible = true, transformation(origin = {-194, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  G1.dVsp = 0.;
  G2.dVsp = 0.;
  connect(G2.p, bus_2.p) annotation(
    Line(points = {{-141, 54}, {-100, 54}}, color = {0, 0, 255}));
  connect(G1.p, bus_1.p) annotation(
    Line(points = {{-141, -39.5}, {-113, -39.5}, {-113, -40}, {-100, -40}}, color = {0, 0, 255}));
  connect(bus_2.p, trafo_2.p) annotation(
    Line(points = {{-100, 54}, {-60, 54}}, color = {0, 0, 255}));
  connect(trafo_2.n, bus_20.p) annotation(
    Line(points = {{-38, 54}, {0, 54}}, color = {0, 0, 255}));
  connect(bus_1.p, trafo_1.p) annotation(
    Line(points = {{-100, -40}, {-60, -40}}, color = {0, 0, 255}));
  connect(trafo_1.n, bus_10.p) annotation(
    Line(points = {{-38, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(bus_20.p, line_1.p) annotation(
    Line(points = {{0, 54}, {20, 54}, {20, 20}}, color = {0, 0, 255}));
  connect(line_1.n, bus_10.p) annotation(
    Line(points = {{20, 0}, {20, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line_21.p, bus_10.p) annotation(
    Line(points = {{54, -34}, {27, -34}, {27, -40}, {0, -40}}, color = {0, 0, 255}));
  connect(line_22.p, bus_10.p) annotation(
    Line(points = {{54, -52}, {0, -52}, {0, -40}}, color = {0, 0, 255}));
  connect(line_21.n, bus_30.p) annotation(
    Line(points = {{74, -34}, {98, -34}, {98, -42}, {122, -42}}, color = {0, 0, 255}));
  connect(line_22.n, bus_30.p) annotation(
    Line(points = {{74, -52}, {98, -52}, {98, -42}, {122, -42}}, color = {0, 0, 255}));
  connect(load.p, bus_30.p) annotation(
    Line(points = {{172, -41}, {135, -41}, {135, -42}, {122, -42}}, color = {0, 0, 255}));
connect(gain.u, ramp_P.y) annotation(
    Line(points = {{-206, 40}, {-216, 40}, {-216, -104}, {-228, -104}}, color = {0, 0, 127}));
connect(ramp_P.y, load.dPsp) annotation(
    Line(points = {{-228, -104}, {181, -104}, {181, -53}}, color = {0, 0, 127}));
  connect(gain.y, G2.dPsp) annotation(
    Line(points = {{-182, 40}, {-158, 40}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-06, Interval = 0.001));
end tutorial_system;