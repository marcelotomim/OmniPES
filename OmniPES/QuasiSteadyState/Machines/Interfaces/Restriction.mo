within OmniPES.QuasiSteadyState.Machines.Interfaces;

partial model Restriction
  outer OmniPES.SystemData data;
  parameter OmniPES.QuasiSteadyState.Machines.RestrictionData param;
  OmniPES.Units.PerUnit P;
  OmniPES.Units.PerUnit Q;
  OmniPES.Units.PerUnit V;
  Modelica.Units.SI.Angle theta; annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {-1, 1}, extent = {{-81, 61}, {81, -61}}, textString = "Power Flow
Restriction")}));
end Restriction;