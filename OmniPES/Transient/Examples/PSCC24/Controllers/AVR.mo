within OmniPES.Transient.Examples.PSCC24.Controllers;

model AVR
    extends OmniPES.Transient.Controllers.Interfaces.PartialAVR;
    parameter Real ka = 100;
    parameter Modelica.Units.SI.Time T = 0.05;
    parameter Modelica.Units.SI.PerUnit Efd_max = 7.0;
    parameter Modelica.Units.SI.PerUnit Efd_min = -7.0;
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(initType = Modelica.Blocks.Types.Init.SteadyState, k = ka/T, outMax = Efd_max, outMin = Efd_min)  annotation(
      Placement(visible = true, transformation(origin = {10, 0}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/ka)  annotation(
      Placement(visible = true, transformation(origin = {0, -51}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Sources.Constant zero(k = 0.0) annotation(
      Placement(visible = true, transformation(origin = {-134, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {-103, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sum sum1(k = {-1, 1, 1, -1}, nin = 4)  annotation(
      Placement(visible = true, transformation(origin = {-35, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(limIntegrator.y, Efd) annotation(
      Line(points = {{25, 0}, {110, 0}}, color = {0, 0, 127}));
    connect(gain.u, limIntegrator.y) annotation(
      Line(points = {{12, -51}, {61, -51}, {61, 0}, {25, 0}}, color = {0, 0, 127}));
    connect(zero.y, Vref.u) annotation(
      Line(points = {{-123, 0}, {-115, 0}}, color = {0, 0, 127}));
  connect(sum1.y, limIntegrator.u) annotation(
      Line(points = {{-24, 0}, {-7, 0}}, color = {0, 0, 127}));
  connect(Vctrl, sum1.u[1]) annotation(
      Line(points = {{-112, 60}, {-82, 60}, {-82, 0}, {-47, 0}}, color = {0, 0, 127}));
  connect(Vref.y, sum1.u[2]) annotation(
      Line(points = {{-92, 0}, {-47, 0}}, color = {0, 0, 127}));
  connect(Vsad, sum1.u[3]) annotation(
      Line(points = {{-112, -60}, {-82, -60}, {-82, 0}, {-47, 0}}, color = {0, 0, 127}));
  connect(gain.y, sum1.u[4]) annotation(
      Line(points = {{-11, -51}, {-70, -51}, {-70, 0}, {-47, 0}}, color = {0, 0, 127}));
    annotation(
      Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Rectangle(origin = {-119, 0}, lineColor = {255, 0, 0}, lineThickness = 0.5, extent = {{-33, 22}, {33, -22}}), Text(origin = {-116, 34}, textColor = {255, 0, 0}, extent = {{-38, 14}, {39, -13}}, textString = "Unknown
Reference 
Value")}));
  end AVR;