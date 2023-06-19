within OmniPES.QuasiSteadyState.Examples;

model Test_CtrlVoltageSource
  import Modelica.ComplexMath.exp;
  OmniPES.Circuit.Sources.ControlledVoltageSource controlledVoltageSource annotation(
    Placement(visible = true, transformation(origin = {12, 2}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex annotation(
    Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Step step(height = 1, startTime = 0.1) annotation(
    Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  constant Complex j = Complex(0, 1);
  Real delta;
  Circuit.Basic.SeriesImpedance seriesImpedance(x = 0.05) annotation(
    Placement(visible = true, transformation(origin = {40, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Sources.VoltageSource voltageSource annotation(
    Placement(visible = true, transformation(origin = {76, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
equation
// Variável delta controlada, provoca alterações na potência aparente transferida da fonte controlada até a fonte fixa
  delta = if time > 0.5 then 1 else 0;
  realToComplex.y*exp(j*delta) = controlledVoltageSource.u;
  connect(const.y, realToComplex.im) annotation(
    Line(points = {{-78, -20}, {-68, -20}, {-68, -6}, {-56, -6}}, color = {0, 0, 127}));
  connect(step.y, realToComplex.re) annotation(
    Line(points = {{-79, 20}, {-66, 20}, {-66, 6}, {-56, 6}}, color = {0, 0, 127}));
  connect(controlledVoltageSource.p, seriesImpedance.p) annotation(
    Line(points = {{12, 12}, {30, 12}}, color = {0, 0, 255}));
  connect(seriesImpedance.n, voltageSource.p) annotation(
    Line(points = {{50, 12}, {76, 12}}, color = {0, 0, 255}));
end Test_CtrlVoltageSource;