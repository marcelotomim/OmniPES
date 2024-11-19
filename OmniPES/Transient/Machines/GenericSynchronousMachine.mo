within OmniPES.Transient.Machines;

model GenericSynchronousMachine
  parameter OmniPES.Transient.Machines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {0, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData specs "Record with load flow specs." annotation(
    Placement(visible = true, transformation(origin = {-40, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  //  parameter Boolean useExternalReferences = false annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  OmniPES.Circuit.Interfaces.PositivePin terminal annotation(
    Placement(transformation(origin = {-91, 32}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  OmniPES.Transient.Machines.Interfaces.Inertia inertia(smData = smData) annotation(
    Placement(transformation(origin = {67, 3}, extent = {{-20, -20}, {20, 20}})));
  replaceable OmniPES.Transient.Machines.Interfaces.Restriction restriction annotation(
    Placement(transformation(origin = {68, 71}, extent = {{-19, -19}, {19, 19}}))) constrainedby Interfaces.Restriction(param = specs) annotation(
     choicesAllMatching = true,
     Placement(visible = true, transformation(origin = {-19, 73}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  replaceable OmniPES.Transient.Controllers.Interfaces.PartialAVR avr annotation(
    Placement(transformation(origin = {-68, -10}, extent = {{-10, 10}, {10, -10}})));
  replaceable OmniPES.Transient.Controllers.Interfaces.PartialSpeedRegulator sreg annotation(
    Placement(transformation(origin = {64, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  replaceable OmniPES.Transient.Controllers.Interfaces.PartialPSS pss annotation(
    Placement(transformation(origin = {4, -69}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  replaceable OmniPES.Transient.Machines.Interfaces.PartialElectrical electrical(smData = smData) constrainedby Interfaces.PartialElectrical(smData = smData) annotation(choicesAllMatching = true,
    Placement(transformation(origin = {-11.5, 2.5}, extent = {{-20.5, -20.5}, {20.5, 20.5}})));
equation
  restriction.P = electrical.Pt;
  restriction.Q = electrical.Qt;
  restriction.V = electrical.Vabs;
  restriction.theta = electrical.theta;
  connect(sreg.wctrl, inertia.omega) annotation(
    Line(points = {{75, -44}, {94, -44}, {94, -9}, {89, -9}}, color = {0, 0, 127}));
  connect(sreg.Pm, inertia.Pm) annotation(
    Line(points = {{53, -44}, {29, -44}, {29, -9}, {45, -9}}, color = {0, 0, 127}));
  connect(pss.omega, inertia.omega) annotation(
    Line(points = {{15, -69}, {94, -69}, {94, -9}, {89, -9}}, color = {0, 0, 127}));
  connect(pss.Vsad, avr.Vsad) annotation(
    Line(points = {{-7, -69}, {-96, -69}, {-96, -4}, {-79, -4}}, color = {0, 0, 127}));
  connect(electrical.Pe, inertia.Pe) annotation(
    Line(points = {{11.05, 14.8}, {45.05, 14.8}}, color = {0, 0, 127}));
  connect(avr.Efd, electrical.Efd) annotation(
    Line(points = {{-57, -10}, {-34, -10}}, color = {0, 0, 127}));
  connect(electrical.Vt, avr.Vctrl) annotation(
    Line(points = {{11.05, -9.8}, {21.05, -9.8}, {21.05, -43.8}, {-85.95, -43.8}, {-85.95, -15.8}, {-78.95, -15.8}}, color = {0, 0, 127}));
  connect(inertia.delta, electrical.delta) annotation(
    Line(points = {{89, 15}, {94, 15}, {94, 33}, {-52, 33}, {-52, 15}, {-34, 15}}, color = {0, 0, 127}));
  connect(terminal, electrical.terminal) annotation(
    Line(points = {{-91, 32}, {-65, 32}, {-65, 2.5}, {-34, 2.5}}, color = {0, 0, 255}));
  annotation(
    Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text(origin = {30, 0}, extent = {{-50, -50}, {50, 50}}, textString = "SM")}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Text(origin = {28.5, 20}, extent = {{-4, 7}, {5, -7}}, textString = "Pe"), Text(origin = {38.5, -38}, extent = {{-4, 7}, {5, -7}}, textString = "Pm"), Text(origin = {97, 24}, extent = {{-2, 6}, {3, -6}}, textString = "δ"), Text(origin = {98, -22}, extent = {{-2, 6}, {3, -6}}, textString = "ω"), Text(origin = {-53, -62}, extent = {{-7, 7}, {9, -7}}, textString = "Vsad"), Text(origin = {-46, -15}, extent = {{-5, 5}, {6, -5}}, textString = "Efd"), Text(origin = {-30.5, -39}, extent = {{-4, 7}, {5, -7}}, textString = "Vt")}));
end GenericSynchronousMachine;