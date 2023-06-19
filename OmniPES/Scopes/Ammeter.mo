within OmniPES.Scopes;

model Ammeter
  extends Circuit.Interfaces.SeriesComponent;
  import Modelica.ComplexMath.conj;
  Units.PerUnit I;
  Units.CPerUnit S;
  Modelica.Units.SI.Angle theta;
equation
  I^2 = i.re^2 + i.im^2;
  i.re = I*cos(theta);
  S = p.v*conj(p.i);
  v = Complex(0);
  annotation(
    Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, endAngle = 360), Text(origin = {0, 1}, extent = {{-26, 25}, {26, -25}}, textString = "A"), Line(origin = {-70, 0}, points = {{-30, 0}, {30, 0}}), Line(origin = {70, 0}, points = {{-30, 0}, {30, 0}})}));
end Ammeter;