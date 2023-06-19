within OmniPES;

model SystemData
  import Modelica.Units.SI;
  import Modelica.Constants.pi;
  parameter Units.ApparentPower Sbase = 100 annotation(
    Dialog(group = "Base Quantities"));
  parameter SI.Frequency fb = 60 annotation(
    Dialog(group = "Base Quantities"));
  parameter SI.AngularVelocity wb = 2*pi*fb;
  annotation(
    defaultComponentName = "data",
    defaultComponentPrefixes = "inner",
    missingInnerMessage = "The System object is missing, please drag it on the top layer of your model",
    Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 70}, {80, -70}}), Text(extent = {{-60, 40}, {60, -40}}, textString = "System")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end SystemData;