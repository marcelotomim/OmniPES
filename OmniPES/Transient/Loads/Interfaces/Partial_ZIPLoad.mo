within OmniPES.Transient.Loads.Interfaces;

partial model Partial_ZIPLoad
  import Modelica.ComplexMath.conj;
  import Modelica.Units.SI;
  outer SystemData data;
  extends Circuit.Interfaces.ShuntComponent;
  parameter SI.ActivePower Psp(displayUnit="MW") "Specified active power";
  parameter SI.ReactivePower Qsp(displayUnit="Mvar") "Specified reactive power";
  parameter SI.PerUnit Vdef = 1.0 "Voltage at which the load is specified in steady-state";
  parameter Interfaces.LoadData dyn_par = Interfaces.LoadData(pz = 1, qz = 1, pi = 0, qi = 0) annotation(
    Placement(visible = true, transformation(origin = {-70, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Interfaces.LoadData ss_par = Interfaces.LoadData() annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  SI.ComplexPerUnit S;
  SI.PerUnit Vabs(start = 1);
  SI.PerUnit Vo(start = 1);
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
    Icon(graphics = {Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}}), Text( origin = {41, -1}, rotation = 90,extent = {{-99, 55}, {99, -55}}, textString = "%Psp
%Qsp", fontSize = 8), Polygon(origin = {-40, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, lineThickness = 0.5, points = {{-20, -20}, {-20, 20}, {20, 0}, {-20, -20}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end Partial_ZIPLoad;