within OmniPES.QuasiSteadyState.Loads.Interfaces;

partial model PartialDynamicLoad
  parameter OmniPES.Units.ActivePower Pesp "Specified active power [MW]";
  parameter OmniPES.Units.ReactivePower Qesp "Specified reactive power [Mvar]";
  parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData par;
  Modelica.ComplexBlocks.Interfaces.ComplexInput v annotation(
    Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vo annotation(
    Placement(visible = true, transformation(origin = {-122, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 120}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput i annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  //  OmniPES.Units.CPerUnit S;
  outer OmniPES.SystemData data;
  import Modelica.ComplexMath.conj;
  OmniPES.Units.PerUnit Vabs(start = 1.0);
equation
//  S = v * conj(i);
  Vabs^2 = v.re^2 + v.im^2;
end PartialDynamicLoad;