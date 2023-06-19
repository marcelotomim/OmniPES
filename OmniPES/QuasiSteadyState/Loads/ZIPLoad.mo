within OmniPES.QuasiSteadyState.Loads;

model ZIPLoad
  extends OmniPES.Circuit.Interfaces.ShuntComponent;
  parameter OmniPES.Units.ActivePower Pesp "Specified active power [MW]";
  parameter OmniPES.Units.ReactivePower Qesp "Specified reactive power [Mvar]";
  parameter OmniPES.Units.PerUnit Vdef = 1.0;
  parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData dyn_par = OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData(pz = 1, qz = 1, pi = 0, qi = 0) annotation(
    Placement(visible = true, transformation(origin = {-70, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData ss_par = OmniPES.QuasiSteadyState.Loads.Interfaces.LoadData() annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OmniPES.Units.CPerUnit S;
  OmniPES.Units.PerUnit Vabs(start = 1);
  OmniPES.Units.PerUnit Vo(start = 1);
  import Modelica.ComplexMath.conj;
  outer OmniPES.SystemData data;
initial equation
  der(Vo) = 0;
equation
  S = v*conj(i);
  Vabs^2 = v.re^2 + v.im^2;
  der(Vo) = if initial() then Vabs - Vo else 0;
  S.re = if initial() then Pesp/data.Sbase*(1 - ss_par.pi - ss_par.pz + ss_par.pi*(Vo/Vdef) + ss_par.pz*(Vo/Vdef)^2) else Pesp/data.Sbase*(1 - dyn_par.pi - dyn_par.pz + dyn_par.pi*(Vabs/Vo) + dyn_par.pz*(Vabs/Vo)^2);
  S.im = if initial() then Qesp/data.Sbase*(1 - ss_par.qi - ss_par.qz + ss_par.qi*(Vo/Vdef) + ss_par.qz*(Vo/Vdef)^2) else Qesp/data.Sbase*(1 - dyn_par.qi - dyn_par.qz + dyn_par.qi*(Vabs/Vo) + dyn_par.qz*(Vabs/Vo)^2);
//  if initial() then
//    S.re = Pesp/data.Sbase*(1 - ss_par.pi - ss_par.pz + ss_par.pi*(Vo/Vdef) + ss_par.pz*(Vo/Vdef)^2);
//    S.im = Qesp/data.Sbase*(1 - ss_par.qi - ss_par.qz + ss_par.qi*(Vo/Vdef) + ss_par.qz*(Vo/Vdef)^2);
//  else
//    S.re = Pesp/data.Sbase*(1 - dyn_par.pi - dyn_par.pz + dyn_par.pi*(Vabs/Vo) + dyn_par.pz*(Vabs/Vo)^2);
//    S.im = Qesp/data.Sbase*(1 - dyn_par.qi - dyn_par.qz + dyn_par.qi*(Vabs/Vo) + dyn_par.qz*(Vabs/Vo)^2);
//  end if;
  annotation(
    Icon(graphics = {Text(origin = {1, 2.84217e-14}, extent = {{-55, 40}, {55, -40}}, textString = "%name"), Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}));
end ZIPLoad;