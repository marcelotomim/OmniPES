within OmniPES.SteadyState.Sources;

model PVSource
  extends Interfaces.Partial_Source;
  import Modelica.Units.SI;
  import Abs = Modelica.ComplexMath.abs;
  parameter SI.ActivePower Psp(displayUnit = "MW") "specified active power";
  parameter SI.PerUnit Vsp = 1.0 "specified voltage magnitude";
equation
  S.re = Psp/data.Sbase;
  Vsp = V;
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "PV", horizontalAlignment = TextAlignment.Left)}));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end PVSource;