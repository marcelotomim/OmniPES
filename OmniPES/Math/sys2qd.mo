within OmniPES.Math;

function sys2qd
  extends Modelica.Icons.Function;
  input Complex A;
  input Modelica.Units.SI.Angle delta;
  output Complex Aqd;
  import Modelica.ComplexMath.j;
algorithm
  Aqd := A*Modelica.ComplexMath.exp(-j*delta);
end sys2qd;