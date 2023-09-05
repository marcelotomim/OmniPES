within OmniPES.QuasiSteadyState.Examples.PSCC24.Controllers;

model Central_SVR
  Modelica.Blocks.Continuous.PI pilot_ctrl(T = kp/ki, initType = Modelica.Blocks.Types.Init.SteadyState, k = kp) annotation(
    Placement(visible = true, transformation(origin = {62, -38}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {10, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vpilot annotation(
    Placement(visible = true, transformation(origin = {-80.5, -59.5}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Real kp = 0.005 "proportional gain";
  parameter Real ki = 0.05 "integral gain";
  parameter Real K = 1/3 "reactive power sharing coefficients";
  Modelica.Blocks.Interfaces.RealOutput Vref annotation(
    Placement(visible = true, transformation(origin = {110, -38}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant ref(k = 1) annotation(
    Placement(visible = true, transformation(origin = {-80, -21}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealVectorInput Qin[2] annotation(
    Placement(visible = true, transformation(origin = {-90, 32}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Qout[2](start={K,1}) annotation(
    Placement(visible = true, transformation(origin = {110, 32}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(nin = 2) annotation(
    Placement(visible = true, transformation(origin = {-60, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k =  1/(K + 1))  annotation(
    Placement(visible = true, transformation(origin = {-5, 32}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {51, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Vpilot, add.u2) annotation(
    Line(points = {{-80.5, -59.5}, {-37, -59.5}, {-37, -44}, {-2, -44}}, color = {0, 0, 127}));
  connect(Vref, pilot_ctrl.y) annotation(
    Line(points = {{110, -38}, {77, -38}}, color = {0, 0, 127}));
  connect(ref.y, add.u1) annotation(
    Line(points = {{-69, -21}, {-36, -21}, {-36, -32}, {-2, -32}}, color = {0, 0, 127}));
  connect(add.y, pilot_ctrl.u) annotation(
    Line(points = {{21, -38}, {45, -38}}, color = {0, 0, 127}));
  connect(Qin, sum1.u) annotation(
    Line(points = {{-90, 32}, {-88.5, 32}, {-88.5, 31.5}, {-69, 31.5}}, color = {0, 0, 127}, thickness = 0.5));
  connect(sum1.y, gain.u) annotation(
    Line(points = {{-49, 32}, {-23, 32}}, color = {0, 0, 127}));
  connect(gain.y, Qout[2]) annotation(
    Line(points = {{12, 32}, {110, 32}}, color = {0, 0, 127}));
  connect(add1.u1, sum1.y) annotation(
    Line(points = {{39, 60}, {-34, 60}, {-34, 32}, {-49, 32}}, color = {0, 0, 127}));
  connect(add1.u2, gain.y) annotation(
    Line(points = {{39, 48}, {14, 48}, {14, 32}, {12, 32}}, color = {0, 0, 127}));
  connect(add1.y, Qout[1]) annotation(
    Line(points = {{62, 54}, {76, 54}, {76, 32}, {110, 32}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(lineThickness = 0.75, extent = {{-100, 100}, {100, -100}}), Text(origin = {-0.5, -5}, extent = {{-90.5, 65}, {90.5, -65}}, textString = "Central
SRV")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end Central_SVR;