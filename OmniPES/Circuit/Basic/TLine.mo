within OmniPES.Circuit.Basic;

model TLine
  import Modelica.Units.SI;
  outer SystemData data;
  parameter SI.PerUnit r "series resistance";
  parameter SI.PerUnit x "series reactance";
  parameter SI.ReactivePower Q(displayUnit="Mvar") "capacitive loading";
  Circuit.Interfaces.PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.NegativePin n annotation(
    Placement(visible = true, transformation(origin = {40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SeriesImpedance Z(r = r, x = x) annotation(
    Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Shunt_Capacitor Ypp(NominalPower = Q/2) annotation(
    Placement(visible = true, transformation(origin = {-26, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Shunt_Capacitor Ynn(NominalPower = Q/2) annotation(
    Placement(visible = true, transformation(origin = {24, 28}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
  connect(Z.n, n) annotation(
    Line(points = {{10, 52}, {40, 52}}, color = {0, 0, 255}));
  connect(p, Z.p) annotation(
    Line(points = {{-40, 52}, {-10, 52}}, color = {0, 0, 255}));
  connect(Ypp.p, Z.p) annotation(
    Line(points = {{-26, 36}, {-26, 44}, {-10, 44}, {-10, 52}}, color = {0, 0, 255}));
  connect(Ynn.p, Z.n) annotation(
    Line(points = {{24, 38}, {24, 44}, {10, 44}, {10, 52}}, color = {0, 0, 255}));
  annotation(
    Icon(graphics = {Line(origin = {-80, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Rectangle(origin = {-60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {-60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {-60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {-60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Line(origin = {60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {0, 30}, rotation = -90, extent = {{-10, 20}, {10, -20}}), Line(origin = {-40, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {40, 30}, points = {{20, 0}, {-20, 0}}), Line(origin = {80, 30}, points = {{-20, 0}, {20, 0}})}, coordinateSystem(initialScale = 0.1)));
end TLine;