within OmniPES.Scopes;

model Ammeter
  extends Circuit.Interfaces.SeriesComponent;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.arg;
  import Modelica.ComplexMath.abs;
  import Modelica.Units.SI;
  Units.PerUnit I;
  Units.CPerUnit S;
  SI.Angle theta;
equation
  I = abs(p.i);
  theta = arg(p.i);
  S = p.v*conj(p.i);
  v = Complex(0);
  annotation(
    Icon(graphics = {Ellipse(extent = {{-40, 40}, {40, -40}}, endAngle = 360), Text(origin = {0, 1}, extent = {{-26, 25}, {26, -25}}, textString = "A"), Line(origin = {-70, 0}, points = {{-30, 0}, {30, 0}}), Line(origin = {70, 0}, points = {{-30, 0}, {30, 0}})}));
end Ammeter;