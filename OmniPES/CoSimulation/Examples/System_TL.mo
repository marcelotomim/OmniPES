within OmniPES.CoSimulation.Examples;

model System_TL
  parameter Real dt = 1e-3;
  OmniPES.CoSimulation.Examples.SubSystem_1_TL subs1 annotation(
    Placement(visible = true, transformation(origin = {-34, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.CoSimulation.Examples.SubSystem_2_TL subs2 annotation(
    Placement(visible = true, transformation(origin = {44, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  subs2.hin_re = delay(subs1.hout_re, dt);
  subs2.hin_im = delay(subs1.hout_im, dt);
  subs1.hin_re = delay(subs2.hout_re, dt);
  subs1.hin_im = delay(subs2.hout_im, dt);
end System_TL;