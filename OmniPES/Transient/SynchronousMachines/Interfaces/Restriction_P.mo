within OmniPES.Transient.SynchronousMachines.Interfaces;

model Restriction_P
  extends Restriction;
initial equation
  P = param.Psp/data.Sbase;
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Restriction_P;