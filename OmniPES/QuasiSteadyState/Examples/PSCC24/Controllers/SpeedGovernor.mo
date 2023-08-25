within OmniPES.QuasiSteadyState.Examples.PSCC24.Controllers;

  model SpeedGovernor
    extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialSpeedRegulator;
    parameter Real R = 0.04;
    parameter Modelica.Units.SI.Time Tg = 0.5;
  Modelica.Blocks.Sources.Constant wref(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-105, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k1 = -1)  annotation(
      Placement(visible = true, transformation(origin = {-54, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/R)  annotation(
      Placement(visible = true, transformation(origin = {-12, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
      Placement(visible = true, transformation(origin = {36, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = Tg, initType = Modelica.Blocks.Types.Init.SteadyState)  annotation(
      Placement(visible = true, transformation(origin = {74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant zero(k = 0.0) annotation(
      Placement(visible = true, transformation(origin = {-54, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator Pref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {-18, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(wctrl, add.u1) annotation(
      Line(points = {{-120, 60}, {-84, 60}, {-84, 0}, {-66, 0}}, color = {0, 0, 127}));
    connect(add1.u2, gain.y) annotation(
      Line(points = {{24, -6}, {-1, -6}}, color = {0, 0, 127}));
    connect(gain.u, add.y) annotation(
      Line(points = {{-24, -6}, {-43, -6}}, color = {0, 0, 127}));
    connect(add1.y, firstOrder.u) annotation(
      Line(points = {{47, 0}, {62, 0}}, color = {0, 0, 127}));
    connect(firstOrder.y, Pm) annotation(
      Line(points = {{85, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(add.u2, wref.y) annotation(
      Line(points = {{-66, -12}, {-94, -12}}, color = {0, 0, 127}));
  connect(Pref.y, add1.u1) annotation(
      Line(points = {{-6, 42}, {10, 42}, {10, 6}, {24, 6}}, color = {0, 0, 127}));
  connect(zero.y, Pref.u) annotation(
      Line(points = {{-43, 42}, {-30, 42}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
  end SpeedGovernor;