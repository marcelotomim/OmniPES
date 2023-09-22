within OmniPES.Transient.Controllers.Interfaces;

partial model PartialAVR
  import Modelica.Blocks.Interfaces;
  Modelica.Blocks.Interfaces.RealInput Vctrl annotation(
    Placement(visible = true, transformation(origin = {-112, 60}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vsad annotation(
    Placement(visible = true, transformation(origin = {-112, -60}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.RealOutput Efd(start = 2.0) annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    Icon(graphics = {Text(extent = {{-80, 60}, {80, -60}}, textString = "AVR"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end PartialAVR;