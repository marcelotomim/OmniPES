within OmniPES.SteadyState.Sources;

model VTHSource_Qlim_discrete
    extends Interfaces.Partial_VSource_Qlim_discrete;
    import Modelica.ComplexMath.arg;
    parameter Modelica.Units.SI.Angle angle(displayUnit="deg") = 0.0 "Reference angle";
equation
  arg(p.v) = angle;
    annotation( Icon(coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1}), graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "Vth
Qlim", horizontalAlignment = TextAlignment.Left)}));
end VTHSource_Qlim_discrete;