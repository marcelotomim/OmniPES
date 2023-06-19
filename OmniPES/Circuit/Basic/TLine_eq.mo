within OmniPES.Circuit.Basic;

model TLine_eq
  outer OmniPES.SystemData data;
  parameter OmniPES.Units.PerUnit r;
  parameter OmniPES.Units.PerUnit x;
  parameter OmniPES.Units.ReactivePower Q;
  OmniPES.Circuit.Interfaces.PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {-110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Circuit.Interfaces.NegativePin n annotation(
    Placement(visible = true, transformation(origin = {40, 52}, extent = {{-4, -4}, {4, 4}}, rotation = 0), iconTransformation(origin = {110, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  //protected
  parameter Complex ysh(re = 1e-10, im = Q/2);
  parameter Complex ykm = 1/Complex(r, x);
equation
  p.i = ykm*(p.v - n.v) + ysh*p.v;
  n.i = ykm*(n.v - p.v) + ysh*n.v;
//p.i.re = ykm.re * (p.v.re - n.v.re) - ykm.im * (p.v.im - n.v.im) - ysh.im * p.v.im;
//p.i.im = ykm.re * (p.v.im - n.v.im) + ykm.im * (p.v.re - n.v.re) + ysh.im * p.v.re;
//n.i.re = ykm.re * (n.v.re - p.v.re) - ykm.im * (n.v.im - p.v.im) - ysh.im * n.v.im;
//n.i.im = ykm.re * (n.v.im - p.v.im) + ykm.im * (n.v.re - p.v.re) + ysh.im * p.v.re;
  annotation(
    Icon(graphics = {Rectangle(origin = {0, -1}, extent = {{-100, 61}, {100, -61}}), Line(origin = {-80, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Rectangle(origin = {-60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {-60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {-60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {-60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {-60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {60, 0}, extent = {{-10, 20}, {10, -20}}), Line(origin = {60, 25}, points = {{0, 5}, {0, -5}, {0, -5}}), Line(origin = {60, -30}, points = {{0, 10}, {0, -10}}), Line(origin = {60, -40}, points = {{-20, 0}, {20, 0}}), Line(origin = {60, -46}, points = {{-12, 0}, {12, 0}}), Line(origin = {60, -50}, points = {{-4, 0}, {4, 0}}), Rectangle(origin = {0, 30}, rotation = -90, extent = {{-10, 20}, {10, -20}}), Line(origin = {-40, 30}, points = {{-20, 0}, {20, 0}}), Line(origin = {40, 30}, points = {{20, 0}, {-20, 0}}), Line(origin = {80, 30}, points = {{-20, 0}, {20, 0}})}, coordinateSystem(initialScale = 0.1)));
end TLine_eq;