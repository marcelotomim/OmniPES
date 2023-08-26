within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Restriction_PQ
  extends QuasiSteadyState.Machines.Interfaces.Restriction;
initial equation
  P = param.Psp/data.Sbase;
  Q = param.Qsp/data.Sbase;
end Restriction_PQ;