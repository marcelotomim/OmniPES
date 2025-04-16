within OmniPES.Transient.Controllers.Interfaces;

partial model PartialSpeedRegulator
  import Modelica.Blocks.Interfaces;
  Interfaces.RealInput wctrl(unit = "1") "speed signal to be controlled" annotation(
    Placement(transformation(origin = {-210, 90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.RealOutput Pm(unit = "1") "mechanical developed power" annotation(
    Placement(transformation(origin = {210, 90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  SignalBus signalBus annotation(
    Placement(transformation(origin = {-210, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 110}, extent = {{-20, -20}, {20, 20}})));
  annotation(
    Icon(graphics = {Text(extent = {{-80, 60}, {80, -60}}, textString = "SR"), Rectangle(extent = {{-100, 100}, {100, -100}})}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end PartialSpeedRegulator;