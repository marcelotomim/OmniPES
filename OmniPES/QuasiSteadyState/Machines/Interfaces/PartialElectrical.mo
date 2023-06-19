within OmniPES.QuasiSteadyState.Machines.Interfaces;

partial model PartialElectrical
  OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Efd(start = 1.0, unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput delta(unit = "rad", displayUnit = "deg") annotation(
    Placement(visible = true, transformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Pt(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Qt(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Units.CPerUnit Vqd(re(start = 1.0), im(start = 0.0));
  OmniPES.Units.CPerUnit Iqd;
  //(re(start = 1.0), im(start = 0.0));
  OmniPES.Units.CPerUnit Fqd;
  //(re(start = 0.0), im(start = 1.0));
  OmniPES.Units.CPerUnit Faqd;
  //(re(start = 0.0), im(start = 1.0));
  Modelica.Blocks.Interfaces.RealOutput Pe(unit = "pu") annotation(
    Placement(visible = true, transformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //  OmniPES.Units.PerUnit Te(start=1.0);
  //        protected
  OmniPES.Units.CPerUnit St;
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {-2, 74}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter OmniPES.Units.PerUnit ra = smData.convData.Ra;
  parameter OmniPES.Units.PerUnit xl = smData.convData.Xl;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.conj;
initial equation
  der(delta) = 0.0;
equation
  Vqd = OmniPES.Math.sys2qd(terminal.v, delta);
  Iqd = OmniPES.Math.sys2qd(-terminal.i, delta);
  St = Vqd*conj(Iqd);
  Pt = St.re;
  Qt = St.im;
//  Pe = Pt + ra * (terminal.i.re ^ 2 + terminal.i.im ^ 2);
  Vqd = -ra*Iqd - j*Fqd;
  Pe = Fqd.im*Iqd.re - Fqd.re*Iqd.im;
  Fqd = xl*Iqd + Faqd;
annotation(
    Icon(graphics = {Text(extent = {{-80, 30}, {80, -30}}, textString = "Electrical"), Rectangle(extent = {{-100, 100}, {100, -100}})}));
end PartialElectrical;