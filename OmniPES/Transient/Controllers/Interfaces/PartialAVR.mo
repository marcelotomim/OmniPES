within OmniPES.Transient.Controllers.Interfaces;

partial model PartialAVR
  import Modelica.Blocks.Interfaces;
  Modelica.Blocks.Interfaces.RealInput Vctrl(unit = "1") "voltage magnitude to be controlled" annotation(
    Placement(transformation(origin = {-210, 90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput Vsad(unit = "1") "aditional stabilizing signal" annotation(
    Placement(transformation(origin = {-210, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.RealOutput Efd(start = 1.0, unit = "1") "Field voltage" annotation(
    Placement(transformation(origin = {210, 89}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  SignalBus signalBus annotation(
    Placement(transformation(origin = {-210, 50}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 110}, extent = {{-20, -20}, {20, 20}})));
initial equation
  assert(Efd > 0.1, "Problem in the field voltage initialization.") annotation(
    Icon(graphics = {Text(extent = {{-80, 60}, {80, -60}}, textString = "AVR"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(extent = {{-80, 60}, {80, -60}}, textString = "AVR")}));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end PartialAVR;