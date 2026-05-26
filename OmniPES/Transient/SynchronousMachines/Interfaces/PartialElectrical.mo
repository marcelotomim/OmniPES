within OmniPES.Transient.SynchronousMachines.Interfaces;

partial model PartialElectrical
  import Modelica.Units.SI;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  import OmniPES.Math.sys2qd;
  parameter SynchronousMachineData smData "Record with machine parameters in the system base" annotation(
    Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Boolean is_saturable = false "Mark for enabling saturation." annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Saturation data"));
  replaceable OmniPES.Transient.SynchronousMachines.SaturationFunctions.Exponential_2 sat_d if is_saturable "Choose a saturation function model." constrainedby OmniPES.Transient.SynchronousMachines.Interfaces.PartialSaturationFunction annotation(choicesAllMatching = true, Placement(transformation(extent = {{-10, -10}, {10, 10}})), Dialog(group="Saturation data", enable = is_saturable));
  Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Efd(start = 1.5, unit = "1", min = 0) annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput delta(unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Pt(unit = "1");
  Modelica.Blocks.Interfaces.RealInput Qt(unit = "1");
  Modelica.Blocks.Interfaces.RealOutput Pe(unit = "1") annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Vt(unit = "1") annotation(
    Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SI.ComplexPerUnit Vqd(re(start = 1.0), im(start = 0.0));
  SI.PerUnit Vabs(start = 1.0);
  SI.Angle theta;
  SI.ComplexPerUnit St;
  SI.ComplexPerUnit Iqd;
  SI.ComplexPerUnit Fqd;
  final parameter Boolean allow_ctrl = true;
  Controllers.Interfaces.SignalBus signalBus annotation(
    Placement(transformation(origin = {-60, 80}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {0, 110}, extent = {{-20, -20}, {20, 20}})));  protected
  parameter SI.PerUnit ra = smData.Ra;
  parameter SI.PerUnit xl = smData.Xl;
equation
  Vabs = abs(terminal.v);
  theta = arg(terminal.v);
  Vqd = sys2qd(terminal.v, delta);
  Iqd = sys2qd(-terminal.i, delta);
  St = terminal.v*conj(-terminal.i);
  Pt = St.re;
  Qt = St.im;
  Vt = Vabs;
  Vqd.re = -ra*Iqd.re + Fqd.im;
  Vqd.im = -ra*Iqd.im - Fqd.re;
  Pe = Fqd.im*Iqd.re - Fqd.re*Iqd.im;
  
  connect(Pt, signalBus.TerminalActivePower);
  connect(Qt, signalBus.TerminalReactivePower);
annotation(
    Icon(graphics = {Text(extent = {{-80, 60}, {80, -60}}, textString = "Electrical"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
  annotation(
    Documentation(info="<html><body>TODO</body></html>"));

end PartialElectrical;