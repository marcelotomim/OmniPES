within OmniPES.SteadyState.Sources;

model PVSource
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  outer SystemData data;
  parameter Units.ActivePower Psp;
  parameter Units.PerUnit Vsp = 1.0;
  Units.CPerUnit S;
equation
  S = -v*conj(i);
  S.re = Psp/data.Sbase;
  Vsp = abs(p.v);
  annotation(
    Icon(graphics = {Text(origin = {70, 55}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "PV")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end PVSource;