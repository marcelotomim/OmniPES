within OmniPES.Circuit.Basic;

model TwoWindingTransformer
  import Modelica.Units.SI;
  outer SystemData data;
  parameter SI.ApparentPower NominalMVA(displayUnit="MW") = data.Sbase;
  parameter SI.PerUnit r = 0 "series resistance";
  parameter SI.PerUnit x "series reactance";
  parameter SI.PerUnit tap = 1 "normalized tap position";
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
    Icon(graphics = {Ellipse(origin = {-17, 0}, extent = {{-28, 28}, {28, -28}}), Ellipse(origin = {17, 0}, extent = {{-28, 28}, {28, -28}}), Line(origin = {-72, 0}, points = {{-30, 0}, {27, 0}}), Line(origin = {72, 0}, points = {{-27, 0}, {30, 0}}), Ellipse(origin = {-60, 40}, fillPattern = FillPattern.Solid, extent = {{-5, 5}, {5, -5}}), Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "1:%tap")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, initialScale = 0.1, grid = {1, 1})),
  Documentation(info="<html><body>
<h4>Related Components</h4>
<ul>
  <li><a href=\"modelica://OmniPES.Circuit.Basic.SeriesImpedance\">OmniPES.Circuit.Basic.SeriesImpedance</a>: Series impedance used for leakage modeling</li>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.IdealTransformer\">OmniPES.Circuit.Interfaces.IdealTransformer</a>: Ideal tap-changing transformer</li>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.PositivePin\">OmniPES.Circuit.Interfaces.PositivePin</a>: Primary-side pin</li>
  <li><a href=\"modelica://OmniPES.Circuit.Interfaces.NegativePin\">OmniPES.Circuit.Interfaces.NegativePin</a>: Secondary-side pin</li>
  <li><a href=\"modelica://OmniPES.SystemData\">OmniPES.SystemData</a>: System base data (outer)</li>
  <li><a href=\"modelica://Modelica.Units.SI\">Modelica.Units.SI</a>: Apparent power and per-unit parameters</li>
</ul>
</body></html>"));
end TwoWindingTransformer;