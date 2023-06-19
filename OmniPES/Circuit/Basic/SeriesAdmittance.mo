within OmniPES.Circuit.Basic;

model SeriesAdmittance
  extends OmniPES.Circuit.Interfaces.SeriesComponent;
  parameter OmniPES.Units.PerUnit g;
  parameter OmniPES.Units.PerUnit b;
equation
  i = Complex(g, b)*v;
  annotation(
    Icon(graphics = {Rectangle(origin = {1, -1}, fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-13, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {14, 0}})}, coordinateSystem(initialScale = 0.1)));
end SeriesAdmittance;