within OmniPES.Transient.SynchronousMachines.Interfaces;

model Model_Classical_Electric
  extends Interfaces.PartialElectrical(redeclare final parameter Boolean is_saturable=false, redeclare final parameter Boolean allow_ctrl=false);
  import Modelica.Units.SI;
protected
  final parameter SI.PerUnit x1d = smData.X1d;
equation
  Fqd.im = Efd - x1d*Iqd.im;
  Fqd.re = - x1d*Iqd.re;
annotation(
    Icon(graphics = {Text(origin = {0, -60}, extent = {{-90, 40}, {90, -3}}, textString = "(1, 0)", fontSize = 8)}));

end Model_Classical_Electric;