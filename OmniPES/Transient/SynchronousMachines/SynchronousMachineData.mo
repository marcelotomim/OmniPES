within OmniPES.Transient.SynchronousMachines;

record SynchronousMachineData
  extends Modelica.Icons.Record;  
  import Modelica.Units.SI;
  parameter SI.ApparentPower MVAb(displayUnit="MVA") "Machine base power" annotation(
    Dialog(group = "Machine Base Quatities"));
  parameter Integer Nmaq = 1 "Number of parallel machines" annotation(
    Dialog(group = "Machine Base Quatities"));
  parameter SI.PerUnit Ra "armature resistance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit Xl "leakage reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit Xd "d-axis synchronous reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit Xq "q-axis synchronous reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit X1d "d-axis transient reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit X1q "q-axis transient reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit X2d "d-axis subtransient reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.PerUnit X2q "q-axis subtransient reactance" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time T1d0 "d-axis open-circuit transient time constant" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time T2d0 "d-axis open-circuit subtransient time constant" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time T1q0 "q-axis open-circuit transient time constant" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time T2q0 "q-axis open-circuit subtransient time constant" annotation(
    Dialog(group = "Electrical Data"));
  parameter SI.Time H "constant of inertia" annotation(
    Dialog(group = "Mechanical Data"));
  parameter SI.PerUnit D "damping constant" annotation(
    Dialog(group = "Mechanical Data"));
annotation(defaultComponentPrefixes = "parameter");
end SynchronousMachineData;