within OmniPES.Transient.Examples;

model Test_Breaker
  OmniPES.Circuit.Switches.Fault fault annotation(
    Placement(transformation(origin = {28, -34}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
    Placement(transformation(origin = {-78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  OmniPES.Transient.Loads.ZIPLoad zIPLoad(Psp = 1e8, Qsp = 5e7) annotation(
    Placement(visible = true, transformation(origin = {-4, -34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Circuit.Switches.TimedBreaker timedBreaker(t_open = 0.6) annotation(
    Placement(visible = true, transformation(origin = {-14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner SystemData data annotation(
    Placement(transformation(origin = {-62, 66}, extent = {{-22, -22}, {22, 22}})));
  Circuit.Basic.SeriesImpedance seriesImpedance(x = 0.1) annotation(
    Placement(transformation(origin = {-48, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Circuit.Switches.Fault fault1(X = 1, t_on = 0.2, t_off = 10000, R = 1)  annotation(
    Placement(transformation(origin = {58, -34}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(timedBreaker.n, fault.T) annotation(
    Line(points = {{-4, 0}, {28, 0}, {28, -24}}, color = {0, 0, 255}));
  connect(zIPLoad.p, timedBreaker.n) annotation(
    Line(points = {{-4, -24}, {-4, 0}}, color = {0, 0, 255}));
  connect(voltageSource.p, seriesImpedance.p) annotation(
    Line(points = {{-68, 0}, {-58, 0}}, color = {0, 0, 255}));
  connect(seriesImpedance.n, timedBreaker.p) annotation(
    Line(points = {{-38, 0}, {-24, 0}}, color = {0, 0, 255}));
  connect(fault1.T, timedBreaker.n) annotation(
    Line(points = {{58, -24}, {60, -24}, {60, 0}, {-4, 0}}, color = {0, 0, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Test_Breaker;