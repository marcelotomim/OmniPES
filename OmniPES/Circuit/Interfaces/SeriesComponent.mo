within OmniPES.Circuit.Interfaces;

partial model SeriesComponent
  import Modelica.Units.SI;
  SI.ComplexPerUnit v "Voltage drop from p to n (p.u.)";
  SI.ComplexPerUnit i "Current injected into pin p (p.u., positive from p to n through the element)";
  PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NegativePin n annotation(
    Placement(visible = true, transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  v = p.v - n.v;
  i = p.i;
  p.i + n.i = Complex(0);
  annotation(
    Documentation(info = "<html>
      <h4>Overview</h4>
      <p>
        Partial base model for series (impedance/transformer) elements connecting two network nodes.
        Defines the standard interface for series components such as transmission lines, transformers, and impedances.
      </p>
      <h4>Purpose</h4>
      <p>
        Series components transfer power between two nodes with a voltage drop and current flow.
        This model establishes the two-terminal connection pattern and provides voltage drop and current variables
        for use by concrete implementations.
      </p>
      <h4>Connectors</h4>
      <ul>
        <li><strong>p</strong>: <code>PositivePin</code> at the sending-end node</li>
        <li><strong>n</strong>: <code>NegativePin</code> at the receiving-end node</li>
      </ul>
      <h4>Variables</h4>
      <ul>
        <li><strong>v</strong>: Complex voltage drop from <code>p</code> to <code>n</code> (p.u.)</li>
        <li><strong>i</strong>: Complex current injected into pin <code>p</code> (p.u., following Modelica convention: positive when flowing from <code>p</code> through the element to <code>n</code>)</li>
      </ul>
      <h4>Behavior</h4>
      <p>
        Voltage drop is computed as the difference between sending and receiving node voltages.
        Current conservation is enforced: current entering at <code>p</code> equals current leaving at <code>n</code>,
        ensuring the series element is passive (no net charge accumulation).
      </p>
      <h4>Usage</h4>
      <p>
        Extend this model and define constitutive equations. The base model establishes a two-terminal, lumped series behavior suitable for steady-state and dynamic network studies.
      </p>
    </html>"));
end SeriesComponent;