within OmniPES.Transient.FACTS;

model STATCOM_simple
  import Modelica.Units.SI;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.conj;
  extends OmniPES.Circuit.Interfaces.ShuntComponent;
  parameter SI.PerUnit k = 100 "controller gain";
  parameter SI.Time T = 0.1 "controller time constant";
  parameter SI.PerUnit imax = 1.2 "maximum injected current";
  parameter SI.PerUnit imin = -0.8 "minimum injected current";
  parameter Boolean external_reference = false annotation(choices(checkBox=true));
  parameter SI.PerUnit vref = 1.0 "constant voltage reference" annotation(Dialog(enable=not external_reference));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant const_vref(k = vref) if not external_reference annotation(
    Placement(transformation(origin = {-70, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput ext_ref if external_reference annotation(
    Placement(transformation(origin = {-78, 16}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {114, 0}, extent = {{18, -18}, {-18, 18}})));
  OmniPES.Transient.Controllers.Blocks.LagLimit simpleLagLim(k = k, T = T, ymax = imax, ymin = imin)  annotation(
    Placement(transformation(origin = {40, 60}, extent = {{-10, -10}, {10, 10}})));
  SI.ComplexPerUnit St;
  SI.PerUnit I, V;
equation
  I = simpleLagLim.y;
  V = abs(p.v);
  feedback.u2 = V;
  St = -p.v*conj(p.i);
  St.re = 0;
  St.im = V*I;
  connect(feedback.y, simpleLagLim.u) annotation(
    Line(points = {{9, 60}, {27, 60}}, color = {0, 0, 127}, thickness = 0.5));
  if external_reference then
     connect(ext_ref, feedback.u1) annotation(
    Line(points = {{-78, 16}, {-40, 16}, {-40, 60}, {-8, 60}}, color = {0, 0, 127}));
  else
    connect(const_vref.y, feedback.u1) annotation(
    Line(points = {{-58, 60}, {-8, 60}}, color = {0, 0, 127}));
  end if;
  annotation(
    Icon(graphics = {Rectangle(lineThickness = 0.5, extent = {{-100, 100}, {100, -100}}), Rectangle(origin = {-15, 0}, lineThickness = 0.5, extent = {{-50, 50}, {50, -50}}), Line(origin = {-15, 0}, points = {{-50, 50}, {50, -50}}, thickness = 0.5), Line(origin = {75, 4}, points = {{-15, 0}, {15, 0}, {15, 0}}, thickness = 0.5), Line(origin = {75, -4}, points = {{-15, 0}, {15, 0}, {15, 0}}, thickness = 0.5), Line(origin = {55, 19}, points = {{20, -15}, {20, 15}, {-20, 15}, {-20, 15}}, thickness = 0.5), Line(origin = {55, -20}, points = {{-20, -15}, {20, -15}, {20, 15}, {20, 15}}, thickness = 0.5), Line(origin = {-83.4629, 0}, points = {{-18, 0}, {18, 0}, {18, 0}}, thickness = 0.5), Line(origin = {-49.1125, -14.9974}, rotation = -90, points = {{-23, -2}, {-9, 8}, {9, -10}, {23, 2}, {23, 2}}, thickness = 0.5, smooth = Smooth.Bezier), Line(origin = {-38.3708, -14.9974}, rotation = -90, points = {{-23, -2}, {-9, 8}, {9, -10}, {23, 2}, {23, 2}}, thickness = 0.5, smooth = Smooth.Bezier), Line(origin = {6, 25}, rotation = 90, points = {{-15, 0}, {15, 0}, {15, 0}}, thickness = 0.5), Line(origin = {15, 25}, rotation = 90, points = {{-15, 0}, {15, 0}, {15, 0}}, thickness = 0.5)}),
  Diagram(graphics = {Text(origin = {0, 41}, extent = {{-18, 9}, {18, -9}}, textString = "terminal
voltage
magnitude"), Rectangle(origin = {0, 40}, lineThickness = 0.5, extent = {{-16, 10}, {16, -10}}), Text(origin = {74, 61}, extent = {{-18, 9}, {18, -9}}, textString = "injected
current
magnitude"), Rectangle(origin = {74, 60}, lineThickness = 0.5, extent = {{-16, 10}, {16, -10}}), Line(origin = {54, 60}, points = {{4, 0}, {-4, 0}, {-4, 0}, {-4, 0}}, thickness = 0.5)}),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end STATCOM_simple;