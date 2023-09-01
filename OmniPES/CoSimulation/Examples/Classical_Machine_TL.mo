within OmniPES.CoSimulation.Examples;

model Classical_Machine_TL
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-74, 64}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData gen1_data annotation(
    Placement(visible = true, transformation(origin = {50, 52}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData gen1_specs(Psp = 80., Qsp = 15.798602722763516, Vsp = 1.0, theta_sp (displayUnit = "rad")= 0.3899475035313694)  annotation(
    Placement(visible = true, transformation(origin = {1, 53}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  //
  OmniPES.QuasiSteadyState.Machines.ClassicalSynchronousMachine SM(redeclare OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction_PQ restriction, smData = gen1_data, specs = gen1_specs) annotation(
    Placement(visible = true, transformation(origin = {62, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput var_Ehk_re(start = 0) annotation(
    Placement(visible = true, transformation(origin = {-75, -37}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput var_Ehk_im(start = 0) annotation(
    Placement(visible = true, transformation(origin = {-75, -83}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
OmniPES.CoSimulation.BergeronLink bergeronLink(Vsp = gen1_specs.Vsp, Zc = Complex(gen1_data.convData.Ra, gen1_data.convData.X1d), theta_sp = gen1_specs.theta_sp)  annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex annotation(
    Placement(visible = true, transformation(origin = {-32, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
connect(SM.terminal, bergeronLink.pin_p) annotation(
    Line(points = {{44, 0}, {21, 0}}, color = {0, 0, 255}));
connect(var_Ehk_re, realToComplex.re) annotation(
    Line(points = {{-74, -36}, {-54, -36}, {-54, -48}, {-44, -48}}, color = {0, 0, 127}));
connect(var_Ehk_im, realToComplex.im) annotation(
    Line(points = {{-74, -82}, {-54, -82}, {-54, -60}, {-44, -60}}, color = {0, 0, 127}));
connect(realToComplex.y, bergeronLink.var_Ehk) annotation(
    Line(points = {{-20, -54}, {-10, -54}, {-10, -6}, {-2, -6}}, color = {85, 170, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    Diagram);
end Classical_Machine_TL;