within OmniPES.Circuit.Basic;

model ShuntAdmittance
  extends OmniPES.Circuit.Interfaces.ShuntComponent;
  //protected
  parameter OmniPES.Units.PerUnit g;
  parameter OmniPES.Units.PerUnit b;
equation
  i = Complex(g, b)*v;
  annotation(
    Icon(graphics = {Rectangle(origin = {1, -1}, fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-27, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {24, 0}}), Line(origin = {112, 0}, points = {{0, 22}, {0, -22}}), Line(origin = {100, 0}, points = {{0, 30}, {0, -30}}), Line(origin = {122, 0}, points = {{0, 12}, {0, -12}})}, coordinateSystem(initialScale = 0.1)));
end ShuntAdmittance;