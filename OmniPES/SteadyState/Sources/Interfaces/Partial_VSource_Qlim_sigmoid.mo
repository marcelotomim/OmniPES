within OmniPES.SteadyState.Sources.Interfaces;

partial model Partial_VSource_Qlim_sigmoid
  outer SystemData data;
  extends Icons.Vsource;
  extends Interfaces.Partial_VSource_Qlim;
  parameter Units.PerUnit growth_rate = 1e5 "Sigmoid growth rate" annotation(Dialog(tab="Reactive limits parameters"));
  Real ch1, ch2, ch3, ch4;
  protected
  final parameter Real lim_max = Qmax/data.Sbase - tolq;
  final parameter Real lim_min = Qmin/data.Sbase + tolq;
  Real lim_sup;
  Real lim_inf;
initial algorithm

if (S.im < Qmax/data.Sbase - tolq) and (S.im > Qmin/data.Sbase + tolq) then
  ch1 := 0;
  ch2 := 0;
  ch3 := 1;
  ch4 := 1;
elseif S.im >= Qmax/data.Sbase - tolq then
  ch1 := 1;
  ch2 := 0;
  ch3 := 1;
  ch4 := 0;
else
  ch1 := 0;
  ch2 := 1;
  ch3 := 0;
  ch4 := 1;
end if;

equation
  lim_sup = Vsp + dvsp + tolv;
  lim_inf = Vsp + dvsp - tolv;
  (1 - ch1*ch3)*(1 - ch2*ch4)*(V - Vsp - dvsp) + ch1*ch3*(1 - ch2*ch4)*(S.im - Qmax/data.Sbase) + (1 - ch1*ch3)*(ch2*ch4)*(S.im - Qmin/data.Sbase) = 0;
algorithm
  ch1 := 1/(1 + exp(-growth_rate*(S.im - lim_max)));
  ch2 := 1/(1 + exp(growth_rate*(S.im - lim_min)));
  ch3 := 1/(1 + exp(growth_rate*(V - lim_sup)));
  ch4 := 1/(1 + exp(-growth_rate*(V - lim_inf)));
  annotation(
    Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end Partial_VSource_Qlim_sigmoid;