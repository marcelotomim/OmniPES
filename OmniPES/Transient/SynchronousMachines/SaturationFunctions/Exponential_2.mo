within OmniPES.Transient.SynchronousMachines.SaturationFunctions;

model Exponential_2
  extends OmniPES.Transient.SynchronousMachines.Interfaces.PartialSaturationFunction;
    import Modelica.Math.exp;
    parameter Real A = 0.015;
    parameter Real B = 9.60;
    parameter Real C = 0.90;
  equation
    y = A*exp(B*(u - C));
    annotation(
      Icon(graphics = {Line(origin = {-7.86, -28.86}, points = {{-72.1371, -51.1371}, {-32.1371, -51.1371}, {19.8629, -45.1371}, {59.8629, 8.8629}, {79.8629, 100.863}}, color = {0, 0, 255}, thickness = 1, smooth = Smooth.Bezier)}),
      Documentation(info= "<html><head></head><body>
<h3>Overview</h3>
<p>
<strong>Exponential_2</strong> implements a three-parameter exponential saturation function for modeling magnetic saturation effects 
in synchronous generator flux linkages. This model captures the nonlinear behavior of ferromagnetic materials in the machine's 
magnetic circuit as the flux density increases.
</p>
<p>
This formulation corresponds to the <strong>\"Curva de saturação exponencial (tipo 2)\"</strong> (Exponential saturation curve, type 2) 
as defined in CEPEL's ANATEM transient stability program, a widely-used tool for power system analysis in Brazil and Latin America.
</p>

<h3>Mathematical Model</h3>
<p>
The saturation function is defined as:
</p>
<p style=\"text-align:center;\">
<strong>y = A · e<sup>B·(u − C)</sup></strong>
</p>
<p>where:</p>
<ul>
  <li><strong>u</strong> [pu]: input flux magnitude (typically F2m = √(F2d² + F2q²) in <a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric\">Model_2_2_Electric</a>)</li>
  <li><strong>y</strong> [pu]: output saturation factor representing the additional magnetizing current required due to saturation</li>
  <li><strong>A</strong> [-]: amplitude/scale parameter (default: 0.015)</li>
  <li><strong>B</strong> [-]: exponential rate parameter (default: 9.60)</li>
  <li><strong>C</strong> [pu]: threshold/offset parameter representing the flux level at which saturation becomes significant (default: 0.90 pu)</li>
</ul>

<h4>Saturation Curve with Default Parameters</h4>
<p>The figure below shows the saturation function behavior using the default parameter values (A=0.015, B=9.60, C=0.90). The curve exhibits minimal saturation below the threshold (C = 0.9 pu), then increases exponentially as flux magnitude rises above rated values. Definition points <strong>S<sub>1.0</sub></strong> (u = 1.0 pu) and <strong>S<sub>1.2</sub></strong> (u = 1.2 pu) are highlighted with labeled boxes placed above the curve; the red dashed line marks the threshold at <strong>C = 0.90 pu</strong>.&nbsp;</p>
<p style=\"text-align:center;\"><img src=\"modelica://OmniPES/Resources/Images/saturation_exponential_2.png\" alt=\"Exponential_2 Saturation Curve with S1.0 and S1.2 markers\" style=\"max-width:600px; display:block; margin:0 auto;\"></p>
<p style=\"text-align:center; font-size:0.9em; color:#666;\"><em>Figure: Exponential saturation function y = A·e<sup>B·(u−C)</sup> with default parameters. Markers indicate S<sub>1.0</sub> and S<sub>1.2</sub>; annotations are positioned above (NE) of the points; the red dashed line shows C = 0.90 pu; legend at upper-right.</em></p>

<h3>Physical Interpretation</h3>
<p>
Magnetic saturation in synchronous machines occurs when the iron core approaches its magnetic flux density limit. As saturation 
increases, more magnetizing current is required to produce the same flux, effectively reducing the magnetizing inductance. 
This function models the <em>additional</em> mmf (magnetomotive force) drop caused by saturation.
</p>
<ul>
  <li><strong>Below C</strong>: Saturation is negligible (y ≈ 0 for u &lt; C, assuming small A and large B)</li>
  <li><strong>Near C</strong>: Saturation begins to have noticeable effects</li>
  <li><strong>Above C</strong>: Saturation increases exponentially, requiring significantly more field current to maintain flux levels</li>
</ul>

<h3>Parameters</h3>

<h4>A — Amplitude/Scale Parameter</h4>
<ul>
  <li><strong>Type:</strong> Real [-]</li>
  <li><strong>Default:</strong> 0.015</li>
  <li><strong>Description:</strong> Scaling factor that determines the overall magnitude of the saturation effect. Larger values indicate 
  stronger saturation characteristics.</li>
</ul>

<h4>B — Exponential Rate Parameter</h4>
<ul>
  <li><strong>Type:</strong> Real [-]</li>
  <li><strong>Default:</strong> 9.60</li>
  <li><strong>Description:</strong> Exponential growth rate that controls how rapidly saturation increases beyond the threshold. 
  Higher values produce a sharper saturation curve (more abrupt transition from linear to saturated behavior).</li>
</ul>

<h4>C — Threshold/Offset Parameter</h4>
<ul>
  <li><strong>Type:</strong> Real [pu]</li>
  <li><strong>Default:</strong> 0.90 pu</li>
  <li><strong>Description:</strong> Flux magnitude threshold at which saturation becomes significant. Acts as a horizontal shift 
  of the exponential curve. For typical generators, saturation effects become noticeable around 90–100% of rated flux.</li>
</ul>

<h3>Parameter Estimation</h3>
<p>
The saturation function parameters (A, B, C) are typically determined from:
</p>
<ol>
  <li><strong>Open-Circuit Saturation Curve</strong>: Measured during factory tests by plotting terminal voltage vs. field current 
  at no-load. The saturation curve is the deviation from the air-gap line.</li>
  <li><strong>Standard Points S<sub>1.0</sub> and S<sub>1.2</sub></strong>: IEEE Std 1110 defines saturation factors at 
  1.0 pu and 1.2 pu terminal voltage:
    <ul>
      <li>S<sub>1.0</sub>: saturation factor at rated voltage (typically 0.03–0.10)</li>
      <li>S<sub>1.2</sub>: saturation factor at 120% voltage (typically 0.3–0.6)</li>
    </ul>
  </li>
  <li><strong>Curve Fitting</strong>: Parameters A, B, C are obtained by fitting the exponential function to the measured 
  saturation curve or to the S<sub>1.0</sub>/S<sub>1.2</sub> data points using least-squares or nonlinear optimization.</li>
</ol>

<h3>Numerical Considerations</h3>
<ul>
  <li><strong>Initial Conditions</strong>: For saturated initial conditions, ensure that the flux magnitude F2m is consistent 
  with the saturation curve to avoid initialization issues.</li>
</ul>

<h3>Related Components</h3>
<ul>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.PartialSaturationFunction\">PartialSaturationFunction</a> 
  — base class defining the saturation function interface (input u, output y)</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.Model_2_2_Electric\">Model_2_2_Electric</a> 
  — electrical model (IEEE Model 2.2) that uses saturation functions</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.Interfaces.PartialElectrical\">PartialElectrical</a> 
  — base class with <code>is_saturable</code> parameter and <code>sat_d</code> component declaration</li>
  <li><a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a> 
  — main generator model where saturation is enabled/disabled</li>
</ul>

<h3>References</h3>
<ul>
  <li><strong>CEPEL/ANATEM</strong>: <em>Modelos de Curva de Saturação - Curva de saturação exponencial (tipo 2)</em>. 
  ANATEM User Manual, Centro de Pesquisas de Energia Elétrica (CEPEL), Brazil. 
  Available: <a href=\"https://see.cepel.br/manual/anatem/equipamentos/maquinas_sincronas/saturacao.html\" target=\"_blank\">https://see.cepel.br/manual/anatem/equipamentos/maquinas_sincronas/saturacao.html</a></li>
  <li>IEEE Std 1110-2002: <em>IEEE Guide for Synchronous Generator Modeling Practices and Applications in Power System Stability Analyses</em></li>
  <li>Kundur, P. (1994). <em>Power System Stability and Control</em>. McGraw-Hill. (Chapters on synchronous machine modeling and saturation)</li>
</ul>

<h3>Compatibility Note</h3>
<p>
This model is compatible with the <strong>ANATEM type 2 saturation curve</strong> used in CEPEL's power system stability program. 
The parameter correspondence is direct: OmniPES parameters A, B, C map exactly to ANATEM parameters P1, P2, P3 for tipo=2 in the 
DCST data entry code. This ensures consistency when transferring generator models between OmniPES/Modelica and ANATEM environments.
</p>

</body></html>"));
end Exponential_2;