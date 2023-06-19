within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Model_2_2_Electric
  extends OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical;
  OmniPES.Units.PerUnit F1d(start = 1.0);
  OmniPES.Units.PerUnit Fkd(start = 1.0);
  OmniPES.Units.PerUnit Fgq(start = 1.0);
  OmniPES.Units.PerUnit Fkq(start = 1.0);
protected
  parameter OmniPES.Units.PerUnit x2q = smData.convData.X2q;
  parameter OmniPES.Units.PerUnit x2d = smData.convData.X2d;
  parameter OmniPES.Units.PerUnit x1d = smData.convData.X1d;
  parameter OmniPES.Units.PerUnit x1q = smData.convData.X1q;
  parameter OmniPES.Units.PerUnit xd = smData.convData.Xd;
  parameter OmniPES.Units.PerUnit xq = smData.convData.Xq;
  parameter OmniPES.Units.PerUnit T1d0 = smData.convData.T1d0;
  parameter OmniPES.Units.PerUnit T1q0 = smData.convData.T1q0;
  parameter OmniPES.Units.PerUnit T2q0 = smData.convData.T2q0;
  parameter OmniPES.Units.PerUnit T2d0 = smData.convData.T2d0;
  OmniPES.Units.PerUnit Ifd, Ikd;
  OmniPES.Units.PerUnit Igq, Ikq;
initial equation
  der(F1d) = 0;
  der(Fkd) = 0;
  der(Fgq) = 0;
  der(Fkq) = 0;
equation
  T1d0*der(F1d) = Efd - (xd - xl)*Ifd;
  T2d0*der(Fkd) = (x1d - xl)^2/(x2d - x1d)*Ikd;
  T1q0*der(Fgq) = (xq - xl)^2/(x1q - xq)*Igq;
  T2q0*der(Fkq) = (x1q - xl)^2/(x2q - x1q)*Ikq;
  Ifd = ((x1d - xd)/(xd - xl)*Faqd.im + F1d)/(x1d - xl);
  Ikd = (x2d - x1d)*(Faqd.im - Fkd)/(x2d - xl)/(x1d - xl);
  Igq = (x1q - xq)*(Faqd.re - Fgq)/(x1q - xl)/(xq - xl);
  Ikq = (x2q - x1q)*(Faqd.re - Fkq)/(x2q - xl)/(x1q - xl);
  Faqd.im = (x2d - xl)*Iqd.im + (x2d - xl)*F1d/(x1d - xl) + (x1d - x2d)*Fkd/(x1d - xl);
  Faqd.re = (x2q - xl)*Iqd.re + (x1q - x2q)/(x1q - xl)*Fkq + (x2q - xl)*(xq - x1q)/(x1q - xl)/(xq - xl)*Fgq;
end Model_2_2_Electric;