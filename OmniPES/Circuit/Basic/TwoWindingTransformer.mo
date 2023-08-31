within OmniPES.Circuit.Basic;

model TwoWindingTransformer
  outer SystemData data;
  parameter Units.ApparentPower NominalMVA = data.Sbase;
  parameter Units.PerUnit r = 0;
  parameter Units.PerUnit x;
  parameter Real tap = 1;
  Circuit.Interfaces.PositivePin p(v.re(start = 1)) annotation(
    Placement(visible = true, transformation(origin = {-66, 14}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.NegativePin n(v.re(start = 1)) annotation(
    Placement(visible = true, transformation(origin = {56, 14}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Basic.SeriesImpedance Z(r = r*data.Sbase/NominalMVA, x = x*data.Sbase/NominalMVA) annotation(
    Placement(visible = true, transformation(origin = {26, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Circuit.Interfaces.IdealTransformer idealTransformer(a = tap) annotation(
    Placement(visible = true, transformation(origin = {-30, 14}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
equation
  connect(p, idealTransformer.p) annotation(
    Line(points = {{-66, 14}, {-46, 14}}, color = {0, 0, 255}));
  connect(idealTransformer.n, Z.p) annotation(
    Line(points = {{-14.6, 14}, {15.4, 14}}, color = {0, 0, 255}));
  connect(Z.n, n) annotation(
    Line(points = {{36, 13.8}, {56, 13.8}}, color = {0, 0, 255}));
  annotation(
    Icon(graphics = {Rectangle(origin = {0, -1}, extent = {{-100, 61}, {100, -61}}), Ellipse(origin = {-17, 0}, extent = {{-28, 28}, {28, -28}}), Ellipse(origin = {17, 0}, extent = {{-28, 28}, {28, -28}}), Line(origin = {-72, 0}, points = {{-30, 0}, {27, 0}}), Line(origin = {72, 0}, points = {{-27, 0}, {30, 0}}), Ellipse(origin = {-60, 40}, fillPattern = FillPattern.Solid, extent = {{-5, 5}, {5, -5}}), Text(origin = {-1, 78}, extent = {{-98, 21}, {100, -18}}, textString = "1:%tap")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, initialScale = 0.1, grid = {1, 1})));
end TwoWindingTransformer;