within OmniPES.Circuit.Interfaces;

model IdealTransformer
  parameter Real a = 1.0 "Transformer ratio";
  PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NegativePin n annotation(
    Placement(visible = true, transformation(origin = {104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  p.v = a*n.v;
  n.i + a*p.i = Complex(0);
  annotation(
    Icon(graphics = {Line(origin = {72, 0}, points = {{-27, 0}, {30, 0}}), Line(origin = {-72, 0}, points = {{-30, 0}, {27, 0}}), Ellipse(origin = {-17, 0}, extent = {{-28, 28}, {28, -28}}), Ellipse(origin = {17, 0}, extent = {{-28, 28}, {28, -28}}), Ellipse(origin = {-48, 28}, fillPattern = FillPattern.Solid, extent = {{-4, 4}, {4, -4}}), Text(origin = {0, 70}, textColor = {26, 95, 180}, extent = {{-150, 30}, {150, -30}}, textString = "1:%a")}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
    Documentation(info = "<html>
      <h4>Overview</h4>
      <p>
        Ideal (lossless, zero-impedance) two-winding transformer connecting two network nodes.
        Enforces voltage transformation and current scaling according to a fixed turns ratio without any losses or impedance.
      </p>
      <h4>Purpose</h4>
      <p>
        Represents an ideal voltage and current transformer at its primary and secondary windings.
        Commonly used to represent impedance conversion and voltage level transformation
        in steady-state and dynamic power system studies.
      </p>
      <h4>Connectors</h4>
      <ul>
        <li><strong>p</strong>: <code>PositivePin</code> at the primary winding</li>
        <li><strong>n</strong>: <code>NegativePin</code> at the secondary winding</li>
      </ul>
      <h4>Parameters</h4>
      <ul>
        <li><strong>a</strong>: Transformer turns ratio (default 1.0); ratio of primary to secondary voltage and inverse of current ratio</li>
      </ul>
      <h4>Behavior</h4>
      <p>
        Primary voltage <code>p.v</code> equals the secondary voltage <code>n.v</code> scaled by the real ratio <code>a</code>.
        Current conservation is enforced: current injected into the primary plus scaled secondary current equals zero,
        ensuring zero net power loss (ideal transformer). The ratio <code>a</code> represents voltage step-up or step-down transformations.
      </p>
      <h4>Notes</h4>
      <p>
        This model assumes ideal (lossless) operation. For realistic transformers with losses, impedance, and saturation,
        extend this model or use more detailed transformer models from the Circuit library.
        The turns ratio <code>a</code> is typically derived from the winding turns or voltage ratings of the physical transformer.
      </p>
    </html>"),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end IdealTransformer;