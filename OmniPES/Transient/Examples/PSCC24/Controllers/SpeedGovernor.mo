within OmniPES.Transient.Examples.PSCC24.Controllers;

  model SpeedGovernor
    extends OmniPES.Transient.Controllers.Interfaces.PartialSpeedRegulator;
    parameter Real R = 0.04;
    parameter Modelica.Units.SI.Time Tg = 0.5;
  Modelica.Blocks.Sources.Constant wref(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-90, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = -1)  annotation(
      Placement(visible = true, transformation(origin = {-39, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/R)  annotation(
      Placement(visible = true, transformation(origin = {-3, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
      Placement(visible = true, transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = Tg, initType = Modelica.Blocks.Types.Init.SteadyState)  annotation(
      Placement(visible = true, transformation(origin = {74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant zero(k = 0.0) annotation(
      Placement(visible = true, transformation(origin = {-30, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator Pref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {-1, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(wctrl, add.u1) annotation(
      Line(points = {{-120, 60}, {-71, 60}, {-71, 0}, {-51, 0}}, color = {0, 0, 127}));
    connect(add1.u2, gain.y) annotation(
      Line(points = {{24, -6}, {8, -6}}, color = {0, 0, 127}));
    connect(gain.u, add.y) annotation(
      Line(points = {{-15, -6}, {-28, -6}}, color = {0, 0, 127}));
    connect(add1.y, firstOrder.u) annotation(
      Line(points = {{47, 0}, {62, 0}}, color = {0, 0, 127}));
    connect(firstOrder.y, Pm) annotation(
      Line(points = {{85, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(add.u2, wref.y) annotation(
      Line(points = {{-51, -12}, {-79, -12}}, color = {0, 0, 127}));
  connect(Pref.y, add1.u1) annotation(
      Line(points = {{10, 42}, {15, 42}, {15, 6}, {24, 6}}, color = {0, 0, 127}));
  connect(zero.y, Pref.u) annotation(
      Line(points = {{-19, 42}, {-13, 42}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(origin = {-13, 42}, lineColor = {255, 0, 0}, lineThickness = 0.5, extent = {{-38, 23}, {38, -23}}), Text(origin = {-14, 77}, textColor = {255, 0, 0}, extent = {{-38, 14}, {39, -13}}, textString = "Unknown
Reference 
Value")}));
  end SpeedGovernor;