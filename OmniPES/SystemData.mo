within OmniPES;

model SystemData
  import Modelica.Units.SI;
  import Modelica.Constants.pi;
  parameter SI.ApparentPower Sbase(displayUnit = "MVA") = 100e6 annotation(
    Dialog(group = "Base Quantities"));
  parameter SI.Frequency fb = 60 annotation(
    Dialog(group = "Base Quantities"));
  final parameter SI.AngularVelocity wb = 2*pi*fb;
  annotation(
    singleInstance = true,
    defaultComponentName = "data",
    defaultComponentPrefixes = "inner",
    missingInnerMessage = "The System object is missing, please drag it on the top layer of your model",
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 70}, {80, -70}}), Text(extent = {{-70, 60}, {70, -60}}, textString = "System
%Sbase
%fb")}),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
  Documentation(info = "<html>
<head></head>
<body>
  <h4>Overview</h4>
  <p>
    The <code>SystemData</code> model defines the base quantities for the per-unit system used throughout the OmniPES library.
    This is a singleton model that provides system-wide base parameters for normalization of voltages, currents, powers, and impedances
    in the transmission network.
  </p>

  <h4>Purpose</h4>
  <p>
    This model serves as the central reference for per-unit calculations, ensuring consistency across all network components including
    transmission lines, transformers, reactors, capacitor banks, and other passive elements. It must be instantiated as an <code>inner</code>
    component at the top level of every OmniPES model to make base quantities accessible to all components.
  </p>

  <h4>Parameters</h4>
  <ul>
    <li><strong>Sbase</strong>: Base apparent power (default: 100 MVA) &mdash; reference power for per-unit normalization</li>
    <li><strong>fb</strong>: Base frequency (default: 60 Hz) &mdash; nominal system frequency</li>
    <li><strong>wb</strong> (final): Base angular velocity = 2&pi; &times; fb &mdash; computed from <code>fb</code></li>
  </ul>

  <h4>Usage</h4>
  <p>
    Declare this model as an <code>inner</code> component at the top level of your system model:
  </p>
  <pre>
  inner OmniPES.SystemData data(Sbase=100e6, fb=60);
  </pre>
  <p>
    All components in the model will automatically access these base quantities through the <code>outer</code> mechanism.
    The singleton annotation ensures only one instance exists per model hierarchy.
  </p>
  
  <p>
    <strong>Accessing SystemData in custom models:</strong><br/>
    To use the base quantities in your own custom components, declare an <code>outer</code> reference:
  </p>
  <pre>
  model MyCustomComponent
    outer OmniPES.SystemData data;
    
    // Now you can access data.Sbase, data.fb, data.wb
    parameter Real Z_pu = Z_ohms * data.Sbase / (Vbase^2);
    // ... rest of your model
  end MyCustomComponent;
  </pre>
  <p>
    The <code>outer</code> declaration creates a reference to the <code>inner</code> instance defined at the top level,
    allowing all nested components to share the same base quantities without passing them as parameters.
  </p>

  <h4>Notes</h4>
  <ul>
    <li>The <code>singleInstance</code> annotation enforces that only one <code>SystemData</code> object can exist in a model</li>
    <li>The <code>missingInnerMessage</code> provides an error if the user forgets to include this component</li>
    <li>All per-unit quantities in OmniPES are normalized with respect to these base values</li>
    <li>Changing <code>Sbase</code> or <code>fb</code> will affect the entire system's per-unit scaling</li>
  </ul>
</body>
</html>"));
end SystemData;