within OmniPES.QuasiSteadyState.Examples.PSCC24.Controllers;

model Plant_SVR
  //
  import Modelica.Blocks.Types.Init;
  parameter Real kp = 0.005 "proportional gain";
  parameter Real ki = 0.05 "integral gain";
  parameter Init init;
  Modelica.Blocks.Continuous.PI Q_ctrl(T = kp/ki, k = kp, initType = init) annotation(
    Placement(visible = true, transformation(origin = {31, 0}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {-15, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Qg annotation(
    Placement(visible = true, transformation(origin = {-73, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Vref annotation(
    Placement(visible = true, transformation(origin = {79, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {111, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Qcom annotation(
    Placement(visible = true, transformation(origin = {-73, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(Vref, Q_ctrl.y) annotation(
    Line(points = {{79, 0}, {46, 0}}, color = {0, 0, 127}));
  connect(add.y, Q_ctrl.u) annotation(
    Line(points = {{-4, 0}, {14, 0}}, color = {0, 0, 127}));
  connect(Qcom, add.u1) annotation(
    Line(points = {{-73, 30}, {-50, 30}, {-50, 6}, {-27, 6}}, color = {0, 0, 127}));
  connect(Qg, add.u2) annotation(
    Line(points = {{-73, -30}, {-50, -30}, {-50, -6}, {-27, -6}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(lineThickness = 0.75, extent = {{-100, 100}, {100, -100}}), Text(origin = {-0.5, -5}, extent = {{-90.5, 65}, {90.5, -65}}, textString = "Plant
SRV")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.001));
end Plant_SVR;