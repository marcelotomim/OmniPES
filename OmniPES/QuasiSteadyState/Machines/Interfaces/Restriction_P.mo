within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Restriction_P
  extends QuasiSteadyState.Machines.Interfaces.Restriction;
initial equation
  P = param.Pesp/data.Sbase;
end Restriction_P;