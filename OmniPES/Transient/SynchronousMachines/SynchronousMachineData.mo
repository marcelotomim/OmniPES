within OmniPES.Transient.SynchronousMachines;

record SynchronousMachineData
  extends Modelica.Icons.Record;  
  import Modelica.Units.SI;
  parameter SI.ApparentPower MVAb(displayUnit="MVA") "Machine base power" annotation(
    Dialog(group = "Machine Base Quatities"));
  parameter Integer Nmaq = 1 "Number of parallel machines" annotation(
    Dialog(group = "Machine Base Quatities"));
  parameter SI.PerUnit Ra = 0.0 "armature resistance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit Xl = 0.2 "leakage reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit Xd = 1.8 "d-axis synchronous reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit Xq = 1.7 "q-axis synchronous reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit X1d = 0.3 "d-axis transient reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit X1q = 0.55 "q-axis transient reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit X2d = 0.25 "d-axis subtransient reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit X2q = 0.25 "q-axis subtransient reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time T1d0 = 8.00 "d-axis open-circuit transient time constant" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time T2d0 = 0.03 "d-axis open-circuit subtransient time constant" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time T1q0 = 0.4 "q-axis open-circuit transient time constant" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time T2q0 = 0.05 "q-axis open-circuit subtransient time constant" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time H = 5 "constant of inertia" annotation(
    Dialog(group = "Mechanical Data"));
  parameter SI.PerUnit D = 0.0 "damping constant" annotation(
    Dialog(group = "Mechanical Data"));
annotation(defaultComponentPrefixes = "parameter");
end SynchronousMachineData;