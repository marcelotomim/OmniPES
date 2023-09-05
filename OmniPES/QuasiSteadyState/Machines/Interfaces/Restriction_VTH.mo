within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Restriction_VTH
  extends Restriction;
  import Modelica.Constants.pi;
initial equation
  V = param.Vsp;
  theta = param.theta_sp;
end Restriction_VTH;