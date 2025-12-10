within OmniPES.Transient.SynchronousMachines.Interfaces;

model Restriction_TH
  extends Restriction;
  import Modelica.Constants.pi;
initial equation
  theta = param.theta_sp;
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Restriction_TH;