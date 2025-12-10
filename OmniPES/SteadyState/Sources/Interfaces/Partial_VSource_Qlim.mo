within OmniPES.SteadyState.Sources.Interfaces;

partial model Partial_VSource_Qlim
  outer SystemData data;
  extends Icons.Vsource;
  extends Interfaces.Partial_Source;
  import Modelica.Units.SI;
  parameter SI.PerUnit Vsp = 1.0  "Specified Terminal Voltage";
  parameter SI.ActivePower Psp(displayUnit="MW") = 0.0  "Specified Active Power";
  parameter SI.ReactivePower Qmin(displayUnit="Mvar") = -1e12 "Minimum reactive power";
  parameter SI.ReactivePower Qmax(displayUnit="Mvar") = +1e12 "Maximum reactive power";
  
  parameter Boolean useExternalPowerSpec = false  "Check to activate the external power specification" annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));
  
  parameter Boolean useExternalVoltageSpec = false  "Check to activate the external voltage specification" annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));

  Modelica.Blocks.Interfaces.RealInput dPsp if useExternalPowerSpec annotation(Placement(visible = useExternalPowerSpec, transformation(origin = {-70, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {68, 36}, extent = {{-12, -12}, {12, 12}}, rotation = 180)), Icon(graphics={Text(textString="P")}));

  Modelica.Blocks.Interfaces.RealInput dVsp if useExternalVoltageSpec annotation(
    Placement(visible = useExternalVoltageSpec, transformation(origin = {-70, -40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {68, -36}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));

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
  
annotation(
    Icon(graphics = {Text(visible = useExternalPowerSpec, origin = {68, 62}, extent = {{-12, 14}, {12, -14}}, textString = "P"), Text(visible = useExternalVoltageSpec, origin = {68, -60}, extent = {{-12, 14}, {12, -14}}, textString = "V")}),
    Documentation(info="<html><body>TODO</body></html>"));
end Partial_VSource_Qlim;