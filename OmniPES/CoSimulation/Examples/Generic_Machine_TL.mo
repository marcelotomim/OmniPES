within OmniPES.CoSimulation.Examples;

model Generic_Machine_TL
  inner OmniPES.SystemData data annotation(
    Placement(visible = true, transformation(origin = {-41, 43}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.SynchronousMachineData gen1_data annotation(
    Placement(visible = true, transformation(origin = {78, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData gen1_specs annotation(
    Placement(visible = true, transformation(origin = {40, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //
  OmniPES.Transient.Machines.GenericSynchronousMachine SM(smData = gen1_data, specs = gen1_specs, redeclare OmniPES.Transient.Machines.Interfaces.Model_2_2_Electric electrical, redeclare OmniPES.Transient.Machines.Interfaces.Restriction_PQ restriction, redeclare IEEE_AC4A avr, redeclare OmniPES.Transient.Controllers.PSS.NoPSS pss, redeclare OmniPES.Transient.Controllers.SpeedRegulators.ConstantPm sreg) annotation(
    Placement(transformation(origin = {79, -1}, extent = {{-15, -15}, {15, 15}})));

  Modelica.Blocks.Interfaces.RealInput var_Ehk_im(start = 0) annotation(
    Placement(visible = true, transformation(origin = {-75, -83}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {44, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.ComplexBlocks.ComplexMath.RealToComplex realToComplex annotation(
    Placement(visible = true, transformation(origin = {-32, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
BergeronLink bergeronLink(Vsp = gen1_specs.Vsp, Zc = Complex(gen1_data.convData.Ra, gen1_data.convData.X2d), theta_sp = gen1_specs.theta_sp) annotation(
    Placement(transformation(origin = {32, 0}, extent = {{10, -10}, {-10, 10}})));
Modelica.Blocks.Interfaces.RealInput var_Ehk_re(start = 0) annotation(
    Placement(visible = true, transformation(origin = {-75, -37}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {46, -36}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

model IEEE_AC4A
  extends OmniPES.Transient.Controllers.Interfaces.PartialAVR;
  Modelica.Blocks.Continuous.FirstOrder Rectifier(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 200) annotation(
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add3(k1 = -1, k2 = +1) annotation(
    Placement(visible = true, transformation(origin = {-44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.Integrator Vref(initType = Modelica.Blocks.Types.Init.SteadyState, k = 1, y_start = 1) annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(
    Placement(visible = true, transformation(origin = {-124, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = +4, uMin = -4) annotation(
    Placement(visible = true, transformation(origin = {82, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.TransferFunction LeadLag(a = {1, 10}, b = {1, 1}, initType = Modelica.Blocks.Types.Init.SteadyState) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T = 0.01, initType = Modelica.Blocks.Types.Init.SteadyState, k = 1) annotation(
    Placement(visible = true, transformation(origin = {-80, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(add3.u3, Vsad) annotation(
    Line(points = {{-56, -8}, {-68, -8}, {-68, -60}, {-120, -60}}, color = {0, 0, 127}));
  connect(Vref.y, add3.u2) annotation(
    Line(points = {{-79, 0}, {-56, 0}}, color = {0, 0, 127}));
  connect(const.y, Vref.u) annotation(
    Line(points = {{-112, 0}, {-102, 0}, {-102, 0}, {-102, 0}}, color = {0, 0, 127}));
  connect(Rectifier.y, limiter.u) annotation(
    Line(points = {{51, 0}, {70, 0}}, color = {0, 0, 127}));
  connect(limiter.y, Efd) annotation(
    Line(points = {{93, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(add3.y, LeadLag.u) annotation(
    Line(points = {{-32, 0}, {-12, 0}, {-12, 0}, {-12, 0}}, color = {0, 0, 127}));
  connect(LeadLag.y, Rectifier.u) annotation(
    Line(points = {{12, 0}, {28, 0}, {28, 0}, {28, 0}}, color = {0, 0, 127}));
  connect(firstOrder.u, Vctrl) annotation(
    Line(points = {{-92, 60}, {-112, 60}, {-112, 60}, {-120, 60}}, color = {0, 0, 127}));
  connect(firstOrder.y, add3.u1) annotation(
    Line(points = {{-68, 60}, {-62, 60}, {-62, 8}, {-56, 8}, {-56, 8}}, color = {0, 0, 127}));
end IEEE_AC4A;


equation
  connect(realToComplex.y, bergeronLink.var_Ehk) annotation(
    Line(points = {{-20, -54}, {-10, -54}, {-10, -6}, {21, -6}}, color = {85, 170, 255}));
  connect(var_Ehk_re, realToComplex.re) annotation(
    Line(points = {{-74, -36}, {-54, -36}, {-54, -48}, {-44, -48}}, color = {0, 0, 127}));
  connect(var_Ehk_im, realToComplex.im) annotation(
    Line(points = {{-74, -82}, {-54, -82}, {-54, -60}, {-44, -60}}, color = {0, 0, 127}));
connect(bergeronLink.pin_p, SM.terminal) annotation(
    Line(points = {{43, 0}, {42, 0}, {42, -1}, {64, -1}}, color = {0, 0, 255}));
protected
  annotation(
    experiment(StartTime = 0, StopTime = 5, Tolerance = 1e-6, Interval = 0.0001),
    uses(Modelica(version = "3.2.2")));
end Generic_Machine_TL;