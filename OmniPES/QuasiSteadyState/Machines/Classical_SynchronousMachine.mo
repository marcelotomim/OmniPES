within OmniPES.QuasiSteadyState.Machines;

model Classical_SynchronousMachine
  parameter SynchronousMachineData smData "Record with machine parameters" annotation(
    Placement(visible = true, transformation(origin = {-78, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  parameter RestrictionData specs "Record with load flow specs." annotation(
    Placement(visible = true, transformation(origin = {-126, 78}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Circuit.Interfaces.PositivePin terminal annotation(
    Placement(visible = true, transformation(origin = {-144, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.Inertia inertia(smData = smData) annotation(
    Placement(visible = true, transformation(origin = {57, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  Interfaces.Classical_Electric electrical(smData = smData) annotation(
    Placement(visible = true, transformation(origin = {-38, 0}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  replaceable Interfaces.Restriction restriction constrainedby Interfaces.Restriction(param = specs) annotation(
     choicesAllMatching = true,
     Placement(visible = true, transformation(origin = {-19, 73}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
equation
  der(inertia.Pm) = 0.0;
  der(electrical.Efd) = 0.0;
  restriction.P = electrical.Pt;
  restriction.Q = electrical.Qt;
  restriction.V = Modelica.ComplexMath.abs(terminal.v);
  terminal.v.re*tan(restriction.theta) = terminal.v.im;
  connect(inertia.delta, electrical.delta) annotation(
    Line(points = {{74, 6.5}, {88, 6.5}, {88, 38}, {-82, 38}, {-82, 18}, {-67, 18}, {-67, 19}}, color = {0, 0, 127}));
  connect(electrical.Pe, inertia.Pe) annotation(
    Line(points = {{-12, 0}, {40, 0}}, color = {0, 0, 127}));
  connect(terminal, electrical.terminal) annotation(
    Line(points = {{-144, 0}, {-63, 0}}, color = {0, 0, 255}));
  annotation(
    Icon(graphics = {Ellipse(origin = {33, 0}, extent = {{65, 65}, {-65, -65}}, endAngle = 360), Line(origin = {-66, -1.07}, points = {{-34, 1}, {34, 1}}), Bitmap(extent = {{22, 4}, {22, 4}}), Text(origin = {10, 27}, extent = {{72, -67}, {-30, 13}}, textString = "SM")}, coordinateSystem(initialScale = 0.1)));
end Classical_SynchronousMachine;