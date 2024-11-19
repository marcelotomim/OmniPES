within OmniPES.Transient.Machines.Interfaces;

model Model_1_0_Electric
  extends Interfaces.PartialElectrical;
  Modelica.Units.SI.PerUnit F1d(start=1.0);
  Modelica.Units.SI.PerUnit XmdIfd(start=1.0);
protected
  parameter Modelica.Units.SI.PerUnit x1d = smData.convData.X1d;
  parameter Modelica.Units.SI.PerUnit xd = smData.convData.Xd;
  parameter Modelica.Units.SI.PerUnit xq = smData.convData.Xq;
  parameter Modelica.Units.SI.PerUnit T1d0 = smData.convData.T1d0;
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
end Model_1_0_Electric;