within OmniPES.Transient.SynchronousMachines.Interfaces;

model Restriction_VTH
  extends Restriction;
  import Modelica.Constants.pi;
initial equation
  V = param.Vsp;
  theta = param.theta_sp;
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Restriction_VTH;