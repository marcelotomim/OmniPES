within OmniPES.QuasiSteadyState.Controllers.PSS;

model NoPSS
  extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialPSS;
equation
  Vsad = 0;
end NoPSS;