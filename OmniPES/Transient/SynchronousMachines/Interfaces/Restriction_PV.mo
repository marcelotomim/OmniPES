within OmniPES.Transient.SynchronousMachines.Interfaces;

model Restriction_PV
  extends Restriction;
initial equation
  P = param.Psp/data.Sbase;
  V = param.Vsp;
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end Restriction_PV;