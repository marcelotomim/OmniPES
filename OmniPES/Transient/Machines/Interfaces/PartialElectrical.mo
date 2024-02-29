within OmniPES.Transient.Machines.Interfaces;

partial model PartialElectrical
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  import OmniPES.Math.sys2qd;
  parameter SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  protected
  parameter Modelica.Units.SI.PerUnit ra = smData.convData.Ra;
  parameter Modelica.Units.SI.PerUnit xl = smData.convData.Xl;
  public
  Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Efd(start = 1.0, unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput delta(unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Units.SI.PerUnit Pt, Qt;
  Modelica.Blocks.Interfaces.RealOutput Pe(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Vt(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Units.SI.ComplexPerUnit Vqd(re(start = 1.0), im(start = 0.0));
  Modelica.Units.SI.PerUnit Vabs(start = 1.0);
  Modelica.Units.SI.Angle theta;
  Modelica.Units.SI.ComplexPerUnit St;
  Modelica.Units.SI.ComplexPerUnit Iqd;
  Modelica.Units.SI.ComplexPerUnit Fqd;
  Modelica.Units.SI.ComplexPerUnit Faqd;
initial equation
  der(delta) = 0.0;
equation
  Vabs = abs(terminal.v);
  theta = arg(terminal.v);
  Vqd = sys2qd(terminal.v, delta);
  Iqd = sys2qd(-terminal.i, delta);
  St = Vqd*conj(Iqd);
  Pt = St.re;
  Qt = St.im;
  Vt = Vabs;
  Vqd = -ra*Iqd - j*Fqd;
  Fqd = xl*Iqd + Faqd;
  Pe = Fqd.im*Iqd.re - Fqd.re*Iqd.im;
annotation(
    Icon(graphics = {Text(extent = {{-80, 30}, {80, -30}}, textString = "Electrical"), Rectangle(extent = {{-100, 100}, {100, -100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end PartialElectrical;