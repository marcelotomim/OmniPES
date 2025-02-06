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
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {1, 77}, extent = {{-97, 19}, {97, -19}}, textString = "PV", fontSize = 8, horizontalAlignment = TextAlignment.Left)}));
end PVSource;