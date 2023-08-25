within OmniPES.Circuit.Switches;

model Breaker
  extends Circuit.Switches.Interfaces.BasicBreaker;
  Modelica.Blocks.Interfaces.BooleanInput ext_open annotation(
    Placement(visible = true, transformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90), iconTransformation(origin = {0, 88}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
equation
  ext_open = open;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Line(origin = {0, 53}, points = {{0, 17}, {0, -29}}, thickness = 0.5, arrow = {Arrow.None, Arrow.Filled})}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end Breaker;