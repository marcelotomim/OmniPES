within OmniPES.Circuit.Interfaces;

partial model SeriesComponent
  Modelica.Units.SI.ComplexPerUnit v "Voltage drop accros this circuit element.";
  Modelica.Units.SI.ComplexPerUnit i "Current flowing from pin 'p' to pin 'n'";
  PositivePin p annotation(
    Placement(visible = true, transformation(origin = {-46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  NegativePin n annotation(
    Placement(visible = true, transformation(origin = {46, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  v = p.v - n.v;
  i = p.i;
  p.i + n.i = Complex(0);
end SeriesComponent;