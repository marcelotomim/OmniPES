within OmniPES.SteadyState.Sources.Interfaces;

partial model Partial_Source
  extends Icons.Vsource;
  extends Circuit.Interfaces.ShuntComponent;
  outer SystemData data;
  import Modelica.ComplexMath.conj;
  import Abs=Modelica.ComplexMath.abs;
  import Modelica.Units.SI;
  SI.ComplexPerUnit S "generated apparent power"; 
  SI.PerUnit V(start=1, max=1.5, min=0.5) "voltage magnitude";

  parameter Boolean voltage_limits = false  "Check to activate sigmoid-based voltage limits" annotation(Evaluate=true, HideResult=true, choices(checkBox=true), Dialog(group="Selectors"));
  parameter SI.PerUnit Vmax = 2.0 if voltage_limits "Maximum voltage limit" annotation(Evaluate=true, HideResult=false, Dialog(group="Limits", enable=voltage_limits));
  parameter SI.PerUnit Vmin = 0.5 if voltage_limits "Minimum voltage limit" annotation(Evaluate=true, HideResult=false, Dialog(group="Limits", enable=voltage_limits));
  Real aux if voltage_limits "auxiliary variable" annotation(HideResult = true);
equation
  S = -v*conj(i);
  V = Abs(v);
  
  if voltage_limits then
    V = OmniPES.Math.sigmoid(aux);
  end if;

end Partial_Source;