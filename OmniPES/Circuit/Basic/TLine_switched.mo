within OmniPES.Circuit.Basic;

model TLine_switched
  import Modelica.Units.SI;
  outer SystemData data;
  parameter SI.PerUnit r "series resistance";
  parameter SI.PerUnit x "series reactance";
  parameter SI.ReactivePower Q(displayUnit="Mvar") "capacitive loading";
  Circuit.Interfaces.PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-86, 54}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.NegativePin n annotation(
    Placement(visible = true, transformation(origin = {90, 54}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  parameter Boolean open_p = true "true, for opening the line from the positive terminal" annotation(Dialog(tab="Positive terminal breaker"), choices(checkBox=true), HideResult = true, Evaluate=true);
  parameter SI.Time t_open_p = 0.3 if open_p "Time instant for the breaker opening" annotation(Dialog(tab="Positive terminal breaker", enable = open_p));
  parameter Boolean open_n = true "true, for opening the line from the negative terminal" annotation(Dialog(tab="Negative terminal breaker"), choices(checkBox=true), HideResult = true, Evaluate=true);
  parameter SI.Time t_open_n = 0.3 if open_n "Time instant for the breaker opening" annotation(Dialog(tab="Negative terminal breaker", enable = open_n));
  Circuit.Switches.TimedBreaker brk_p(t_open = t_open_p)  if open_p "breaker on the positive terminal" annotation(
    Placement(visible = true, transformation(origin = {-46, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Switches.TimedBreaker brk_n(t_open = t_open_p)  if open_n "breaker on the negative terminal" annotation(
    Placement(visible = true, transformation(origin = {48, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  TLine tLine(r=r, x=x, Q=Q) annotation(
    Placement(transformation(origin = {4, 50}, extent = {{-10, -10}, {10, 10}})));
equation

if open_p then
  connect(p, brk_p.p) annotation(
    Line(points = {{-86, 54}, {-56, 54}, {-56, 52}}, color = {0, 0, 255}));
  connect(brk_p.n, tLine.p) annotation(
    Line(points = {{-36, 52}, {-6, 52}, {-6, 54}}, color = {0, 0, 255}));
else
  connect(p, tLine.p) annotation(
    Line(points = {{-86, 54}, {-78, 54}, {-78, 70}, {-6, 70}, {-6, 54}}, color = {0, 0, 255}));
end if;

if open_n then
  connect(brk_n.n, n) annotation(
    Line(points = {{58, 52}, {74, 52}, {74, 54}, {90, 54}}, color = {0, 0, 255}));
  connect(tLine.n, brk_n.p) annotation(
    Line(points = {{16, 54}, {38, 54}, {38, 52}}, color = {0, 0, 255}));
else
  connect(tLine.n, n) annotation(
    Line(points = {{16, 54}, {16, 74}, {90, 74}, {90, 54}}, color = {0, 0, 255}));
end if;

  annotation(
    Icon(graphics = {Line(origin = {-80, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Rectangle(origin = {-60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {-60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {-60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {-60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Line(origin = {60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {0, 30}, rotation = -90, extent = {{-10, 20}, {10, -20}}), Line(origin = {-40, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {40, 30}, points = {{20, 0}, {-20, 0}}), Line(origin = {80, 30}, points = {{-20, 0}, {20, 0}}), Text(origin = {-3, -60}, extent = {{43, -40}, {-43, 40}}, textString = "SW")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end TLine_switched;