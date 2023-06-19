within OmniPES.CoSimulation;

model BergeronLink
  OmniPES.Circuit.Interfaces.PositivePin pin_p annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput Ehm annotation(
    Placement(visible = true, transformation(origin = {90, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.ComplexBlocks.Interfaces.ComplexInput var_Ehk annotation(
    Placement(visible = true, transformation(origin = {89, -29}, extent = {{-11, -11}, {11, 11}}, rotation = 0), iconTransformation(origin = {111, -59}, extent = {{-11, -11}, {11, 11}}, rotation = 180)));
  Complex Ehk_ini;
  parameter Complex Zc = Complex(0, 0.1);
  parameter Real Vesp(start=1);
  parameter Real theta_esp(start=0);
  Complex S;
  import Modelica.ComplexMath.conj;
initial equation
  Modelica.ComplexMath.abs(pin_p.v) = Vesp;
  Modelica.ComplexMath.arg(pin_p.v) = theta_esp;
equation
  der(Ehk_ini.re) = 0;
  der(Ehk_ini.im) = 0;
  S = pin_p.v*conj(pin_p.i);
  pin_p.v = Zc*pin_p.i + Ehk_ini + var_Ehk;
  Ehm = pin_p.v + Zc*pin_p.i;
  annotation(
    Icon(graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}), Line(origin = {-95, 0}, points = {{-15, 0}, {15, 0}}), Line(origin = {95.3614, 59.8795}, points = {{-15, 0}, {15, 0}}), Line(origin = {94.8795, -59.8795}, points = {{-15, 0}, {15, 0}}), Text(origin = {4, -1}, extent = {{-56, 39}, {56, -39}}, textString = "BL")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end BergeronLink;
