within OmniPES.Math;

function sigmoid
  extends Modelica.Icons.Function;
  input Real x "input variable";
  input Real x0 = 0 "input variable value for asymptotes midpoint";
  input Real left_asym = 0.5 "left horizontal asymptote";
  input Real right_asym = 10.0 "right horizontal asymptote";
  input Real growth_rate = 1 "growth rate";
  output Real y "output variable";
algorithm
  y := left_asym + (right_asym-left_asym)/(1+exp(-growth_rate*(x-x0)));
end sigmoid;