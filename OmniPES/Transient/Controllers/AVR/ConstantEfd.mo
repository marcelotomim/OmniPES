within OmniPES.Transient.Controllers.AVR;

model ConstantEfd
  extends Interfaces.PartialAVR;
equation
  der(Efd) = 0;
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end ConstantEfd;