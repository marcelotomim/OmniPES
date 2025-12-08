within OmniPES.Transient.SynchronousMachines.Interfaces;

partial model Restriction
  outer SystemData data;
  import Modelica.Units.SI;
  parameter RestrictionData param;
  SI.PerUnit P;
  SI.PerUnit Q;
  SI.PerUnit V;
  SI.Angle theta(displayUnit = "deg");
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 80}, {100, -80}}), Text(extent = {{-90, 70}, {90, -70}}, textString = "Power Flow 
Restriction")}, coordinateSystem(extent = {{-100, -80}, {100, 80}})),
  Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})),
  Documentation(info="<html><body>TODO</body></html>"));
end Restriction;