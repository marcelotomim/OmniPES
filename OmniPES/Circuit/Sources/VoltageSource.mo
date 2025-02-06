within OmniPES.Circuit.Sources;

model VoltageSource
  import Modelica.Units.SI;
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import OmniPES.Math.polar2cart;
  parameter SI.PerUnit magnitude = 1.0 "voltage magnitude";
  parameter SI.Angle angle(displayUnit="deg") = 0.0 "voltage phase";
  SI.ComplexPerUnit S "generated apparent power";
equation
  v = polar2cart(magnitude, angle);
  S = -v*conj(i);
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end VoltageSource;