within OmniPES.Circuit.Interfaces;

partial model ShuntComponent
  PositivePin p annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Units.SI.ComplexPerUnit v(re(start=1)) "Node voltage across this shunt element.";
  Modelica.Units.SI.ComplexPerUnit i "Current flowing towards the reference node.";
equation
  v = p.v;
  i = p.i;
end ShuntComponent;