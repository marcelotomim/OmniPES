within OmniPES.SteadyState.Loads.Interfaces;

partial model Partial_ZIPLoad
  outer SystemData data;
  extends Circuit.Interfaces.ShuntComponent;
  import Modelica.ComplexMath.conj;
  parameter Units.ActivePower Psp "Specified active power";
  parameter Units.ReactivePower Qsp "Specified reactive power";
  parameter Units.PerUnit Vdef = 1.0 "Voltage at which the specified power is defined"; 
  parameter Interfaces.LoadData ss_par = Interfaces.LoadData() annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Units.CPerUnit S "Complex power";
  Units.PerUnit Vabs(start = 1) "Terminal voltage magnitude";
protected
  Modelica.Blocks.Interfaces.RealOutput dp, dq;
  parameter Real pp = 1 - ss_par.pi - ss_par.pz;
  parameter Real pi = ss_par.pi;
  parameter Real pz = ss_par.pz;
  parameter Real qq = 1 - ss_par.qi - ss_par.qz;
  parameter Real qi = ss_par.qi;
  parameter Real qz = ss_par.qz;
equation
  S = v*conj(i);
  Vabs^2 = v.re^2 + v.im^2;
  S.re = (Psp+dp)/data.Sbase*(pp + pi*(Vabs/Vdef) + pz*(Vabs/Vdef)^2);
  S.im = (Qsp+dq)/data.Sbase*(qq + qi*(Vabs/Vdef) + qz*(Vabs/Vdef)^2);
  annotation(
    Icon(graphics = {Text(origin = {1, 2.84217e-14}, extent = {{-55, 40}, {55, -40}}, textString = "%name"), Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}));
end Partial_ZIPLoad;