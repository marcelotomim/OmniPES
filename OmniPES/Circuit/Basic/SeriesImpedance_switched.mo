within OmniPES.Circuit.Basic;

model SeriesImpedance_switched
  import Modelica.Units.SI;
  parameter SI.PerUnit r = 0 "series resistance";
  parameter SI.PerUnit x = 0 "series reactance";
  parameter Boolean open = true "true, for opening this branch" annotation(choices(checkBox=true), HideResult = true, Dialog(group="Switching Event"));
  parameter SI.Time t_open = 0.3 if open "opening instant" annotation(Dialog(group="Switching Event", enable = open));
  OmniPES.Circuit.Basic.SeriesImpedance Z(r = r, x = x)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.NegativePin n annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Switches.TimedBreaker brk(t_open = t_open) if open "Time instant for opening this branch" annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
if open then
    connect(brk.p, p) annotation(
      Line(points = {{-60, 0}, {-102, 0}}, color = {0, 0, 255}));
    connect(brk.n, Z.p) annotation(
      Line(points = {{-40, 0}, {-10, 0}}, color = {0, 0, 255}));
else 
    connect(p, Z.p) annotation(
    Line(points = {{-102, 0}, {-80, 0}, {-80, 30}, {-10, 30}, {-10, 0}}, color = {0, 0, 255}));
end if;
connect(Z.n, n) annotation(
    Line(points = {{10, 0}, {100, 0}}, color = {0, 0, 255}));

  annotation(
    Icon(graphics = {Rectangle(origin = {1, -1}, extent = {{-61, 35}, {61, -35}}), Line(origin = {-73, 0}, points = {{13, 0}, {-13, 0}}), Line(origin = {76, 0}, points = {{-14, 0}, {14, 0}}), Text(origin = {1, -1}, extent = {{-61, 34}, {61, -34}}, textString = "SW")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})),
    Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Basic.SeriesImpedance\">OmniPES.Circuit.Basic.SeriesImpedance</a>: Series impedance element used inside the switch</li>
  <li><a href=\"modelica://OmniPES.Circuit.Switches.TimedBreaker\">OmniPES.Circuit.Switches.TimedBreaker</a>: Breaker controlling branch opening</li>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.PositivePin\">OmniPES.Circuit.Interfaces.PositivePin</a>: Sending-end pin</li>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.NegativePin\">OmniPES.Circuit.Interfaces.NegativePin</a>: Receiving-end pin</li>
  <li><a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>: Per-unit impedance and timing types</li>
</ul>
</body></html>"));
end SeriesImpedance_switched;