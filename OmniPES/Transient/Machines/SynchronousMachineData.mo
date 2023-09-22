within OmniPES.Transient.Machines;

record SynchronousMachineData
  extends Modelica.Icons.Record;
  import OmniPES.Units;
  parameter Units.ApparentPower MVAs = 100 "System base power" annotation(
    Dialog(group = "Base Quatities"));
  parameter Units.ApparentPower MVAb = 100 "Machine base power" annotation(
    Dialog(group = "Base Quatities"));
  parameter Integer Nmaq = 1 "Number of parallel machines" annotation(
    Dialog(group = "Base Quatities"));
  parameter Units.PerUnit Ra = 0.0 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit Xl = 0.0 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit Xd = 1.0 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit Xq = 0.8 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit X1d = 0.2 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit X1q = 0.2 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit X2d = 0.02 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit X2q = 0.02 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit T1d0 = 5.0 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit T2d0 = 0.01 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit T1q0 = 0.3 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit T2q0 = 0.01 annotation(
    Dialog(group = "Electrical Data"));
  parameter Units.PerUnit H = 5.0 annotation(
    Dialog(group = "Mechanical Data"));
  parameter Units.PerUnit D = 0.0 annotation(
    Dialog(group = "Mechanical Data"));

  record ConvertedData
    parameter Units.PerUnit Ra annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit Xl annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit Xd annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit Xq annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit X1d annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit X1q annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit X2d annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit X2q annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit T1d0 annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit T2d0 annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit T1q0 annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit T2q0 annotation(
      Dialog(group = "Electrical Data"));
    parameter Units.PerUnit H annotation(
      Dialog(group = "Mechanical Data"));
    parameter Units.PerUnit D annotation(
      Dialog(group = "Mechanical Data"));
  end ConvertedData;

  ConvertedData convData(Ra = MVAs/MVAb/Nmaq*Ra, Xl = MVAs/MVAb/Nmaq*Xl, Xd = MVAs/MVAb/Nmaq*Xd, Xq = MVAs/MVAb/Nmaq*Xq, X1d = MVAs/MVAb/Nmaq*X1d, X1q = MVAs/MVAb/Nmaq*X1q, X2d = MVAs/MVAb/Nmaq*X2d, X2q = MVAs/MVAb/Nmaq*X2q, H = Nmaq*MVAb/MVAs*H, D = Nmaq*MVAb/MVAs*D, T1d0 = T1d0, T1q0 = T1q0, T2d0 = T2d0, T2q0 = T2q0);
  //        annotation(
  //          Icon(coordinateSystem(initialScale = 0.2, grid = {0.5, 0.5})),
  //  Diagram(coordinateSystem(extent = {{-100, -150}, {100, 100}})));
  annotation(
    defaultComponentName = "smData",
    defaultVariability = "Parameter");
end SynchronousMachineData;