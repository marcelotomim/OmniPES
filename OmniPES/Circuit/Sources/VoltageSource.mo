within OmniPES.Circuit.Sources;

model VoltageSource
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import OmniPES.Math.polar2cart;
  import Modelica.Units.NonSI;
  parameter Units.PerUnit magnitude = 1.0;
  parameter NonSI.Angle_deg angle = 0.0;
  Units.CPerUnit S;
equation
  v = polar2cart(magnitude, angle);
  S = -v*conj(i);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end VoltageSource;