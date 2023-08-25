within OmniPES.SteadyState.Examples.PSCC24.Controllers;

model Central_SVR
  Modelica.Blocks.Continuous.PI pilot_ctrl(T = kp/ki, initType = Modelica.Blocks.Types.Init.SteadyState, k = kp, x_start = 1, y(fixed = true, start = 0)) annotation(
    Placement(visible = true, transformation(origin = {76, -54}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {10, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vpilot annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Real kp = 0.005 "proportional gain";
  parameter Real ki = 0.05 "integral gain";
  parameter Integer ng = 2 "number of generators";
  parameter Real K[ng] = {1/4, 3/4} "column vector with reactive power sharing coefficients";
  Modelica.Blocks.Interfaces.RealOutput Vref annotation(
    Placement(visible = true, transformation(origin = {110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant zero(k = 0.0) annotation(
    Placement(visible = true, transformation(origin = {-110, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput Qin[ng] annotation(
    Placement(visible = true, transformation(origin = {-111, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Qout[ng] annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Units.PerUnit Qtotal;
  Modelica.Blocks.Continuous.Integrator SVR_ref(initType = Modelica.Blocks.Types.Init.NoInit, k = 1, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-69, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {-31, -21}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = -0.1, startTime = 2500)  annotation(
    Placement(visible = true, transformation(origin = {-99, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  Qtotal = sum(Qin);
  Qout = K*Qtotal;
  connect(Vpilot, add.u2) annotation(
    Line(points = {{-120, -60}, {-2, -60}}, color = {0, 0, 127}));
  connect(Vref, pilot_ctrl.y) annotation(
    Line(points = {{110, -54}, {91, -54}}, color = {0, 0, 127}));
  connect(pilot_ctrl.u, add.y) annotation(
    Line(points = {{59, -54}, {21, -54}}, color = {0, 0, 127}));
  connect(zero.y, SVR_ref.u) annotation(
    Line(points = {{-99, -26}, {-81, -26}}, color = {0, 0, 127}));
  connect(SVR_ref.y, add1.u2) annotation(
    Line(points = {{-58, -26}, {-43, -26}, {-43, -27}}, color = {0, 0, 127}));
  connect(add1.y, add.u1) annotation(
    Line(points = {{-20, -21}, {-14, -21}, {-14, -48}, {-2, -48}}, color = {0, 0, 127}));
  connect(step.y, add1.u1) annotation(
    Line(points = {{-88, 12}, {-54, 12}, {-54, -15}, {-43, -15}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(lineThickness = 0.75, extent = {{-100, 100}, {100, -100}}), Text(origin = {-0.5, -5}, extent = {{-90.5, 65}, {90.5, -65}}, textString = "Central
SRV")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end Central_SVR;