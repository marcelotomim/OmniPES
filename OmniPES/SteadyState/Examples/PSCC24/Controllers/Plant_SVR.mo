within OmniPES.SteadyState.Examples.PSCC24.Controllers;

model Plant_SVR
  Modelica.Blocks.Continuous.PI Q_ctrl(T = kp/ki, initType = Modelica.Blocks.Types.Init.NoInit, k = kp, x(fixed = true), x_start = 0, y(fixed = true, start = 0))  annotation(
    Placement(visible = true, transformation(origin = {75, -54}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-7, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Qt annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Real kp = 0.005 "proportional gain";
  parameter Real ki = 0.05 "integral gain";
  Modelica.Blocks.Interfaces.RealOutput Vref annotation(
    Placement(visible = true, transformation(origin = {110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {111, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Qcom annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(Qt, add.u2) annotation(
    Line(points = {{-120, -60}, {-19, -60}}, color = {0, 0, 127}));
  connect(Vref, Q_ctrl.y) annotation(
    Line(points = {{110, -54}, {90, -54}}, color = {0, 0, 127}));
  connect(Qcom, add.u1) annotation(
    Line(points = {{-120, 0}, {-33, 0}, {-33, -48}, {-19, -48}}, color = {0, 0, 127}));
  connect(add.y, Q_ctrl.u) annotation(
    Line(points = {{4, -54}, {58, -54}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(lineThickness = 0.75, extent = {{-100, 100}, {100, -100}}), Text(origin = {-0.5, -5}, extent = {{-90.5, 65}, {90.5, -65}}, textString = "Plant
SRV")}),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.001));
end Plant_SVR;