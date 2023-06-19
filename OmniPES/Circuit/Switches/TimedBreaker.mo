within OmniPES.Circuit.Switches;

model TimedBreaker
  extends OmniPES.Circuit.Switches.Interfaces.BasicBreaker;
  import OmniPES.Units;
  parameter Real t_open;
equation
  open = if time >= t_open then true else false;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Text(origin = {-1, -59}, extent = {{-99, 39}, {99, -39}}, textString = "%t_open [s]")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end TimedBreaker;