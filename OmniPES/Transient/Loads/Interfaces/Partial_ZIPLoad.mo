within OmniPES.Transient.Loads.Interfaces;

partial model Partial_ZIPLoad
  import Modelica.ComplexMath.conj;
  outer SystemData data;
  extends Circuit.Interfaces.ShuntComponent;
  parameter Units.ActivePower Psp "Specified active power [MW]";
  parameter Units.ReactivePower Qsp "Specified reactive power [Mvar]";
  parameter Modelica.Units.SI.PerUnit Vdef = 1.0;
  parameter Interfaces.LoadData dyn_par = Interfaces.LoadData(pz = 1, qz = 1, pi = 0, qi = 0) annotation(
    Placement(visible = true, transformation(origin = {-70, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Interfaces.LoadData ss_par = Interfaces.LoadData() annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Units.SI.ComplexPerUnit S;
  Modelica.Units.SI.PerUnit Vabs(start = 1);
  Modelica.Units.SI.PerUnit Vo(start = 1);
  protected
  Modelica.Blocks.Interfaces.RealOutput dp, dq;
initial equation
  der(Vo) = 0;
equation
  S = v*conj(i);
  Vabs^2 = v.re^2 + v.im^2;
  der(Vo) = if initial() then Vabs - Vo else 0;
  S.re = if initial() then (Psp + dp)/data.Sbase*(1 - ss_par.pi - ss_par.pz + ss_par.pi*(Vo/Vdef) + ss_par.pz*(Vo/Vdef)^2) else (Psp + dp)/data.Sbase*(1 - dyn_par.pi - dyn_par.pz + dyn_par.pi*(Vabs/Vo) + dyn_par.pz*(Vabs/Vo)^2);
  S.im = if initial() then (Qsp + dq)/data.Sbase*(1 - ss_par.qi - ss_par.qz + ss_par.qi*(Vo/Vdef) + ss_par.qz*(Vo/Vdef)^2) else (Qsp + dq)/data.Sbase*(1 - dyn_par.qi - dyn_par.qz + dyn_par.qi*(Vabs/Vo) + dyn_par.qz*(Vabs/Vo)^2);
  annotation(
    Icon(graphics = {Text(origin = {1, (0 - 14)}, extent = {{-55, 40}, {55, -40}}, textString = "%name"), Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}}), Text(origin = {1, (0 - 14)}, extent = {{-55, 40}, {55, -40}}, textString = "%name"), Text(origin = {0, -80}, extent = {{-60, 18}, {60, -18}}, textString = "%Psp", fontSize = 8)}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Partial_ZIPLoad;