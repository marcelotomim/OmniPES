within OmniPES.Transient.SynchronousMachines.Interfaces;

model Model_2_1_Electric
  extends Interfaces.PartialElectrical;
  import Modelica.Units.SI;
  SI.PerUnit F1d(start = 1.0);
  SI.PerUnit F2d(start = 1.0);
  SI.PerUnit F2q(start = 0);
  SI.PerUnit XmdIfd, Fdi;
protected
  parameter SI.PerUnit x2d = smData.X2d;
  parameter SI.PerUnit x2q = smData.X2q;
  parameter SI.PerUnit x1d = smData.X1d;
  parameter SI.PerUnit xd = smData.Xd;
  parameter SI.PerUnit xq = smData.Xq;
  parameter SI.PerUnit T1d0 = smData.T1d0;
  parameter SI.PerUnit T2q0 = smData.T2q0;
  parameter SI.PerUnit T2d0 = smData.T2d0;
public
initial equation
  der(F1d) = 0;
  der(Fdi) = 0;
  der(F2q) = 0;
equation
  if is_saturable then
    F1d = sat_d.u;
  end if;
  T1d0*der(F1d) = Efd - XmdIfd;
  T2d0*der(Fdi) = -F2d + F1d - (x1d - x2d)*Iqd.im;
  T2q0*der(F2q) = -F2q - (xq - x2q)*Iqd.re;
  Fdi = F2d - (x2d - xl)/(x1d - xl)*F1d;
  XmdIfd = -(xd - x1d)/(x1d - xl)*F2d + (xd - xl)/(x1d - xl)*F1d + (x2d - xl)/(x1d - xl)*(xd - x1d)*Iqd.im + (if is_saturable then sat_d.y else 0);
  Fqd.im = F2d - x2d*Iqd.im;
  Fqd.re = F2q - x2q*Iqd.re;
  annotation(
    Icon(graphics = {Text(origin = {0, -60}, extent = {{-90, 40}, {90, -3}}, textString = "(2, 1)", fontSize = 8)}));
end Model_2_1_Electric;