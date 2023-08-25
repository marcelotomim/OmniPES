within OmniPES.QuasiSteadyState.Machines;

model GenericSynchronousMachine
  parameter OmniPES.QuasiSteadyState.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {0, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData specs "Record with load flow specs." annotation(
    Placement(visible = true, transformation(origin = {-48, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
//  parameter Boolean useExternalReferences = false annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.QuasiSteadyState.Machines.Interfaces.Inertia inertia(smData = smData) annotation(
    Placement(visible = true, transformation(origin = {59, 0}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.PartialElectrical electrical annotation(Placement(visible = true, transformation(origin = {-13, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0))) constrainedby Interfaces.PartialElectrical(smData = smData) annotation(choicesAllMatching = true, Placement(visible = true, transformation(origin = {-36, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Machines.Interfaces.Restriction restriction annotation(
    Placement(visible = true, transformation(origin = {66, 70}, extent = {{-26, -26}, {26, 26}}, rotation = 0))) constrainedby Interfaces.Restriction(param = specs) annotation(
     choicesAllMatching = true,
     Placement(visible = true, transformation(origin = {-19, 73}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialAVR avr annotation(
    Placement(visible = true, transformation(origin = {-74, -19}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialSpeedRegulator sreg annotation(
    Placement(visible = true, transformation(origin = {60, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  replaceable OmniPES.QuasiSteadyState.Controllers.Interfaces.PartialPSS pss annotation(
    Placement(visible = true, transformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
equation
  restriction.P = electrical.Pt;
  restriction.Q = electrical.Qt;
  restriction.V = electrical.Vabs;
  restriction.theta = electrical.theta;
  avr.Vctrl = electrical.Vabs;
  connect(terminal, electrical.terminal) annotation(
    Line(points = {{-100, 0}, {-39, 0}}, color = {0, 0, 255}));
  connect(sreg.wctrl, inertia.omega) annotation(
    Line(points = {{71, -44}, {90, -44}, {90, -9.5}, {80, -9.5}}, color = {0, 0, 127}));
  connect(sreg.Pm, inertia.Pm) annotation(
    Line(points = {{49, -44}, {24, -44}, {24, -15}, {36, -15}}, color = {0, 0, 127}));
  connect(pss.omega, inertia.omega) annotation(
    Line(points = {{11, -70}, {90, -70}, {90, -9.5}, {80, -9.5}}, color = {0, 0, 127}));
  connect(pss.Vsad, avr.Vsad) annotation(
    Line(points = {{-11, -70}, {-90, -70}, {-90, -25}, {-85, -25}}, color = {0, 0, 127}));
  connect(avr.Efd, electrical.Efd) annotation(
    Line(points = {{-63, -19}, {-42, -19}}, color = {0, 0, 127}));
  connect(inertia.delta, electrical.delta) annotation(
    Line(points = {{80, 9.5}, {86, 9.5}, {86, 38}, {-80, 38}, {-80, 19}, {-42, 19}}, color = {0, 0, 127}));
  connect(electrical.Pe, inertia.Pe) annotation(
    Line(points = {{13, 0}, {36, 0}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text( origin = {30, 0},extent = {{-50, -50}, {50, 50}}, textString = "SM")}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Text(origin = {25.5, 7}, extent = {{-4, 7}, {5, -7}}, textString = "Pe"), Text(origin = {34.5, -38}, extent = {{-4, 7}, {5, -7}}, textString = "Pm"), Text(origin = {91, 24}, extent = {{-2, 6}, {3, -6}}, textString = "δ"), Text(origin = {94, -22}, extent = {{-2, 6}, {3, -6}}, textString = "ω"), Text(origin = {-57, -62}, extent = {{-7, 7}, {9, -7}}, textString = "Vsad"), Text(origin = {-56, -24}, extent = {{-5, 5}, {6, -5}}, textString = "Efd")}));
end GenericSynchronousMachine;