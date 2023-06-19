within OmniPES.QuasiSteadyState.Loads.Interfaces;

partial model PartialSteadyStateZIP
  extends OmniPES.QuasiSteadyState.Loads.Interfaces.PartialSteadyStateLoad;
  import Modelica.ComplexMath.conj;
equation
  if initial() then
    Modelica.ComplexMath.real(v*conj(i)) = Pesp/data.Sbase*(1 - par.pi - par.pz + par.pi*(Vo/par.Vdef) + par.pz*(Vo/par.Vdef)^2);
    Modelica.ComplexMath.imag(v*conj(i)) = Qesp/data.Sbase*(1 - par.qi - par.qz + par.qi*(Vo/par.Vdef) + par.qz*(Vo/par.Vdef)^2);
  end if;
end PartialSteadyStateZIP;