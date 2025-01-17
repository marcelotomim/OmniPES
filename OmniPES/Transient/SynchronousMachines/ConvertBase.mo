within OmniPES.Transient.SynchronousMachines;

function ConvertBase
  import OmniPES.Units;
  input SynchronousMachineData machine_data "Machine parameters";
  input Units.ApparentPower MVAs "System base power";
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
end ConvertBase;