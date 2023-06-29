within OmniPES.QuasiSteadyState.Machines.Interfaces;

partial model Restriction
  outer SystemData data;
  parameter QuasiSteadyState.Machines.RestrictionData param;
  Units.PerUnit P;
  Units.PerUnit Q;
  Units.PerUnit V;
  Modelica.Units.SI.Angle theta(displayUnit = "deg"); annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 1}, extent = {{-81, 61}, {81, -61}}, textString = "Power Flow
Restriction")}));
end Restriction;