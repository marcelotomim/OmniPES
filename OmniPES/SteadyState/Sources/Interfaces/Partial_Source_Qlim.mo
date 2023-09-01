within OmniPES.SteadyState.Sources.Interfaces;

partial model Partial_Source_Qlim
  outer SystemData data;
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  parameter Units.PerUnit Vsp = 1.0  "Specified Terminal Voltage";
  parameter Units.ReactivePower Qmin = -1e5 "Minimum reactive power";
  parameter Units.ReactivePower Qmax = +1e5 "Maximum reactive power";
  parameter Units.PerUnit tolq = 1e-3 "Reactive power tolerance" annotation(Dialog(tab="Reactive limits parameters"));
  parameter Units.PerUnit tolv = 1e-3 "Voltage magnitude tolerance" annotation(Dialog(tab="Reactive limits parameters"));
  parameter Units.PerUnit inc = 1e5 "Sigmoid inclination" annotation(Dialog(tab="Reactive limits parameters"));
  Units.CPerUnit S;
  Units.PerUnit Vabs(start = 1);
  Boolean volt_ctrl, qmax_ctrl, qmin_ctrl;
protected
  Real ch1(start = 0);
  Real ch2(start = 0);
  Real ch3(start = 0);
  Real ch4(start = 0);
  parameter Real lim_max = Qmax/data.Sbase - tolq;
  parameter Real lim_min = Qmin/data.Sbase + tolq;
  Real lim_sup;
  Real lim_inf;
  Modelica.Blocks.Interfaces.RealOutput dvsp annotation(HideResult=true);
equation
  lim_sup = Vsp + dvsp + tolv;
  lim_inf = Vsp + dvsp - tolv;
  S = -v*conj(i);
  (1 - ch1*ch3)*(1 - ch2*ch4)*(Vabs - Vsp - dvsp) + ch1*ch3*(1 - ch2*ch4)*(S.im - Qmax/data.Sbase) + (1 - ch1*ch3)*(ch2*ch4)*(S.im - Qmin/data.Sbase) = 0;
  Vabs = abs(p.v);
algorithm
  ch1 := 1/(1 + exp(-inc*(S.im - lim_max)));
  ch2 := 1/(1 + exp(inc*(S.im - lim_min)));
  ch3 := 1/(1 + exp(inc*(Vabs - lim_sup)));
  ch4 := 1/(1 + exp(-inc*(Vabs - lim_inf)));
  volt_ctrl := (1 - ch1*ch3)*(1 - ch2*ch4) - 1 >= 0;
  qmax_ctrl := ch1*ch3*(1 - ch2*ch4) - 1 + 1e-5 >= 0;
  qmin_ctrl := (1 - ch1*ch3)*(1 - ch2*ch4) - 1 >= 0;
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end Partial_Source_Qlim;