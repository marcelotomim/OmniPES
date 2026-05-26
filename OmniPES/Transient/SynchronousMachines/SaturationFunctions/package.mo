within OmniPES.Transient.SynchronousMachines;

package SaturationFunctions 
extends Modelica.Icons.FunctionsPackage;



annotation(
    Documentation(info="<html><head></head><body>
<h3>Overview</h3>
<p>
<strong>SaturationFunctions</strong> is a package containing mathematical models for representing magnetic saturation effects 
in synchronous generator electrical models within the OmniPES Transient framework. Saturation functions characterize the 
nonlinear relationship between flux linkages and magnetizing currents in the machine's magnetic circuit as the iron core 
approaches its flux density limits.
</p>

<h3>Purpose and Context</h3>
<p>
Magnetic saturation is a critical nonlinearity in power system modeling that affects:
</p>
<ul>
  <li><strong>Voltage Regulation</strong>: Saturated machines require more field excitation to maintain terminal voltage</li>
  <li><strong>Transient Stability</strong>: Saturation can influence critical clearing times and post-fault voltage recovery</li>
  <li><strong>Excitation System Dynamics</strong>: Saturation limits the effectiveness of automatic voltage regulators (AVRs)</li>
  <li><strong>Fault Current Levels</strong>: Saturation reduces machine reactances, affecting short-circuit current magnitudes</li>
  <li><strong>Reactive Power Capability</strong>: Defines the Q-V capability curves and over-excitation limits</li>
</ul>

<h3>Available Models</h3>
<ul>
  <li><strong><a href=\"modelica://OmniPES.Transient.SynchronousMachines.SaturationFunctions.Exponential_2\">Exponential_2</a></strong> 
  — Three-parameter exponential saturation function (y = A·e<sup>B·(u−C)</sup>). Compatible with CEPEL/ANATEM \"tipo 2\" saturation curve. 
  This is the default saturation model used in OmniPES.</li>
</ul>

<h3>Creating Custom Saturation Functions</h3>
<p>
Users can create custom saturation models by extending the 
<a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.PartialSaturationFunction\">PartialSaturationFunction</a> 
base class. The interface requires:
</p>
<ul>
  <li><strong>Input:</strong> <code>u</code> [pu] — flux magnitude (typically F2m = √(F2d² + F2q²))</li>
  <li><strong>Output:</strong> <code>y</code> [pu] — saturation factor (additional mmf drop)</li>
</ul>

<h4>Example: Custom Polynomial Saturation</h4>
<pre style=\"background-color:#f5f5f5; padding:10px; border:1px solid #ccc; border-radius:4px;\">
within OmniPES.Transient.SynchronousMachines.SaturationFunctions;

model Polynomial_3
  extends OmniPES.Transient.SynchronousMachines.Interfaces.PartialSaturationFunction;
  parameter Real a = 0.01;
  parameter Real b = 0.05;
  parameter Real c = 0.20;
equation
  y = if u &gt; 0.8 then a + b*(u-0.8) + c*(u-0.8)^2 else 0;
  annotation(Documentation(info=\"&lt;html&gt;Quadratic saturation above 0.8 pu&lt;/html&gt;\"));
end Polynomial_3;
</pre>

<h3>Usage in Synchronous Machine Models</h3>
<p>
Saturation functions are optionally enabled in 
<a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a> 
by setting <code>is_saturable = true</code> in the electrical model declaration:
</p>
<pre style=\"background-color:#f5f5f5; padding:10px; border:1px solid #ccc; border-radius:4px;\">
OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine gen(
  smData = gen_data,
  specs = gen_specs,
  redeclare ... Interfaces.Model_2_2_Electric electrical(
    is_saturable = true,  // enable saturation
    redeclare SaturationFunctions.Exponential_2 sat_d(
      A = 0.02,   // customize parameters
      B = 10.5,
      C = 0.88
    )
  ),
  ...
) annotation(Placement(...));
</pre>

<h3>When to Use Saturation</h3>
<p><strong>Enable saturation for:</strong></p>
<ul>
  <li>High excitation scenarios (e.g., post-fault voltage recovery)</li>
  <li>Voltage control and AVR tuning studies</li>
  <li>Machines operating near or above rated voltage</li>
  <li>Detailed stability analysis where accuracy is critical</li>
</ul>
<p><strong>Disable saturation for:</strong></p>
<ul>
  <li>Preliminary system studies and screening analyses</li>
  <li>Low-voltage or remote fault scenarios where saturation is minimal</li>
  <li>Educational/simplified models where computational speed is prioritized</li>
</ul>

<h3>Related Components</h3>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.PartialSaturationFunction\">PartialSaturationFunction</a> 
  — base class for all saturation functions</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.PartialElectrical\">PartialElectrical</a> 
  — base electrical model with <code>is_saturable</code> parameter</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric\">Model_2_2_Electric</a> 
  — IEEE Model 2.2 electrical model with saturation support</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_1_Electric\">Model_2_1_Electric</a> 
  — IEEE Model 2.1 electrical model with saturation support</li>
</ul>

<h3>References</h3>
<ul>
  <li>IEEE Std 1110-2002: <em>IEEE Guide for Synchronous Generator Modeling Practices and Applications in Power System Stability Analyses</em></li>
  <li>CEPEL/ANATEM Manual: <em>Modelos de Curva de Saturação</em>. 
  <a href=\"https://see.cepel.br/manual/anatem/equipamentos/maquinas_sincronas/saturacao.html\" target=\"_blank\">https://see.cepel.br/manual/anatem/equipamentos/maquinas_sincronas/saturacao.html</a></li>
  <li>Kundur, P. (1994). <em>Power System Stability and Control</em>. McGraw-Hill.</li>
</ul>

</body></html>"));

end SaturationFunctions;
