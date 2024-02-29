within OmniPES.SteadyState.Loads;

model ZIPLoad
  extends Interfaces.Partial_Load;
  parameter Modelica.Units.SI.PerUnit Vdef = 1.0 "Voltage at which the specified power is defined"; 
  parameter Interfaces.LoadData ss_par = Interfaces.LoadData() "ZIP load parameters" annotation(
    Placement(visible = true, transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter Real pp = 1 - ss_par.pi - ss_par.pz;
  parameter Real pi = ss_par.pi;
  parameter Real pz = ss_par.pz;
  parameter Real qq = 1 - ss_par.qi - ss_par.qz;
  parameter Real qi = ss_par.qi;
  parameter Real qz = ss_par.qz;
equation
  S.re = (Psp+dpsp)/data.Sbase*(pp + pi*(V/Vdef) + pz*(V/Vdef)^2);
  S.im = (Qsp+dqsp)/data.Sbase*(qq + qi*(V/Vdef) + qz*(V/Vdef)^2);

  annotation(
    Icon(graphics = {Rectangle(origin = {1, 0.424659}, extent = {{-60, 60.5753}, {60, -60.5753}}), Line(origin = {-81, 0}, points = {{21, 0}, {-19, 0}, {-21, 0}})}, coordinateSystem(extent = {{-100, -100}, {100, 80}})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 1e-6, Interval = 1));
end ZIPLoad;