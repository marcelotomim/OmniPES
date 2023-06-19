within OmniPES.Math;

function polar2cart
  extends Modelica.Icons.Function;
  import Modelica.ComplexMath.exp;
  import Modelica.ComplexMath.j;
  import Modelica.Constants.pi;
  input Real mag "Absolute value of the complex";
  input Modelica.Units.SI.Angle phase "Phase angle of the complex";
  output Complex z "Resultant complex number";
algorithm
  z := mag*exp(j*phase);
end polar2cart;