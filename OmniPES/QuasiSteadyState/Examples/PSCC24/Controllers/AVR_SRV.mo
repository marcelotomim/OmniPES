within OmniPES.QuasiSteadyState.Examples.PSCC24.Controllers;

model AVR_SRV
  extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
  parameter Real ka = 100;
  parameter Modelica.Units.SI.Time T = 0.05;
  parameter OmniPES.Units.PerUnit Efd_max = 7.0;
  parameter OmniPES.Units.PerUnit Efd_min = -7.0;
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(initType = Modelica.Blocks.Types.Init.SteadyState, k = ka/T, outMax = Efd_max, outMin = Efd_min, y_start = 2) annotation(
    Placement(visible = true, transformation(origin = {12, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 1/ka) annotation(
    Placement(visible = true, transformation(origin = {10, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Blocks.Math.Sum sum1(k = {-1, 1, -1, 1}, nin = 4) annotation(
    Placement(visible = true, transformation(origin = {-46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vext annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
 equation
  connect(limIntegrator.y, Efd) annotation(
    Line(points = {{23, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(gain.u, limIntegrator.y) annotation(
    Line(points = {{22, -52}, {54, -52}, {54, 0}, {23, 0}}, color = {0, 0, 127}));
  connect(sum1.y, limIntegrator.u) annotation(
    Line(points = {{-34, 0}, {0, 0}}, color = {0, 0, 127}));
  connect(Vctrl, sum1.u[1]) annotation(
    Line(points = {{-112, 60}, {-82, 60}, {-82, 0}, {-58, 0}}, color = {0, 0, 127}));
  connect(gain.y, sum1.u[3]) annotation(
    Line(points = {{0, -52}, {-68, -52}, {-68, 0}, {-58, 0}}, color = {0, 0, 127}));
  connect(Vsad, sum1.u[2]) annotation(
    Line(points = {{-112, -60}, {-82, -60}, {-82, 0}, {-58, 0}}, color = {0, 0, 127}));
  connect(Vext, sum1.u[4]) annotation(
    Line(points = {{-120, 0}, {-58, 0}}, color = {0, 0, 127}));
  annotation(
    Icon(coordinateSystem(extent = {{-120, 100}, {120, -120}}), graphics = {Text(origin = {0, -60}, extent = {{-80, 20}, {80, -20}}, textString = "SVR")}));
end AVR_SRV;