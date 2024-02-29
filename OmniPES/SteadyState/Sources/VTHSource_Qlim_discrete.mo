within OmniPES.SteadyState.Sources;

model VTHSource_Qlim_discrete
    extends Interfaces.Partial_VSource_Qlim_discrete;
    import Modelica.ComplexMath.arg;
    parameter Modelica.Units.NonSI.Angle_deg angle = 0.0 "Reference angle";
equation
  arg(p.v) = angle;
    annotation( Icon(graphics = {Text(visible=useExternalVoltageSpec,origin = {30, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "V"), Text(origin = {70, 54}, rotation = -90, extent = {{-24, 29}, {24, -19}}, textString = "VTH\nQlim")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end VTHSource_Qlim_discrete;