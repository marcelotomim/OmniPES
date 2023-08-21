within OmniPES.SteadyState.Sources;

model Ctrl_PVSource_Qlim
  outer SystemData data;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  parameter Units.ActivePower Psp;
  parameter Units.PerUnit Vsp = 1.0;
  parameter Units.ReactivePower Qmin = -1e5;
  parameter Units.ReactivePower Qmax = +1e5;
  parameter Real tolq = 1e-3;
  parameter Real tolv = 1e-3;
  parameter Real inc = 1e5;
  Units.CPerUnit S(re(start = Psp/data.Sbase), im(start = 0));
  Units.PerUnit Vabs(start = 1);
  Real ch1(start = 0);
  Real ch2(start = 0);
  Real ch3(start = 0);
  Real ch4(start = 0);
  Modelica.Blocks.Interfaces.RealInput DPsp annotation(
    Placement(visible = true, transformation(origin = {-70, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {8, -78}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
protected
  parameter Real lim_max = Qmax/data.Sbase - tolq;
  parameter Real lim_min = Qmin/data.Sbase + tolq;
  parameter Real lim_sup = Vsp + tolv;
  parameter Real lim_inf = Vsp - tolv;
equation
  S = -v*conj(i);
  S.re = (Psp+DPsp)/data.Sbase;
  (1 - ch1*ch3)*(1 - ch2*ch4)*(Vabs - Vsp) + ch1*ch3*(1 - ch2*ch4)*(S.im - Qmax/data.Sbase) + (1 - ch1*ch3)*(ch2*ch4)*(S.im - Qmin/data.Sbase) = 0;
  Vabs^2 = v.re^2 + v.im^2;
algorithm
  ch1 := 1/(1 + exp(-inc*(S.im - lim_max)));
  ch2 := 1/(1 + exp(inc*(S.im - lim_min)));
  ch3 := 1/(1 + exp(inc*(Vabs - lim_sup)));
  ch4 := 1/(1 + exp(-inc*(Vabs - lim_inf)));
  annotation(
    Icon(graphics = {Ellipse(origin = {6, 1}, extent = {{-66, 67}, {66, -67}}), Line(origin = {-73, 0}, points = {{-25, 0}, {13, 0}}), Line(origin = {81, 0}, points = {{-9, 0}, {9, 0}}), Line(origin = {-4, -22}, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {16, 22}, rotation = 180, points = {{12, -22}, {8, -22}, {2, -20}, {-4, -16}, {-10, -10}, {-12, -2}, {-12, 4}, {-10, 8}, {-6, 14}, {-2, 18}, {2, 20}, {8, 22}, {12, 22}, {12, 22}}), Line(origin = {98, 0}, points = {{-10, 0}, {10, 0}}), Line(origin = {108, -1}, points = {{0, 33}, {0, -33}}), Line(origin = {122, -1}, points = {{0, 19}, {0, -19}}), Line(origin = {134, 1}, points = {{0, 3}, {0, -7}}), Text(origin = {75, 65}, rotation = -90, extent = {{-33, 25}, {33, -25}}, textString = "PV
Qlim")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 80}})));
end Ctrl_PVSource_Qlim;