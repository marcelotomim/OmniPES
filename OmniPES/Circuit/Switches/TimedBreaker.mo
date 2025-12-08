within OmniPES.Circuit.Switches;

model TimedBreaker
  extends Circuit.Switches.Interfaces.BasicBreaker;
  parameter Modelica.Units.SI.Time t_open "opening instant";
initial equation
  open = false;
equation
  when time >= t_open then
    open = true;
  end when;
  annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Text(origin = {-1, -59}, extent = {{-99, 39}, {99, -39}}, textString = "%t_open", fontSize = 8)}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
    Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Switches.Interfaces.BasicBreaker\">OmniPES.Circuit.Switches.Interfaces.BasicBreaker</a>: Base breaker interface</li>
  <li><a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>: Time parameter type</li>
</ul>
</body></html>"));
end TimedBreaker;