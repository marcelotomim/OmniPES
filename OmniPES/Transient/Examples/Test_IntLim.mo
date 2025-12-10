within OmniPES.Transient.Examples;

model Test_IntLim
  Modelica.Blocks.Sources.Sine sine(f = 1)  annotation(
    Placement(transformation(origin = {-80, 20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 2, uMin = -1)  annotation(
    Placement(transformation(origin = {36, -24}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator integrator(k = 20, initType = Modelica.Blocks.Types.Init.SteadyState)  annotation(
    Placement(transformation(origin = {-3, -24}, extent = {{-10, -10}, {10, 10}})));
  Controllers.Blocks.IntegratorLimit integratorLimit(k = 20, ymax = 2, ymin = -1) annotation(
    Placement(transformation(origin = {37, 20}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(integrator.y, limiter.u) annotation(
    Line(points = {{8, -24}, {24, -24}}, color = {0, 0, 127}));
  connect(integrator.u, sine.y) annotation(
    Line(points = {{-15, -24}, {-32, -24}, {-32, 20}, {-69, 20}}, color = {0, 0, 127}));
  connect(integratorLimit.u, sine.y) annotation(
    Line(points = {{25, 20}, {-69, 20}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}}, grid = {1, 1})),
    Icon(coordinateSystem(extent = {{-150, -100}, {150, 100}}, grid = {1, 1})),
  experiment(StartTime = 0, StopTime = 4, Tolerance = 1e-06, Interval = 0.001));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Test_IntLim;