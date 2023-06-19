within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Model_1_0_Electric
  extends OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical;
  OmniPES.Units.PerUnit F1d;
  //(start = 1.0);
protected
  parameter OmniPES.Units.PerUnit x1d = smData.convData.X1d;
  parameter OmniPES.Units.PerUnit xd = smData.convData.Xd;
  parameter OmniPES.Units.PerUnit xq = smData.convData.Xq;
  parameter OmniPES.Units.PerUnit T1d0 = smData.convData.T1d0;
  OmniPES.Units.PerUnit Ifd;
initial equation
  der(F1d) = 0;
equation
  T1d0*der(F1d) = Efd - (xd - xl)*Ifd;
  Ifd = ((x1d - xd)/(xd - xl)*Faqd.im + F1d)/(x1d - xl);
  Faqd.im = (x1d - xl)*Iqd.im + F1d;
  Faqd.re = (xq - xl)*Iqd.re;
end Model_1_0_Electric;