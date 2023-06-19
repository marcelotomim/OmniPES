within OmniPES.QuasiSteadyState.Examples;

model Test_Breaker
  OmniPES.Circuit.Switches.Fault fault annotation(
    Placement(visible = true, transformation(origin = {38, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
    Placement(visible = true, transformation(origin = {-74, -10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  OmniPES.QuasiSteadyState.Loads.ZIPLoad zIPLoad(Pesp = 100, Qesp = 50) annotation(
    Placement(visible = true, transformation(origin = {12, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Circuit.Switches.TimedBreaker timedBreaker(t_open = 0.6) annotation(
    Placement(visible = true, transformation(origin = {-14, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner SystemData data annotation(
    Placement(visible = true, transformation(origin = {-62, 46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Basic.SeriesImpedance seriesImpedance(x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(timedBreaker.n, fault.T) annotation(
    Line(points = {{-4, 0}, {38, 0}, {38, -4}}, color = {0, 0, 255}));
  connect(zIPLoad.p, timedBreaker.n) annotation(
    Line(points = {{12, -6}, {-4, -6}, {-4, 0}}, color = {0, 0, 255}));
  connect(voltageSource.p, seriesImpedance.p) annotation(
    Line(points = {{-74, 0}, {-60, 0}}, color = {0, 0, 255}));
  connect(seriesImpedance.n, timedBreaker.p) annotation(
    Line(points = {{-40, 0}, {-24, 0}}, color = {0, 0, 255}));
end Test_Breaker;