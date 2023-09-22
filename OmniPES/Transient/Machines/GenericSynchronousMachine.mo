within OmniPES.Transient.Machines;

model GenericSynchronousMachine
  parameter OmniPES.Transient.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {0, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData specs "Record with load flow specs." annotation(
    Placement(visible = true, transformation(origin = {-40, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
//  parameter Boolean useExternalReferences = false annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-86, 22}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Transient.Machines.Interfaces.Inertia inertia(smData = smData) annotation(
    Placement(visible = true, transformation(origin = {63, 3}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  replaceable OmniPES.Transient.Machines.Interfaces.Restriction restriction annotation(
    Placement(visible = true, transformation(origin = {56, 65}, extent = {{-26, -15}, {26, 15}}, rotation = 0))) constrainedby Interfaces.Restriction(param = specs) annotation(
     choicesAllMatching = true,
     Placement(visible = true, transformation(origin = {-19, 73}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  replaceable OmniPES.Transient.Controllers.Interfaces.PartialAVR avr annotation(
    Placement(visible = true, transformation(origin = {-72, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  replaceable OmniPES.Transient.Controllers.Interfaces.PartialSpeedRegulator sreg annotation(
    Placement(visible = true, transformation(origin = {60, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  replaceable OmniPES.Transient.Controllers.Interfaces.PartialPSS pss annotation(
    Placement(visible = true, transformation(origin = {0, -69}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  replaceable OmniPES.Transient.Machines.Interfaces.PartialElectrical electrical(smData = smData)  annotation(
    Placement(visible = true, transformation(origin = {-14.5, 2.5}, extent = {{-20.5, -20.5}, {20.5, 20.5}}, rotation = 0)));
equation
  restriction.P = electrical.Pt;
  restriction.Q = electrical.Qt;
  restriction.V = electrical.Vabs;
  restriction.theta = electrical.theta;
  connect(sreg.wctrl, inertia.omega) annotation(
    Line(points = {{71, -44}, {90, -44}, {90, -9}, {85, -9}}, color = {0, 0, 127}));
  connect(sreg.Pm, inertia.Pm) annotation(
    Line(points = {{49, -44}, {25, -44}, {25, -9}, {41, -9}}, color = {0, 0, 127}));
  connect(pss.omega, inertia.omega) annotation(
    Line(points = {{11, -69}, {90, -69}, {90, -9}, {85, -9}}, color = {0, 0, 127}));
  connect(pss.Vsad, avr.Vsad) annotation(
    Line(points = {{-11, -69}, {-100, -69}, {-100, -4}, {-83, -4}}, color = {0, 0, 127}));
  connect(electrical.Pe, inertia.Pe) annotation(
    Line(points = {{8, 15}, {41, 15}}, color = {0, 0, 127}));
  connect(avr.Efd, electrical.Efd) annotation(
    Line(points = {{-61, -10}, {-37, -10}}, color = {0, 0, 127}));
  connect(electrical.Vt, avr.Vctrl) annotation(
    Line(points = {{8, -10}, {17, -10}, {17, -44}, {-90, -44}, {-90, -16}, {-83, -16}}, color = {0, 0, 127}));
  connect(inertia.delta, electrical.delta) annotation(
    Line(points = {{85, 15}, {90, 15}, {90, 33}, {-56, 33}, {-56, 15}, {-37, 15}}, color = {0, 0, 127}));
  connect(terminal, electrical.terminal) annotation(
    Line(points = {{-86, 22}, {-69, 22}, {-69, 3}, {-37, 3}}, color = {0, 0, 255}));
  annotation(
    Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text( origin = {30, 0},extent = {{-50, -50}, {50, 50}}, textString = "SM")}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
  Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Text(origin = {24.5, 20}, extent = {{-4, 7}, {5, -7}}, textString = "Pe"), Text(origin = {34.5, -38}, extent = {{-4, 7}, {5, -7}}, textString = "Pm"), Text(origin = {93, 24}, extent = {{-2, 6}, {3, -6}}, textString = "δ"), Text(origin = {94, -22}, extent = {{-2, 6}, {3, -6}}, textString = "ω"), Text(origin = {-57, -62}, extent = {{-7, 7}, {9, -7}}, textString = "Vsad"), Text(origin = {-50, -15}, extent = {{-5, 5}, {6, -5}}, textString = "Efd"), Text(origin = {-34.5, -39}, extent = {{-4, 7}, {5, -7}}, textString = "Vt")}));
end GenericSynchronousMachine;