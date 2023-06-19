within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Model_2_1_Electric
  extends OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical;
  OmniPES.Units.PerUnit F1d(start = 1.0);
  OmniPES.Units.PerUnit Fkd(start = 1.0);
  OmniPES.Units.PerUnit Fkq(start = 0.0);
protected
  parameter OmniPES.Units.PerUnit x2q = smData.convData.X2q;
  parameter OmniPES.Units.PerUnit x2d = smData.convData.X2d;
  parameter OmniPES.Units.PerUnit x1d = smData.convData.X1d;
  parameter OmniPES.Units.PerUnit xd = smData.convData.Xd;
  parameter OmniPES.Units.PerUnit xq = smData.convData.Xq;
  parameter OmniPES.Units.PerUnit T1d0 = smData.convData.T1d0;
  parameter OmniPES.Units.PerUnit T2q0 = smData.convData.T2q0;
  parameter OmniPES.Units.PerUnit T2d0 = smData.convData.T2d0;
  OmniPES.Units.PerUnit Ifd(start = 1.0), Ikd(start = 0.0);
  OmniPES.Units.PerUnit Ikq(start = 0.0);
initial equation
  der(F1d) = 0;
  der(Fkd) = 0;
  der(Fkq) = 0;
equation
  T1d0*der(F1d) = Efd - (xd - xl)*Ifd;
  T2d0*der(Fkd) = (x1d - xl)^2/(x2d - x1d)*Ikd;
  T2q0*der(Fkq) = (xq - xl)^2/(x2q - xq)*Ikq;
  Ifd = ((x1d - xd)/(xd - xl)*Faqd.im + F1d)/(x1d - xl);
  Ikd = (x2d - x1d)*(Faqd.im - Fkd)/(x2d - xl)/(x1d - xl);
  Ikq = (x2q - xq)*(Faqd.re - Fkq)/(x2q - xl)/(xq - xl);
  Faqd.im = (x2d - xl)*Iqd.im + (x2d - xl)*F1d/(x1d - xl) + (x1d - x2d)*Fkd/(x1d - xl);
  Faqd.re = (x2q - xl)*Iqd.re + (xq - x2q)/(xq - xl)*Fkq;
end Model_2_1_Electric;