within OmniPES.Circuit.Basic;

model SeriesImpedance
  extends Circuit.Interfaces.SeriesComponent;
  parameter Modelica.Units.SI.PerUnit r = 0.0;
  parameter Modelica.Units.SI.PerUnit x = 0.0;
equation
  v = Complex(r, x)*i;
  annotation(
    Icon(graphics = {Rectangle(origin = {1, -1}, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-13, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {14, 0}})}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end SeriesImpedance;