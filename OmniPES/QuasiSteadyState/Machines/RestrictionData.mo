within OmniPES.QuasiSteadyState.Machines;

record RestrictionData
  extends Modelica.Icons.Record;
  import OmniPES.Units;
  parameter Units.ActivePower Pesp = 0.0 "Generated Active Power" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter Units.ReactivePower Qesp = 0.0 "Generated Rective Power" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter Units.PerUnit Vesp = 1.0 "Bus voltage magnitude" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter Modelica.Units.SI.Angle theta_esp(displayUnit = "deg") = 0 "Bus voltage angle" annotation(
    Dialog(group = "Steady-State Specifications"));
end RestrictionData;