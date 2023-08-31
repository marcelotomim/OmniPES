within OmniPES.SteadyState.Sources;

model PQSource
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  outer SystemData data;
  parameter Units.ActivePower P;
  parameter Units.ReactivePower Q;
  Units.CPerUnit S;
equation
  S = -v*conj(i);
  S.re = P/data.Sbase;
  S.im = Q/data.Sbase;
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {70, 55}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "PQ")}));
end PQSource;