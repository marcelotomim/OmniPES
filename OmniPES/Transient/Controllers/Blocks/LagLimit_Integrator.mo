within OmniPES.Transient.Controllers.Blocks;

model LagLimit_Integrator
  extends Modelica.Blocks.Interfaces.SISO(y(start=1));
  import Modelica.Units.SI;
  parameter SI.PerUnit k "constant gain";
  parameter SI.Time T "time constant";
  parameter SI.PerUnit ymax "maximum limit";
  parameter SI.PerUnit ymin "minimum limit";
 Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(transformation(origin = {-24, 0}, extent = {{-10, -10}, {10, 10}})));
 Modelica.Blocks.Math.Gain gain(k = k)  annotation(
    Placement(transformation(origin = {-64, 0}, extent = {{-10, -10}, {10, 10}})));
 IntegratorLimit integratorLimit(k = 1/T, ymax = ymax, ymin = ymin)  annotation(
    Placement(transformation(origin = {44, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(u, gain.u) annotation(
    Line(points = {{-120, 0}, {-76, 0}}, color = {0, 0, 127}));
  connect(gain.y, feedback.u1) annotation(
    Line(points = {{-52, 0}, {-32, 0}}, color = {0, 0, 127}));
 connect(feedback.y, integratorLimit.u) annotation(
    Line(points = {{-14, 0}, {32, 0}}, color = {0, 0, 127}));
 connect(integratorLimit.y, y) annotation(
    Line(points = {{56, 0}, {110, 0}}, color = {0, 0, 127}));
 connect(feedback.u2, integratorLimit.y) annotation(
    Line(points = {{-24, -8}, {-24, -40}, {80, -40}, {80, 0}, {56, 0}}, color = {0, 0, 127}));
  annotation(
    Diagram,
  Icon(graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid,lineThickness = 0.5, extent = {{-98, 98}, {98, -98}}), Line(origin = {1, 1}, points = {{-85, 1}, {85, 1}}, thickness = 0.5), Text(origin = {0, 50}, extent = {{-100, 40}, {100, -40}}, textString = "k"), Text(origin = {0, -50}, extent = {{-100, 40}, {100, -40}}, textString = "1+sT"), Line(origin = {32.21, -9}, points = {{-160, -110}, {-100, -110}, {60, 130}, {100, 130}}, thickness = 0.5)}));
 end LagLimit_Integrator;