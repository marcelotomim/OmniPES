within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Restriction_TH
  extends QuasiSteadyState.Machines.Interfaces.Restriction;
  import Modelica.Constants.pi;
initial equation
  theta = param.theta_sp;
end Restriction_TH;