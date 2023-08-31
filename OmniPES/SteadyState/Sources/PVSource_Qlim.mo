within OmniPES.SteadyState.Sources;

model PVSource_Qlim
  outer SystemData data;
  extends Icons.Vsource;
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
protected
  parameter Real lim_max = Qmax/data.Sbase - tolq;
  parameter Real lim_min = Qmin/data.Sbase + tolq;
  parameter Real lim_sup = Vsp + tolv;
  parameter Real lim_inf = Vsp - tolv;
equation
  S = -v*conj(i);
  S.re = Psp/data.Sbase;
  (1 - ch1*ch3)*(1 - ch2*ch4)*(Vabs - Vsp) + ch1*ch3*(1 - ch2*ch4)*(S.im - Qmax/data.Sbase) + (1 - ch1*ch3)*(ch2*ch4)*(S.im - Qmin/data.Sbase) = 0;
  Vabs^2 = v.re^2 + v.im^2;
algorithm
  ch1 := 1/(1 + exp(-inc*(S.im - lim_max)));
  ch2 := 1/(1 + exp(inc*(S.im - lim_min)));
  ch3 := 1/(1 + exp(inc*(Vabs - lim_sup)));
  ch4 := 1/(1 + exp(-inc*(Vabs - lim_inf)));
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}), graphics = {Text(origin = {70, 54}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "PV
Qlim")}));
end PVSource_Qlim;