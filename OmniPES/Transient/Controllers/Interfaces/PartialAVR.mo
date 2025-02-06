within OmniPES.Transient.Controllers.Interfaces;

partial model PartialAVR
  import Modelica.Blocks.Interfaces;
  Modelica.Blocks.Interfaces.RealInput Vctrl(unit="1") "voltage magnitude to be controlled" annotation(
    Placement(visible = true, transformation(origin = {-112, 60}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vsad(unit="1") "aditional stabilizing signal" annotation(
    Placement(visible = true, transformation(origin = {-112, -60}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.RealOutput Efd(start = 1.0, unit="1") "Field voltage" annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  initial equation
  assert(Efd > 0.1, "Problem in the field voltage initialization.")
  
  annotation(
    Icon(graphics = {Text(extent = {{-80, 60}, {80, -60}}, textString = "AVR"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end PartialAVR;