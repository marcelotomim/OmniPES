within OmniPES;

model SystemData
  import Modelica.Units.SI;
  import Modelica.Constants.pi;
  parameter Units.ApparentPower Sbase = 100 annotation(
    Dialog(group = "Base Quantities"));
  parameter SI.Frequency fb = 60 annotation(
    Dialog(group = "Base Quantities"));
  final parameter SI.AngularVelocity wb = 2*pi*fb;
  annotation(
    singleInstance = true,
    defaultComponentName = "data",
    defaultComponentPrefixes = "inner",
    missingInnerMessage = "The System object is missing, please drag it on the top layer of your model",
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 70}, {80, -70}}), Text(extent = {{-60, 40}, {60, -40}}, textString = "System
%Sbase
%fb")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
  Documentation(info = "<html>
  
  <head></head>
  
  <body>
    <h1>SystemData Model</h1>
    <div>The SystemData model contains base values used for the transmission network. The transmission network comprises
      all passive elements, including transmission lines and other concentrated elements such as reactors and capacitor
      banks.</div>
    <div><br></div>
    <div>All per-unit quantities are modeled with respect to the values defined within this model as base values.</div>
    <br>
  </body>
  
  </html>"));
end SystemData;