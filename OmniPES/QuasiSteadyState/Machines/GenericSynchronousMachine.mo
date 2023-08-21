within OmniPES.QuasiSteadyState.Machines;

model GenericSynchronousMachine
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {0, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData specs "Record with load flow specs." annotation(
    Placement(visible = true, transformation(origin = {-48, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Machines.Interfaces.Inertia inertia(smData = smData) annotation(
    Placement(visible = true, transformation(origin = {61, 1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical electrical annotation(Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0))) constrainedby Interfaces.PartialElectrical(smData = smData) annotation(choicesAllMatching = true, Placement(visible = true, transformation(origin = {-36, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction restriction annotation(
    Placement(visible = true, transformation(origin = {66, 70}, extent = {{-26, -26}, {26, 26}}, rotation = 0))) constrainedby Interfaces.Restriction(param = specs) annotation(
     choicesAllMatching = true,
     Placement(visible = true, transformation(origin = {-19, 73}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR avr annotation(
    Placement(visible = true, transformation(origin = {-74, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialSpeedRegulator sreg annotation(
    Placement(visible = true, transformation(origin = {60, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialPSS pss annotation(
    Placement(visible = true, transformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  restriction.P = electrical.Pt;
  restriction.Q = electrical.Qt;
  restriction.V = abs(terminal.v);
  restriction.theta = arg(terminal.v);
  avr.Vctrl = restriction.V;
  connect(terminal, electrical.terminal) annotation(
    Line(points = {{-100, 0}, {-46, 0}}, color = {0, 0, 255}));
  connect(sreg.wctrl, inertia.omega) annotation(
    Line(points = {{71, -44}, {90, -44}, {90, -8.5}, {82, -8.5}}, color = {0, 0, 127}));
  connect(sreg.Pm, inertia.Pm) annotation(
    Line(points = {{49, -44}, {24, -44}, {24, -14}, {38, -14}}, color = {0, 0, 127}));
  connect(pss.omega, inertia.omega) annotation(
    Line(points = {{11, -70}, {90, -70}, {90, -8.5}, {82, -8.5}}, color = {0, 0, 127}));
  connect(pss.Vsad, avr.Vsad) annotation(
    Line(points = {{-11, -70}, {-94, -70}, {-94, -26}, {-85, -26}}, color = {0, 0, 127}));
  connect(avr.Efd, electrical.Efd) annotation(
    Line(points = {{-63, -20}, {-48, -20}}, color = {0, 0, 127}));
  connect(inertia.delta, electrical.delta) annotation(
    Line(points = {{82, 10}, {86, 10}, {86, 38}, {-80, 38}, {-80, 20}, {-48, 20}}, color = {0, 0, 127}));
  connect(electrical.Pe, inertia.Pe) annotation(
    Line(points = {{6, 0}, {22, 0}, {22, 1}, {38, 1}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text( origin = {30, 0},extent = {{-50, -50}, {50, 50}}, textString = "SM")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end GenericSynchronousMachine;