within OmniPES.Transient.Machines;

record RestrictionData
  extends Modelica.Icons.Record;
  import OmniPES.Units;
  parameter Units.ActivePower Psp = 0.0 "Generated Active Power" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter Units.ReactivePower Qsp = 0.0 "Generated Rective Power" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter Units.PerUnit Vsp = 1.0 "Bus voltage magnitude" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter Modelica.Units.SI.Angle theta_sp(displayUnit = "deg") = 0 "Bus voltage angle" annotation(
    Dialog(group = "Steady-State Specifications"));
end RestrictionData;