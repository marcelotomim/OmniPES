within OmniPES.Transient.Controllers.AVR;

model ConstantEfd
  extends Interfaces.PartialAVR;
equation
  der(Efd) = 0;
end ConstantEfd;