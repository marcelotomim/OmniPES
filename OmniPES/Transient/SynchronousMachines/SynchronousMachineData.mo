within OmniPES.Transient.SynchronousMachines;

record SynchronousMachineData
  extends Modelica.Icons.Record;  
   parameter Units.ApparentPower MVAb = 100 "Machine base power" annotation(
    Dialog(group = "Machine Base Quatities"));
  parameter Integer Nmaq = 1 "Number of parallel SynchronousMachines" annotation(
    Dialog(group = "Machine Base Quatities"));
  parameter Modelica.Units.SI.PerUnit Ra = 0.0 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit Xl = 0.0 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit Xd = 1.0 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit Xq = 0.8 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit X1d = 0.2 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit X1q = 0.2 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit X2d = 0.02 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit X2q = 0.02 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit T1d0 = 5.0 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit T2d0 = 0.01 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit T1q0 = 0.3 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit T2q0 = 0.01 annotation(
    Dialog(group = "Electrical Data"));
  parameter Modelica.Units.SI.PerUnit H = 5.0 annotation(
    Dialog(group = "Mechanical Data"));
  parameter Modelica.Units.SI.PerUnit D = 0.0 annotation(
    Dialog(group = "Mechanical Data"));
  
end SynchronousMachineData;