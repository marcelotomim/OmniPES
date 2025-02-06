within OmniPES.Transient.SynchronousMachines.Interfaces;

model Classical_Electric
  import Modelica.Units.SI;
  import Modelica.Blocks.Interfaces;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.exp;
  parameter Transient.SynchronousMachines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Efd(start = 1.0, unit = "pu") "transient voltage magnitude" annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput delta(start = 0.0, unit = "rad", displayUnit = "deg") "load angle" annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-109.5, 70.5}, extent = {{-9.5, -9.5}, {9.5, 9.5}}, rotation = 0)));
  Interfaces.RealOutput Pt(unit = "pu") "terminal active power" annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.RealOutput Qt(unit = "pu") "terminal reactive power" annotation(
    Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.RealOutput Pe(unit = "pu") "electrical converted power" annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SI.ComplexPerUnit Vt(re(start = 1.0), im(start = 0.0)) "terminal voltage";
  SI.ComplexPerUnit Ia(re(start = 0.0), im(start = 0.0)) "armature current";
  SI.ComplexPerUnit St "apparent power";
  SI.ComplexPerUnit E1 "transient voltage";
  equation
  Vt = terminal.v;
  Ia = -terminal.i;
  St = Vt*conj(Ia);
  Pt = St.re;
  Qt = St.im;
  Pe = E1.re*Ia.re + E1.im*Ia.im;
  E1 = Vt + Complex(smData.Ra, smData.X1d)*Ia;
  Efd = abs(E1);
  delta = Modelica.ComplexMath.arg(E1);
annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end Classical_Electric;