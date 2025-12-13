within OmniPES.Transient.SynchronousMachines;

function ConvertBase
  import Modelica.Units.SI;
  input SynchronousMachineData machine_data "Machine parameters";
  input SI.ApparentPower MVAs "System base power";
  output SynchronousMachineData conv_data "Machine parameters in the system base";
  protected
  Real conv_factor;
algorithm
  conv_factor := MVAs/machine_data.MVAb/machine_data.Nmaq;
  conv_data.Nmaq := 1; 
  conv_data.MVAb := MVAs;
  conv_data.Ra := conv_factor*machine_data.Ra;
  conv_data.Xl := conv_factor*machine_data.Xl;
  conv_data.Xd := conv_factor*machine_data.Xd;
  conv_data.Xq := conv_factor*machine_data.Xq; 
  conv_data.X1d := conv_factor*machine_data.X1d; 
  conv_data.X1q := conv_factor*machine_data.X1q; 
  conv_data.X2d := conv_factor*machine_data.X2d; 
  conv_data.X2q := conv_factor*machine_data.X2q; 
  conv_data.H := machine_data.H/conv_factor; 
  conv_data.D := machine_data.D/conv_factor; 
  conv_data.T1d0 := machine_data.T1d0; 
  conv_data.T1q0 := machine_data.T1q0; 
  conv_data.T2d0 := machine_data.T2d0; 
  conv_data.T2q0 := machine_data.T2q0;
  annotation(
    Documentation(info="<html><head></head><body>
<h3>ConvertBase</h3>
<p>Converts a machine data record from its own base (<code>MVAb</code>, <code>Nmaq</code>) to the system base <code>MVAs</code>, producing a normalized copy suitable for simulation across the network.</p>

<h4>Inputs/Outputs</h4>
<ul>
  <li><strong>machine_data</strong>: <a href=\"modelica://OmniPES.Transient.SynchronousMachines.SynchronousMachineData\">SynchronousMachineData</a> on machine base.</li>
  <li><strong>MVAs</strong>: system base apparent power.</li>
  <li><strong>conv_data</strong>: converted record on the system base (<code>MVAb = MVAs</code>, <code>Nmaq = 1</code>).</li>
  
</ul>

<h4>Conversion Factor</h4>
<p>The per‑unit scaling uses the factor:</p>
<p style=\"text-align:center; font-size:1.1em; margin:10px 0;\">
  <code>conv_factor = MVAs / (MVAb · Nmaq)</code>
</p>
<ul>
  <li>Impedances: <code>X* = conv_factor · X*</code>; <code>Ra = conv_factor · Ra</code></li>
  <li>Inertia/damping: <code>H = H / conv_factor</code>; <code>D = D / conv_factor</code></li>
  <li>Time constants: unchanged (<code>T1d0, T1q0, T2d0, T2q0</code>)</li>
  <li>Base values set: <code>conv_data.MVAb = MVAs</code>, <code>conv_data.Nmaq = 1</code></li>
</ul>

<h4>Notes</h4>
<ul>
  <li>Use together with <a href=\"modelica://OmniPES.Transient.SynchronousMachines.GenericSynchronousMachine\">GenericSynchronousMachine</a>, which creates <code>convData</code> internally.</li>
</ul>

</body></html>"));
end ConvertBase;