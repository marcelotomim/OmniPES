within OmniPES.SteadyState.Loads.Interfaces;

model Partial_Load
  outer SystemData data;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import Abs=Modelica.ComplexMath.abs;
  parameter Units.ActivePower Psp "Specified active power";
  parameter Units.ReactivePower Qsp "Specified reactive power";
  Units.CPerUnit S "Load complex power";
  Units.PerUnit V(start = 1) "Terminal voltage magnitude";

  Modelica.Blocks.Interfaces.RealInput dPsp if useExternalPsp  annotation(
    Placement(visible = useExternalPsp, transformation(origin = {-70, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, -72}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput dQsp if useExternalQsp annotation(
    Placement(visible = useExternalQsp, transformation(origin = {-70, 76}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {40, -72}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  parameter Boolean useExternalPsp = false annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));
  parameter Boolean useExternalQsp = false annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));
  Modelica.Blocks.Interfaces.RealOutput dpsp, dqsp;
equation
  S = v*conj(i);
  V = Abs(v);
  
  if useExternalPsp then
    connect(dPsp, dpsp);
  else
    dpsp = 0;
  end if;
  if useExternalQsp then
    connect(dQsp, dqsp);
  else
    dqsp = 0;
  end if;
annotation(
    Icon(graphics = {Text(origin = {1, 2.84217e-14}, extent = {{-55, 40}, {55, -40}}, textString = "%name"), Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}));
end Partial_Load;