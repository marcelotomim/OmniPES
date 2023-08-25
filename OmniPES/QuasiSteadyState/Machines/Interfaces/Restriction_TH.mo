within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Restriction_TH
  extends QuasiSteadyState.Machines.Interfaces.Restriction;
  import Modelica.Constants.pi;
initial equation
  theta = param.theta_esp;
end Restriction_TH;