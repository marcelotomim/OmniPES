within OmniPES.Transient.Machines.Interfaces;

partial model Restriction
  outer SystemData data;
  parameter RestrictionData param;
  Units.PerUnit P;
  Units.PerUnit Q;
  Units.PerUnit V;
  Modelica.Units.SI.Angle theta(displayUnit = "deg");
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 80}, {100, -80}}), Text(extent = {{-80, 60}, {80, -60}}, textString = "Power Flow 
Restriction")}, coordinateSystem(extent = {{-100, -80}, {100, 80}})),
  Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}})));
end Restriction;