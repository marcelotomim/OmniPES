within OmniPES.CoSimulation.Examples;

model SubSystem_2_TL
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
  OmniPES.CoSimulation.BergeronLink TL_m annotation(
    Placement(visible = true, transformation(origin = {-42, 8}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput hin_re annotation(
    Placement(visible = true, transformation(origin = {-63, -67}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput hin_im annotation(
    Placement(visible = true, transformation(origin = {-63, -87}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {-110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput hout_re annotation(
    Placement(visible = true, transformation(origin = {18, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput hout_im annotation(
    Placement(visible = true, transformation(origin = {18, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.Transient.Machines.RestrictionData specs(Psp = 100., Qsp = 63.9135, Vsp = 1.0061432, theta_sp = 0.180552) annotation(
    Placement(visible = true, transformation(origin = {-78, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  TL_m.hist_out.re = hout_re;
  TL_m.hist_out.im = hout_im;
  TL_m.hist_in.re = hin_re;
  TL_m.hist_in.im = hin_im;
  connect(zIPLoad_cs.p, bus5.p) annotation(
    Line(points = {{63.56, 38}, {45.56, 38}}, color = {0, 0, 255}));
  connect(tl2_cs.n, bus5.p) annotation(
    Line(points = {{29, 39}, {45, 39}, {45, 37}}, color = {0, 0, 255}));
  connect(tl2_cs.p, bus4.p) annotation(
    Line(points = {{7, 39}, {-13, 39}, {-13, 37}}, color = {0, 0, 255}));
  connect(TL_m.pin_p, bus4.p) annotation(
    Line(points = {{-42, 20}, {-42, 38}, {-12, 38}}, color = {0, 0, 255}));
end SubSystem_2_TL;