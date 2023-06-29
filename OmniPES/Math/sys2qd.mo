within OmniPES.Math;

function sys2qd
  extends Modelica.Icons.Function;
  import Modelica.Units.SI;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.exp;
  input Complex A;
  input SI.Angle delta;
  output Complex Aqd;
algorithm
  Aqd := A*exp(-j*delta);
end sys2qd;