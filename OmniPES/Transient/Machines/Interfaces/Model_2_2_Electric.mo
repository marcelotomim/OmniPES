within OmniPES.Transient.Machines.Interfaces;

model Model_2_2_Electric
  extends Interfaces.PartialElectrical;
  Modelica.Units.SI.PerUnit F1d(start = 1.0);
  Modelica.Units.SI.PerUnit Fkd(start = 1.0);
  Modelica.Units.SI.PerUnit Fgq(start = 1.0);
  Modelica.Units.SI.PerUnit Fkq(start = 1.0);
  Modelica.Units.SI.PerUnit Ifd, Ikd;
  Modelica.Units.SI.PerUnit Igq, Ikq;
protected
  parameter Modelica.Units.SI.PerUnit x2q = smData.convData.X2q;
  parameter Modelica.Units.SI.PerUnit x2d = smData.convData.X2d;
  parameter Modelica.Units.SI.PerUnit x1d = smData.convData.X1d;
  parameter Modelica.Units.SI.PerUnit x1q = smData.convData.X1q;
  parameter Modelica.Units.SI.PerUnit xd = smData.convData.Xd;
  parameter Modelica.Units.SI.PerUnit xq = smData.convData.Xq;
  parameter Modelica.Units.SI.PerUnit T1d0 = smData.convData.T1d0;
  parameter Modelica.Units.SI.PerUnit T1q0 = smData.convData.T1q0;
  parameter Modelica.Units.SI.PerUnit T2q0 = smData.convData.T2q0;
  parameter Modelica.Units.SI.PerUnit T2d0 = smData.convData.T2d0;
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