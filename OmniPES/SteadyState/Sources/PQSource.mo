within OmniPES.SteadyState.Sources;

model PQSource
  extends Interfaces.Partial_Source;
  parameter Units.ActivePower Psp;
  parameter Units.ReactivePower Qsp;
equation
  S.re = Psp/data.Sbase;
  S.im = Qsp/data.Sbase;
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {70, 55}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "PQ")}));
end PQSource;