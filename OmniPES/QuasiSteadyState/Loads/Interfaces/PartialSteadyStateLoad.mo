within OmniPES.QuasiSteadyState.Loads.Interfaces;

partial model PartialSteadyStateLoad
  parameter OmniPES.Units.ActivePower Pesp "Specified active power [MW]";
  parameter OmniPES.Units.ReactivePower Qesp "Specified reactive power [Mvar]";
  parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData par;
  Modelica.ComplexBlocks.Interfaces.ComplexInput v annotation(
    Placement(visible = true, transformation(origin = {-120, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput i annotation(
    Placement(visible = true, transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Vo(start = 1.0) annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  outer OmniPES.SystemData data;
  import Modelica.ComplexMath.conj;
  //  assert(Vo > 0,"ERROR: Vo cannot be negative.");
equation
  if initial() then
    Vo^2 = v.re^2 + v.im^2;
  else
    der(Vo) = 0;
  end if;
end PartialSteadyStateLoad;