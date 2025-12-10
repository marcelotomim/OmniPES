within OmniPES.Transient.SynchronousMachines.Interfaces;

model Inertia
  import Modelica.Units.SI;
  import Modelica.Constants;
  import Modelica.Blocks.Interfaces;
  outer SystemData data;
  parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData smData "Record with machine parameters in the system base" annotation(
    Placement(visible = true, transformation(origin = {-66, 76}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pm(unit = "1") "mechanical developed power" annotation(
    Placement(visible = true, transformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pe(unit = "1") "electrical converted power" annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput delta(start = 0, unit = "rad", displayUnit = "deg") "load angle" annotation(
    Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega(start = 1.0, unit = "pu") "normalized speed" annotation(
    Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
initial equation
  der(omega) = 0.0;
  der(delta) = 0.0;
equation
  2*smData.H*der(omega) = Pm - Pe - smData.D*(omega - 1.0);
  der(delta) = data.wb*(omega - 1);
  annotation(
    Icon(graphics = {Text( extent = {{-80, 60}, {80, -60}}, textString = "Inertia"), Rectangle(fillColor = {85, 87, 83}, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Inertia;