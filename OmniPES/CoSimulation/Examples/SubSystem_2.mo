within OmniPES.CoSimulation.Examples;

model SubSystem_2
  import Modelica.ComplexMath.conj;
  inner SystemData data annotation(
    Placement(visible = true, transformation(origin = {-70, 70}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
  OmniPES.SteadyState.Loads.ZIPLoad zIPLoad_cs(Psp = 100, Qsp = 50) annotation(
    Placement(visible = true, transformation(origin = {86, 38}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  OmniPES.Circuit.Basic.TLine tl2_cs(Q = 0, r = 0, x = 0.1) annotation(
    Placement(visible = true, transformation(origin = {18, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus4 annotation(
    Placement(visible = true, transformation(origin = {-12, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.Bus bus5 annotation(
    Placement(visible = true, transformation(origin = {46, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.CoSimulation.Adaptors.ControlledVoltage controlledVoltage annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput Ii annotation(
    Placement(visible = true, transformation(origin = {-92, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Ir annotation(
    Placement(visible = true, transformation(origin = {-92, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 180), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Vi annotation(
    Placement(visible = true, transformation(origin = {-4, -10}, extent = {{-8, -8}, {8, 8}}, rotation = 180), iconTransformation(origin = {116, 44}, extent = {{-16, -16}, {16, 16}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealInput Vr annotation(
    Placement(visible = true, transformation(origin = {-4, 8}, extent = {{-8, -8}, {8, 8}}, rotation = 180), iconTransformation(origin = {116, 84}, extent = {{-16, -16}, {16, 16}}, rotation = 180)));
  //initial equation
  //  controlledVoltage.v.re = 0.989789;
  //  controlledVoltage.v.im = 0.180676;
equation
  connect(zIPLoad_cs.p, bus5.p) annotation(
    Line(points = {{63.56, 38}, {45.56, 38}}, color = {0, 0, 255}));
  connect(tl2_cs.n, bus5.p) annotation(
    Line(points = {{29, 39}, {45, 39}, {45, 37}}, color = {0, 0, 255}));
  connect(tl2_cs.p, bus4.p) annotation(
    Line(points = {{7, 39}, {-13, 39}, {-13, 37}}, color = {0, 0, 255}));
  connect(controlledVoltage.p, bus4.p) annotation(
    Line(points = {{-50, 10.2}, {-50, 38.2}, {-12, 38.2}}, color = {0, 0, 255}));
  connect(Vr, controlledVoltage.Vr) annotation(
    Line(points = {{-4, 8}, {-38, 8}}, color = {0, 0, 127}));
  connect(Vi, controlledVoltage.Vi) annotation(
    Line(points = {{-4, -10}, {-28, -10}, {-28, 4}, {-38, 4}}, color = {0, 0, 127}));
  connect(controlledVoltage.Ir, Ir) annotation(
    Line(points = {{-61, 8}, {-92, 8}}, color = {0, 0, 127}));
  connect(controlledVoltage.Ii, Ii) annotation(
    Line(points = {{-61, 4}, {-67, 4}, {-67, -16}, {-92, -16}}, color = {0, 0, 127}));
end SubSystem_2;