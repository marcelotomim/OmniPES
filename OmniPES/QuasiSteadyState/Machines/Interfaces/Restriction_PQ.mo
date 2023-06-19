within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Restriction_PQ
  extends OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction;
initial equation
  P = param.Pesp/data.Sbase;
  Q = param.Qesp/data.Sbase;
end Restriction_PQ;