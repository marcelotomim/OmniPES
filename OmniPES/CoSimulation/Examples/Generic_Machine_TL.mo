within OmniPES.CoSimulation.Examples;

model Generic_Machine_TL
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-41, 43}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
    Placement(visible = true, transformation(origin = {78, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs annotation(
    Placement(visible = true, transformation(origin = {40, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //
  OmniPES.QuasiSteadyState.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.QuasiSteadyState.Controllers.PSS.NoPSS pss, redeclare OmniPES.QuasiSteadyState.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(visible = true, transformation(origin = {71, 1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));

  Modelica.Blocks.Interfaces.RealInput var_Ehk_im(start = 0) annotation(
    Placement(visible = true, transformation(origin = {-75, -83}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex annotation(
    Placement(visible = true, transformation(origin = {-32, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
BergeronLink bergeronLink(Vesp = gen1_specs.Vesp, Zc = Complex(gen1_data.convData.Ra, gen1_data.convData.X2d), theta_esp = gen1_specs.theta_esp) annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput var_Ehk_re(start = 0) annotation(
    Placement(visible = true, transformation(origin = {-75, -37}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(realToComplex.y, bergeronLink.var_Ehk) annotation(
    Line(points = {{-20, -54}, {-10, -54}, {-10, -6}, {-2, -6}}, color = {85, 170, 255}));
  connect(var_Ehk_re, realToComplex.re) annotation(
    Line(points = {{-74, -36}, {-54, -36}, {-54, -48}, {-44, -48}}, color = {0, 0, 127}));
  connect(var_Ehk_im, realToComplex.im) annotation(
    Line(points = {{-74, -82}, {-54, -82}, {-54, -60}, {-44, -60}}, color = {0, 0, 127}));
connect(bergeronLink.pin_p, SM.terminal) annotation(
    Line(points = {{22, 0}, {42, 0}, {42, 1}, {56, 1}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")));
end Generic_Machine_TL;