within OmniPES.Circuit;

package Switches "Electrical switching devices for circuit control"
  
  annotation (Documentation(info="<html>
<p>
This package contains models of electrical switching devices used for circuit control 
and protection in the OmniPES library.
</p>

<h4>Available Components</h4>
<p>
The following switching devices are available:
</p>
<ul>
<li><a href=\"modelica://OmniPES.Circuit.Switches.Breaker\">Breaker</a> - 
Circuit breaker for protection and isolation</li>
<li><a href=\"modelica://OmniPES.Circuit.Switches.TimedBreaker\">TimedBreaker</a> - 
Time-controlled circuit breaker</li>
<li><a href=\"modelica://OmniPES.Circuit.Switches.Fault\">Fault</a> - 
Fault simulation component</li>
<li><a href=\"modelica://OmniPES.Circuit.Switches.Interfaces\">Interfaces</a> - 
Base interfaces for switching devices</li>
</ul>
</html>"),
    Icon(coordinateSystem(initialScale = 0.1, grid = {0.5, 0.5}), graphics = {Line(origin = {-70, 0}, points = {{-10, 0}, {30, 0}}, thickness = 1), Line(origin = {70, 0}, points = {{-20, 0}, {10, 0}}, thickness = 1), Line(origin = {-40, 0}, points = {{0, 0}, {69.28, 40}}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 6), Line(origin = {50, 0}, points = {{-10, 10}, {10, -10}, {10, -10}}), Line(origin = {50, 0}, points = {{-10, -10}, {10, 10}, {10, 10}}), Rectangle(lineThickness = 1, extent = {{-100, 100}, {100, -100}}), Ellipse(origin = {-80, 0}, fillPattern = FillPattern.Solid, extent = {{2, 2}, {-2, -2}}, endAngle = 360), Ellipse(origin = {80, 0}, fillPattern = FillPattern.Solid, extent = {{2, 2}, {-2, -2}}, endAngle = 360)}),
    Diagram(coordinateSystem(extent = {{-100, -150}, {100, 100}})));
end Switches;