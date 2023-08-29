within OmniPES.Circuit.Switches;

model TimedBreaker
  extends Circuit.Switches.Interfaces.BasicBreaker;
  parameter Modelica.Units.SI.Time t_open;
initial equation
  open = false;
equation
  when time >= t_open then
    open = true;
    end when;
//  open = if time >= t_open then true else false;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Text(origin = {-1, -59}, extent = {{-99, 39}, {99, -39}}, textString = "%t_open [s]")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end TimedBreaker;