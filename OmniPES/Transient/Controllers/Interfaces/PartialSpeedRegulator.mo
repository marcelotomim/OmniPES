within OmniPES.Transient.Controllers.Interfaces;

partial model PartialSpeedRegulator
  import Modelica.Blocks.Interfaces;
  Interfaces.RealOutput Pm(unit="1") "mechanical developed power" annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SignalBus signalBus annotation(
    Placement(transformation(origin = {-89, 93}, extent = {{-19, -17}, {19, 17}}), iconTransformation(origin = {-110, 0}, extent = {{-24, -20}, {24, 20}}, rotation = 90)));
  annotation(
    Icon(graphics = {Text(extent = {{-80, 60}, {80, -60}}, textString = "SR"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end PartialSpeedRegulator;