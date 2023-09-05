within OmniPES.SteadyState.Sources.Interfaces;

partial model Partial_Source
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  outer SystemData data;
  import Modelica.ComplexMath.conj;
  Units.CPerUnit S;
equation
  S = -v*conj(i);
end Partial_Source;