within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Restriction_PV
  extends QuasiSteadyState.Machines.Interfaces.Restriction;
initial equation
  P = param.Psp/data.Sbase;
  V = param.Vsp;
end Restriction_PV;