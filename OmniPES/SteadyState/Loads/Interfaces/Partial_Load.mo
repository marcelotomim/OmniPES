within OmniPES.SteadyState.Loads.Interfaces;

model Partial_Load
  outer SystemData data;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.Units.SI;
  import Modelica.ComplexMath.conj;
  import Abs=Modelica.ComplexMath.abs;
  parameter SI.ActivePower Psp(displayUnit="MW") "Specified active power";
  parameter SI.ReactivePower Qsp(displayUnit="Mvar") "Specified reactive power";
  SI.ComplexPerUnit S "Load complex power";
  SI.PerUnit V(start = 1) "Terminal voltage magnitude";

  Modelica.Blocks.Interfaces.RealInput dPsp if useExternalPsp  annotation(
    Placement(visible = useExternalPsp, transformation(origin = {-60, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-40, -72}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput dQsp if useExternalQsp annotation(
    Placement(visible = useExternalQsp, transformation(origin = {-60, -40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {40, -72}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
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
    Icon(graphics = {Text( origin = {101, -1}, rotation = 90, extent = {{-150, 50}, {150, -50}}, textString = "%Psp
%Qsp"), Polygon( fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, lineThickness = 0.5, points = {{-20, -20}, {-20, 20}, {20, 0}, {-20, -20}}), Text(visible = useExternalPsp, origin = {-77, -72}, rotation = 90, extent = {{-15, 15}, {15, -15}}, textString = "P", horizontalAlignment = TextAlignment.Left), Text(visible = useExternalQsp, origin = {10, -72}, rotation = 90, extent = {{-15, 15}, {15, -15}}, textString = "Q", horizontalAlignment = TextAlignment.Left), Line(origin = {-60, 0.5}, points = {{-40, 0}, {40, 0}}, thickness = 0.5)}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html><body>TODO</body></html>"));
end Partial_Load;