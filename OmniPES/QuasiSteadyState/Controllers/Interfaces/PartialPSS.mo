within OmniPES.QuasiSteadyState.Controllers.Interfaces;

partial model PartialPSS
  import Modelica.Blocks.Interfaces;
  Interfaces.RealInput omega annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.RealOutput Vsad annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text( extent = {{-80, 60}, {80, -60}}, textString = "PSS")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end PartialPSS;