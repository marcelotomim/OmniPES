within OmniPES.QuasiSteadyState.Machines.Interfaces;

model Classical_Electric
  OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Efd(start = 1.0, unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput delta(start = 0.0, unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pt(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Qt(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Units.CPerUnit Vt(re(start = 1.0), im(start = 0.0));
  OmniPES.Units.CPerUnit Ia(re(start = 0.0), im(start = 0.0));
  Modelica.Blocks.Interfaces.RealOutput Pe(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  OmniPES.Units.PerUnit Te(start=1.0);
  //        protected
  OmniPES.Units.CPerUnit St;
  OmniPES.Units.CPerUnit E1;
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.exp;
equation
  Vt = terminal.v;
  Ia = -terminal.i;
  St = Vt*conj(Ia);
  Pt = St.re;
  Qt = St.im;
  Pe = E1.re*Ia.re + E1.im*Ia.im;
  E1 = Vt + Complex(smData.convData.Ra, smData.convData.X1d)*Ia;
  Efd = abs(E1);
//  E1.im = E1.re*tan(delta);
//  delta = atan2(E1.im, E1.re);
  delta = Modelica.ComplexMath.arg(E1);
end Classical_Electric;
