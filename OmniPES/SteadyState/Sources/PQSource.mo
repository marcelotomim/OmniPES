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
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "PQ", horizontalAlignment = TextAlignment.Left)}));
end PQSource;