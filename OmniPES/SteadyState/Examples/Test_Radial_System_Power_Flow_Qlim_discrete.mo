within OmniPES.SteadyState.Examples;

model Test_Radial_System_Power_Flow_Qlim_discrete
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus1 annotation(
    Placement(visible = true, transformation(origin = {-46, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus2 annotation(
    Placement(visible = true, transformation(origin = {52, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance1(x = 0.01) annotation(
    Placement(visible = true, transformation(origin = {74, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Basic.SeriesImpedance impedance2(x = 0.01) annotation(
    Placement(transformation(origin = {-70, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Circuit.Interfaces.Bus bus annotation(
    Placement(visible = true, transformation(origin = {94, 18}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tLine(Q = 1e8, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {2, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable OmniPES.SteadyState.Sources.PVSource_Qlim_discrete pVSource_Qlim(Psp = 1e8, Qmax = 6e7, Qmin = -6e7, Vsp = 1.0, voltage_limits = true) annotation(
    Placement(transformation(origin = {128.556, 19.4444}, extent = {{-18, -20}, {18, 16}})));
  Circuit.Basic.TLine_switched tLine1(r = 0, x = 0.1, Q = 1e8, t_open_p = 2, t_open_n = 2, open_p = true, open_n = true) annotation(
    Placement(transformation(origin = {0, -8}, extent = {{-10, -10}, {10, 10}})));
  Sources.VTHSource vTHSource annotation(
    Placement(transformation(origin = {-115, 17}, extent = {{-15, -15}, {15, 15}}, rotation = 180)));
  Circuit.Switches.Breaker breaker annotation(
    Placement(transformation(origin = {52, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Circuit.Basic.Shunt_Reactor shunt_Reactor(NominalPower = 1.5e8) annotation(
    Placement(transformation(origin = {52, -48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime = 4, startValue = true) annotation(
    Placement(transformation(origin = {88, -20}, extent = {{10, -10}, {-10, 10}})));
equation
  connect(impedance2.p, bus1.p) annotation(
    Line(points = {{-60, 18}, {-46.8, 18}}, color = {0, 0, 255}));
  connect(bus2.p, impedance1.n) annotation(
    Line(points = {{52, 16}, {64, 16}}, color = {0, 0, 255}));
  connect(impedance1.p, bus.p) annotation(
    Line(points = {{84, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(tLine.n, bus2.p) annotation(
    Line(points = {{14, 30}, {38, 30}, {38, 22}, {52, 22}, {52, 16}}, color = {0, 0, 255}));
  connect(tLine.p, bus1.p) annotation(
    Line(points = {{-8, 30}, {-34, 30}, {-34, 22}, {-46, 22}, {-46, 18}}, color = {0, 0, 255}));
  connect(pVSource_Qlim.p, bus.p) annotation(
    Line(points = {{110, 17}, {101, 17}, {101, 16}, {94, 16}}, color = {0, 0, 255}));
  connect(tLine1.p, bus1.p) annotation(
    Line(points = {{-11, -5}, {-26, -5}, {-26, 18}, {-46, 18}}, color = {0, 0, 255}));
  connect(tLine1.n, bus2.p) annotation(
    Line(points = {{11, -5}, {34, -5}, {34, 16}, {52, 16}}, color = {0, 0, 255}));
  connect(vTHSource.p, impedance2.n) annotation(
    Line(points = {{-100, 17}, {-100, 18}, {-80, 18}}, color = {0, 0, 255}));
  connect(breaker.p, bus2.p) annotation(
    Line(points = {{52, -10}, {52, 16}}, color = {0, 0, 255}));
  connect(breaker.n, shunt_Reactor.p) annotation(
    Line(points = {{51.8, -30}, {51.8, -38}}, color = {0, 0, 255}));
  connect(booleanStep.y, breaker.ext_open) annotation(
    Line(points = {{77, -20}, {60, -20}}, color = {255, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 6, Tolerance = 1e-06, Interval = 0.01),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end Test_Radial_System_Power_Flow_Qlim_discrete;