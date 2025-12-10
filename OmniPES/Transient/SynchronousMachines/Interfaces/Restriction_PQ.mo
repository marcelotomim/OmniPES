within OmniPES.Transient.SynchronousMachines.Interfaces;

model Restriction_PQ
  extends Restriction;
initial equation
  P = param.Psp/data.Sbase;
  Q = param.Qsp/data.Sbase;
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Restriction_PQ;