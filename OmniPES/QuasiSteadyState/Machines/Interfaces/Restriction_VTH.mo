within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Restriction_VTH
  extends QuasiSteadyState.Machines.Interfaces.Restriction;
  import Modelica.Constants.pi;
initial equation
  V = param.Vesp;
  theta = param.theta_esp;
end Restriction_VTH;