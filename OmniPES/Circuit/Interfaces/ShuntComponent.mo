within OmniPES.Circuit.Interfaces;

partial model ShuntComponent "Base model for shunt circuit elements"
  import Modelica.Units.SI;
  PositivePin p annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SI.ComplexPerUnit v(re(start=1)) "Node voltage (p.u.)";
  SI.ComplexPerUnit i "Current injected into the node (p.u., positive into pin p)";
equation
  v = p.v;
  i = p.i;
  annotation(
    Documentation(info = "<html>
      <h4>Overview</h4>
      <p>
        Partial base model for shunt (admittance/impedance) elements connected between a node and reference ground.
        Defines the standard interface for shunt components such as capacitors, reactors, and impedances.
      </p>
      <h4>Purpose</h4>
      <p>
        Shunt components draw or supply current at a single network node. This model establishes the connection pattern
        and provides voltage and current variables for use by concrete implementations.
      </p>
      <h4>Connector</h4>
      <ul>
        <li><strong>p</strong>: <code>PositivePin</code> connector at the network node; provides access to node voltage and acts as injection point</li>
      </ul>
      <h4>Variables</h4>
      <ul>
        <li><strong>v</strong>: Complex voltage at the node (p.u.)</li>
        <li><strong>i</strong>: Complex current injected into the node <code>p</code> (p.u., following Modelica convention: positive when flowing into pin p)</li>
      </ul>
      <h4>Behavior</h4>
      <p>
        Voltage and current are continuously equated to the connector values, establishing a passive interface
        for concrete shunt models to compute current based on voltage.
      </p>
      <h4>Usage</h4>
      <p>
        Extend this model and define constitutive equations. The base model treats shunt elements as lumped (spatially concentrated) components, suitable for steady-state power flow and transient stability studies.
      </p>
    </html>"));
end ShuntComponent;