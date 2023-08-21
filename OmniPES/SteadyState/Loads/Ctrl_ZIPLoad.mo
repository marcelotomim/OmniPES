within OmniPES.SteadyState.Loads;

model Ctrl_ZIPLoad
  extends Interfaces.Partial_ZIPLoad;
  Modelica.Blocks.Interfaces.RealInput DPsp if useExternalPsp  annotation(
    Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, -72}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput DQsp if useExternalQsp annotation(
    Placement(visible = true, transformation(origin = {-70, 76}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {40, -72}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  parameter Boolean useExternalPsp = false annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useExternalQsp = false annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
equation
  dp = if useExternalPsp then DPsp else 0;
  dq = if useExternalQsp then DQsp else 0;
  annotation(
    Icon(graphics = {Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}, coordinateSystem(extent = {{-100, -100}, {100, 80}})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-6, Interval = 1));
end Ctrl_ZIPLoad;