within OmniPES.QuasiSteadyState.Controllers.SpeedRegulators;

model ConstantPm
  extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialSpeedRegulator;
equation
  der(Pm) = 0;
end ConstantPm;