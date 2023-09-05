within OmniPES.QuasiSteadyState.Controllers.Interfaces;

partial model PartialSpeedRegulator
  import Modelica.Blocks.Interfaces;
  Interfaces.RealInput wctrl annotation(
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.RealOutput Pm annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    Icon(graphics = {Text(extent = {{-80, 60}, {80, -60}}, textString = "SR"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end PartialSpeedRegulator;