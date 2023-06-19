within OmniPES.QuasiSteadyState.Controllers.AVR;

model ConstantEfd
  extends OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR;
equation
  der(Efd) = 0;
end ConstantEfd;