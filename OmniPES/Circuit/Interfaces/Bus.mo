within OmniPES.Circuit.Interfaces;

model Bus
  import Modelica.Units.SI;
  import Modelica.ComplexMath.arg;
  import Modelica.ComplexMath.abs;
  PositivePin p(v.re(start = 1.0)) annotation(
    Placement(transformation(extent = {{-100, -100}, {100, 100}}), iconTransformation(origin = {3, 2.98023e-08}, extent = {{-10, -100}, {10, 100}})));
  SI.PerUnit V(start = 1.0) "node voltage magnitude";
  SI.Angle angle(start = 0, displayUnit = "deg")  "node voltage phase";
equation
  V = abs(p.v);
  angle = arg(p.v);
  p.i = Complex(0);
  annotation(
    Documentation(info = "<html><p>Network bus/node connector for positive-sequence AC studies. Provides a single <code>PositivePin</code> terminal and exposes derived voltage magnitude <code>V</code> and phase <code>angle</code> from the complex pin voltage (no power injection at the bus itself). The <code>PositivePin</code> connector carries complex per-unit voltage <code>v</code> and flow current <code>i</code> (positive into the bus), which is enforced to be zero.</p>
    <p>Use this bus to connect series/shunt elements and to read voltage phasor values for measurements or controllers.</p></html>"),
    Icon(graphics = {Rectangle(origin = {-7, 3}, extent = {{1, 97}, {13, -105}}), Text(origin = {0, 142}, textColor = {26, 95, 180}, extent = {{-150, 30}, {150, -30}}, textString = "%name")}));
end Bus;