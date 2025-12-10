within OmniPES.Transient.Examples;

model Test_LagLim
  Controllers.Blocks.LagLimit lagLimit(k = 20, T = 0.15, ymax = 5, ymin = -5) annotation(
    Placement(transformation(origin = {34, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine sine(f = 1)  annotation(
    Placement(transformation(origin = {-80, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(k = 20, T = 0.15, initType = Modelica.Blocks.Types.Init.SteadyState)  annotation(
    Placement(transformation(origin = {-2, -24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 5, uMin = -5)  annotation(
    Placement(transformation(origin = {36, -24}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(sine.y, lagLimit.u) annotation(
    Line(points = {{-69, 20}, {22, 20}}, color = {0, 0, 127}, thickness = 0.5));
  connect(firstOrder.y, limiter.u) annotation(
    Line(points = {{9, -24}, {24, -24}}, color = {0, 0, 127}));
  connect(firstOrder.u, sine.y) annotation(
    Line(points = {{-14, -24}, {-40, -24}, {-40, 20}, {-69, 20}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}}, grid = {1, 1})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}}, grid = {1, 1})),
  experiment(StartTime = 0, StopTime = 4, Tolerance = 1e-06, Interval = 0.001));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Test_LagLim;