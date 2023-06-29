within OmniPES.Circuit.Sources;

model CurrentSource
  extends Circuit.Interfaces.ShuntComponent;
  import OmniPES.Math.polar2cart;
  import Modelica.Units.NonSI;
  parameter Units.PerUnit magnitude = 0.0;
  parameter NonSI.Angle_deg angle = 0.0;
equation
  i = -polar2cart(magnitude, angle);
  annotation(
    Icon(graphics = {Ellipse(origin = {6, 1}, extent = {{-66, 67}, {66, -67}}, endAngle = 360), Line(origin = {-73, 0}, points = {{-13, 0}, {13, 0}}), Line(origin = {-18.0759, 0}, points = {{75.235, 0}, {11.235, 0}, {11.235, 20}, {-20.765, 0}, {11.235, -20}, {11.235, 0}}), Line(origin = {93, 0}, points = {{-21, 0}, {21, 0}}), Line(origin = {114, -1}, points = {{0, 35}, {0, -35}}), Line(origin = {130, -1}, points = {{0, 21}, {0, -19}}), Line(origin = {144, -1}, points = {{0, 9}, {0, -5}})}, coordinateSystem(initialScale = 0.1)));
end CurrentSource;