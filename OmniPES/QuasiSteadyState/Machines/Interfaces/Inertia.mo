within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Inertia
  import Modelica.Units.SI;
  import Modelica.Constants;
  Modelica.Blocks.Interfaces.RealInput Pm(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pe(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput delta(start = 0, unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {110, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {112, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput omega(start = 1.0, unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {112, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //        protected
  outer OmniPES.SystemData data;
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {-78, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Modelica.Units.SI.Time H = smData.convData.H;
  parameter OmniPES.Units.PerUnit D = smData.convData.D;
initial equation
  der(omega) = 0.0;
  der(delta) = 0.0;
equation
  2*H*der(omega) = Pm - Pe - (if D > 0 then D*(omega - 1.0) else 0);
  der(delta) = data.wb*(omega - 1);
  annotation(
    Icon(graphics = {Text(origin = {-9, 0}, extent = {{-91, 80}, {109, -72}}, textString = "Inertia"), Rectangle(fillColor = {85, 87, 83}, lineThickness = 0.5, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(initialScale = 0.1)));
end Inertia;