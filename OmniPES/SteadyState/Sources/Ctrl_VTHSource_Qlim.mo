within OmniPES.SteadyState.Sources;

model Ctrl_VTHSource_Qlim
  outer SystemData data;
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.arg;
  import Modelica.ComplexMath.abs;
  parameter Boolean useExternalVoltageSpec = true  "Check to activate the external voltage specification" annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Units.PerUnit Vsp = 1.0;
  parameter Modelica.Units.NonSI.Angle_deg angle = 0.0;
  parameter Units.ReactivePower Qmin = -1e5;
  parameter Units.ReactivePower Qmax = +1e5;
  parameter Real tolq = 1e-3;
  parameter Real tolv = 1e-3;
  parameter Real inc = 1e5;
  Units.CPerUnit S;
  Units.PerUnit Vabs(start = 1);
  Modelica.Blocks.Interfaces.RealInput dVsp if useExternalVoltageSpec annotation(
    Placement(visible = true, transformation(origin = {-72, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {48, -78}, extent = {{-12, -12}, {12, 12}}, rotation = 90)));
Boolean volt_ctrl, qmax_ctrl, qmin_ctrl;
protected
  parameter Real lim_max = Qmax/data.Sbase - tolq;
  parameter Real lim_min = Qmin/data.Sbase + tolq;
  Real ch1(start = 0);
  Real ch2(start = 0);
  Real ch3(start = 0);
  Real ch4(start = 0);
  Real lim_sup;
  Real lim_inf;
  Modelica.Blocks.Interfaces.RealOutput dvsp annotation(HideResult=true);
equation
  if useExternalVoltageSpec then
    connect(dVsp, dvsp);
  else
    dvsp = 0;
  end if;
  lim_sup = Vsp + dvsp + tolv;
  lim_inf = Vsp + dvsp - tolv;
  S = -v*conj(i);
  (1 - ch1*ch3)*(1 - ch2*ch4)*(Vabs - (Vsp + dvsp)) + ch1*ch3*(1 - ch2*ch4)*(S.im - Qmax/data.Sbase) + (1 - ch1*ch3)*(ch2*ch4)*(S.im - Qmin/data.Sbase) = 0;
  Vabs = abs(p.v);
  arg(p.v) = angle;
algorithm
  ch1 := 1/(1 + exp(-inc*(S.im - lim_max)));
  ch2 := 1/(1 + exp(inc*(S.im - lim_min)));
  ch3 := 1/(1 + exp(inc*(Vabs - lim_sup)));
  ch4 := 1/(1 + exp(-inc*(Vabs - lim_inf)));
  volt_ctrl := (1 - ch1*ch3)*(1 - ch2*ch4) - 1 >= 0;
  qmax_ctrl := ch1*ch3*(1 - ch2*ch4) - 1 + 1e-5 >= 0;
  qmin_ctrl := (1 - ch1*ch3)*(1 - ch2*ch4) - 1 >= 0;
  annotation(
    Icon(graphics = {Text(origin = {70, 54}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "VTH
Qlim"), Text(origin = {30, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "V")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
end Ctrl_VTHSource_Qlim;