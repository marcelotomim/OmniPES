within OmniPES.Transient.Controllers.PSS;

model NoPSS
  extends Interfaces.PartialPSS;
equation
  Vsad = 0;
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end NoPSS;