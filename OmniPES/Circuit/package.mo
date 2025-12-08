within OmniPES;

package Circuit
  annotation(
    Documentation(info="<html>
<head></head>
<body>
  <h4>Overview</h4>
  <p>
    The <code>Circuit</code> package provides fundamental electrical network components for positive-sequence AC power system modeling.
    All components operate in per-unit quantities and use complex phasors for voltage and current representation.
  </p>

  <h4>Main Subpackages</h4>
  <ul>
    <li><strong><a href=\"modelica://OmniPES.Circuit.Interfaces\">Interfaces</a></strong> &mdash; Base connector and partial model definitions
    </li>
    
    <li><strong><a href=\"modelica://OmniPES.Circuit.Basic\">Basic</a></strong> &mdash; Passive network elements
    </li>
    
    <li><strong><a href=\"modelica://OmniPES.Circuit.Sources\">Sources</a></strong> &mdash; Voltage and current injection sources
    </li>
    
    <li><strong><a href=\"modelica://OmniPES.Circuit.Switches\">Switches</a></strong> &mdash; Switching and fault elements
    </li>
  </ul>

  <h4>Key Concepts</h4>
  <ul>
    <li><strong>Per-unit system:</strong> All quantities normalized using <code>SystemData</code> base values</li>
    <li><strong>Complex phasors:</strong> Voltages and currents represented as complex numbers (real + imaginary)</li>
    <li><strong>Positive-sequence:</strong> Balanced three-phase systems represented by single-phase equivalent</li>
    <li><strong>Current convention:</strong> Positive current flows into pins following Modelica flow variable convention</li>
  </ul>

  <h4>Usage</h4>
  <p>
    Circuit components are the building blocks for both steady-state and transient power system models.
    They can be combined with components from <code>SteadyState</code> and <code>Transient</code> packages to create complete system models.
  </p>
</body>
</html>"));
end Circuit;