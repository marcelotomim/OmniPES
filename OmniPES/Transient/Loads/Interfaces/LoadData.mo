within OmniPES.Transient.Loads.Interfaces;

record LoadData
  extends Modelica.Icons.Record;
  parameter Real pi = 0 "Constant current factor for the active power";
  parameter Real pz = 0 "Constant impedance factor for the active power";
  parameter Real qi = 0 "Constant current factor for the reactive power";
  parameter Real qz = 0 "Constant impedance factor for the reactive power";
  annotation(
    defaultComponentPrefixes = "parameter",
    Documentation(info="<html><body>TODO</body></html>"));
end LoadData;