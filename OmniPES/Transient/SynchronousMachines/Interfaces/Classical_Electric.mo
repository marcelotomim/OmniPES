within OmniPES.Transient.SynchronousMachines.Interfaces;

model Classical_Electric
  extends Interfaces.PartialElectrical(redeclare final parameter Boolean is_saturable=false, redeclare final parameter Boolean allow_ctrl=false);
  import Modelica.Units.SI;
protected
  final parameter SI.PerUnit x1d = smData.X1d;
equation
  Fqd.im = Efd - x1d*Iqd.im;
  Fqd.re = - x1d*Iqd.re;
annotation(
    Icon(graphics = {Text(origin = {0, -60}, extent = {{-90, 25}, {90, -5}}, textString = "Classical")}));

end Classical_Electric;