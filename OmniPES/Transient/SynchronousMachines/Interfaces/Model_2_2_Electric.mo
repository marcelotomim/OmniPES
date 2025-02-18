within OmniPES.Transient.SynchronousMachines.Interfaces;

model Model_2_2_Electric
  extends Interfaces.PartialElectrical;
  import Modelica.Units.SI;
  SI.PerUnit F1d(start = 1.0);
  SI.PerUnit F2d(start = 1.0);
  SI.PerUnit Fdi(start = 1.0);
  SI.PerUnit F1q(start = 1.0);
  SI.PerUnit F2q(start = 1.0);
  SI.PerUnit Fqi(start = 1.0);
  SI.PerUnit XmdIfd(start = 1.0);
  SI.PerUnit XmqIgq(start = 0.0);
  SI.PerUnit F2m if is_saturable;
  SI.PerUnit sd if is_saturable;
  SI.PerUnit sq if is_saturable;

protected
  parameter SI.PerUnit x2q = smData.X2q;
  parameter SI.PerUnit x2d = smData.X2d;
  parameter SI.PerUnit x1d = smData.X1d;
  parameter SI.PerUnit x1q = smData.X1q;
  parameter SI.PerUnit xd = smData.Xd;
  parameter SI.PerUnit xq = smData.Xq;
  parameter SI.Time T1d0 = smData.T1d0;
  parameter SI.Time T1q0 = smData.T1q0;
  parameter SI.Time T2q0 = smData.T2q0;
  parameter SI.Time T2d0 = smData.T2d0;
public
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
annotation(
    Icon(graphics = {Text(origin = {0, -60}, extent = {{-90, 40}, {90, -3}}, textString = "(2, 2)", fontSize = 8)}));
end Model_2_2_Electric;