within OmniPES.QuasiSteadyState.Controllers.Interfaces;

partial model PartialAVR
  import Modelica.Blocks.Interfaces;
  Interfaces.RealInput Vctrl annotation(
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.RealInput Vsad annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.RealOutput Efd(start = 2.0) annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  annotation(
    Icon(graphics = {Text(extent = {{-100, 60}, {100, -60}}, textString = "AVR"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end PartialAVR;