within OmniPES.SteadyState.Sources;

model Ctrl_PVSource_Qlim
  extends Interfaces.Partial_Source_Qlim(S(re(start = Psp/data.Sbase), im(start = 0)));

  parameter Units.ActivePower Psp "Specified Active Power";
  parameter Boolean useExternalPowerSpec = true  "Check to activate the external power specification" annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));
  parameter Boolean useExternalVoltageSpec = true  "Check to activate the external voltage specification" annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));
  Modelica.Blocks.Interfaces.RealInput dPsp if useExternalPowerSpec annotation(Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, -78}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput dVsp if useExternalVoltageSpec annotation(
    Placement(visible = true, transformation(origin = {-72, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {48, -78}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));

  Modelica.Blocks.Interfaces.RealOutput dpsp annotation(HideResult=true);
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
  S.re = (Psp + dpsp)/data.Sbase;
  annotation( Icon(graphics = {Text(origin = {30, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "V"),Text(origin = {-60, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "P"), Text(origin = {70, 54}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "PV\nQlim")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end Ctrl_PVSource_Qlim;