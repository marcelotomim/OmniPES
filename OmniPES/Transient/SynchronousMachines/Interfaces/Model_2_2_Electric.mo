within OmniPES.Transient.SynchronousMachines.Interfaces;

model Model_2_2_Electric
  extends Interfaces.PartialElectrical;
  Modelica.Units.SI.PerUnit F1d(start = 1.0);
  Modelica.Units.SI.PerUnit F2d(start = 1.0);
  Modelica.Units.SI.PerUnit Fdi(start = 1.0);
  Modelica.Units.SI.PerUnit F1q(start = 1.0);
  Modelica.Units.SI.PerUnit F2q(start = 1.0);
  Modelica.Units.SI.PerUnit Fqi(start = 1.0);
  Modelica.Units.SI.PerUnit XmdIfd(start = 1.0);
  Modelica.Units.SI.PerUnit XmqIgq(start = 0.0);
  Modelica.Units.SI.PerUnit F2m if is_saturable;
  Modelica.Units.SI.PerUnit sd if is_saturable;
  Modelica.Units.SI.PerUnit sq if is_saturable;

protected
  parameter Modelica.Units.SI.PerUnit x2q = smData.X2q;
  parameter Modelica.Units.SI.PerUnit x2d = smData.X2d;
  parameter Modelica.Units.SI.PerUnit x1d = smData.X1d;
  parameter Modelica.Units.SI.PerUnit x1q = smData.X1q;
  parameter Modelica.Units.SI.PerUnit xd = smData.Xd;
  parameter Modelica.Units.SI.PerUnit xq = smData.Xq;
  parameter Modelica.Units.SI.PerUnit T1d0 = smData.T1d0;
  parameter Modelica.Units.SI.PerUnit T1q0 = smData.T1q0;
  parameter Modelica.Units.SI.PerUnit T2q0 = smData.T2q0;
  parameter Modelica.Units.SI.PerUnit T2d0 = smData.T2d0;
initial equation
  der(F1d) = 0;
  der(F1q) = 0;
  der(Fdi) = 0;
  der(Fqi) = 0;
equation
  if is_saturable then
   F2m = sqrt(F2d^2 + F2q^2);
   sat_d.u = F2m;
   sd = F2d/F2m*sat_d.y;
   sq = F2q/F2m*(xq-xl)/(xd-xl)*sat_d.y;
  end if;
  T1d0*der(F1d) = Efd - XmdIfd;
  T1q0*der(F1q) = -XmqIgq;
  T2d0*der(Fdi) = -F2d + F1d - (x1d-x2d)*Iqd.im;
  T2q0*der(Fqi) = -F2q + F1q - (x1q-x2q)*Iqd.re;
  Fdi = F2d - (x2d-xl)/(x1d-xl)*F1d;
  Fqi = F2q - (x2q-xl)/(x1q-xl)*F1q;
  XmdIfd = -(xd-x1d)/(x1d-xl)*F2d + (xd-xl)/(x1d-xl)*F1d + (x2d-xl)/(x1d-xl)*(xd-x1d)*Iqd.im + (if is_saturable then sd else 0);
  XmqIgq = -(xq-x1q)/(x1q-xl)*F2q + (xq-xl)/(x1q-xl)*F1q + (x2q-xl)/(x1q-xl)*(xq-x1q)*Iqd.re + (if is_saturable then sq else 0);
  Fqd.im = F2d - x2d*Iqd.im;
  Fqd.re = F2q - x2q*Iqd.re;
end Model_2_2_Electric;