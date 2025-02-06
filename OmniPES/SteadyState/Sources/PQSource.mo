within OmniPES.SteadyState.Sources;

model PQSource
  import Modelica.Units.SI;
  extends Interfaces.Partial_Source;
  parameter SI.ActivePower Psp(displayUnit="MW") "specified active power";
  parameter SI.ReactivePower Qsp(displayUnit="Mvar") "specified reactive power";
equation
  S.re = Psp/data.Sbase;
  S.im = Qsp/data.Sbase;
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {1, 77}, extent = {{-97, 19}, {97, -19}}, textString = "PQ", fontSize = 8, horizontalAlignment = TextAlignment.Left)}));
end PQSource;