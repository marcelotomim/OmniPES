within OmniPES.Transient.Controllers.SpeedRegulators;

model ConstantPm
  extends Interfaces.PartialSpeedRegulator;
equation
  der(Pm) = 0;
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end ConstantPm;