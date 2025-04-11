within OmniPES.Transient.Controllers.Interfaces;

partial model PartialPSS
  import Modelica.Blocks.Interfaces;
  Interfaces.RealOutput Vsad(unit="1") "stabilizing signal" annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SignalBus signalBus annotation(
    Placement(transformation(origin = {-124, 71}, extent = {{-18, -15}, {18, 15}}), iconTransformation(origin = {-111, 0}, extent = {{-19, -20}, {19, 20}}, rotation = 90)));
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text( extent = {{-80, 60}, {80, -60}}, textString = "PSS")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end PartialPSS;