within OmniPES.QuasiSteadyState.Machines;

model GenericSynchronousMachine
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {-74, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData specs "Record with load flow specs." annotation(
    Placement(visible = true, transformation(origin = {-126, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-146, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Machines.Interfaces.Inertia inertia(smData = smData) annotation(
    Placement(visible = true, transformation(origin = {57, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical electrical annotation(
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0))) constrainedby OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical(smData = smData) annotation(
     choicesAllMatching = true,
     Placement(visible = true, transformation(origin = {-36, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction restriction constrainedby OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction(param = specs) annotation(
     choicesAllMatching = true,
     Placement(visible = true, transformation(origin = {-19, 73}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR avr annotation(
    Placement(visible = true, transformation(origin = {-96, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialSpeedRegulator sreg annotation(
    Placement(visible = true, transformation(origin = {58, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialPSS pss annotation(
    Placement(visible = true, transformation(origin = {-56, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  restriction.P = electrical.Pt;
  restriction.Q = electrical.Qt;
  restriction.V = Modelica.ComplexMath.abs(terminal.v);
  restriction.theta = Modelica.ComplexMath.arg(terminal.v);
  avr.Vctrl = restriction.V;
  connect(inertia.delta, electrical.delta) annotation(
    Line(points = {{74, 6.5}, {88, 6.5}, {88, 38}, {-82, 38}, {-82, 18}, {-65, 18}, {-65, 19}, {-49, 19}}, color = {0, 0, 127}));
  connect(electrical.Pe, inertia.Pe) annotation(
    Line(points = {{6, 0}, {40, 0}}, color = {0, 0, 127}));
  connect(terminal, electrical.terminal) annotation(
    Line(points = {{-146, 0}, {-45, 0}}, color = {0, 0, 255}));
  connect(sreg.wctrl, inertia.omega) annotation(
    Line(points = {{69, -44}, {86, -44}, {86, -8}, {74, -8}}, color = {0, 0, 127}));
  connect(sreg.Pm, inertia.Pm) annotation(
    Line(points = {{47, -44}, {24, -44}, {24, -12}, {40, -12}}, color = {0, 0, 127}));
  connect(pss.omega, inertia.omega) annotation(
    Line(points = {{-44, -70}, {90, -70}, {90, -8}, {74, -8}, {74, -8}}, color = {0, 0, 127}));
  connect(pss.Vsad, avr.Vsad) annotation(
    Line(points = {{-68, -70}, {-134, -70}, {-134, -24}, {-107, -24}}, color = {0, 0, 127}));
  connect(avr.Efd, electrical.Efd) annotation(
    Line(points = {{-85, -18}, {-67.5, -18}, {-67.5, -19}, {-49, -19}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text(origin = {10, 27}, extent = {{72, -67}, {-30, 13}}, textString = "SM")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end GenericSynchronousMachine;