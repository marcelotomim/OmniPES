within OmniPES.QuasiSteadyState.Loads.Interfaces;

record LoadData
  extends Modelica.Icons.Record;
  parameter Real pi = 0;
  parameter Real pz = 0;
  parameter Real qi = 0;
  parameter Real qz = 0;
  annotation(
    defaultComponentPrefixes = "parameter");
end LoadData;