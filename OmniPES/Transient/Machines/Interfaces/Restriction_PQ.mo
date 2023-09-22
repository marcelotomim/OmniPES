within OmniPES.Transient.Machines.Interfaces;

model Restriction_PQ
  extends Restriction;
initial equation
  P = param.Psp/data.Sbase;
  Q = param.Qsp/data.Sbase;
end Restriction_PQ;