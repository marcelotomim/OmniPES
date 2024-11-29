within OmniPES.Transient.Machines.Interfaces;

model Model_2_1_Electric
  extends Interfaces.PartialElectrical;
  Modelica.Units.SI.PerUnit F1d(start = 1.0);
  Modelica.Units.SI.PerUnit F2d(start = 1.0);
  Modelica.Units.SI.PerUnit F2q(start = 0);
  Modelica.Units.SI.PerUnit XmdIfd, Fdi;
  protected
  parameter Modelica.Units.SI.PerUnit x2d = smData.convData.X2d;
  parameter Modelica.Units.SI.PerUnit x2q = smData.convData.X2q;
  parameter Modelica.Units.SI.PerUnit x1d = smData.convData.X1d;
  parameter Modelica.Units.SI.PerUnit xd = smData.convData.Xd;
  parameter Modelica.Units.SI.PerUnit xq = smData.convData.Xq;
  parameter Modelica.Units.SI.PerUnit T1d0 = smData.convData.T1d0;
  parameter Modelica.Units.SI.PerUnit T2q0 = smData.convData.T2q0;
  parameter Modelica.Units.SI.PerUnit T2d0 = smData.convData.T2d0;
initial equation
  der(F1d) = 0;
  der(Fdi) = 0;
  der(F2q) = 0;
equation
  if is_saturable then
    F1d = sat_d.u;
  end if;
  T1d0*der(F1d) = Efd - XmdIfd;
  T2d0*der(Fdi) = -F2d + F1d - (x1d-x2d)*Iqd.im;
  T2q0*der(F2q) = -F2q - (xq-x2q)*Iqd.re;
  Fdi = F2d - (x2d-xl)/(x1d-xl)*F1d;
  XmdIfd = -(xd-x1d)/(x1d-xl)*F2d + (xd-xl)/(x1d-xl)*F1d + (x2d-xl)/(x1d-xl)*(xd-x1d)*Iqd.im + (if is_saturable then sat_d.y else 0);
  Fqd.im = F2d - x2d*Iqd.im;
  Fqd.re = F2q - x2q*Iqd.re;
end Model_2_1_Electric;