within OmniPES;

class Overview
  extends Modelica.Icons.Information;
  annotation(
    Documentation(info = "<html>
    <head></head>
    
    <body>
      <h1>OmniPES: Modelica Library for Power Systems Simulation</h1>
      
      <h2>Overview</h2>
      <p>
        The OmniPES library is the main outcome of a learning experience in which we investigated how to effectively use 
        the Modelica language for modeling and analyzing electrical power systems. As the library matured, it was structured 
        along the same lines as industrial-grade power-flow and transient stability programs employ for modeling bulk power systems.
      </p>
      <p>
        At present, the OmniPES library provides two main analysis frameworks:
      </p>
      <ul>
        <li><strong>Steady-State Analysis</strong>: Power-flow restrictions are enforced at all times during simulation</li>
        <li><strong>Transient Stability Analysis</strong>: Allows inclusion of fast and slow dynamics associated with generation, 
        load, and other system controlling devices</li>
      </ul>
      <p>
        By design, initial operating conditions are established through embedded power-flow restrictions applied to power plants, 
        loads, and dynamic devices. This strategy facilitates rapid prototyping of small to medium-scale power systems without 
        importing results from third-party programs. Having both frameworks available in a single library also enables 
        long-term simulations for voltage and frequency stability analysis.
      </p>

      <h2>Key Features</h2>
      <ul>
        <li><strong>Dual Analysis Frameworks</strong>: Steady-state power flow and transient stability</li>
        <li><strong>Embedded Power Flow</strong>: Power-flow restrictions directly embedded in models</li>
        <li><strong>No External Dependencies</strong>: Initial conditions automatically determined through embedded power-flow</li>
        <li><strong>Rapid Prototyping</strong>: Quick development of small to medium-scale models</li>
        <li><strong>Sigmoid-Based Reactive Power Limits</strong>: Advanced constraint enforcement for reactive power</li>
        <li><strong>Quasi-Steady-State Capability</strong>: Supports long-term voltage and frequency stability studies</li>
        <li><strong>Positive-Sequence Models</strong>: Based on positive-sequence analysis for bulk power systems</li>
        <li><strong>Production-Grade Structure</strong>: Organized like industrial tools (PSS/E, PSAT)</li>
        <li><strong>Open Source</strong>: Developed with OpenModelica 1.22.2+ on MSL 4.0.0</li>
      </ul>

      <h2>Why OmniPES?</h2>
      <h3>Motivation</h3>
      <p>
        Modern electric power systems face unprecedented challenges with rapid integration of distributed energy resources (DERs), 
        renewable energy sources, and advanced power converters. These developments require sophisticated modeling tools that can:
      </p>
      <ul>
        <li>Rapidly prototype power system models for small to medium-scale systems without external computational dependencies</li>
        <li>Enable seamless integration of traditional and innovative control systems</li>
        <li>Support multiple analysis frameworks (steady-state, transient stability, quasi-steady-state) within a single environment</li>
        <li>Follow industry best practices matching production-grade tools</li>
      </ul>
      <h3>Key Advantages</h3>
      <p>
        Unlike other Modelica libraries for power systems, OmniPES:
      </p>
      <ul>
        <li><strong>Eliminates external power flow dependency</strong>: Initial conditions are implicitly determined through 
        embedded power-flow restrictions</li>
        <li><strong>Supports advanced reactive power management</strong>: Implements sigmoid-based switches for smooth constraint 
        enforcement with automatic backoff capabilities</li>
        <li><strong>Provides unified simulation environment</strong>: Combine steady-state and transient models seamlessly</li>
        <li><strong>Designed for education and research</strong>: Enables rapid development and validation of control systems</li>
      </ul>

      <h2>Library Architecture</h2>
      <p>
        The OmniPES library is organized hierarchically into five main subpackages and supporting utilities:
      </p>
      <ul>
        <li><strong><code>Circuit</code></strong>: Basic circuit components (buses, lines, transformers, switches)</li>
        <li><strong><code>SteadyState</code></strong>: Power flow analysis framework with sources and loads</li>
        <li><strong><code>Transient</code></strong>: Transient stability framework with machines and controllers</li>
        <li><strong><code>Math</code></strong>: Mathematical utilities and transformation functions</li>
        <li><strong><code>Scopes</code></strong>: Measurement and monitoring components</li>
        <li><strong><code>Icons</code></strong>: Icon definitions for visual representation</li>
      </ul>

      <h3>Design Philosophy</h3>
      <p>
        The library follows key design principles:
      </p>
      <ol>
        <li><strong>Embedded Power-Flow Restrictions</strong>: Power-flow restrictions are directly embedded in component models, 
        ensuring self-contained initial operating conditions</li>
        <li><strong>Modularity</strong>: Components are designed as building blocks easily combined into larger system models</li>
        <li><strong>Positive-Sequence Representation</strong>: All models use positive-sequence representation, simplifying analysis 
        while capturing essential dynamics</li>
        <li><strong>Compatibility</strong>: Built on MSL 4.0.0, ensuring compatibility with the Modelica standard and broad simulator support</li>
      </ol>

      <h2>Core Concepts</h2>
      <h3>Base Parameters and Units</h3>
      <p>
        All power system quantities in OmniPES are expressed in per-unit (p.u.) form using base values defined in the 
        <code>SystemData</code> model:
      </p>
      <ul>
        <li><strong>Sbase</strong>: Base apparent power (default: 100 MVA) &mdash; used for power normalization</li>
        <li><strong>fb</strong>: Base frequency (default: 60 Hz) &mdash; used for angular velocity calculations</li>
        <li><strong>wb</strong> (final): Base angular velocity = 2&pi; fb &mdash; computed from fb</li>
      </ul>
      <p>
        The <code>SystemData</code> model must be instantiated as an inner component at the top level of any system model.
      </p>

      <h3>Voltage Representation</h3>
      <p>
        Voltages are represented as complex numbers in the Modelica <code>Complex</code> type, automatically handling both 
        magnitude and angle. Buses and nodes provide interfaces to extract:
      </p>
      <ul>
        <li><strong>V</strong>: Voltage magnitude in p.u.</li>
        <li><strong>angle</strong>: Voltage phase angle in radians (or degrees)</li>
      </ul>

      <h3>Power Representation</h3>
      <p>
        Power is represented as complex power in p.u., where:
      </p>
      <ul>
        <li><strong>P</strong>: Active power in p.u. (base = Sbase)</li>
        <li><strong>Q</strong>: Reactive power in p.u. (base = Sbase)</li>
      </ul>

      <h2>Main Subpackages</h2>
      <h3>1. Circuit Subpackage</h3>
      <p>
        The <code><a href=\"modelica://OmniPES.Circuit\">Circuit</a></code> subpackage contains fundamental network elements for positive-sequence power system analysis. 
        It is organized into several sections:
      </p>
      <ul>
        <li><strong><code><a href=\"modelica://OmniPES.Circuit.Interfaces\">Interfaces</a></code></strong>: Partial models and connectors establishing the standard interface for all power system elements (connectors, base classes for series/shunt components)</li>
        <li><strong><code><a href=\"modelica://OmniPES.Circuit.Basic\">Basic</a></code></strong>: Concrete implementations of network components (transmission lines, transformers, impedances, capacitors, reactors)</li>
        <li><strong><code><a href=\"modelica://OmniPES.Circuit.Sources\">Sources</a></code></strong>: Voltage and current sources, including controlled variants</li>
        <li><strong><code><a href=\"modelica://OmniPES.Circuit.Switches\">Switches</a></code></strong>: Controllable breakers and fault simulation elements</li>
      </ul>

      <h3>2. SteadyState Subpackage</h3>
      <p>
        The <code><a href=\"modelica://OmniPES.SteadyState\">SteadyState</a></code> subpackage contains models for traditional power flow analysis where power-flow restrictions 
        are enforced at each time step. Time acts as a parameterization variable for load and generation variations.
      </p>
      <ul>
        <li><strong><code><a href=\"modelica://OmniPES.SteadyState.Sources\">Sources</a></code></strong>: Various source models (PQ, PV, VTH) with optional reactive power limits</li>
        <li><strong><code><a href=\"modelica://OmniPES.SteadyState.Loads\">Loads</a></code></strong>: Voltage-dependent polynomial loads with configurable impedance/current/power fractions</li>
        <li><strong><code><a href=\"modelica://OmniPES.SteadyState.Examples\">Examples</a></code></strong>: Test cases and benchmark systems for validation</li>
      </ul>

      <h3>3. Transient Subpackage</h3>
      <p>
        The <code><a href=\"modelica://OmniPES.Transient\">Transient</a></code> subpackage contains models for electromechanical transient stability analysis, including 
        synchronous machine models and their controllers.
      </p>
      <ul>
        <li><strong><code><a href=\"modelica://OmniPES.Transient.SynchronousMachines\">SynchronousMachines</a></code></strong>: Flexible synchronous machine framework supporting multiple electrical model complexities (Classical, Models 1.0, 2.1, 2.2) and various initialization strategies</li>
        <li><strong><code><a href=\"modelica://OmniPES.Transient.Controllers\">Controllers</a></code></strong>: Framework for automatic voltage regulators (AVR), speed governors, and power system stabilizers (PSS), with reusable control blocks</li>
        <li><strong><code><a href=\"modelica://OmniPES.Transient.Loads\">Loads</a></code></strong>: Dynamic loads with distinct steady-state and transient behavior</li>
        <li><strong><code><a href=\"modelica://OmniPES.Transient.FACTS\">FACTS</a></code></strong>: Flexible AC transmission system devices for reactive power support</li>
        <li><strong><code><a href=\"modelica://OmniPES.Transient.Examples\">Examples</a></code></strong>: Comprehensive benchmark systems (Kundur, IEEE test systems, custom studies)</li>
      </ul>

      <h3>4. Math Subpackage</h3>
      <p>
        The <code><a href=\"modelica://OmniPES.Math\">Math</a></code> subpackage provides utility functions for coordinate transformations and mathematical operations used throughout the library.
      </p>

      <h3>5. Scopes Subpackage</h3>
      <p>
        The <code><a href=\"modelica://OmniPES.Scopes\">Scopes</a></code> subpackage provides measurement and monitoring components for extracting simulation results (current, power, voltage).
      </p>

      <h2>Getting Started</h2>
      <h3>Prerequisites</h3>
      <ul>
        <li>OpenModelica version 1.22.2 or later</li>
        <li>Modelica Standard Library (MSL) 4.0.0</li>
        <li>Understanding of power systems and Modelica basics</li>
      </ul>

      <h3>Basic Workflow</h3>
      <p><strong>Step 1: Set Up System Data</strong></p>
      <p>Every OmniPES model must include a <code>SystemData</code> component at the top level:</p>
      <pre>
model MyPowerSystem
  inner SystemData data(
    Sbase = 100e6,    // 100 MVA base
    fb = 60);          // 60 Hz base frequency
  
  // ... rest of model
end MyPowerSystem;
      </pre>

      <p><strong>Step 2: Create Network Nodes (Buses)</strong></p>
      <pre>
// Define nodes/buses
OmniPES.Circuit.Interfaces.Bus B1, B2;
      </pre>

      <p><strong>Step 3: Add Network Components</strong></p>
      <pre>
// Add transmission line
OmniPES.Circuit.Basic.TLine TL_12(r=0.05, x=0.15, Q=50e6);
connect(B1.p, TL_12.p);
connect(TL_12.n, B2.p);
      </pre>

      <p><strong>Step 4: Add Power Sources and Loads</strong></p>
      <p><em>For Steady-State Analysis:</em></p>
      <pre>
OmniPES.SteadyState.Sources.PVSource Gen(
  Psp = 700e6,    // 700 MW
  Vsp = 1.05);    // 1.05 p.u.
connect(B1.p, Gen.p);
      </pre>

      <p><em>For Transient Analysis:</em></p>
      <pre>
parameter OmniPES.Transient.SynchronousMachines.SynchronousMachineData gen_data(
  MVAb = 700e6,
  H = 5.0,
  Xd = 1.8,
  Xq = 1.7,
  X1d = 0.3,
  // ... other machine parameters
);

OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine Gen(
  smData = gen_data,
  redeclare OmniPES.Transient.SynchronousMachines.Interfaces.Restriction_PV restriction
);
connect(B2.p, Gen.terminal);
      </pre>

      <h2>Library Information</h2>
      <ul>
        <li><strong>Version</strong>: 0.1</li>
        <li><strong>Base Library</strong>: Modelica Standard Library (MSL) 4.0.0</li>
        <li><strong>Development Environment</strong>: OpenModelica 1.22.2~12-g3b7ae01</li>
        <li><strong>Last Updated</strong>: December 2024</li>
      </ul>

      <h2>Authors</h2>
      <ul>
        <li><strong>Marcelo A. Tomim</strong> &mdash; Federal University of Juiz de Fora (UFJF), Brazil<br/>
        Email: marcelo.tomim [at] ufjf.br</li>
        <li><strong>Ricardo M. Henriques</strong> (Senior Member, IEEE) &mdash; Federal University of Juiz de Fora (UFJF), Brazil<br/>
        Email: ricardo.henriques [at] ufjf.br</li>
        <li><strong>Jo&atilde;o A. Passos Filho</strong> (Senior Member, IEEE) &mdash; Federal University of Juiz de Fora (UFJF), Brazil<br/>
        Email: joao.passos [at] ufjf.br</li>
      </ul>

      <h2>Citation</h2>
      <p>
        If you use OmniPES in your research, please cite:
      </p>
      <p>
        Tomim, M. A., Henriques, R. M., &amp; Passos Filho, J. A. (2025). Introduction to OmniPES: A Modelica Library for Power Systems Modeling and Analysis. <em>IEEE Access</em>, vol. 13, pp. 51922&ndash;51937, Mar. 2025. 
        DOI: <a href=\"https://doi.org/10.1109/ACCESS.2025.3553782\">10.1109/ACCESS.2025.3553782</a>
      </p>

      <h2>References</h2>
      <ul>
        <li><strong>IEEE Std 421.5-2005</strong>: Recommended Practice for Excitation System Models for Power System Stability Studies</li>
        <li><strong>Modelica Standard Library (MSL) 4.0.0</strong>: <a href=\"https://github.com/modelica/ModelicaStandardLibrary\">https://github.com/modelica/ModelicaStandardLibrary</a></li>
        <li><strong>OpenModelica Documentation</strong>: <a href=\"https://openmodelica.org/\">https://openmodelica.org/</a></li>
      </ul>

    </body>
    </html>"));
end Overview;