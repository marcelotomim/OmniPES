within OmniPES.Circuit.Switches;

model Fault
  import Modelica.Units.SI;
  parameter Units.PerUnit R = 0;
  parameter Units.PerUnit X = 1e-3;
  parameter SI.Time t_on = 0.1;
  parameter SI.Time t_off = 0.2;
  Circuit.Interfaces.PositivePin T annotation(
    Placement(visible = true, transformation(origin = {0, 110}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1.77636e-15, 100}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  Boolean closed;
protected
  Circuit.Switches.Breaker breaker annotation(
    Placement(visible = true, transformation(origin = {0, 76}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Circuit.Basic.ShuntAdmittance shuntAdmittance(g = R/(R^2 + X^2), b = -X/(R^2 + X^2)) annotation(
    Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
initial equation
  closed = false;
equation
  breaker.open = not closed;
  closed = if time >= t_on and time < t_off then true else false;
  connect(breaker.p, T) annotation(
    Line(points = {{0, 86}, {0, 110}}, color = {0, 0, 255}));
  connect(breaker.n, shuntAdmittance.p) annotation(
    Line(points = {{0, 66}, {0, 50}}, color = {0, 0, 255}));
protected
  annotation(
    Icon(coordinateSystem(grid = {0.5, 0.5}, initialScale = 0.1), graphics = {Line(origin = {10, 60}, points = {{-20, 0}, {20, 0}}), Line(origin = {-20, 44}, points = {{10, 16}, {-10, -16}}), Line(origin = {20, 44}, points = {{10, 16}, {-10, -16}}), Line(origin = {20, 12}, points = {{10, 16}, {-10, -16}}), Line(origin = {-20, 12}, points = {{10, 16}, {-10, -16}, {-10, -16}}), Line(origin = {-20, -20}, points = {{10, 16}, {-10, -40}}), Line(origin = {-20, 28}, points = {{-10, 0}, {10, 0}}), Line(origin = {20, 28}, points = {{-10, 0}, {10, 0}}), Line(origin = {-20, -4}, points = {{-10, 0}, {10, 0}}), Line(origin = {12, -20}, points = {{10, 16}, {-42, -40}}), Line(origin = {16, -4}, points = {{-6, 0}, {6, 0}}), Rectangle(origin = {-15, -1}, extent = {{-45, 71}, {75, -71}}), Line(origin = {0, 86}, points = {{0, 16}, {0, -16}})}),
    Diagram(coordinateSystem(grid = {0.5, 0.5})),
    __OpenModelica_commandLineOptions = "");
end Fault;