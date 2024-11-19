within OmniPES.Math;

function sys2qd
  extends Modelica.Icons.Function;
  import Modelica.Units.SI;
  import Modelica.Math.cos;
  import Modelica.Math.sin;
  input Complex A;
  input SI.Angle delta;
  output Complex Aqd;
algorithm
  Aqd.re := A.re*cos(delta) + A.im*sin(delta);
  Aqd.im := A.re*sin(delta) - A.im*cos(delta);
end sys2qd;