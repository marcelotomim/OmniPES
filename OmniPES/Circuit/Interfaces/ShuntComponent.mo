within OmniPES.Circuit.Interfaces;

partial model ShuntComponent
  PositivePin p annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Units.CPerUnit v(re(start=1)) "Node voltage across this shunt element.";
  Units.CPerUnit i "Current flowing towards the reference node.";
equation
  v = p.v;
  i = p.i;
end ShuntComponent;