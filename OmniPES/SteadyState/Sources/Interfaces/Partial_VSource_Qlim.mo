within OmniPES.SteadyState.Sources.Interfaces;

partial model Partial_VSource_Qlim
  outer SystemData data;
  extends Icons.Vsource;
  extends Interfaces.Partial_Source;
  parameter Units.PerUnit Vsp = 1.0  "Specified Terminal Voltage";
  parameter Units.PerUnit Psp = 1.0  "Specified Active Power";
  parameter Units.ReactivePower Qmin = -1e5 "Minimum reactive power";
  parameter Units.ReactivePower Qmax = +1e5 "Maximum reactive power";
  parameter Units.PerUnit tolq = 1e-3 "Reactive power tolerance" annotation(Dialog(tab="Reactive limits parameters"));
  parameter Units.PerUnit tolv = 1e-3 "Voltage magnitude tolerance" annotation(Dialog(tab="Reactive limits parameters"));
  
  parameter Boolean useExternalPowerSpec = false  "Check to activate the external power specification" annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));
  
  parameter Boolean useExternalVoltageSpec = false  "Check to activate the external voltage specification" annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));

  Modelica.Blocks.Interfaces.RealInput dPsp if useExternalPowerSpec annotation(Placement(visible = useExternalPowerSpec, transformation(origin = {-70, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, -78}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));

  Modelica.Blocks.Interfaces.RealInput dVsp if useExternalVoltageSpec annotation(
    Placement(visible = useExternalVoltageSpec, transformation(origin = {-72, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {48, -78}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));

  Modelica.Blocks.Interfaces.RealOutput dpsp annotation(HideResult=true);
  Modelica.Blocks.Interfaces.RealOutput dvsp annotation(HideResult=true);

equation
  if useExternalPowerSpec then
    connect(dPsp, dpsp);
  else
    dpsp = 0;
  end if;
  if useExternalVoltageSpec then
    connect(dVsp, dvsp);
  else
    dvsp = 0;
  end if;
  
end Partial_VSource_Qlim;