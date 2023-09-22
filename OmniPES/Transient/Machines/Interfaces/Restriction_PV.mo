within OmniPES.Transient.Machines.Interfaces;

model Restriction_PV
  extends Restriction;
initial equation
  P = param.Psp/data.Sbase;
  V = param.Vsp;
end Restriction_PV;