within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Restriction_PV
  extends OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction;
initial equation
  P = param.Pesp/data.Sbase;
  V = param.Vesp;
end Restriction_PV;