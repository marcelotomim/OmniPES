within OmniPES.QuasiSteadyState.Controllers.PSS;

model NoPSS
  extends Interfaces.PartialPSS;
equation
  Vsad = 0;
end NoPSS;