within OmniPES.QuasiSteadyState.Examples.PSCC24.Controllers;

model Central_SVR
  Modelica.Blocks.Continuous.PI pilot_ctrl(T = kp/ki, initType = Modelica.Blocks.Types.Init.SteadyState, k = kp) annotation(
    Placement(visible = true, transformation(origin = {76, -54}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {10, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vpilot annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Real kp = 0.005 "proportional gain";
  parameter Real ki = 0.05 "integral gain";
  parameter Real K = 1/3 "reactive power sharing coefficients";
  parameter Real Qmax[2] = {0.26, 0.78};
  Modelica.Blocks.Interfaces.RealOutput Vref annotation(
    Placement(visible = true, transformation(origin = {110, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant ref(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-79, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput Qin[2] annotation(
    Placement(visible = true, transformation(origin = {-111, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Qout[2](start={K,1}) annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

  Qout[1] = K*Qout[2];
  sum(Qin) - sum(Qout) = 0;
  
  connect(Vpilot, add.u2) annotation(
    Line(points = {{-120, -60}, {-2, -60}}, color = {0, 0, 127}));
  connect(Vref, pilot_ctrl.y) annotation(
    Line(points = {{110, -54}, {91, -54}}, color = {0, 0, 127}));
  connect(ref.y, add.u1) annotation(
    Line(points = {{-68, -24}, {-36, -24}, {-36, -48}, {-2, -48}}, color = {0, 0, 127}));
  connect(add.y, pilot_ctrl.u) annotation(
    Line(points = {{21, -54}, {59, -54}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(lineThickness = 0.75, extent = {{-100, 100}, {100, -100}}), Text(origin = {-0.5, -5}, extent = {{-90.5, 65}, {90.5, -65}}, textString = "Central
SRV")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end Central_SVR;