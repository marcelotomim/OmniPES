within OmniPES.Transient.Controllers.SpeedRegulators;

model ConstantPm
  extends Interfaces.PartialSpeedRegulator;
equation
  der(Pm) = 0;
end ConstantPm;