within OmniPES.Transient.Controllers.Interfaces;

partial model PartialPSS
  import Modelica.Blocks.Interfaces;
  Interfaces.RealInput omega(unit = "1") "speed signal" annotation(
    Placement(transformation(origin = {-210, 90}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}})));
  Interfaces.RealOutput Vsad(unit = "1") "stabilizing signal" annotation(
    Placement(transformation(origin = {210, 89}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  SignalBus signalBus annotation(
    Placement(transformation(origin = {-210, 70}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 110}, extent = {{-20, -20}, {20, 20}})));
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(extent = {{-80, 60}, {80, -60}}, textString = "PSS")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Documentation(info="<html><body>TODO</body></html>"));
end PartialPSS;