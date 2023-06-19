within OmniPES.QuasiSteadyState.Loads.Interfaces;

partial model PartialDynamicZIP
  extends OmniPES.QuasiSteadyState.Loads.Interfaces.PartialDynamicLoad;
  import Modelica.ComplexMath.conj;
equation
  Modelica.ComplexMath.real(v*conj(i)) = Pesp/data.Sbase*(1 - par.pi - par.pz + par.pi*(Vabs/Vo) + par.pz*(Vabs/Vo)^2);
  Modelica.ComplexMath.imag(v*conj(i)) = Qesp/data.Sbase*(1 - par.qi - par.qz + par.qi*(Vabs/Vo) + par.qz*(Vabs/Vo)^2);
end PartialDynamicZIP;