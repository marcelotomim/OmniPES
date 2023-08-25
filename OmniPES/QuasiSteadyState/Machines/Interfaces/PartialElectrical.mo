within OmniPES.QuasiSteadyState.Machines.Interfaces;

partial model PartialElectrical
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  import OmniPES.Math.sys2qd;
  parameter QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter Units.PerUnit ra = smData.convData.Ra;
  parameter Units.PerUnit xl = smData.convData.Xl;
  Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Efd(start = 1.0, unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput delta(unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Units.PerUnit Pt, Qt;
  Modelica.Blocks.Interfaces.RealOutput Pe(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Units.CPerUnit Vqd(re(start = 1.0), im(start = 0.0));
  Units.CPerUnit Iqd;
  Units.CPerUnit Fqd;
  Units.CPerUnit Faqd;
  Units.CPerUnit St;
  Units.PerUnit Vabs(start = 1.0);
  Modelica.Units.SI.Angle theta;  
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
  Vqd = -ra*Iqd - j*Fqd;
  Pe = Fqd.im*Iqd.re - Fqd.re*Iqd.im;
  Fqd = xl*Iqd + Faqd;
annotation(
    Icon(graphics = {Text(extent = {{-80, 30}, {80, -30}}, textString = "Electrical"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end PartialElectrical;
