within OmniPES.SteadyState.Sources;

model VTHSource_Qlim_sigmoid
    extends Interfaces.Partial_VSource_Qlim_sigmoid;
    import Modelica.ComplexMath.arg;
    parameter Modelica.Units.SI.Angle angle(displayUnit="deg") = 0.0 "Reference angle";
equation
  arg(p.v) = angle;
    annotation( Icon(graphics = {Text(visible = useExternalVoltageSpec, origin = {30, -79}, rotation = -90, extent = {{-14, 11}, {14, -11}}, textString = "V"), Text(origin = {1, 80}, rotation = 180, extent = {{-97, 28}, {100, -19}}, textString = "VTH
Qlim", fontSize = 8, horizontalAlignment = TextAlignment.Right)}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}}, grid = {1, 1})));
end VTHSource_Qlim_sigmoid;