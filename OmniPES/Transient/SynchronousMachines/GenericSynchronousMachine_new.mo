within OmniPES.Transient.SynchronousMachines;

model GenericSynchronousMachine_new
  Circuit.Interfaces.PositivePin terminal annotation(
    Placement(transformation(origin = {-91, 32}, extent = {{-12, -12}, {12, 12}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}})));
  //
  // Machine parameters
  //
  outer SystemData data;
  parameter Transient.SynchronousMachines.SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {0, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  final parameter Transient.SynchronousMachines.SynchronousMachineData convData = ConvertBase(smData, data.Sbase) "Record with machine parameters in the system base";
  //
  // Power Flow Restriction
  //
  parameter Transient.SynchronousMachines.RestrictionData specs "Record with load flow specs." annotation(
    Dialog(tab = "Power Flow Restriction", group = "Parameters"),
    Placement(visible = true, transformation(origin = {-40, 70}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
  //
  replaceable Transient.SynchronousMachines.Interfaces.Restriction restriction annotation(
    Placement(transformation(origin = {59, 71}, extent = {{-19, -19}, {19, 19}}))) constrainedby Interfaces.Restriction(param = specs) annotation(
     choicesAllMatching = true,
     Dialog(tab = "Power Flow Restriction", group = "Model"),
     Placement(transformation(origin = {55, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  //
  // Electrical Model
  //
  replaceable Transient.SynchronousMachines.Interfaces.PartialElectrical electrical(smData = convData) constrainedby Interfaces.PartialElectrical(smData = convData) annotation(
     Evaluate = true,
     choicesAllMatching = true,
     Dialog(tab = "Electrical Model", group = "Model"),
     Placement(transformation(origin = {-11.5, 2.5}, extent = {{-20.5, -20.5}, {20.5, 20.5}})));
  //
  // Mechanical Model
  //
  Transient.SynchronousMachines.Interfaces.Inertia inertia(smData = convData) annotation(
    Placement(transformation(origin = {67, 3}, extent = {{-20, -20}, {20, 20}})));
  //
  // Automatic Voltage Regulator
  //
  parameter Boolean avr_on = true annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(tab = "Controllers", group = "Automatic Voltage Regulator", enable = electrical.allow_ctrl));
  //
  replaceable Transient.Controllers.AVR.ConstantEfd avr if avr_on constrainedby Interfaces.PartialAVR annotation(
     choicesAllMatching = true,
     Dialog(tab = "Controllers", group = "Automatic Voltage Regulator", enable = avr_on),
     Placement(transformation(origin = {-68, -10}, extent = {{-10, 10}, {10, -10}})));
  //
  // Speed Regulator
  //
  parameter Boolean sreg_on = true annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(tab = "Controllers", group = "Speed Regulator", enable = electrical.allow_ctrl));
  //
  replaceable Transient.Controllers.SpeedRegulators.ConstantPm sreg if sreg_on constrainedby Transient.Controllers.Interfaces.PartialSpeedRegulator annotation(
     choicesAllMatching = true,
     Dialog(tab = "Controllers", group = "Speed Regulator", enable = sreg_on),
     Placement(transformation(origin = {64, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //
  // PSS
  //
  parameter Boolean pss_on = true "enabled only if avr_on == true" annotation(
    Evaluate = true,
    HideResult = true,
    choices(checkBox = true),
    Dialog(tab = "Controllers", group = "Power System Stabilizer", enable = avr_on));
  //
  replaceable Transient.Controllers.PSS.NoPSS pss if pss_on and avr_on constrainedby Transient.Controllers.Interfaces.PartialPSS annotation(
     Dialog(tab = "Controllers", group = "Power System Stabilizer", enable = pss_on),
     choicesAllMatching = true,
     Placement(transformation(origin = {4, -69}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  //
equation
  restriction.P = electrical.Pt;
  restriction.Q = electrical.Qt;
  restriction.V = electrical.Vabs;
  restriction.theta = electrical.theta;
//  if sreg_on then
//    connect(sreg.wctrl, inertia.omega) annotation(
//      Line(points = {{75, -44}, {94, -44}, {94, -9}, {89, -9}}, color = {0, 0, 127}));
//    connect(sreg.Pm, inertia.Pm) annotation(
//      Line(points = {{53, -44}, {29, -44}, {29, -9}, {45, -9}}, color = {0, 0, 127}));
//  else
//    der(inertia.Pm) = 0;
//  end if;
//  if avr_on then
//    connect(avr.Efd, electrical.Efd) annotation(
//      Line(points = {{-57, -10}, {-34, -10}}, color = {0, 0, 127}));
//    connect(electrical.Vt, avr.Vctrl) annotation(
//      Line(points = {{11.05, -9.8}, {21.05, -9.8}, {21.05, -43.8}, {-85.95, -43.8}, {-85.95, -15.8}, {-78.95, -15.8}}, color = {0, 0, 127}));
//    if pss_on then
//      connect(pss.omega, inertia.omega) annotation(
//        Line(points = {{15, -69}, {94, -69}, {94, -9}, {89, -9}}, color = {0, 0, 127}));
//      connect(pss.Vsad, avr.Vsad) annotation(
//        Line(points = {{-7, -69}, {-96, -69}, {-96, -4}, {-79, -4}}, color = {0, 0, 127}));
//    else
//      avr.Vsad = 0.0;
//    end if;
//  else
//    der(electrical.Efd) = 0;
//  end if;
  connect(electrical.Pe, inertia.Pe) annotation(
    Line(points = {{11.05, 14.8}, {45.05, 14.8}}, color = {0, 0, 127}));
  connect(inertia.delta, electrical.delta) annotation(
    Line(points = {{89, 15}, {94, 15}, {94, 33}, {-52, 33}, {-52, 15}, {-34, 15}}, color = {0, 0, 127}));
  connect(terminal, electrical.terminal) annotation(
    Line(points = {{-91, 32}, {-65, 32}, {-65, 2.5}, {-34, 2.5}}, color = {0, 0, 255}));
  connect(inertia.omega, sreg.signalBus) annotation(
    Line(points = {{89, -9}, {94, -9}, {94, -44}, {75, -44}}, color = {0, 0, 127}));
  connect(electrical.signalBus, sreg.signalBus) annotation(
    Line(points = {{-11, -20}, {-11, -28}, {85, -28}, {85, -44}, {75, -44}}, color = {255, 204, 51}, thickness = 0.5));
  connect(sreg.Pm, inertia.Pm) annotation(
    Line(points = {{53, -44}, {34, -44}, {34, -9}, {45, -9}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text(origin = {32, 0}, extent = {{65, -55}, {-65, 55}}, textString = "G")}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, grid = {1, 1})),
    Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}}, grid = {1, 1}), graphics = {Text(origin = {28.5, 20}, extent = {{-4, 7}, {5, -7}}, textString = "Pe"), Text(origin = {35, -5}, textColor = if sreg_on then {0, 0, 0} else {255, 0, 0}, extent = {{-4, 7}, {5, -7}}, textString = "Pm"), Text(origin = {97, 24}, extent = {{-2, 6}, {3, -6}}, textString = "δ"), Text(origin = {98, -22}, extent = {{-2, 6}, {3, -6}}, textString = "ω"), Text(origin = {-53, -62}, textColor = if pss_on then {0, 0, 0} else {195, 195, 195}, extent = {{-7, 7}, {9, -7}}, textString = "Vsad"), Text(origin = {-46, -15}, textColor = if avr_on then {0, 0, 0} else {255, 0, 0}, extent = {{-5, 5}, {6, -5}}, textString = "Efd"), Text(origin = {-30.5, -39}, textColor = if avr_on then {0, 0, 0} else {195, 195, 195}, extent = {{-4, 7}, {5, -7}}, textString = "Vt")}));
end GenericSynchronousMachine_new;