within OmniPES.Transient.SynchronousMachines;

record RestrictionData
  extends Modelica.Icons.Record;
  import Modelica.Units.SI;
  parameter SI.ActivePower Psp(displayUnit="MW") = 0.0 "Generated Active Power" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter SI.ReactivePower Qsp(displayUnit="Mvar") = 0.0 "Generated Rective Power" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter SI.PerUnit Vsp = 1.0 "Bus voltage magnitude" annotation(
    Dialog(group = "Steady-State Specifications"));
  parameter SI.Angle theta_sp(displayUnit = "deg") = 0 "Bus voltage angle" annotation(
    Dialog(group = "Steady-State Specifications"));
annotation(defaultComponentPrefixes = "parameter");
 end RestrictionData;