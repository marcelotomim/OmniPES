within OmniPES.Circuit.Switches.Interfaces;

partial model BasicBreaker
  extends OmniPES.Circuit.Interfaces.SeriesComponent;
  import OmniPES.Units;
  Boolean open(start = false);
protected
  parameter Real Ron(final min = 0) = 1e-6;
  parameter Real Goff(final min = 0) = 1e-6;
  Complex s(re(start = 0)) "Auxiliary variable";
equation
//v = s*(if open then 1 else Ron);
//i = s*(if open then Goff else 1);
  if open then
    v = s;
    i = Complex(0);
  else
    v = Complex(0);
    i = s;
  end if;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Line(origin = {-70, 0}, points = {{-30, 0}, {30, 0}}, thickness = 1), Line(origin = {70, 0}, points = {{-30, 0}, {30, 0}}, thickness = 1), Line(origin = {-40, 0}, points = {{0, 0}, {69.28, 40}}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 6), Line(origin = {50, 0}, points = {{-10, 10}, {10, -10}, {10, -10}}), Line(origin = {50, 0}, points = {{-10, -10}, {10, 10}, {10, 10}})}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end BasicBreaker;