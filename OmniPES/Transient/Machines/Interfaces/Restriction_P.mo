within OmniPES.Transient.Machines.Interfaces;

model Restriction_P
  extends Restriction;
initial equation
  P = param.Psp/data.Sbase;
end Restriction_P;