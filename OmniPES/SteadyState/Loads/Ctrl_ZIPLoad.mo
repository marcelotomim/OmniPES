within OmniPES.SteadyState.Loads;

model Ctrl_ZIPLoad
  extends Interfaces.Partial_ZIPLoad;
  Modelica.Blocks.Interfaces.RealInput dPsp if useExternalPsp  annotation(
    Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, -72}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput dQsp if useExternalQsp annotation(
    Placement(visible = true, transformation(origin = {-70, 76}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {40, -72}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  parameter Boolean useExternalPsp = true annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useExternalQsp = true annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
equation
if useExternalPsp then
  connect(dPsp, dp);
else
  dp = 0;
end if;
if useExternalQsp then
  connect(dQsp, dq);
else
  dq = 0;
end if;
  annotation(
    Icon(graphics = {Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}, coordinateSystem(extent = {{-100, -100}, {100, 80}})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-6, Interval = 1));
end Ctrl_ZIPLoad;