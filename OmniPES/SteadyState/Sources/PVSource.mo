within OmniPES.SteadyState.Sources;

model PVSource
  extends Interfaces.Partial_Source;
  import Abs=Modelica.ComplexMath.abs;
  parameter Units.ActivePower Psp;
  parameter Modelica.Units.SI.PerUnit Vsp = 1.0;
equation
  S.re = Psp/data.Sbase;
  Vsp = V;
  annotation(
    Icon(graphics = {Text(origin = {70, 55}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "PV")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end PVSource;