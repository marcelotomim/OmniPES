within OmniPES.Transient.SynchronousMachines.Interfaces;

model Model_1_0_Electric
  extends Interfaces.PartialElectrical;
  import Modelica.Units.SI;
  SI.PerUnit F1d(start=1.0);
  SI.PerUnit XmdIfd(start=1.0);
protected
  parameter SI.PerUnit x1d = smData.X1d;
  parameter SI.PerUnit xd = smData.Xd;
  parameter SI.PerUnit xq = smData.Xq;
  parameter SI.PerUnit T1d0 = smData.T1d0;
initial equation
  der(F1d) = 0;
equation
  if is_saturable then
    F1d = sat_d.u;
  end if;
  T1d0*der(F1d) = Efd - XmdIfd;
  XmdIfd = F1d + (xd - x1d)*Iqd.im + (if is_saturable then sat_d.y else 0);
  Fqd.im = F1d - x1d*Iqd.im;
  Fqd.re = -xq*Iqd.re;
annotation(
    Icon(graphics = {Text(origin = {0, -60}, extent = {{-90, 40}, {90, -3}}, textString = "(1, 0)", fontSize = 8)}));
end Model_1_0_Electric;