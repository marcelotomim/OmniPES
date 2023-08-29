within OmniPES.Circuit.Basic;

model TLine_switched
  outer SystemData data;
  parameter Units.PerUnit r;
  parameter Units.PerUnit x;
  parameter Units.ReactivePower Q;
  Circuit.Interfaces.PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-86, 54}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.NegativePin n annotation(
    Placement(visible = true, transformation(origin = {90, 54}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SeriesImpedance Z(r = r, x = x) annotation(
    Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Shunt_Capacitor Ypp(NominalPower = Q/2) annotation(
    Placement(visible = true, transformation(origin = {-12, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Shunt_Capacitor Ynn(NominalPower = Q/2) annotation(
    Placement(visible = true, transformation(origin = {12, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  parameter Real t_open = 0.3;
  Circuit.Switches.TimedBreaker brk_p(t_open = t_open) annotation(
    Placement(visible = true, transformation(origin = {-46, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Switches.TimedBreaker brk_n(t_open = t_open) annotation(
    Placement(visible = true, transformation(origin = {48, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Basic.SeriesImpedance seriesImpedance(r = 0, x = 1e4) annotation(
    Placement(visible = true, transformation(origin = {-46, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Z.p, Ypp.p) annotation(
    Line(points = {{-10, 52}, {-12, 52}, {-12, 38}}, color = {0, 0, 255}));
  connect(Z.n, Ynn.p) annotation(
    Line(points = {{10, 52}, {12, 52}, {12, 38}}, color = {0, 0, 255}));
  connect(p, brk_p.p) annotation(
    Line(points = {{-86, 54}, {-56, 54}, {-56, 52}}, color = {0, 0, 255}));
  connect(brk_p.n, Z.p) annotation(
    Line(points = {{-36, 52}, {-10, 52}}, color = {0, 0, 255}));
  connect(Z.n, brk_n.p) annotation(
    Line(points = {{10, 52}, {38, 52}}, color = {0, 0, 255}));
  connect(brk_n.n, n) annotation(
    Line(points = {{58, 52}, {74, 52}, {74, 54}, {90, 54}}, color = {0, 0, 255}));
  connect(seriesImpedance.p, brk_p.p) annotation(
    Line(points = {{-56, 16}, {-56, 52}}, color = {0, 0, 255}));
  connect(seriesImpedance.n, brk_p.n) annotation(
    Line(points = {{-36, 16}, {-36, 52}}, color = {0, 0, 255}));
  annotation(
    Icon(graphics = {Rectangle(origin = {0, -1}, extent = {{-100, 61}, {100, -61}}), Line(origin = {-80, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Rectangle(origin = {-60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {-60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {-60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {-60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Line(origin = {60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {0, 30}, rotation = -90, extent = {{-10, 20}, {10, -20}}), Line(origin = {-40, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {40, 30}, points = {{20, 0}, {-20, 0}}), Line(origin = {80, 30}, points = {{-20, 0}, {20, 0}}), Text(origin = {-2, -18}, extent = {{38, -38}, {-38, 38}}, textString = "SW")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end TLine_switched;