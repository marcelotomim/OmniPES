within OmniPES.SteadyState.Sources;

model Ctrl_VTHSource_Qlim
    extends Interfaces.Partial_Source_Qlim;
    import Modelica.ComplexMath.arg;
    import Modelica.ComplexMath.abs;
    parameter Modelica.Units.NonSI.Angle_deg angle = 0.0 "Reference angle";
    parameter Boolean useExternalVoltageSpec = true  "Check to activate the external voltage specification" annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));
  Modelica.Blocks.Interfaces.RealInput dVsp if useExternalVoltageSpec annotation(
    Placement(visible = true, transformation(origin = {-72, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {48, -78}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
equation
if useExternalVoltageSpec then
    connect(dVsp, dvsp);
  else
    dvsp = 0;
  end if;
    arg(p.v) = angle;
    annotation( Icon(graphics = {Text(origin = {30, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "V"), Text(origin = {70, 54}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "VTH\nQlim")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end Ctrl_VTHSource_Qlim;