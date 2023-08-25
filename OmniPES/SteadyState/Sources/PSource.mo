within OmniPES.SteadyState.Sources;

model PSource
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;

  outer SystemData data;
  parameter Units.ActivePower Psp;
  Units.CPerUnit S;
equation
  S = -v*conj(i);
  S.re = Psp/data.Sbase;
  annotation(
    Icon(graphics = {Ellipse(origin = {6, 1}, extent = {{-66, 67}, {66, -67}}), Line(origin = {-73, 0}, points = {{-13, 0}, {13, 0}}), Line(origin = {81, 0}, points = {{-9, 0}, {9, 0}}), Line(origin = {-4, -22}, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {16, 22}, rotation = 180, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {98, 0}, points = {{-10, 0}, {10, 0}}), Line(origin = {108, -1}, points = {{0, 33}, {0, -33}}), Line(origin = {122, -1}, points = {{0, 19}, {0, -19}}), Line(origin = {134, 1}, points = {{0, 3}, {0, -7}}), Text(origin = {80.4, -71.35}, rotation = 90, extent = {{-25.35, 29.6}, {26.65, -18.4}}, textString = "PV")}, coordinateSystem(initialScale = 0.1)));
end PSource;